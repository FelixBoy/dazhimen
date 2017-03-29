package dazhimen.api.service;

import dazhimen.api.bean.ApiCustomerBean;
import dazhimen.api.bean.MphoneLoginBean;
import dazhimen.api.bean.ThirdPartLoginBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import util.Constant;
import util.IdUtils;

import java.util.Random;

/**
 * Created by Administrator on 2017/3/18.
 */
public class ApiLoginService {
    public ApiCustomerBean doThirdPartLogin(ThirdPartLoginBean loginBean) throws ParameterCheckException, ApiException {
        if(loginBean == null){
            throw new ParameterCheckException("ApiLoginService的doThirdPartLogin方法，参数为null");
        }
        SqlSession sqlSession = null;
        ApiCustomerBean customerBean = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            if(loginBean.getLoginType().equals("1")){
                customerBean = sqlSession.selectOne("dazhimen.api.bean.ApiLogin.checkCustomerIsExistsByQQuid", loginBean.getQqUid());
            }else if(loginBean.getLoginType().equals("2")){
                customerBean = sqlSession.selectOne("dazhimen.api.bean.ApiLogin.checkCustomerIsExistsByWeixinuid", loginBean.getWeixinUid());
            }
            if(customerBean == null) {
                String cid = new IdUtils().getCid();
                loginBean.setCid(cid);
                int result = sqlSession.insert("dazhimen.api.bean.ApiLogin.saveThirdPartLogin", loginBean);
                if (!(result == 1)) {
                    throw new ApiException("新增会员信息出错");
                }
                sqlSession.commit();
                customerBean = getCustomerInfoByCid(cid);
            }
        } catch (Exception e) {
            sqlSession.rollback();
            e.printStackTrace();
            throw new ApiException("新增会员信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return customerBean;
    }
    public ApiCustomerBean getCustomerInfoByCid(String cid) throws ApiException {
        ApiCustomerBean customerBean = null;
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            customerBean = sqlSession.selectOne("dazhimen.api.bean.ApiLogin.getCustomerInfoByCid", cid);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ApiException("查询会员信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return customerBean;
    }
    public ApiCustomerBean doMphoneLogin(MphoneLoginBean loginBean) throws ParameterCheckException, ApiException {
        if(loginBean == null){
            throw new ParameterCheckException("ApiLoginService的doMphoneLogin，参数为null");
        }
        //校验验证码
        if(!checkVerifyCode(loginBean.getVerifyCode())){
            throw new ParameterCheckException("验证码输入错误");
        }
        SqlSession sqlSession = null;
        ApiCustomerBean customerBean = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            customerBean = sqlSession.selectOne("dazhimen.api.bean.ApiLogin.checkCustomerIsExistsByMphone", loginBean.getMphone());
            if(customerBean == null){
                String cid = new IdUtils().getCid();
                loginBean.setCid(cid);
                int result = sqlSession.insert("dazhimen.api.bean.ApiLogin.saveMphoneLogin", loginBean);
                if (!(result == 1)) {
                    throw new ApiException("新增会员信息出错");
                }
                sqlSession.commit();
                customerBean = getCustomerInfoByCid(cid);
            }
        }catch (Exception e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException("新增会员信息出错");
        } finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return customerBean;
    }
    private boolean checkVerifyCode(String verfiyCode) throws ParameterCheckException {
        if(verfiyCode == null || verfiyCode.equals("")){
            throw new ParameterCheckException("传入的验证码为空");
        }
        if(verfiyCode.equals("1234")){
            return true;
        }
        return false;
    }
    public String genVerifyCode() {
        String charValue = "";
        for (int i = 0; i < Constant.verifyCodeLength; i++) {
            char c = (char) (randomInt(0, 10) + '0');
            charValue += String.valueOf(c);
        }
        return charValue;
    }
    private int randomInt(int from, int to) {
        Random r = new Random();
        return from + r.nextInt(to - from);
    }
}
