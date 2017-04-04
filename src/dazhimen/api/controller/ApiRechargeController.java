package dazhimen.api.controller;

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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
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
    @RequestMapping("/dealWXPayResult")
    public void dealWXPayResult(HttpServletRequest resq, HttpServletResponse resp) throws IOException, JDOMException {
        InputStream inStream = null;
        inStream = resq.getInputStream();
        ByteArrayOutputStream outSteam = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int len = 0;
        while ((len = inStream.read(buffer)) != -1){
            outSteam.write(buffer, 0, len);
        }
        System.out.println("~~~~~~~~~~~~~~~~付款成功~~~~~~~~~");
        outSteam.close();
        inStream.close();
        String result = new String(outSteam.toByteArray(), "utf-8");// 获取微信调用我们notify_url的返回信息
        Map<String, String> map = WXPayUtil.doXMLParse(result);


        if (map.get("result_code").toString().equalsIgnoreCase("SUCCESS")) {
            //验证签名,在网上看到很多人都不去验证签名，这种做法，一般情况下不会有问题，但是。。。。。，多的我就不说
            if (WXPayUtil.verifyWeixinNotify(map)) {
                //订单处理
                System.out.println(map);
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
