package util;

import com.alipay.api.AlipayApiException;
import com.alipay.api.domain.AlipayTradeAppPayModel;
import com.alipay.api.request.AlipayTradeAppPayRequest;
import com.alipay.api.response.AlipayTradeAppPayResponse;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import com.alipay.api.AlipayClient;
import com.alipay.api.AlipayConstants;
import com.alipay.api.DefaultAlipayClient;

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
		if(passBackPara != null && passBackPara.equals("")){
			model.setPassbackParams(passBackPara);
		}
		request.setBizModel(model);
		request.setNotifyUrl(notify_url);
		String orderString = null;
		try {
			//这里和普通的接口调用不同，使用的是sdkExecute
			AlipayTradeAppPayResponse response = alipayClient.sdkExecute(request);
			orderString = response.getBody();//就是orderString 可以直接给客户端请求，无需再做处理。
		} catch (AlipayApiException e) {
			e.printStackTrace();
		}
		return orderString;
	}
	public static void main(String[] args){
//		orderPay(0.01, "dazhimentest000001");
	}
}
