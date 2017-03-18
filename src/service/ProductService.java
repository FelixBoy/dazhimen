package service;

import bean.UserBean;
import db.DBConnUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.List;

/**
 * Created by Administrator on 2017/3/17.
 */
public class ProductService {
    /**
     * 查询所有掌门的信息
     * @return 包含所有掌门信息的 list
     */
    public List<UserBean> queryAllMasters(){
        List<UserBean> userBeans = null;
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            userBeans = runner.query("select uid,name,mphone,gender,loginname,remarks" +
                            " from user where type = '1' and isdel = '0' ",
                    new BeanListHandler<UserBean>(UserBean.class));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userBeans;
    }
}
