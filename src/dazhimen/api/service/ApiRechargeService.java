package dazhimen.api.service;

import dazhimen.api.bean.ApiBalanceBean;
import dazhimen.api.bean.ApiRechargeByWeixinBean;
import dazhimen.api.bean.ApiUpdateCustomerBalanceBean;
import dazhimen.api.bean.SingleValueBean;
import dazhimen.api.exception.ApiException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import util.CheckIsExistsUtils;
import util.Constant;
import util.IdUtils;
import util.pay.WXPayUtil;
import util.pay.AlipayUtil;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.SortedMap;

/**
 * Created by Administrator on 2017/4/4.
 */
public class ApiRechargeService {
    public ApiBalanceBean getBalanceByCid(String cid) throws ApiException {
        SqlSession sqlSession = null;
        ApiBalanceBean balanceBean = null;
        CheckIsExistsUtils checkUtil = new CheckIsExistsUtils();
        if(!checkUtil.checkCidIsExists(cid)){
            throw new ApiException("传入的[cid]值，无效。在数据库中不存在。");
        }
        try{

            sqlSession = MyBatisUtil.createSession();
            balanceBean = sqlSession.selectOne("dazhimen.api.bean.ApiRecharge.getBalanceByCid", cid);
            if(balanceBean == null || balanceBean.getAccoutbalance() == null){
                throw new ApiException("出现异常，查询用户余额出错");
            }
        }catch (ApiException e){
            e.printStackTrace();
            throw new ApiException(e.getMessage());
        }catch(Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，查询用户余额出错");
        } finally{
            MyBatisUtil.closeSession(sqlSession);
        }

        return balanceBean;
    }
    public SortedMap<String, Object> doRechargeByWeixin(HttpServletRequest resq) throws ApiException {
        String cid = resq.getParameter("cid");
        SortedMap<String, Object> resultMap = null;
        CheckIsExistsUtils checkUtil = new CheckIsExistsUtils();
        if(!checkUtil.checkCidIsExists(cid)){
            throw new ApiException("传入的[cid]值，无效。在数据库中不存在。");
        }
        try {
            String rechargeAmount = resq.getParameter("rechargeamout");
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
            String notify_url = "http://" + localIp + ":" + localPort + appName + "/api/recharge/dealWXRechargeResult";
            String recid = new IdUtils().getRECId();
            Map<String, String> map = WXPayUtil.weixinPrePay(recid, new BigDecimal(rechargeAmount),"大职门余额充值", remoteIp, notify_url, cid);
            if(map.get("result_code").toString().equalsIgnoreCase("SUCCESS")){
                resultMap = WXPayUtil.createSignAgain(map);
                resultMap.put("recid", recid);
                System.out.println("统一下单接口调用成功---[" + recid + "]");
            }else{
                throw new ApiException("统一下单接口调用错误:" + map.get("err_code_des"));
            }

        } catch (ApiException e){
            e.printStackTrace();
            throw new ApiException(e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            throw new ApiException("出现异常，发起微信支付充值失败");
        }
        return resultMap;
    }
    public HashMap doRechargeByAlipay(HttpServletRequest resq) throws ApiException {
        String cid = resq.getParameter("cid");
        HashMap<String, String> resultMap = new HashMap<>();
        String orderString = null;
        CheckIsExistsUtils checkUtil = new CheckIsExistsUtils();
        if(!checkUtil.checkCidIsExists(cid)){
            throw new ApiException("传入的[cid]值，无效。在数据库中不存在。");
        }
        try {
            String rechargeAmount = resq.getParameter("rechargeamout");
            Double rechargeAmountDouble = null;
            try{
                rechargeAmountDouble = Double.parseDouble(rechargeAmount);
            }catch (NumberFormatException e){
                e.printStackTrace();
                throw new ApiException("支付宝统一下单接口调用错误:充值金额不是有效的数字");
            }

            String localIp = resq.getLocalAddr();
            String appName = resq.getContextPath();
            if(Constant.isDeployInAliyun){
                localIp = Constant.AliyunIP;
            }
            int localPort = resq.getLocalPort();
            String notify_url = "http://" + localIp + ":" + localPort + appName + "/api/recharge/dealAliPayRechargeResult";
            String recid = new IdUtils().getRECId();
            resultMap.put("recid", recid);
            orderString = AlipayUtil.orderPay(rechargeAmountDouble, recid,"大职门余额充值", notify_url, cid);
            if(orderString != null && !orderString.equals("")){
                System.out.println("支付宝统一下单接口调用成功---[" + orderString + "]");
            }else{
                throw new ApiException("支付宝统一下单接口调用错误");
            }
            resultMap.put("orderstring", orderString);
        } catch (ApiException e){
            e.printStackTrace();
            throw new ApiException(e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            throw new ApiException("出现异常，发起支付宝充值失败");
        }
        return resultMap;
    }
    public void dealWXRechargeResult(Map<String, String> map) throws ApiException {
        //更新用户余额，并更新充值记录的数据
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            String recid = map.get("out_trade_no");
            String transaction_id = map.get("transaction_id");
            String total_free_str = map.get("total_fee");
            Double recamount = Double.parseDouble(total_free_str)/100.0;
            String cid = map.get("attach");

            SingleValueBean valueBean = sqlSession.selectOne("dazhimen.api.bean.ApiRecharge.checkISTransactionExists", transaction_id);
            if(valueBean != null && valueBean.getValueInfo() != null && valueBean.getValueInfo().equals("1")){
                return;
            }

            ApiRechargeByWeixinBean rechargeByWeixinBean = new ApiRechargeByWeixinBean();
            rechargeByWeixinBean.setCid(cid);
            rechargeByWeixinBean.setRecamount(recamount);
            rechargeByWeixinBean.setRecid(recid);
            rechargeByWeixinBean.setTransaction_id(transaction_id);
            rechargeByWeixinBean.setPaymenttype(Constant.paymentType_WXPay);
            sqlSession.insert("dazhimen.api.bean.ApiRecharge.doRechargeByWeixin", rechargeByWeixinBean);

            ApiUpdateCustomerBalanceBean customerBalanceBean = new ApiUpdateCustomerBalanceBean();
            customerBalanceBean.setChangeamount(recamount);
            customerBalanceBean.setCid(cid);
            sqlSession.update("dazhimen.api.bean.ApiRecharge.updateCustomerBalanceAfterWX",customerBalanceBean);

            sqlSession.commit();

        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException("处理微信支付结果失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public boolean recheckWXRechargeResult(String recid, String cid) throws ApiException {
        if(!new CheckIsExistsUtils().checkCidIsExists(cid)){
            throw new ApiException("传入的[cid]值，无效。在数据库中不存在。");
        }
        Map<String, String> map = WXPayUtil.queryWXOrderInfo(recid);
        if (map.get("result_code").toString().equalsIgnoreCase("SUCCESS")) {
            map.put("attach", cid);
            dealWXRechargeResult(map);
            return true;
        }else{
            return false;
        }
    }

    public void dealAliPayRechargeResult(Map<String, String> map) throws ApiException {
        //更新用户余额，并更新充值记录的数据
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            String trade_status = map.get("trade_status");
            if(trade_status == null || trade_status.equals("") || !trade_status.equals("TRADE_SUCCESS")){
                throw new ApiException("支付宝充值回调，返回交易状态异常");
            }
            String recid = map.get("out_trade_no");
            String trade_no = map.get("trade_no");
            String total_amount_str = map.get("total_amount");
            Double recamount = Double.parseDouble(total_amount_str);
            String cid = map.get("passback_params");
            SingleValueBean valueBean = sqlSession.selectOne("dazhimen.api.bean.ApiRecharge.checkISTransactionExists", trade_no);
            if(valueBean != null && valueBean.getValueInfo() != null && valueBean.getValueInfo().equals("1")){
                return;
            }

            ApiRechargeByWeixinBean rechargeByWeixinBean = new ApiRechargeByWeixinBean();
            rechargeByWeixinBean.setCid(cid);
            rechargeByWeixinBean.setRecamount(recamount);
            rechargeByWeixinBean.setRecid(recid);
            rechargeByWeixinBean.setTransaction_id(trade_no);
            rechargeByWeixinBean.setPaymenttype(Constant.paymentType_AliPay);
            sqlSession.insert("dazhimen.api.bean.ApiRecharge.doRechargeByWeixin", rechargeByWeixinBean);


            ApiUpdateCustomerBalanceBean customerBalanceBean = new ApiUpdateCustomerBalanceBean();
            customerBalanceBean.setChangeamount(recamount);
            customerBalanceBean.setCid(cid);
            sqlSession.update("dazhimen.api.bean.ApiRecharge.updateCustomerBalanceAfterWX",customerBalanceBean);
            sqlSession.commit();
        }catch (ApiException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException(e.getMessage());
        }catch(Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException("处理支付宝充值结果失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public boolean recheckAlipayRechargeResult(String recid, String cid) throws ApiException {
        if(!new CheckIsExistsUtils().checkCidIsExists(cid)){
            throw new ApiException("传入的[cid]值，无效。在数据库中不存在。");
        }
        Map<String, String> map = AlipayUtil.orderQuery(recid);
        String trade_status = map.get("trade_status");
        if(trade_status != null && !trade_status.equals("") && trade_status.equals("TRADE_SUCCESS")){
            map.put("passback_params", cid);
            dealAliPayRechargeResult(map);
            return true;
        } else{
            return false;
        }
    }
}
