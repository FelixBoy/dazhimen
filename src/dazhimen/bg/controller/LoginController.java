package dazhimen.bg.controller;

import com.google.gson.JsonObject;
import dazhimen.bg.bean.login.LoginUserBean;
import dazhimen.bg.service.LoginService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import util.Constant;
import util.web.ResponseUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;

/**
 * Created by Administrator on 2017/3/16.
 */
@Controller
@RequestMapping("/login")
public class LoginController {
    @RequestMapping(value="/doLoginCheck", method= RequestMethod.POST)
    public void doLoginCheck(@RequestParam("loginname") String loginName,
                             @RequestParam("password") String passWord,
                             HttpServletRequest resq,
                             HttpServletResponse resp){
        try {
            LoginService loginService = new LoginService();
            JsonObject jsonObj = new JsonObject();
            if(!loginService.checkIsLoginnameExists(loginName)){
                ResponseUtil.writeFailMsgToBrowse(resp, "用户名不存在");
            }else if(!loginService.checkPassword(loginName, passWord)){
                ResponseUtil.writeFailMsgToBrowse(resp, "用户名或者密码错误");
            }else{
                jsonObj.addProperty("msg", "登录成功");
                jsonObj.addProperty("rediretUrl" , resq.getContextPath()+"/user/fwdMainPage");
                LoginUserBean userBean = loginService.getUserInfoByLoginname(loginName);
                HttpSession session = resq.getSession(true);
                session.setAttribute(Constant.LoginUserKey, userBean);
                ResponseUtil.writeMsg(resp,jsonObj.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，登录失败");
        }
    }
    @RequestMapping("/exitLogin")
    public void exitLogin(HttpServletRequest resq, HttpServletResponse resp){
        HttpSession session = resq.getSession(false);
        if(session != null || isSessionContainsLoginUser(session)) {
            session.removeAttribute(Constant.LoginUserKey);
        }
        String loginPageUrl = resq.getContextPath()+ "/login.jsp";
        String javaScriptSegment = "<script id=\"script_exe\" defer=\"defer\">location.href=\""+ loginPageUrl + "\";</script>";
        ResponseUtil.writeJavaScript(resp, javaScriptSegment);
    }
    private boolean isSessionContainsLoginUser(HttpSession session){
        Object loginUserObj = session.getAttribute(Constant.LoginUserKey);
        if(loginUserObj == null){
            return false;
        }else{
            LoginUserBean userBean = (LoginUserBean)loginUserObj;
            if(userBean.getUid() == null || userBean.getUname() == null || userBean.getUtype() == null){
                return false;
            }
            return true;
        }
    }
}
