package dazhimen.bg.controller;

import com.google.gson.JsonObject;
import dazhimen.bg.service.LoginService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

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
        LoginService loginService = new LoginService();
        JsonObject jsonObj = new JsonObject();
        if(!loginService.checkIsLoginnameExists(loginName)){
            jsonObj.addProperty("code", "error");
            jsonObj.addProperty("msg", "用户名不存在");
        }else if(!loginService.checkPassword(loginName, passWord)){
            jsonObj.addProperty("code", "error");
            jsonObj.addProperty("msg", "用户名或者密码错误");
        }else{
            jsonObj.addProperty("code", "succ");
            jsonObj.addProperty("msg", "登录成功");
            jsonObj.addProperty("rediretUrl" , resq.getContextPath()+"/user/fwdMainPage");
        }
        resp.setCharacterEncoding("utf-8");
        try {
            resp.getWriter().write(jsonObj.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
