package dazhimen.bg.controller;

import com.google.gson.JsonObject;
import dazhimen.bg.service.LoginService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import util.Constant;

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
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            LoginService loginService = new LoginService();
            JsonObject jsonObj = new JsonObject();
            if(!loginService.checkIsLoginnameExists(loginName)){
               resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
               resp.getWriter().write("用户名不存在");
            }else if(!loginService.checkPassword(loginName, passWord)){
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.getWriter().write("用户名或者密码错误");
            }else{
                resp.setStatus(HttpServletResponse.SC_OK);
                jsonObj.addProperty("msg", "登录成功");
                jsonObj.addProperty("rediretUrl" , resq.getContextPath()+"/user/fwdMainPage");
                resp.getWriter().write(jsonObj.toString());
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，登录失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
}
