package dazhimen.bg.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2017/4/5.
 */
@Controller
@RequestMapping("/recharge")
public class RechargeController {
    @RequestMapping("/fwdManageRechargePage")
    public String fwdManageRechargePage(){
        return "/recharge/mangeRecharge";
    }
    @RequestMapping("/queryAllRecharge")
    public void queryAllRecharge(HttpServletRequest resq, HttpServletResponse resp){

    }
}
