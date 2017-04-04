package util;

import dazhimen.bg.exception.BgException;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.http.Consts;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.ssl.SSLContexts;
import org.apache.http.util.EntityUtils;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

import javax.net.ssl.SSLContext;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.math.BigDecimal;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.KeyStore;
import java.util.*;

public class WXPayUtil{
    //微信参数配置
    public static final String API_KEY = "bEAc07AWaFTFp9wm17xn6wMf7NNqtVxm";
    //
    public static final String APPID = "wx950a4b0af7146165";
    public static final String MCH_ID= "1440557102";

    //随机字符串生成
    public static String getRandomString(int length) { //length表示生成字符串的长度
        String base = "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        Random random = new Random();
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < length; i++) {
            int number = random.nextInt(base.length());
            sb.append(base.charAt(number));
        }
        return sb.toString();
    }
    //请求xml组装
    public static String getRequestXml(SortedMap<String,Object> parameters){
        StringBuffer sb = new StringBuffer();
        sb.append("<xml>");
        Set es = parameters.entrySet();
        Iterator it = es.iterator();
        while(it.hasNext()) {
            Map.Entry entry = (Map.Entry)it.next();
            String key = (String)entry.getKey();
            String value = (String)entry.getValue();
            if ("attach".equalsIgnoreCase(key)||"body".equalsIgnoreCase(key)||"sign".equalsIgnoreCase(key)) {
                sb.append("<"+key+">"+"<![CDATA["+value+"]]></"+key+">");
            }else {
                sb.append("<"+key+">"+value+"</"+key+">");
            }
        }
        sb.append("</xml>");
        return sb.toString();
    }
    //生成签名
    public static String createSign(String characterEncoding,SortedMap<String,Object> parameters){
        StringBuffer sb = new StringBuffer();
        Set es = parameters.entrySet();
        Iterator it = es.iterator();
        while(it.hasNext()) {
            Map.Entry entry = (Map.Entry)it.next();
            String k = (String)entry.getKey();
            Object v = entry.getValue();
            if(null != v && !"".equals(v)
                    && !"sign".equals(k) && !"key".equals(k)) {
                sb.append(k + "=" + v + "&");
            }
        }
        sb.append("key=" + API_KEY);
        String sign = MD5Util.MD5Encode(sb.toString(), characterEncoding).toUpperCase();
        return sign;
    }
    //请求方法
    public static String httpsRequest(String requestUrl, String requestMethod, String outputStr) {
        try {

            URL url = new URL(requestUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);
            // 设置请求方式（GET/POST）
            conn.setRequestMethod(requestMethod);
            conn.setRequestProperty("content-type", "application/x-www-form-urlencoded");
            // 当outputStr不为null时向输出流写数据
            if (null != outputStr) {
                OutputStream outputStream = conn.getOutputStream();
                // 注意编码格式
                outputStream.write(outputStr.getBytes("UTF-8"));
                outputStream.close();
            }
            // 从输入流读取返回内容
            InputStream inputStream = conn.getInputStream();
            InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
            String str = null;
            StringBuffer buffer = new StringBuffer();
            while ((str = bufferedReader.readLine()) != null) {
                buffer.append(str);
            }
            // 释放资源
            bufferedReader.close();
            inputStreamReader.close();
            inputStream.close();
            inputStream = null;
            conn.disconnect();
            return buffer.toString();
        } catch (ConnectException ce) {
            System.out.println("连接超时：{}"+ ce);
        } catch (Exception e) {
            System.out.println("https请求异常：{}"+ e);
        }
        return null;
    }
    //xml解析
    public static Map doXMLParse(String strxml) throws JDOMException, IOException {
        strxml = strxml.replaceFirst("encoding=\".*\"", "encoding=\"UTF-8\"");

        if(null == strxml || "".equals(strxml)) {
            return null;
        }

        Map m = new HashMap();

        InputStream in = new ByteArrayInputStream(strxml.getBytes("UTF-8"));
        SAXBuilder builder = new SAXBuilder();
        Document doc = builder.build(in);
        Element root = doc.getRootElement();
        List list = root.getChildren();
        Iterator it = list.iterator();
        while(it.hasNext()) {
            Element e = (Element) it.next();
            String k = e.getName();
            String v = "";
            List children = e.getChildren();
            if(children.isEmpty()) {
                v = e.getTextNormalize();
            } else {
                v = getChildrenText(children);
            }

            m.put(k, v);
        }

        //关闭流
        in.close();

        return m;
    }

    public static String getChildrenText(List children) {
        StringBuffer sb = new StringBuffer();
        if(!children.isEmpty()) {
            Iterator it = children.iterator();
            while(it.hasNext()) {
                Element e = (Element) it.next();
                String name = e.getName();
                String value = e.getTextNormalize();
                List list = e.getChildren();
                sb.append("<" + name + ">");
                if(!list.isEmpty()) {
                    sb.append(getChildrenText(list));
                }
                sb.append(value);
                sb.append("</" + name + ">");
            }
        }

        return sb.toString();
    }
    public static Map<String, String> weixinPrePay(String sn,BigDecimal totalAmount,
                                                   String description, HttpServletRequest request) {
        SortedMap<String, Object> parameterMap = new TreeMap<String, Object>();
        parameterMap.put("appid", WXPayUtil.APPID);
        parameterMap.put("mch_id", WXPayUtil.MCH_ID);
        parameterMap.put("nonce_str", WXPayUtil.getRandomString(32));
        parameterMap.put("body",
                StringUtils.abbreviate(description.replaceAll(
                        "[^0-9a-zA-Z\\u4e00-\\u9fa5 ]", ""), 600));
        parameterMap.put("out_trade_no", sn);
        parameterMap.put("fee_type", "CNY");
        System.out.println("jiner");
        BigDecimal total = totalAmount.multiply(new BigDecimal(100));
        java.text.DecimalFormat df=new java.text.DecimalFormat("0");
        parameterMap.put("total_fee", df.format(total));
        System.out.println("jiner2");
        parameterMap.put("spbill_create_ip", "123.12.12.123");
        parameterMap.put("notify_url", "http://xxx.com");
        parameterMap.put("trade_type", "APP");
        System.out.println("");
        String sign = WXPayUtil.createSign("UTF-8", parameterMap);
        System.out.println("jiner2");
        parameterMap.put("sign", sign);
        String requestXML = WXPayUtil.getRequestXml(parameterMap);
        System.out.println(requestXML);
        String result = WXPayUtil.httpsRequest(
                "https://api.mch.weixin.qq.com/pay/unifiedorder", "POST",
                requestXML);
        System.out.println("result ===" + result);
        Map<String, String> map = null;
        try {
            map = WXPayUtil.doXMLParse(result);
        } catch (JDOMException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return map;
    }
    public static void main(String[] args) throws BgException {
       Map<String, String> map = weixinPrePay(new IdUtils().getRECId(),new BigDecimal("0.01"),"测试", null);
        System.out.println(map);
        System.out.println(verifyWeixinNotify(map));
    }
    public static boolean verifyWeixinNotify(Map<String, String> map) {
        SortedMap<String, Object> parameterMap = new TreeMap<String, Object>();
        String sign = (String) map.get("sign");
        for (Object keyValue : map.keySet()) {
            if(!keyValue.toString().equals("sign")){
                parameterMap.put(keyValue.toString(), map.get(keyValue));
            }

        }
        String createSign = WXPayUtil.createSign("UTF-8", parameterMap);
        if(createSign.equals(sign)){
            return true;
        }else{
            return false;
        }

    }
    public static String createSignAgain(Map<String, String> map){
        JSONObject jsonObject = new JSONObject();
        SortedMap<String, Object> parameterMap = new TreeMap<String, Object>();
        parameterMap.put("appid", WXPayUtil.APPID);
        parameterMap.put("partnerid", WXPayUtil.MCH_ID);
        parameterMap.put("prepayid", map.get("prepay_id"));
        parameterMap.put("package", "Sign=WXPay");
        parameterMap.put("noncestr", WXPayUtil.getRandomString(32));
        parameterMap.put("timestamp", System.currentTimeMillis());
        String sign = WXPayUtil.createSign("UTF-8", parameterMap);
        parameterMap.put("sign", sign);
        jsonObject.put("parameterMap",parameterMap);
        return jsonObject.toString();
}
}