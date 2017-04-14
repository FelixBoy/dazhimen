package demo;

import dazhimen.api.exception.ApiException;
import dazhimen.api.service.ApiOrderService;
import net.sf.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/14.
 */
public class TestdealAliPayByProductResult {
    public static void main(String[] args) throws ApiException {
        //改订单表，添加微信支付相关信息
        Map<String, String> map = new HashMap<>();
        map.put("trade_status", "TRADE_SUCCESS");
        map.put("out_trade_no", "or17041400045");
        map.put("trade_no", "2013112011001004330000121536");
        map.put("total_amount", "0.01");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("cid", "c17041400076");
        jsonObject.put("pid", "p17032700050");
        map.put("passback_params", jsonObject.toString());
        ApiOrderService orderService = new ApiOrderService();
        orderService.dealAliPayByProductResult(map);
    }
}
