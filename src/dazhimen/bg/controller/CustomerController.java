package dazhimen.bg.controller;

import com.google.gson.Gson;
import dazhimen.bg.bean.CustomerBean;
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
    public void queryAllCustomers(HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try{
            CustomerService customerService = new CustomerService();
            List<CustomerBean> customerBeans = customerService.queryAllCustomers();
            Gson gson = new Gson();
            String customerJson = gson.toJson(customerBeans);
            resp.getWriter().write(customerJson);
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
