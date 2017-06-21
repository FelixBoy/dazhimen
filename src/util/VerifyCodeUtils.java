package util;

import dazhimen.api.bean.ApiCheckVerifyCodeBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import org.dom4j.DocumentException;
import util.web.HttpClientUtils;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

/**
 * Created by Administrator on 2017/4/23.
 */
public class VerifyCodeUtils {
//    public static void main(String[] args) throws ApiException {
//        sendVerifyCodeToMphone("18769796133", "2468");
//    }
    public static boolean sendVerifyCodeToMphone(String mphone, String verifyCode) throws ApiException {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("action", "send");
        params.put("userid", "");
        params.put("account", "AB00271");
        params.put("password", "70AE96E2F487F7B26BD5A311C3A5DBB8");
        params.put("mobile", mphone);
        params.put("content", " 您的验证码是" + verifyCode + "，五分钟内有效。请勿将验证码泄露给其他人。【大职门App】");
        params.put("extno", "");
        params.put("sendTime", "");
        String result = null;
        try {
            result = HttpClientUtils.doPost("http://dx.ipyy.net/sms.aspx", params);
        } catch (IOException e) {
            e.printStackTrace();
            throw new ApiException("发送短信请求出错" + result);
        }
        Map<String, String> map = null;
        try {
            map = XmlUtils.convertXMLStringToMap(result);
        } catch (DocumentException e) {
            e.printStackTrace();
            throw new ApiException("解析发送短信请求结果出错" + map);
        }
        if(map.get("returnstatus").equals("Success")){
            return true;
        }else{
            return false;
        }
    }
//    public static boolean checkVerifyCode(String verifyCode) throws ParameterCheckException {
//        if(verifyCode == null || verifyCode.equals("")){
//            throw new ParameterCheckException("传入的验证码为空");
//        }
//        if(verifyCode.equals("1234")){
//            return true;
//        }
//        return false;
//    }
    public static boolean checkMobileVerifyCode(String mphone, String verifyCode) throws ParameterCheckException, ApiException {
        if(verifyCode == null || verifyCode.equals("")){
            throw new ParameterCheckException("传入的验证码为空");
        }
        if(mphone == null || mphone.equals("")){
            throw new ParameterCheckException("传入的手机号码为空");
        }
        boolean result = false;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            ApiCheckVerifyCodeBean verifyCodeBean = sqlSession.selectOne("dazhimen.api.bean.ApiLogin.getCheckVerifyCode", mphone);
            if(verifyCodeBean == null || verifyCodeBean.getCode() == null || verifyCodeBean.getExpiredatetime() == null){
                throw new ApiException("获取验证码校验信息出错");
            }
            long expireDateTimeLong = Long.parseLong(verifyCodeBean.getExpiredatetime());
            if(System.currentTimeMillis() > expireDateTimeLong){
                throw new ApiException("验证码已超时");
            }
            if(verifyCode.equals(verifyCodeBean.getCode())){
                result = true;
            }else{
                throw new ApiException("验证码错误");
            }
        }catch (ApiException e){
            e.printStackTrace();
            throw new ApiException(e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，校验验证码失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result;
    }
    public static String genVerifyCode() {
        String charValue = "";
        for (int i = 0; i < Constant.verifyCodeLength; i++) {
            char c = (char) (randomInt(0, 10) + '0');
            charValue += String.valueOf(c);
        }
        return charValue;
    }
    private static int randomInt(int from, int to) {
        Random r = new Random();
        return from + r.nextInt(to - from);
    }
}
