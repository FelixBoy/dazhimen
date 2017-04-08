package dazhimen.bg.controller;

import dazhimen.bg.service.OrderService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import util.Constant;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2017/4/7.
 */
@Controller
@RequestMapping("/order")
public class OrderController {
    @RequestMapping("/fwdManageOrderPage")
    public String fwdManageOrderPage(){
        return "/order/manageOrder";
    }
    @RequestMapping("/queryAllOrder")
    public void queryAllOrder(HttpServletRequest resq, HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);

        try {
            String page = resq.getParameter("page");
            String rows = resq.getParameter("rows");
            OrderService orderService = new OrderService();
            String result = orderService.queryAllOrder(page, rows);
            resp.getWriter().write(result);
        }catch (Exception e){
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
