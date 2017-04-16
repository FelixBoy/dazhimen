package dazhimen.bg.service;

import dazhimen.api.exception.ApiException;
import dazhimen.bg.bean.customer.CustomerBean;
import dazhimen.bg.bean.PaginationParamBean;
import dazhimen.bg.bean.customer.QueryCustomerParamBean;
import dazhimen.bg.bean.SingleValueBean;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import net.sf.json.JSONObject;
import org.apache.ibatis.session.SqlSession;
import util.PaginationUtil;

import java.util.List;

/**
 * Created by Administrator on 2017/3/23.
 */
public class CustomerService {
    public String queryAllCustomersByParam(String page, String rows, QueryCustomerParamBean paramBean) throws BgException {
        List<CustomerBean> customerBeans = null;
        SqlSession sqlSession = null;
        Integer totalCount = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean allCustomerCountValue = sqlSession.selectOne("dazhimen.bg.bean.Customer.getAllCustomerCountByParam", paramBean);
            if(allCustomerCountValue == null || allCustomerCountValue.getValueInfo() == null){
                throw new ApiException("获取会员数据总条数出错");
            }
            totalCount = Integer.parseInt(allCustomerCountValue.getValueInfo());
            PaginationParamBean paginationParamBean = PaginationUtil.getPaginationParamBean(page,rows);
            paramBean.setStartnum(paginationParamBean.getStartnum());
            paramBean.setGetrows(paginationParamBean.getGetrows());
            customerBeans = sqlSession.selectList("dazhimen.bg.bean.Customer.listAllCustomerByParam", paramBean);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有会员信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", customerBeans);
        return jsonObject.toString();
    }

    public String queryAllCustomers(String page, String rows) throws BgException {
        List<CustomerBean> customerBeans = null;
        SqlSession sqlSession = null;
        Integer totalCount = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean allCustomerCountValue = sqlSession.selectOne("dazhimen.bg.bean.Customer.getAllCustomerCount");
            if(allCustomerCountValue == null || allCustomerCountValue.getValueInfo() == null){
                throw new ApiException("获取会员数据总条数出错");
            }
            totalCount = Integer.parseInt(allCustomerCountValue.getValueInfo());
            PaginationParamBean paramBean = PaginationUtil.getPaginationParamBean(page,rows);
            customerBeans = sqlSession.selectList("dazhimen.bg.bean.Customer.listAllCustomer", paramBean);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有会员信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", customerBeans);
        return jsonObject.toString();
    }
}
