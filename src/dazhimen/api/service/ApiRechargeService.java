package dazhimen.api.service;

import dazhimen.api.bean.ApiBalanceBean;
import dazhimen.api.bean.ApiRechargeByWeixinBean;
import dazhimen.api.exception.ApiException;
import db.MyBatisUtil;
import net.sf.json.JSONObject;
import org.apache.ibatis.session.SqlSession;
import util.Constant;
import util.IdUtils;
import util.WXPayUtil;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.Map;
import java.util.SortedMap;

/**
 * Created by Administrator on 2017/4/4.
 */
public class ApiRechargeService {
    public ApiBalanceBean getBalanceByCid(String cid) throws ApiException {
        SqlSession sqlSession = null;
        ApiBalanceBean balanceBean = null;
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
        SortedMap<String, Object> resultMap = null;
        SqlSession sqlSession = null;
        try {
            String cid = resq.getParameter("cid");
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
            String notify_url = "http://" + localIp + ":" + localPort + appName + "/api/recharge/dealWXPayResult";
            String recid = new IdUtils().getRECId();
            Map<String, String> map = WXPayUtil.weixinPrePay(recid, new BigDecimal(rechargeAmount),recid + "的充值测试", remoteIp, notify_url);
            sqlSession = MyBatisUtil.createSession();
            if(map.get("result_code").equals("SUCCESS") && map.get("result_code").equals("SUCCESS")){
                resultMap = WXPayUtil.createSignAgain(map);
                ApiRechargeByWeixinBean rechargeByWeixinBean = new ApiRechargeByWeixinBean();
                rechargeByWeixinBean.setCid(cid);
                rechargeByWeixinBean.setRecamount(Double.parseDouble(rechargeAmount));
                rechargeByWeixinBean.setRecid(recid);
                sqlSession.insert("dazhimen.api.bean.ApiRecharge.doRechargeByWeixin", rechargeByWeixinBean);
                sqlSession.commit();
            }else{
                System.out.println("统一下单接口调用错误");
                throw new ApiException("统一下单接口调用错误");
            }

        } catch (ApiException e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new ApiException(e.getMessage());
        } catch (Exception e) {
            sqlSession.rollback();
            e.printStackTrace();
            throw new ApiException("出现异常，发起微信支付充值失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return resultMap;
    }
}
