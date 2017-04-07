package dazhimen.api.service;

import com.google.gson.Gson;
import dazhimen.api.bean.*;
import dazhimen.api.exception.ApiException;
import db.MyBatisUtil;
import net.sf.json.JSONObject;
import org.apache.ibatis.session.SqlSession;
import util.CheckIsExistsUtils;
import util.IdUtils;
import util.WXPayUtil;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.SortedMap;

/**
 * Created by Administrator on 2017/4/6.
 */
public class ApiOrderService {
    public void buyProductByBalance(String cid, String pid) throws ApiException {
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
            buyProductByBalance.setPaymenttype("1");
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
        }
        return resultMap;
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
            buyProductByWXPay.setPaymenttype("1");
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
}
