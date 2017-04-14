package dazhimen.api.controller;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayConstants;
import com.alipay.api.internal.util.AlipaySignature;
import com.google.gson.Gson;
import dazhimen.api.bean.ApiBalanceBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import dazhimen.api.service.ApiRechargeService;
import net.sf.json.JSONObject;
import org.jdom.JDOMException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import util.ApiUtils;
import util.Constant;
import util.WXPayUtil;
import util.AlipayUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.SortedMap;

/**
 * Created by Administrator on 2017/4/4.
 */
@Controller
@RequestMapping("/api/recharge")
public class ApiRechargeController {
    @RequestMapping(value="/getBalanceByCid", method = RequestMethod.POST)
    public void getBalanceByCid(HttpServletRequest resq, HttpServletResponse resp){
        try {
            if(resq.getCharacterEncoding() == null)
                resq.setCharacterEncoding(Constant.CharSet);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            ApiUtils.checkSignature(resq);
            checkGetBalanceByCidPara(resq);
            ApiRechargeService rechargeService = new ApiRechargeService();
            ApiBalanceBean balance = rechargeService.getBalanceByCid(resq.getParameter("cid"));
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "200");
            jsonObject.put("msg", "获取成功");
            if(balance == null){
                jsonObject.put("data", new Gson().toJson(null));
            }else{
                jsonObject.put("data", new Gson().toJson(balance));
            }
            try {
                resp.getWriter().write(jsonObject.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        } catch (ApiException e) {
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping(value="/doRechargeByWeixin", method = RequestMethod.POST)
    public void doRechargeByWeixin(HttpServletRequest resq, HttpServletResponse resp){
        try {
            if(resq.getCharacterEncoding() == null)
                resq.setCharacterEncoding(Constant.CharSet);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            ApiUtils.checkSignature(resq);
            checkDoRechargeByWeixinPara(resq);
            ApiRechargeService rechargeService = new ApiRechargeService();

            SortedMap<String, Object> resultMap = rechargeService.doRechargeByWeixin(resq);

            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "200");
            jsonObject.put("msg", "获取成功");
            jsonObject.put("data", resultMap);
            try {
                resp.getWriter().write(jsonObject.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        } catch (ApiException e) {
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/dealWXRechargeResult")
    public void dealWXRechargeResult(HttpServletRequest resq, HttpServletResponse resp) throws IOException, JDOMException, ApiException {
        InputStream inStream = null;
        inStream = resq.getInputStream();
        ByteArrayOutputStream outSteam = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int len = 0;
        while ((len = inStream.read(buffer)) != -1){
            outSteam.write(buffer, 0, len);
        }
        outSteam.close();
        inStream.close();
        String result = new String(outSteam.toByteArray(), "utf-8");// 获取微信调用我们notify_url的返回信息
        Map<String, String> map = WXPayUtil.doXMLParse(result);


        if (map.get("result_code").toString().equalsIgnoreCase("SUCCESS")) {
            if (WXPayUtil.verifyWeixinNotify(map)) {
                //订单处理
                ApiRechargeService rechargeService = new ApiRechargeService();
                rechargeService.dealWXRechargeResult(map);
                System.out.println("处理支付结果通知成功");
                StringBuffer resultBF = new StringBuffer();
                resultBF.append("<xml>");
                resultBF.append("<return_code><![CDATA[SUCCESS]]></return_code>");
                resultBF.append("<return_msg><![CDATA[OK]]></return_msg>");
                resultBF.append("</xml>");
                resp.getWriter().write(resultBF.toString()); // 告诉微信服务器，我收到信息了，不要在调用回调action了
            }
        }else{
            System.out.println("订单结果为失败");
        }

    }
    @RequestMapping(value="/doRechargeByAlipay", method = RequestMethod.POST)
    public void doRechargeByAlipay(HttpServletRequest resq, HttpServletResponse resp){
        try {
            if(resq.getCharacterEncoding() == null)
                resq.setCharacterEncoding(Constant.CharSet);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            ApiUtils.checkSignature(resq);
            checkDoRechargeByWeixinPara(resq);
            ApiRechargeService rechargeService = new ApiRechargeService();

            Map<String, String> resultMap = rechargeService.doRechargeByAlipay(resq);

            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "200");
            jsonObject.put("msg", "获取成功");
            jsonObject.put("orderstring", resultMap.get("orderstring"));
            jsonObject.put("recid", resultMap.get("recid"));
            try {
                resp.getWriter().write(jsonObject.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        } catch (ApiException e) {
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/dealAliPayRechargeResult")
    public void dealAliPayRechargeResult(HttpServletRequest resq, HttpServletResponse resp){
        //获取支付宝POST过来反馈信息
        System.out.println("===========进入支付宝回调=================");
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
                System.out.println("========支付宝订单支付成功=========");
                System.out.println(params.toString());
                ApiRechargeService rechargeService = new ApiRechargeService();
                rechargeService.dealAliPayRechargeResult(params);
            }else{
                System.out.println("========支付宝订单支付失败=========");
            }
        } catch (AlipayApiException e) {
            e.printStackTrace();
        } catch (ApiException e) {
            e.printStackTrace();
        }
    }
    @RequestMapping(value = "/recheckWXRechargeResult", method = RequestMethod.POST)
    public void recheckWXRechargeResult(HttpServletRequest resq, HttpServletResponse resp) throws IOException, JDOMException {
        try {
            if(resq.getCharacterEncoding() == null)
                resq.setCharacterEncoding(Constant.CharSet);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            ApiUtils.checkSignature(resq);
            checkWXRechargeResultPara(resq);
            ApiRechargeService rechargeService = new ApiRechargeService();
            boolean result = rechargeService.recheckWXRechargeResult(resq.getParameter("recid"), resq.getParameter("cid"));
            if(result){
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("code", "200");
                jsonObject.put("msg", "复核成功");
                try {
                    resp.getWriter().write(jsonObject.toString());
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }else{
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("code", "400");
                jsonObject.put("msg", "复核失败");
                try {
                    resp.getWriter().write(jsonObject.toString());
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        } catch (ApiException e) {
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }

    }
    @RequestMapping(value = "/recheckAlipayRechargeResult", method = RequestMethod.POST)
    public void recheckAlipayRechargeResult(HttpServletRequest resq, HttpServletResponse resp) throws IOException, JDOMException {
        try {
            if(resq.getCharacterEncoding() == null)
                resq.setCharacterEncoding(Constant.CharSet);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            ApiUtils.checkSignature(resq);
            checkAlipayRechargeResultPara(resq);
            ApiRechargeService rechargeService = new ApiRechargeService();
            boolean result = rechargeService.recheckAlipayRechargeResult(resq.getParameter("recid"), resq.getParameter("cid"));
            if(result){
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("code", "200");
                jsonObject.put("msg", "复核成功");
                try {
                    resp.getWriter().write(jsonObject.toString());
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }else{
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("code", "400");
                jsonObject.put("msg", "复核失败");
                try {
                    resp.getWriter().write(jsonObject.toString());
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        } catch (ApiException e) {
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }

    }
    private void checkWXRechargeResultPara(HttpServletRequest resq) throws ParameterCheckException {
        String recid = resq.getParameter("recid");
        if(recid == null){
            throw new ParameterCheckException("未取到参数[recid]");
        }
        if(recid.equals("")){
            throw new ParameterCheckException("参数[recid]的值为空");
        }
        String cid = resq.getParameter("cid");
        if(cid == null){
            throw new ParameterCheckException("未取到参数[cid]");
        }
        if(cid.equals("")){
            throw new ParameterCheckException("参数[cid]的值为空");
        }
    }
    private void checkAlipayRechargeResultPara(HttpServletRequest resq) throws ParameterCheckException {
        String recid = resq.getParameter("recid");
        if(recid == null){
            throw new ParameterCheckException("未取到参数[recid]");
        }
        if(recid.equals("")){
            throw new ParameterCheckException("参数[recid]的值为空");
        }
        String cid = resq.getParameter("cid");
        if(cid == null){
            throw new ParameterCheckException("未取到参数[cid]");
        }
        if(cid.equals("")){
            throw new ParameterCheckException("参数[cid]的值为空");
        }
    }
    private void checkGetBalanceByCidPara(HttpServletRequest resq) throws ParameterCheckException {
        String cid = resq.getParameter("cid");
        if(cid == null){
            throw new ParameterCheckException("未取到参数[cid]");
        }
        if(cid.equals("")){
            throw new ParameterCheckException("参数[cid]的值为空");
        }
    }
    private void checkDoRechargeByWeixinPara(HttpServletRequest resq) throws ParameterCheckException {
        String cid = resq.getParameter("cid");
        if(cid == null){
            throw new ParameterCheckException("未取到参数[cid]");
        }
        if(cid.equals("")){
            throw new ParameterCheckException("参数[cid]的值为空");
        }
        String rechargeamout = resq.getParameter("rechargeamout");
        if(rechargeamout == null){
            throw new ParameterCheckException("未取到参数[rechargeamout]");
        }
        if(rechargeamout.equals("")){
            throw new ParameterCheckException("参数[rechargeamout]的值为空");
        }
        try{
            Double.parseDouble(rechargeamout);
        }catch (Exception e){
            throw new ParameterCheckException("参数[rechargeamout]的值，不是合法浮点数");
        }
    }

}
