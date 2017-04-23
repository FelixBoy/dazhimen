package dazhimen.api.controller;

import com.sun.xml.internal.bind.v2.runtime.reflect.opt.Const;
import dazhimen.api.bean.ApiCustomerBean;
import com.google.gson.Gson;
import dazhimen.api.bean.MphoneLoginBean;
import dazhimen.api.bean.ThirdPartLoginBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import dazhimen.api.service.ApiLoginService;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import util.ApiUtils;
import util.Constant;
import util.web.ResponseUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

/**
 * Created by Administrator on 2017/3/18.
 */
@Controller
@RequestMapping("/api/customer")
public class ApiLoginController {
    @RequestMapping(value = "/thirdPartLogin",method = RequestMethod.POST)
    public void doThirdPartLogin(HttpServletRequest resq, HttpServletResponse resp){
        try {
            checkThirdPartLoginParam(resq);
            ApiUtils.checkSignature(resq);
            ThirdPartLoginBean loginBean = getThirdPartLoginBean(resq);
            ApiLoginService apiLoginService = new ApiLoginService();
            ApiCustomerBean customerBean = apiLoginService.doThirdPartLogin(loginBean);
            String headerUrl = customerBean.getHeaderurl();
            if(headerUrl != null && !headerUrl.equals("")){
                if(!headerUrl.contains("http")){
                    String localIp = resq.getLocalAddr();//获取本地ip
                    if(Constant.isDeployInAliyun){
                        localIp = Constant.AliyunIP;
                    }
                    int localPort = resq.getLocalPort();//获取本地的端口
                    String appName = resq.getContextPath();
                    String newHeaderUrl = "http://" + localIp + ":" + localPort + appName + "/" + headerUrl;
                    customerBean.setHeaderurl(newHeaderUrl);
                }
            }
                JSONObject jsonObj = new JSONObject();
                jsonObj.put("code","200");
                jsonObj.put("msg","成功");
                jsonObj.put("data",new Gson().toJson(customerBean));
                ResponseUtil.writeMsg(resp,jsonObj.toString());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }catch (ParameterCheckException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }

    @RequestMapping(value="/mphoneLogin",method = RequestMethod.POST)
    public void doMphoneLogin(HttpServletRequest resq,
                        HttpServletResponse resp){
        try {
            checkMphoneLoginParam(resq);
            ApiUtils.checkSignature(resq);
            MphoneLoginBean loginBean = getMphoneLoginBean(resq);
            ApiLoginService apiLoginService = new ApiLoginService();
            ApiCustomerBean customerBean = apiLoginService.doMphoneLogin(loginBean);
            String headerUrl = customerBean.getHeaderurl();
            if(headerUrl != null && !headerUrl.equals("")){
                if(!headerUrl.contains("http")){
                    String localIp = resq.getLocalAddr();//获取本地ip
                    if(Constant.isDeployInAliyun){
                        localIp = Constant.AliyunIP;
                    }
                    int localPort = resq.getLocalPort();//获取本地的端口
                    String appName = resq.getContextPath();
                    String newHeaderUrl = "http://" + localIp + ":" + localPort + appName + "/" + headerUrl;
                    customerBean.setHeaderurl(newHeaderUrl);
                }
            }
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code","200");
            jsonObject.put("msg","成功");
            jsonObject.put("data",new Gson().toJson(customerBean));
            ResponseUtil.writeMsg(resp,jsonObject.toString());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }catch (ParameterCheckException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }
    @RequestMapping(value="/getVerifyCode",method = RequestMethod.POST)
    public void getVerifyCode(HttpServletRequest resq,
                              HttpServletResponse resp){
        try {
            checkGetVerifyCodePara(resq);
            ApiUtils.checkSignature(resq);
            ApiLoginService loginService = new ApiLoginService();
            loginService.getVerifyCode(resq.getParameter("mphone"));
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            ResponseUtil.writeMsg(resp, jsonObj.toString());
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }
    private void checkGetVerifyCodePara(HttpServletRequest resq) throws ParameterCheckException {
        String mphone = resq.getParameter("mphone");
        if(mphone == null){
            throw new ParameterCheckException("未取到参数[mphone]");
        }
        if(mphone.equals("")){
            throw new ParameterCheckException("参数[mphone]的值为空");
        }
    }
    private void checkThirdPartLoginParam(HttpServletRequest resq) throws ParameterCheckException{
        String loginType = resq.getParameter("loginType");
        if(loginType == null){
            throw new ParameterCheckException("未取到参数[loginType]");
        }
        if(!(loginType.equals("1") || loginType.equals("2"))){
            throw new ParameterCheckException("参数[loginType]的值不符合规则");
        }
        if(loginType.equals("1")){
            String qqUid = resq.getParameter("qqUid");
            if(qqUid == null){
                throw new ParameterCheckException("未取到参数[qqUid]");
            }
            if(qqUid.equals("")){
                throw new ParameterCheckException("参数[qqUid]的值为空");
            }
        }
        if(loginType.equals("2")){
            String weixinUid = resq.getParameter("weixinUid");
            if(weixinUid == null){
                throw new ParameterCheckException("未取到参数[weixinUid]");
            }
            if(weixinUid.equals("")){
                throw new ParameterCheckException("参数[weixinUid]的值为空");
            }
        }
    }
    private ThirdPartLoginBean getThirdPartLoginBean(HttpServletRequest resq) throws ParameterCheckException{
        ThirdPartLoginBean loginBean = new ThirdPartLoginBean();
        String loginType = resq.getParameter("loginType");
        loginBean.setLoginType(loginType);
        if("1".equals(loginType)){
            loginBean.setQqUid(resq.getParameter("qqUid"));
        }
        if("2".equals(loginType)){
            loginBean.setWeixinUid(resq.getParameter("weixinUid"));
        }
        loginBean.setNickname(resq.getParameter("nickname"));
        loginBean.setHeaderurl(resq.getParameter("headerurl"));
        loginBean.setGender(resq.getParameter("gender"));
        return loginBean;
    }
    private void checkMphoneLoginParam(HttpServletRequest resq) throws ParameterCheckException {
        String mphone = resq.getParameter("mphone");
        if(mphone == null){
            throw new ParameterCheckException("未取到参数[mphone]");
        }
        if(mphone.equals("")){
            throw new ParameterCheckException("参数[mphone]的值为空");
        }
        String verifycode = resq.getParameter("verifycode");
        if(verifycode == null){
            throw new ParameterCheckException("未取到参数[verifycode]");
        }
        if(verifycode.equals("")){
            throw new ParameterCheckException("参数[verifycode]的值为空");
        }
    }
    private MphoneLoginBean getMphoneLoginBean(HttpServletRequest resq){
        MphoneLoginBean mphoneLoginBean = new MphoneLoginBean();
        String mphone = resq.getParameter("mphone");
        mphoneLoginBean.setMphone(mphone);
        String verifyCode = resq.getParameter("verifycode");
        mphoneLoginBean.setVerifyCode(verifyCode);
        return mphoneLoginBean;
    }
}
