package dazhimen.api.controller;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayConstants;
import com.alipay.api.internal.util.AlipaySignature;
import com.google.gson.Gson;
import dazhimen.api.bean.order.ApiCustomerPurchaseProductBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import dazhimen.api.service.ApiOrderService;
import net.sf.json.JSONObject;
import org.jdom.JDOMException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import util.pay.AlipayUtil;
import util.ApiUtils;
import util.Constant;
import util.pay.WXPayUtil;
import util.web.ResponseUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

/**
 * Created by Administrator on 2017/4/6.
 */
@Controller
@RequestMapping("/api/order")
public class ApiOrderController {
    @RequestMapping(value = "/getPurchaseProductByCid.do",method = RequestMethod.POST)
    public void getPurchaseProductByCid(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            checkGetPurchaseProductByCidPara(resq);
            ApiOrderService orderService = new ApiOrderService();
            List<ApiCustomerPurchaseProductBean> productBeans = orderService.getPurchaseProductByCid(resq);
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "200");
            jsonObject.put("msg", "获取成功");
            if(productBeans == null || productBeans.size()==0){
                jsonObject.put("data", new Gson().toJson(null));
            }else{
                productBeans = dealPurchaseProductBean(resq,productBeans);
                jsonObject.put("data", new Gson().toJson(productBeans));
            }
            ResponseUtil.writeMsg(resp, jsonObject.toString());
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }
    @RequestMapping(value="/buyProductByBalance.do", method = RequestMethod.POST)
    public void buyProductByBalance(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            checkBuyProductByBalanceParams(resq);
            ApiOrderService orderService = new ApiOrderService();
            orderService.buyProductByBalance(resq.getParameter("cid"), resq.getParameter("pid"), resq.getParameter("verifycode"));
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "200");
            jsonObject.put("msg", "购买成功");
            ResponseUtil.writeMsg(resp, jsonObject.toString());
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }

    }

    @RequestMapping(value="/buyProductByWXPay.do", method = RequestMethod.POST)
    public void buyProductByWXPay(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            checkBuyProductByWXPayAlipayPara(resq);

            String remoteIp = resq.getRemoteAddr();
            if(remoteIp == null || remoteIp.equals("")){
                remoteIp = "123.12.12.123";
            }
            String localIp = resq.getLocalAddr();
            String appName = resq.getContextPath();
            if(Constant.isDeployInAliyun){
                localIp = Constant.AliyunIP;
            }
            int localPort = resq.getLocalPort();
            String notify_url = "http://" + localIp + ":" + localPort + appName + "/api/order/dealWXPayBuyProductResult.do";

            String cid = resq.getParameter("cid");
            String pid = resq.getParameter("pid");

            ApiOrderService orderService = new ApiOrderService();
            SortedMap<String, Object> resultMap = orderService.buyProductByWXPay(cid, pid, remoteIp, notify_url);
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "200");
            jsonObject.put("msg", "获取成功");
            jsonObject.put("data", resultMap);
            ResponseUtil.writeMsg(resp, jsonObject.toString());
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }
    @RequestMapping(value="/buyProductByAlipay.do", method = RequestMethod.POST)
    public void buyProductByAlipay(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            checkBuyProductByWXPayAlipayPara(resq);
            String localIp = resq.getLocalAddr();
            String appName = resq.getContextPath();
            if(Constant.isDeployInAliyun){
                localIp = Constant.AliyunIP;
            }
            int localPort = resq.getLocalPort();
            String notify_url = "http://" + localIp + ":" + localPort + appName + "/api/order/dealAliPayByProductResult.do";

            String cid = resq.getParameter("cid");
            String pid = resq.getParameter("pid");
            ApiOrderService orderService = new ApiOrderService();
            Map<String, String> resultMap = orderService.buyProductByAlipay(cid, pid, notify_url);
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "200");
            jsonObject.put("msg", "获取成功");
            jsonObject.put("orderstring", resultMap.get("orderstring"));
            jsonObject.put("orderid", resultMap.get("orderid"));
            jsonObject.put("pid", resultMap.get("pid"));
            ResponseUtil.writeMsg(resp, jsonObject.toString());
        }catch (ParameterCheckException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }
    @RequestMapping("/dealAliPayByProductResult.do")
    public void dealAliPayRechargeResult(HttpServletRequest resq, HttpServletResponse resp){
        //获取支付宝POST过来反馈信息
        System.out.println("=======Start   支付宝支付购买产品，支付结果处理========");
        Map<String,String> params = new HashMap<String,String>();
        Map requestParams = resq.getParameterMap();
        for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
            String name = (String) iter.next();
            String[] values = (String[]) requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i]
                        : valueStr + values[i] + ",";
            }
            //乱码解决，这段代码在出现乱码时使用。
            //valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
            params.put(name, valueStr);
        }
        try {
            boolean flag = AlipaySignature.rsaCheckV1(params, AlipayUtil.ALIPAY_PUBLIC_KEY, AlipayConstants.CHARSET_UTF8,AlipayConstants.SIGN_TYPE_RSA);
            if(flag){
                System.out.println("========【支付宝购买】订单支付成功=========");
                System.out.println(params.toString());
                ApiOrderService orderService = new ApiOrderService();
                orderService.dealAliPayByProductResult(params);
            }else{
                System.out.println("========【支付宝购买】订单支付失败=========");
            }
        } catch (AlipayApiException e) {
            e.printStackTrace();
        } catch (ApiException e) {
            e.printStackTrace();
        }
        System.out.println("=======End  支付宝支付购买产品，支付结果处理========");
    }
    @RequestMapping("/dealWXPayBuyProductResult.do")
    public void dealWXPayBuyProductResult(HttpServletRequest resq, HttpServletResponse resp) throws IOException, JDOMException, ApiException {
        System.out.println("=======Start   微信支付购买产品，支付结果处理========");
        InputStream inStream = null;
        ByteArrayOutputStream outSteam = null;
        try {
            inStream = resq.getInputStream();
            outSteam = new ByteArrayOutputStream();
            byte[] buffer = new byte[1024];
            int len = 0;
            while ((len = inStream.read(buffer)) != -1){
                outSteam.write(buffer, 0, len);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            outSteam.close();
            inStream.close();
        }

        String result = new String(outSteam.toByteArray(), "utf-8");
        Map<String, String> map = WXPayUtil.doXMLParse(result);
        System.out.println("====接口返回值为=====");
        System.out.println(map);;
        if (map.get("result_code").toString().equalsIgnoreCase("SUCCESS")) {
            if (WXPayUtil.verifyWeixinNotify(map)) {
                //订单处理
                ApiOrderService rechargeService = new ApiOrderService();
                rechargeService.dealWXPayBuyProductResult(map);
                System.out.println("处理微信知否，购买，通知成功");
                StringBuffer resultBF = new StringBuffer();
                resultBF.append("<xml>");
                resultBF.append("<return_code><![CDATA[SUCCESS]]></return_code>");
                resultBF.append("<return_msg><![CDATA[OK]]></return_msg>");
                resultBF.append("</xml>");
                resp.getWriter().write(resultBF.toString());
            }
        }else{
            System.out.println("订单结果为失败");
        }
        System.out.println("=======End  微信支付购买产品，支付结果处理========");
    }
    @RequestMapping(value = "/recheckWXPayBuyProductResult.do", method = RequestMethod.POST)
    public void recheckWXPayBuyProductResult(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            checkWXPayBuyProductResultPara(resq);
            ApiOrderService orderService = new ApiOrderService();
            boolean result = orderService.recheckWXPayBuyProductResult(resq.getParameter("orderid"), resq.getParameter("pid"), resq.getParameter("cid"));
            if(result){
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("code", "200");
                jsonObject.put("msg", "复核成功");
                ResponseUtil.writeMsg(resp, jsonObject.toString());
            }else{
                ResponseUtil.writeFailMsgToApiResult(resp, "复核失败");
            }
        }catch (ParameterCheckException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }

    @RequestMapping(value = "/recheckAlipayBuyProductResult.do", method = RequestMethod.POST)
    public void recheckAlipayBuyProductResult(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            checkAlipayBuyProductResultPara(resq);
            ApiOrderService orderService = new ApiOrderService();
            boolean result = orderService.recheckAlipayBuyProductResult(resq.getParameter("orderid"), resq.getParameter("pid"), resq.getParameter("cid"));
            if(result){
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("code", "200");
                jsonObject.put("msg", "复核成功");
                ResponseUtil.writeMsg(resp, jsonObject.toString());
            }else{
                ResponseUtil.writeFailMsgToApiResult(resp, "复核失败");
            }
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }
    private List<ApiCustomerPurchaseProductBean> dealPurchaseProductBean(HttpServletRequest resq,
                                                                       List<ApiCustomerPurchaseProductBean> productBeans){
        String localIp = resq.getLocalAddr();//获取本地ip
        if(Constant.isDeployInAliyun){
            localIp = Constant.AliyunIP;
        }
        int localPort = resq.getLocalPort();//获取本地的端口
        String appName = resq.getContextPath();
        for(int i = 0; i < productBeans.size(); i++){
            ApiCustomerPurchaseProductBean productBean = productBeans.get(i);

            String listImgUrl = "http://" + localIp + ":" + localPort + appName + "/" + productBean.getListimgurl();
            productBean.setListimgurl(listImgUrl);

            String mainImgUrl = "http://" + localIp + ":" + localPort + appName + "/" + productBean.getMainimgurl();
            productBean.setMainimgurl(mainImgUrl);
        }
        return productBeans;
    }
    private void checkWXPayBuyProductResultPara(HttpServletRequest resq) throws ParameterCheckException {
        String orderid = resq.getParameter("orderid");
        if(orderid == null){
            throw new ParameterCheckException("未取到参数[orderid]");
        }
        if(orderid.equals("")){
            throw new ParameterCheckException("参数[orderid]的值为空");
        }

        String pid = resq.getParameter("pid");
        if(pid == null){
            throw new ParameterCheckException("未取到参数[pid]");
        }
        if(pid.equals("")){
            throw new ParameterCheckException("参数[pid]的值为空");
        }
        String cid = resq.getParameter("cid");
        if(cid == null){
            throw new ParameterCheckException("未取到参数[cid]");
        }
        if(cid.equals("")){
            throw new ParameterCheckException("参数[cid]的值为空");
        }
    }
    private void checkAlipayBuyProductResultPara(HttpServletRequest resq) throws ParameterCheckException {
        String orderid = resq.getParameter("orderid");
        if(orderid == null){
            throw new ParameterCheckException("未取到参数[orderid]");
        }
        if(orderid.equals("")){
            throw new ParameterCheckException("参数[orderid]的值为空");
        }

        String pid = resq.getParameter("pid");
        if(pid == null){
            throw new ParameterCheckException("未取到参数[pid]");
        }
        if(pid.equals("")){
            throw new ParameterCheckException("参数[pid]的值为空");
        }
        String cid = resq.getParameter("cid");
        if(cid == null){
            throw new ParameterCheckException("未取到参数[cid]");
        }
        if(cid.equals("")){
            throw new ParameterCheckException("参数[cid]的值为空");
        }
    }
    private void checkBuyProductByBalanceParams(HttpServletRequest resq) throws ParameterCheckException {
        String pid = resq.getParameter("pid");
        if(pid == null){
            throw new ParameterCheckException("未取到参数[pid]");
        }
        if(pid.equals("")){
            throw new ParameterCheckException("参数[pid]的值为空");
        }
        String cid = resq.getParameter("cid");
        if(cid == null){
            throw new ParameterCheckException("未取到参数[cid]");
        }
        if(cid.equals("")){
            throw new ParameterCheckException("参数[cid]的值为空");
        }
        String verifycode = resq.getParameter("verifycode");
        if(verifycode == null){
            throw new ParameterCheckException("未取到参数[verifycode]");
        }
        if(verifycode.equals("")){
            throw new ParameterCheckException("参数[verifycode]的值为空");
        }
    }
    public void checkBuyProductByWXPayAlipayPara(HttpServletRequest resq) throws ParameterCheckException {
        String pid = resq.getParameter("pid");
        if(pid == null){
            throw new ParameterCheckException("未取到参数[pid]");
        }
        if(pid.equals("")){
            throw new ParameterCheckException("参数[pid]的值为空");
        }
        String cid = resq.getParameter("cid");
        if(cid == null){
            throw new ParameterCheckException("未取到参数[cid]");
        }
        if(cid.equals("")){
            throw new ParameterCheckException("参数[cid]的值为空");
        }
    }
    private void checkGetPurchaseProductByCidPara(HttpServletRequest resq) throws ParameterCheckException {
        String cid = resq.getParameter("cid");
        if(cid == null){
            throw new ParameterCheckException("未取到参数[cid]");
        }
        if(cid.equals("")){
            throw new ParameterCheckException("参数[cid]的值为空");
        }
    }
}
