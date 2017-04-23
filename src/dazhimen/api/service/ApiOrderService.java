package dazhimen.api.service;

import com.google.gson.Gson;
import dazhimen.api.bean.*;
import dazhimen.api.bean.customer.ApiCustomerBean;
import dazhimen.api.bean.order.*;
import dazhimen.api.bean.product.ApiListViewCourseBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import db.MyBatisUtil;
import net.sf.json.JSONObject;
import org.apache.ibatis.session.SqlSession;
import util.*;
import util.pay.AlipayUtil;
import util.pay.WXPayUtil;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2017/4/6.
 */
public class ApiOrderService {
    public List<ApiCustomerPurchaseProductBean> getPurchaseProductByCid(HttpServletRequest resq) throws ApiException {
        String cid = resq.getParameter("cid");
        if(!new CheckIsExistsUtils().checkCidIsExists(cid)){
            throw new ApiException("传入的[cid]值，无效。在数据库中不存在。");
        }
        SqlSession sqlSession = null;
        List<ApiCustomerPurchaseProductBean> productBeans = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            productBeans = sqlSession.selectList("dazhimen.api.bean.ApiOrder.getPurchaseProductByCid", cid);
            for(int i = 0 ; i < productBeans.size(); i++){
                ApiCustomerPurchaseProductBean productBean = productBeans.get(i);
                String pid = productBean.getPid();
                List<ApiListViewCourseBean> courseBeans = sqlSession.selectList("dazhimen.api.bean.ApiProduct.getProductCourseList", pid);
                if(courseBeans == null || courseBeans.size() == 0){
                    productBean.setCourselist("");
                }else{
                    courseBeans = dealApiListViewCourseBean(resq,courseBeans);
                    productBean.setCourselist(new Gson().toJson(courseBeans));
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return productBeans;
    }
    private List<ApiListViewCourseBean> dealApiListViewCourseBean(HttpServletRequest resq,
                                                                  List<ApiListViewCourseBean> courseBeans){
        String localIp = resq.getLocalAddr();//获取本地ip
        if(Constant.isDeployInAliyun){
            localIp = Constant.AliyunIP;
        }
        int localPort = resq.getLocalPort();//获取本地的端口
        String appName = resq.getContextPath();
        for(int i = 0; i < courseBeans.size(); i++){
            ApiListViewCourseBean courseBean = courseBeans.get(i);
            Date createDateO = courseBean.getCreatedateo();
            SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
            Calendar cal = Calendar.getInstance();
            cal.setTime(createDateO);
            String createdate = cal.get(Calendar.MONTH) + 1 + "月" + cal.get(Calendar.DAY_OF_MONTH)+"日";
            courseBean.setCreatedate(createdate);
            courseBean.setCreatedateo(null);

            String audioUrl = "http://" + localIp + ":" + localPort + appName + "/" + courseBean.getAudiourl();
            courseBean.setAudiourl(audioUrl);
            String listimgurl = "http://" + localIp + ":" + localPort + appName + "/" + courseBean.getListimgurl();
            courseBean.setListimgurl(listimgurl);
        }
        return courseBeans;
    }
    public void buyProductByBalance(String cid, String pid,String verifycode) throws ApiException {
        CheckIsExistsUtils isExistsUtils = new CheckIsExistsUtils();
        if(!isExistsUtils.checkCidIsExists(cid)){
            throw new ApiException("传入的[cid]值，无效。在数据库中不存在。");
        }
        if(!isExistsUtils.checkPidIsExists(pid)){
            throw new ApiException("传入的[pid]值，无效。在数据库中不存在，或者产品已经下架。");
        }
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            ApiCustomerBean customerBean = sqlSession.selectOne("dazhimen.api.bean.ApiLogin.getCustomerInfoByCid", cid);
            if(customerBean == null || customerBean.getMphone() == null || customerBean.getMphone().equals("")){
                throw new ApiException("出现异常，查询会员对应手机号码出错");
            }
            String mphone = customerBean.getMphone();
            //校验验证码
            if(!VerifyCodeUtils.checkVerifyCode(verifycode) && !VerifyCodeUtils.checkMobileVerifyCode(customerBean.getMphone(), verifycode)){
                throw new ParameterCheckException("验证码输入错误");
            }
            ApiCheckProductIsBuyBean checkProductIsBuyBean = new ApiCheckProductIsBuyBean();
            checkProductIsBuyBean.setPid(pid);
            checkProductIsBuyBean.setCid(cid);
            SingleValueBean valueBean = sqlSession.selectOne("dazhimen.api.bean.ApiOrder.checkProductIsBuy", checkProductIsBuyBean);
            if(valueBean != null && valueBean.getValueInfo()!= null && valueBean.getValueInfo().equals("1")){
                throw new ApiException("该产品已经购买，不能重复购买");
            }
            ApiBalanceBean balanceBean = sqlSession.selectOne("dazhimen.api.bean.ApiOrder.getBalanceByCid",cid);
            if(balanceBean == null || balanceBean.getAccoutbalance() == null){
                throw new ApiException("出现异常，获取会员余额信息异常");
            }
            ApiProductPriceBean productPriceBean = sqlSession.selectOne("dazhimen.api.bean.ApiOrder.getProductPriceByPid", pid);
            if(productPriceBean == null || productPriceBean.getPrice() == null || productPriceBean.getDerateProportion() == null){
                throw new ApiException("出现异常，获取产品价格信息异常");
            }
            Double accountBalance = balanceBean.getAccoutbalance();
            Double productPrice = productPriceBean.getPrice();
            Integer derateProportion = productPriceBean.getDerateProportion();
            Double realPayPrice = productPrice * ((100.0 - derateProportion)/100.0);
            if(accountBalance < realPayPrice){
                throw new ApiException("余额不足");
            }
            ApiBuyProductByBalance buyProductByBalance = new ApiBuyProductByBalance();
            String orderid = new IdUtils().getOrderId();
            buyProductByBalance.setOrid(orderid);
            buyProductByBalance.setCid(cid);
            buyProductByBalance.setOrdersum(realPayPrice);
            buyProductByBalance.setPaymenttype(Constant.paymentType_Balance);
            sqlSession.insert("dazhimen.api.bean.ApiOrder.buyProductByBalance", buyProductByBalance);

            ApiIROrderProductBean irOrderProductBean = new ApiIROrderProductBean();
            irOrderProductBean.setOrid(orderid);
            irOrderProductBean.setPid(pid);
            sqlSession.insert("dazhimen.api.bean.ApiOrder.dealIrOrderProduct", irOrderProductBean);

            ApiUpdateCustomerBalanceBean updateCustomerBalanceBean = new ApiUpdateCustomerBalanceBean();
            updateCustomerBalanceBean.setChangeamount(realPayPrice);
            updateCustomerBalanceBean.setCid(cid);
            sqlSession.update("dazhimen.api.bean.ApiOrder.updateCustomerBalanceAfterBuy", updateCustomerBalanceBean);

            //更新产品的buycount
            sqlSession.update("dazhimen.api.bean.ApiOrder.updateProductBuyCount", pid);
            sqlSession.commit();
        }catch (ApiException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException(e.getMessage());
        }catch (Exception e){
            sqlSession.rollback();
            e.printStackTrace();
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public SortedMap<String, Object> buyProductByWXPay(String cid, String pid, String remoteIp, String notify_url) throws ApiException {
        SortedMap<String, Object> resultMap = null;
        CheckIsExistsUtils isExistsUtils = new CheckIsExistsUtils();
        if (!isExistsUtils.checkCidIsExists(cid)) {
            throw new ApiException("传入的[cid]值，无效。在数据库中不存在。");
        }
        if (!isExistsUtils.checkPidIsExists(pid)) {
            throw new ApiException("传入的[pid]值，无效。在数据库中不存在，或者产品已经下架。");
        }

        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();

            ApiCheckProductIsBuyBean checkProductIsBuyBean = new ApiCheckProductIsBuyBean();
            checkProductIsBuyBean.setPid(pid);
            checkProductIsBuyBean.setCid(cid);
            SingleValueBean valueBean = sqlSession.selectOne("dazhimen.api.bean.ApiOrder.checkProductIsBuy", checkProductIsBuyBean);
            if(valueBean != null && valueBean.getValueInfo()!= null && valueBean.getValueInfo().equals("1")){
                throw new ApiException("该产品已经购买，不能重复购买");
            }

            ApiProductPriceBean productPriceBean = sqlSession.selectOne("dazhimen.api.bean.ApiOrder.getProductPriceByPid", pid);
            if(productPriceBean == null || productPriceBean.getPrice() == null || productPriceBean.getDerateProportion() == null){
                throw new ApiException("出现异常，获取产品价格信息异常");
            }
            Double productPrice = productPriceBean.getPrice();
            String pname = productPriceBean.getPname();

            String orderid = new IdUtils().getOrderId();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("cid", cid);
            jsonObject.put("pid", pid);
            Map<String, String> map = WXPayUtil.weixinPrePay(orderid, new BigDecimal(productPrice.toString()),pname, remoteIp, notify_url, jsonObject.toString());
            if(map.get("result_code").toString().equalsIgnoreCase("SUCCESS")){
                resultMap = WXPayUtil.createSignAgain(map);
                resultMap.put("orderid", orderid);
                resultMap.put("pid", pid);
                System.out.println("统一下单接口调用成功---[" + orderid + "]");
            }else{
                throw new ApiException("统一下单接口调用错误:" + map.get("err_code_des"));
            }
        }catch (ApiException e){
            e.printStackTrace();
            throw new ApiException(e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            throw new ApiException("出现异常，发起微信支付充值失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return resultMap;
    }
    public Map<String, String> buyProductByAlipay(String cid, String pid , String notify_url) throws ApiException {
        CheckIsExistsUtils isExistsUtils = new CheckIsExistsUtils();
        if (!isExistsUtils.checkCidIsExists(cid)) {
            throw new ApiException("传入的[cid]值，无效。在数据库中不存在。");
        }
        if (!isExistsUtils.checkPidIsExists(pid)) {
            throw new ApiException("传入的[pid]值，无效。在数据库中不存在，或者产品已经下架。");
        }
        SqlSession sqlSession = null;
        HashMap<String, String> resultMap = new HashMap<>();
        String orderString = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            ApiCheckProductIsBuyBean checkProductIsBuyBean = new ApiCheckProductIsBuyBean();
            checkProductIsBuyBean.setPid(pid);
            checkProductIsBuyBean.setCid(cid);
            SingleValueBean valueBean = sqlSession.selectOne("dazhimen.api.bean.ApiOrder.checkProductIsBuy", checkProductIsBuyBean);
            if(valueBean != null && valueBean.getValueInfo()!= null && valueBean.getValueInfo().equals("1")){
                throw new ApiException("该产品已经购买，不能重复购买");
            }

            ApiProductPriceBean productPriceBean = sqlSession.selectOne("dazhimen.api.bean.ApiOrder.getProductPriceByPid", pid);
            if(productPriceBean == null || productPriceBean.getPrice() == null || productPriceBean.getDerateProportion() == null){
                throw new ApiException("出现异常，获取产品价格信息异常");
            }
            Double productPrice = productPriceBean.getPrice();
            String pname = productPriceBean.getPname();

            String orderid = new IdUtils().getOrderId();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("cid", cid);
            jsonObject.put("pid", pid);
            orderString = AlipayUtil.orderPay(productPrice, orderid,pname, notify_url, jsonObject.toString());
            if(orderString != null && !orderString.equals("")){
                System.out.println("支付宝统一下单接口调用成功---[" + orderString + "]");
            }else{
                throw new ApiException("支付宝统一下单接口调用错误");
            }
            resultMap.put("orderstring", orderString);
            resultMap.put("orderid", orderid);
            resultMap.put("pid", pid);
        } catch (ApiException e){
            e.printStackTrace();
            throw new ApiException(e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return resultMap;
    }
    public void dealAliPayByProductResult(Map<String, String> map) throws ApiException {
        SqlSession sqlSession = null;
        try {
            String trade_status = map.get("trade_status");
            if(trade_status == null || trade_status.equals("") || !trade_status.equals("TRADE_SUCCESS")){
                throw new ApiException("支付宝购买产品回调，返回交易状态异常");
            }
            String orderid = map.get("out_trade_no");
            //改订单表，添加微信支付相关信息
            String transaction_id = map.get("trade_no");
            String total_amount_str = map.get("total_amount");
            Double orderamount = Double.parseDouble(total_amount_str);
            String attach = map.get("passback_params");

            Gson gson = new Gson();
            Map<String, Object> attachMap = new HashMap<String, Object>();
            attachMap = gson.fromJson(attach, attachMap.getClass());
            String cid = attachMap.get("cid").toString();
            String pid = attachMap.get("pid").toString();

            sqlSession = MyBatisUtil.createSession();
            SingleValueBean valueBean = sqlSession.selectOne("dazhimen.api.bean.ApiOrder.checkISTransactionExists", transaction_id);
            if(valueBean != null && valueBean.getValueInfo() != null && valueBean.getValueInfo().equals("1")){
                return;
            }
            ApiBuyProductByWXPay buyProductByWXPay = new ApiBuyProductByWXPay();
            buyProductByWXPay.setOrid(orderid);
            buyProductByWXPay.setCid(cid);
            buyProductByWXPay.setOrdersum(orderamount);
            buyProductByWXPay.setPaymenttype(Constant.paymentType_AliPay);
            buyProductByWXPay.setTransaction_id(transaction_id);
            sqlSession.insert("dazhimen.api.bean.ApiOrder.buyProductByWXPay", buyProductByWXPay);

            ApiIROrderProductBean irOrderProductBean = new ApiIROrderProductBean();
            irOrderProductBean.setOrid(orderid);
            irOrderProductBean.setPid(pid);
            sqlSession.insert("dazhimen.api.bean.ApiOrder.dealIrOrderProduct", irOrderProductBean);

            sqlSession.update("dazhimen.api.bean.ApiOrder.updateProductBuyCount", pid);
            sqlSession.commit();

        }catch (ApiException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException(e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException("出现异常，处理支付宝结果失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public void dealWXPayBuyProductResult(Map<String, String> map) throws ApiException {
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            String orderid = map.get("out_trade_no");
            //改订单表，添加微信支付相关信息
            String transaction_id = map.get("transaction_id");
            String total_free_str = map.get("total_fee");
            Double orderamount = Double.parseDouble(total_free_str) / 100.0;
            String attach = map.get("attach");

            Gson gson = new Gson();
            Map<String, Object> attachMap = new HashMap<String, Object>();
            attachMap = gson.fromJson(attach, attachMap.getClass());
            String cid = attachMap.get("cid").toString();
            String pid = attachMap.get("pid").toString();

            SingleValueBean valueBean = sqlSession.selectOne("dazhimen.api.bean.ApiOrder.checkISTransactionExists", transaction_id);
            if(valueBean != null && valueBean.getValueInfo() != null && valueBean.getValueInfo().equals("1")){
                return;
            }

            ApiBuyProductByWXPay buyProductByWXPay = new ApiBuyProductByWXPay();
            buyProductByWXPay.setOrid(orderid);
            buyProductByWXPay.setCid(cid);
            buyProductByWXPay.setOrdersum(orderamount);
            buyProductByWXPay.setPaymenttype(Constant.paymentType_WXPay);
            buyProductByWXPay.setTransaction_id(transaction_id);
            sqlSession.insert("dazhimen.api.bean.ApiOrder.buyProductByWXPay", buyProductByWXPay);

            ApiIROrderProductBean irOrderProductBean = new ApiIROrderProductBean();
            irOrderProductBean.setOrid(orderid);
            irOrderProductBean.setPid(pid);
            sqlSession.insert("dazhimen.api.bean.ApiOrder.dealIrOrderProduct", irOrderProductBean);

            //更新产品的buycount
            //更新产品的buycount
            sqlSession.update("dazhimen.api.bean.ApiOrder.updateProductBuyCount", pid);

            sqlSession.commit();
        }catch (Exception e){
            sqlSession.rollback();
            throw new ApiException("处理微信支付结果失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public boolean recheckWXPayBuyProductResult(String orderid, String pid, String cid) throws ApiException {
        CheckIsExistsUtils checkIsExistsUtils = new CheckIsExistsUtils();
        if(!checkIsExistsUtils.checkCidIsExists(cid)){
            throw new ApiException("传入的[cid]值，无效。在数据库中不存在。");
        }
        if(!checkIsExistsUtils.checkPidIsExists(pid)){
            throw new ApiException("传入的[pid]值，无效。在数据库中不存在，或者产品已经下架。");
        }
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean valueBean = sqlSession.selectOne("dazhimen.api.bean.ApiOrder.checkProductIsBuyByOrid", orderid);
            if(valueBean != null && valueBean.getValueInfo()!= null && valueBean.getValueInfo().equals("1")){
                return true;
            }
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        Map<String, String> map = WXPayUtil.queryWXOrderInfo(orderid);
        if (map.get("result_code").toString().equalsIgnoreCase("SUCCESS")) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("pid", pid);
            jsonObject.put("cid", cid);
            map.put("attach", jsonObject.toString());
            dealWXPayBuyProductResult(map);
            return true;
        }else {
            return false;
        }
    }
    public boolean recheckAlipayBuyProductResult(String orderid, String pid, String cid) throws ApiException {
        CheckIsExistsUtils checkIsExistsUtils = new CheckIsExistsUtils();
        if(!checkIsExistsUtils.checkCidIsExists(cid)){
            throw new ApiException("传入的[cid]值，无效。在数据库中不存在。");
        }
        if(!checkIsExistsUtils.checkPidIsExists(pid)){
            throw new ApiException("传入的[pid]值，无效。在数据库中不存在，或者产品已经下架。");
        }
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean valueBean = sqlSession.selectOne("dazhimen.api.bean.ApiOrder.checkProductIsBuyByOrid", orderid);
            if(valueBean != null && valueBean.getValueInfo()!= null && valueBean.getValueInfo().equals("1")){
                return true;
            }
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        Map<String, String> map = AlipayUtil.orderQuery(orderid);
        String trade_status = map.get("trade_status");
        if(trade_status != null && !trade_status.equals("") && trade_status.equals("TRADE_SUCCESS")){
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("pid", pid);
            jsonObject.put("cid", cid);
            map.put("passback_params", jsonObject.toString());
            dealAliPayByProductResult(map);
            return true;
        } else{
            return false;
        }
    }
}
