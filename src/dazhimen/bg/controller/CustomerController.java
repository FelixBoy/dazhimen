package dazhimen.bg.controller;

import dazhimen.bg.bean.customer.QueryCustomerParamBean;
import dazhimen.bg.service.CustomerService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import util.Constant;
import util.web.ResponseUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2017/3/23.
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {
    @RequestMapping("/fwdCustomerManagePage")
    public String forwardCustomerManagePage(HttpServletResponse resp){
        return "/customer/manageCustomer";
    }
    @RequestMapping("/queryAllCustomers")
    public void queryAllCustomers(HttpServletRequest resq, HttpServletResponse resp){
        try{
            CustomerService customerService = new CustomerService();
            String page = resq.getParameter("page");
            String rows = resq.getParameter("rows");
            String queryByParamFlag = resq.getParameter("queryByParamFlag");
            String result = null;
            if(queryByParamFlag == null || queryByParamFlag.equals("")){
                result = customerService.queryAllCustomers(page, rows);
            }else{
                String cidCondition = resq.getParameter("cidCondition");
                String nicknameCondition = resq.getParameter("nicknameCondition");
                String nameCondition = resq.getParameter("nameCondition");
                String weixinCondition = resq.getParameter("weixinCondition");
                String starttimeCondition = resq.getParameter("starttimeCondition");
                String endtimeCondition = resq.getParameter("endtimeCondition");
                String startBalanceCondition = resq.getParameter("startBalanceCondition");
                String endBalanceCondition = resq.getParameter("endBalanceCondition");
                QueryCustomerParamBean paramBean = new QueryCustomerParamBean();
                paramBean.setCidCondition(cidCondition);
                paramBean.setNicknameCondition(nicknameCondition);
                paramBean.setNameCondition(nameCondition);
                paramBean.setWeixinCondition(weixinCondition);
                paramBean.setStarttimeCondition(starttimeCondition);
                paramBean.setEndtimeCondition(endtimeCondition);
                paramBean.setStartBalanceCondition(startBalanceCondition);
                paramBean.setEndBalanceCondition(endBalanceCondition);
                result = customerService.queryAllCustomersByParam(page, rows, paramBean);
            }
            ResponseUtil.writeMsg(resp, result);
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询所有会员信息失败");
        }
    }
}
