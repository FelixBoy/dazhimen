package dazhimen.bg.controller;

import dazhimen.bg.bean.recharge.QueryRechargeParamBean;
import dazhimen.bg.service.RechargeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import util.Constant;
import util.web.ResponseUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2017/4/5.
 */
@Controller
@RequestMapping("/recharge")
public class RechargeController {
    @RequestMapping("/fwdManageRechargePage")
    public String fwdManageRechargePage(){
        return "/recharge/manageRecharge";
    }
    @RequestMapping("/queryAllRecharge")
    public void queryAllRecharge(HttpServletRequest resq, HttpServletResponse resp){

        try {
            String page = resq.getParameter("page");
            String rows = resq.getParameter("rows");
            String queryByParamFlag = resq.getParameter("queryByParamFlag");
            RechargeService rechargeService = new RechargeService();
            String result = null;
            if(queryByParamFlag == null || queryByParamFlag.equals("")){
                result = rechargeService.queryAllRecharge(page, rows);
            }else{
                String cidCondition = resq.getParameter("cidCondition");
                String nicknameCondition = resq.getParameter("nicknameCondition");
                String nameCondition = resq.getParameter("nameCondition");
                String paymenttypeCondition = resq.getParameter("paymenttypeCondition");
                String starttimeCondition = resq.getParameter("starttimeCondition");
                String endtimeCondition = resq.getParameter("endtimeCondition");
                String startAmountCondition = resq.getParameter("startAmountCondition");
                String endAmountCondition = resq.getParameter("endAmountCondition");
                QueryRechargeParamBean paramBean = new QueryRechargeParamBean();
                paramBean.setCidCondition(cidCondition);
                paramBean.setNicknameCondition(nicknameCondition);
                paramBean.setNameCondition(nameCondition);
                paramBean.setPaymenttypeCondition(paymenttypeCondition);
                paramBean.setStarttimeCondition(starttimeCondition);
                paramBean.setEndtimeCondition(endtimeCondition);
                paramBean.setStartAmountCondition(startAmountCondition);
                paramBean.setEndAmountCondition(endAmountCondition);
                result = rechargeService.queryAllRechargeByParam(page, rows, paramBean);
            }
            ResponseUtil.writeMsg(resp, result);
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询所有充值信息失败");
        }
    }
}
