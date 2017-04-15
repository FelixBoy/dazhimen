package demo;

import dazhimen.api.exception.ApiException;
import util.pay.AlipayUtil;

/**
 * Created by Administrator on 2017/4/14.
 */
public class TestAlipayRecharge {
    public static void main(String[] args) throws ApiException {
        System.out.println(doRechargeByAlipay());
    }
    public static String doRechargeByAlipay() throws ApiException {
        String cid = "c201144112444";
        String orderString = null;
        try {
            Double rechargeAmountDouble = 0.01;


            String notify_url = "http://211.87.239.36/dazhimen/api/recharge/dealAliPayRechargeResult";
            orderString = AlipayUtil.orderPay(rechargeAmountDouble, "dazhimentest00021213123","大职门余额充值", notify_url, cid);
            if(orderString != null && !orderString.equals("")){
                System.out.println("统一下单接口调用成功---[" + orderString + "]");
            }else{
                throw new ApiException("统一下单接口调用错误");
            }

        } catch (ApiException e){
            e.printStackTrace();
            throw new ApiException(e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            throw new ApiException("出现异常，发起微信支付充值失败");
        }
        return orderString;
    }
}
