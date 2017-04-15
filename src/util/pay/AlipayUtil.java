package util.pay;

import com.alibaba.fastjson.JSON;
import com.alipay.api.AlipayApiException;
import com.alipay.api.domain.AlipayTradeAppPayModel;
import com.alipay.api.request.AlipayTradeAppPayRequest;
import com.alipay.api.request.AlipayTradeQueryRequest;
import com.alipay.api.response.AlipayTradeAppPayResponse;
import com.alipay.api.response.AlipayTradeQueryResponse;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import com.alipay.api.AlipayClient;
import com.alipay.api.AlipayConstants;
import com.alipay.api.DefaultAlipayClient;

import java.util.HashMap;
import java.util.Map;

/**
 * 创建时间：2016年11月10日 下午7:09:08
 * 
 * alipay支付
 * 
 * @author andy
 * @version 2.2
 */

public class AlipayUtil {

	public static final String ALIPAY_APPID = "2017040606565773"; // appid

	public static String APP_PRIVATE_KEY = null; // app支付私钥

	public static String ALIPAY_PUBLIC_KEY = null; // 支付宝公钥

	static {
		try {
			Resource resource = new ClassPathResource("rsa_private_key_pkcs8.pem");
			APP_PRIVATE_KEY = FileUtil.readInputStream2String(resource.getInputStream());
			resource = new ClassPathResource("alipay_public_key_sha1.pem");
			ALIPAY_PUBLIC_KEY = FileUtil.readInputStream2String(resource.getInputStream());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 统一收单交易创建接口
	private static AlipayClient alipayClient = null;

	public static AlipayClient getAlipayClient() {
		if (alipayClient == null) {
			synchronized (AlipayUtil.class) {
				if (null == alipayClient) {
					alipayClient = new DefaultAlipayClient("https://openapi.alipay.com/gateway.do", ALIPAY_APPID,
							APP_PRIVATE_KEY, AlipayConstants.FORMAT_JSON, AlipayConstants.CHARSET_UTF8,
							ALIPAY_PUBLIC_KEY);
				}
			}
		}
		return alipayClient;
	}
	public static Map<String, String> orderQuery(String out_trade_no){
		AlipayTradeQueryRequest alipayRequest = new AlipayTradeQueryRequest(); // 统一收单线下交易查询
		// 只需要传入业务参数
		Map<String, Object> param = new HashMap<>();
		param.put("out_trade_no", out_trade_no); // 商户订单号
		param.put("trade_no", "");// 交易金额
		alipayRequest.setBizContent(JSON.toJSONString(param)); // 不需要对json字符串转义

		Map<String, String> restmap = new HashMap<String, String>();// 返回提交支付宝订单交易查询信息
		boolean flag = false; // 查询状态
		try {
			AlipayTradeQueryResponse alipayResponse = AlipayUtil.getAlipayClient().execute(alipayRequest);
			if (alipayResponse.isSuccess()) {
				// 调用成功，则处理业务逻辑
				if ("10000".equals(alipayResponse.getCode())) {
					// 订单创建成功
					flag = true;
					restmap.put("out_trade_no", alipayResponse.getOutTradeNo());
					restmap.put("trade_no", alipayResponse.getTradeNo());
					restmap.put("trade_status", alipayResponse.getTradeStatus());
					restmap.put("total_amount", alipayResponse.getTotalAmount());
				}
			}
		} catch (AlipayApiException e) {
			e.printStackTrace();
		}
		return restmap;
	}
	public static String orderPay(Double cashnum, String orderid, String description, String notify_url, String passBackPara) {
		//实例化客户端
		AlipayClient alipayClient = new DefaultAlipayClient("https://openapi.alipay.com/gateway.do", AlipayUtil.ALIPAY_APPID,
				APP_PRIVATE_KEY, AlipayConstants.FORMAT_JSON, AlipayConstants.CHARSET_UTF8, ALIPAY_PUBLIC_KEY, AlipayConstants.SIGN_TYPE_RSA);
		//实例化具体API对应的request类,类名称和接口名称对应,当前调用接口名称：alipay.trade.app.pay
		AlipayTradeAppPayRequest request = new AlipayTradeAppPayRequest();
		//SDK已经封装掉了公共参数，这里只需要传入业务参数。以下方法为sdk的model入参方式(model和biz_content同时存在的情况下取biz_content)。
		AlipayTradeAppPayModel model = new AlipayTradeAppPayModel();
		model.setBody(description);
		model.setSubject(description);
		model.setOutTradeNo(orderid);
		model.setTimeoutExpress("30m");
		model.setTotalAmount(String.valueOf(cashnum));
		model.setProductCode("QUICK_MSECURITY_PAY");
		if(passBackPara != null && !passBackPara.equals("")){
			model.setPassbackParams(passBackPara);
		}
		request.setBizModel(model);
		request.setNotifyUrl(notify_url);
		String orderString = null;
		try {
			//这里和普通的接口调用不同，使用的是sdkExecute
			AlipayTradeAppPayResponse response = alipayClient.sdkExecute(request);
			orderString = response.getBody();//就是orderString 可以直接给客户端请求，无需再做处理。
			String tradeNo = response.getTradeNo();
			System.out.println(tradeNo);
		} catch (AlipayApiException e) {
			e.printStackTrace();
		}
		return orderString;
	}
	public static void main(String[] args){
		orderQuery("r17041400128");
	}
}
