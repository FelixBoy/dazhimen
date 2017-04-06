package demo;

import dazhimen.api.exception.ApiException;
import dazhimen.api.service.ApiOrderService;

/**
 * Created by Administrator on 2017/4/6.
 */
public class TestByProductByBalance {
    public static void main(String[] args) throws ApiException {
        //p17032600047
        //c17033100021
        ApiOrderService orderService = new ApiOrderService();
        orderService.buyProductByBalance("c17033100021", "p17032600047");
    }
}
