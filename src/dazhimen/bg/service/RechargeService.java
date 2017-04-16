package dazhimen.bg.service;

import dazhimen.bg.bean.PaginationParamBean;
import dazhimen.bg.bean.SingleValueBean;
import dazhimen.bg.bean.recharge.QueryRechargeParamBean;
import dazhimen.bg.bean.recharge.ViewRechargeBean;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import net.sf.json.JSONObject;
import org.apache.ibatis.session.SqlSession;
import util.PaginationUtil;

import java.util.List;

/**
 * Created by Administrator on 2017/4/5.
 */
public class RechargeService {
    public String queryAllRecharge(String page, String rows) throws BgException {
        List<ViewRechargeBean> rechargeBeans = null;
        SqlSession sqlSession = null;
        Integer totalCount = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean allRechargeCountValue = sqlSession.selectOne("dazhimen.bg.bean.Recharge.getAllRechargeCount");
            if(allRechargeCountValue == null || allRechargeCountValue.getValueInfo() == null){
                throw new BgException("获取充值数据总条数出错");
            }
            totalCount = Integer.parseInt(allRechargeCountValue.getValueInfo());
            PaginationParamBean paramBean = PaginationUtil.getPaginationParamBean(page,rows);
            rechargeBeans = sqlSession.selectList("dazhimen.bg.bean.Recharge.queryAllRecharge", paramBean);
        }catch (BgException e){
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有充值信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", rechargeBeans);
        return jsonObject.toString();
    }

    public String queryAllRechargeByParam(String page, String rows, QueryRechargeParamBean paramBean) throws BgException {
        List<ViewRechargeBean> rechargeBeans = null;
        SqlSession sqlSession = null;
        Integer totalCount = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean allRechargeCountValue = sqlSession.selectOne("dazhimen.bg.bean.Recharge.getAllRechargeCountByParam", paramBean);
            if(allRechargeCountValue == null || allRechargeCountValue.getValueInfo() == null){
                throw new BgException("获取充值数据总条数出错");
            }
            totalCount = Integer.parseInt(allRechargeCountValue.getValueInfo());
            PaginationParamBean paginationParamBean = PaginationUtil.getPaginationParamBean(page,rows);
            paramBean.setStartnum(paginationParamBean.getStartnum());
            paramBean.setGetrows(paginationParamBean.getGetrows());
            rechargeBeans = sqlSession.selectList("dazhimen.bg.bean.Recharge.queryAllRechargeByParam", paramBean);
        }catch (BgException e){
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有充值信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", rechargeBeans);
        return jsonObject.toString();
    }
}
