package dazhimen.api.controller;

import bean.CustomerBean;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dazhimen.api.bean.MphoneLoginBean;
import dazhimen.api.bean.ThirdPartLoginBean;
import dazhimen.api.exception.ParameterCheckException;
import dazhimen.api.service.LoginService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import util.ApiUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2017/3/18.
 */
@Controller
@RequestMapping("/api/customer")
public class ApiLoginController {
    @RequestMapping("/thirdPartLogin")
    public void doThirdPartLogin(HttpServletRequest resq,
                                 HttpServletResponse resp){
        resp.setCharacterEncoding("utf-8");
        try {
            checkThirdPartLoginParam(resq);
            ApiUtils.checkSignatureThirdPart(resq);
            ThirdPartLoginBean loginBean = getThirdPartLoginBean(resq);
            LoginService loginService = new LoginService();
            CustomerBean customerBean = loginService.doThirdPartLogin(loginBean);
            try {
                JsonObject jsonObj = new JsonObject();
                jsonObj.addProperty("code","200");
                jsonObj.addProperty("msg","成功");
                jsonObj.addProperty("data",new Gson().toJson(customerBean));
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            JsonObject jsonObj = new JsonObject();
            jsonObj.addProperty("code","400");
            jsonObj.addProperty("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }

    @RequestMapping("/mphoneLogin")
    public void doMphoneLogin(HttpServletRequest resq,
                        HttpServletResponse resp){
        resp.setCharacterEncoding("utf-8");
        try {
            checkMphoneLoginParam(resq);
            ApiUtils.checkSignatureMphone(resq);
            MphoneLoginBean loginBean = getMphoneLoginBean(resq);
            LoginService loginService = new LoginService();
            CustomerBean customerBean = loginService.doMphoneLogin(loginBean);
            try {
                JsonObject jsonObj = new JsonObject();
                jsonObj.addProperty("code","200");
                jsonObj.addProperty("msg","成功");
                jsonObj.addProperty("data",new Gson().toJson(customerBean));
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            JsonObject jsonObj = new JsonObject();
            jsonObj.addProperty("code","400");
            jsonObj.addProperty("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
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
            String qq = resq.getParameter("qq");
            if(qq == null){
                throw new ParameterCheckException("未取到参数[qq]");
            }
            String qqUid = resq.getParameter("qqUid");
            if(qqUid == null){
                throw new ParameterCheckException("未取到参数[qqUid]");
            }
        }
        if(loginType.equals("2")){
            String weixin = resq.getParameter("weixin");
            if(weixin == null){
                throw new ParameterCheckException("未取到参数[weixin]");
            }
            String weixinUid = resq.getParameter("weixinUid");
            if(weixinUid == null){
                throw new ParameterCheckException("未取到参数[weixinUid]");
            }
        }
    }
    private ThirdPartLoginBean getThirdPartLoginBean(HttpServletRequest resq) throws ParameterCheckException{
        ThirdPartLoginBean loginBean = new ThirdPartLoginBean();
        String loginType = resq.getParameter("loginType");
        loginBean.setLoginType(loginType);
        if("1".equals(loginType)){
            loginBean.setQq(resq.getParameter("qq"));
            loginBean.setQqUid(resq.getParameter("qqUid"));
        }
        if("2".equals(loginType)){
            loginBean.setWeixin(resq.getParameter("weixin"));
            loginBean.setWeixin(resq.getParameter("weixinUid"));
        }
        loginBean.setNickname(resq.getParameter("nickname"));
        loginBean.setHeaderurl(resq.getParameter("headerurl"));
        loginBean.setGender(resq.getParameter("gender"));
        Integer age = null;
        try{
            age = Integer.valueOf(resq.getParameter("age"));
        }catch (NumberFormatException e){
            e.printStackTrace();
            throw new ParameterCheckException("参数[age]的值不符合规则");
        }
        loginBean.setAge(age);
        return loginBean;
    }
    private void checkMphoneLoginParam(HttpServletRequest resq) throws ParameterCheckException {
        String loginType = resq.getParameter("mphone");
        if(loginType == null){
            throw new ParameterCheckException("未取到参数[mphone]");
        }
    }
    private MphoneLoginBean getMphoneLoginBean(HttpServletRequest resq){
        MphoneLoginBean mphoneLoginBean = new MphoneLoginBean();
        String mphone = resq.getParameter("mphone");
        mphoneLoginBean.setMphone(mphone);
        return mphoneLoginBean;
    }

}
