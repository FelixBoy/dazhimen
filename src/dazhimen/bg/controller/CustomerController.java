package dazhimen.bg.controller;

import com.google.gson.Gson;
import dazhimen.bg.bean.CustomerBean;
import dazhimen.bg.bean.QueryCustomerParamBean;
import dazhimen.bg.service.CustomerService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import util.Constant;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

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
        resp.setCharacterEncoding(Constant.CharSet);
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

            resp.getWriter().write(result);
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询所有会员信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/saveCustomerDel")
    public void saveCustomerDel(HttpServletRequest resq,HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try{
            CustomerService customerService = new CustomerService();
            customerService.saveCustomerDel(resq.getParameter("cid"));
            resp.getWriter().write("删除会员成功");
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，删除会员信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
}
