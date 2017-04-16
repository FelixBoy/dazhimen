package dazhimen.bg.controller;

import dazhimen.bg.bean.order.QueryOrderParamBean;
import dazhimen.bg.service.OrderService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import util.Constant;
import util.web.ResponseUtil;

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
            String queryByParamFlag = resq.getParameter("queryByParamFlag");
            OrderService orderService = new OrderService();
            String result = null;
            if(queryByParamFlag == null || queryByParamFlag.equals("")){
                result = orderService.queryAllOrder(page, rows);
            }else{
                String cidCondition = resq.getParameter("cidCondition");
                String mphoneCondition = resq.getParameter("mphoneCondition");
                String producttypeCondition = resq.getParameter("producttypeCondition");
                String paymenttypeCondition = resq.getParameter("paymenttypeCondition");
                String starttimeCondition = resq.getParameter("starttimeCondition");
                String endtimeCondition = resq.getParameter("endtimeCondition");
                String startAmountCondition = resq.getParameter("startAmountCondition");
                String endAmountCondition = resq.getParameter("endAmountCondition");
                QueryOrderParamBean paramBean = new QueryOrderParamBean();
                paramBean.setCidCondition(cidCondition);
                paramBean.setMphoneCondition(mphoneCondition);
                paramBean.setProducttypeCondition(producttypeCondition);
                paramBean.setPaymenttypeCondition(paymenttypeCondition);
                paramBean.setStarttimeCondition(starttimeCondition);
                paramBean.setEndtimeCondition(endtimeCondition);
                paramBean.setStartAmountCondition(startAmountCondition);
                paramBean.setEndAmountCondition(endAmountCondition);
                result = orderService.queryAllOrderByParam(page, rows, paramBean);
            }

            ResponseUtil.writeMsg(resp, result);
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询所有订单信息失败");
        }
    }
}
