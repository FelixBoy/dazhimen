package service;

import bean.SingleValueBean;
import bean.UserBean;
import com.sun.webpane.webkit.network.data.DataURLConnection;
import db.DBConnUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import util.IdUtils;

import java.sql.SQLException;
import java.util.List;

/**
 * Created by zhj on 2017/3/13.
 */
public class UserService {
    /**
     * 保存掌门新增
     * @param userBean 要保存的掌门信息
     * @return 保存是否成功
     * @throws SQLException
     */
    public boolean saveMasterAdd(UserBean userBean) throws SQLException {
        userBean.setUid(IdUtils.getUid());
        QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
        StringBuffer sqlBF = new StringBuffer();
        sqlBF.append("insert into user(uid,name,mphone,password,gender,type,loginname,remarks) ");
        sqlBF.append("          values(?,    ?,   ?,       ?,      ?,   ?,    ?,        ? )");
        int result = runner.update(sqlBF.toString(),userBean.getUid(),userBean.getName(), userBean.getMphone(),
                userBean.getPassword(), userBean.getGender(), userBean.getType(), userBean.getLoginname(), userBean.getRemarks());
        return result == 1;
    }
    public boolean checkLoginnameDuplicate(String loginName){
        QueryRunner runner = null;
        boolean result = false;
        try {
            runner = new QueryRunner(DBConnUtil.getDataSource());
            System.out.println(" select 1 as valueinfo from user where loginname = '" + loginName +"'");
            SingleValueBean value = runner.query(" select 1 as valueinfo from user where loginname = '" + loginName +"'",
                    new BeanHandler<SingleValueBean>(SingleValueBean.class));
            result = value.getValueInfo() == null? false:true;
            System.out.println(result);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 查询所有掌门的信息
     * @return 包含所有掌门信息的 list
     * @throws SQLException
     */
    public List<UserBean> queryAllMasters() throws SQLException {
        QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
        List<UserBean> userBeans = runner.query("select uid,name,mphone,gender,loginname from user where type = '1'",
                new BeanListHandler<UserBean>(UserBean.class));
        return userBeans;
    }

    /**
     * 通过uid获取 制定掌门的信息
     * @param uid 要获取信息的掌门ID
     * @return 返回要获取的掌门信息
     * @throws SQLException
     */
    public UserBean getMasterDataByUid(String uid) throws SQLException {
        QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
        StringBuffer sqlBF = new StringBuffer();
        sqlBF.append("select uid,name,mphone,gender,loginname,loginname as loginnameorginal ");
        sqlBF.append("  from user ");
        sqlBF.append(" where uid = ? ");
        UserBean user = runner.query(sqlBF.toString(), new BeanHandler<UserBean>(UserBean.class),uid);
        return user;
    }

    /**
     * 保存对制定master的修改信息
     * @param user
     * @return
     * @throws SQLException
     */
    public boolean saveMasterModify(UserBean user) throws SQLException {
        QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
        StringBuffer sqlBF = new StringBuffer();
        sqlBF.append(" update user  ");
        sqlBF.append(" set name = ?,mphone = ?,gender = ?, ");
        sqlBF.append(" loginname = ?,remarks = ? ");
        sqlBF.append(" where uid = ? ");
        int result = runner.update(sqlBF.toString(),user.getName(), user.getMphone(),
                user.getGender(), user.getLoginname(), user.getRemarks(), user.getUid());
        return result == 1;
    }

    public boolean saveMasterDel(String uid) throws SQLException {
        QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
        int result = runner.update(" delete from user where uid = ? ", uid);
        return result == 1;
    }
}
