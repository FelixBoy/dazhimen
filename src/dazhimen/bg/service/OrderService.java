package dazhimen.bg.service;

import dazhimen.bg.bean.PaginationParamBean;
import dazhimen.bg.bean.SingleValueBean;
import dazhimen.bg.bean.order.QueryOrderParamBean;
import dazhimen.bg.bean.order.ViewOrderBean;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import net.sf.json.JSONObject;
import org.apache.ibatis.session.SqlSession;
import util.PaginationUtil;

import java.util.List;

/**
 * Created by Administrator on 2017/4/7.
 */
public class OrderService {
    public String queryAllOrder(String page, String rows) throws BgException {
        SqlSession sqlSession = null;
        Integer totalCount = 0;
        List<ViewOrderBean> orderBeans = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean allOrderCountValue = sqlSession.selectOne("dazhimen.bg.bean.Order.getAllOrderCount");
            if(allOrderCountValue == null || allOrderCountValue.getValueInfo() == null){
                throw new BgException("获取订单数据总条数出错");
            }
            totalCount = Integer.parseInt(allOrderCountValue.getValueInfo());
            PaginationParamBean paramBean = PaginationUtil.getPaginationParamBean(page,rows);
            orderBeans = sqlSession.selectList("dazhimen.bg.bean.Order.queryAllOrder", paramBean);
        }catch (BgException e){
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch(Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有订单信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", orderBeans);
        return jsonObject.toString();
    }

    public String queryAllOrderByParam(String page, String rows, QueryOrderParamBean paramBean) throws BgException {
        SqlSession sqlSession = null;
        Integer totalCount = 0;
        List<ViewOrderBean> orderBeans = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean allOrderCountValue = sqlSession.selectOne("dazhimen.bg.bean.Order.getAllOrderCountByParam", paramBean);
            if(allOrderCountValue == null || allOrderCountValue.getValueInfo() == null){
                throw new BgException("获取订单数据总条数出错");
            }
            totalCount = Integer.parseInt(allOrderCountValue.getValueInfo());
            PaginationParamBean paginationParamBean = PaginationUtil.getPaginationParamBean(page,rows);
            paramBean.setStartnum(paginationParamBean.getStartnum());
            paramBean.setGetrows(paginationParamBean.getGetrows());
            orderBeans = sqlSession.selectList("dazhimen.bg.bean.Order.queryAllOrderByParam", paramBean);
        }catch (BgException e){
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch(Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有订单信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", orderBeans);
        return jsonObject.toString();
    }
}
