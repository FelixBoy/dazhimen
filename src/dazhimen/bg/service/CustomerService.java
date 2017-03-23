package dazhimen.bg.service;

import dazhimen.bg.bean.CustomerBean;
import db.DBConnUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.List;

/**
 * Created by Administrator on 2017/3/23.
 */
public class CustomerService {
    public List<CustomerBean> queryAllCustomers(){
        List<CustomerBean> customerBeans = null;
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            customerBeans = runner.query("select cid,name,nickname,gender,mphone,email,education " +
                            " from customer where isdel = '0' ",
                    new BeanListHandler<CustomerBean>(CustomerBean.class));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customerBeans;
    }
}
