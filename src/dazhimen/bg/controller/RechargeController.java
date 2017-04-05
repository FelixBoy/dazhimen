package dazhimen.bg.controller;

import com.google.gson.Gson;
import dazhimen.bg.bean.ViewRechargeBean;
import dazhimen.bg.exception.BgException;
import dazhimen.bg.service.RechargeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import util.Constant;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

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
        resp.setCharacterEncoding(Constant.CharSet);

        try {
            String rows = resq.getParameter("rows");
            String page = resq.getParameter("page");
            RechargeService rechargeService = new RechargeService();
            String result = rechargeService.queryAllRecharge(page, rows);
            resp.getWriter().write(result);
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询所有产品信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
}
