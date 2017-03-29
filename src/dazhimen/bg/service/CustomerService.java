package dazhimen.bg.service;

import dazhimen.bg.bean.CustomerBean;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

/**
 * Created by Administrator on 2017/3/23.
 */
public class CustomerService {
    public List<CustomerBean> queryAllCustomers() throws BgException {
        List<CustomerBean> customerBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            customerBeans = sqlSession.selectList("dazhimen.bg.bean.Customer.listAllCustomer");
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有会员信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return customerBeans;
    }

    public void saveCustomerDel(String cid) throws BgException {
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            sqlSession.update("dazhimen.bg.bean.Customer.saveCustomerDel", cid);
            sqlSession.commit();
        }catch (Exception e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，删除会员信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
}
