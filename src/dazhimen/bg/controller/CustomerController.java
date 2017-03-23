package dazhimen.bg.controller;

import com.google.gson.Gson;
import dazhimen.bg.bean.CustomerBean;
import dazhimen.bg.service.CustomerService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
        CustomerService customerService = new CustomerService();
        List<CustomerBean> customerBeans = customerService.queryAllCustomers();
        Gson gson = new Gson();
        String customerJson = gson.toJson(customerBeans);
        resp.setCharacterEncoding("utf-8");
        try {
            resp.getWriter().write(customerJson);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
