package dazhimen.api.service;

import dazhimen.api.bean.*;
import dazhimen.api.exception.ApiException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import util.CheckIsExistsUtils;
import util.IdUtils;

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
}
