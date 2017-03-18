package dazhimen.bg.service;

import dazhimen.bg.bean.SingleValueBean;
import dazhimen.bg.bean.UserBean;
import db.DBConnUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import util.GlobalUtils;
import util.IdUtils;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

/**
 * Created by zhj on 2017/3/13.
 */
public class UserService {
    /**
     * 保存掌门新增
     * @param userBean 要保存的掌门信息
     * @return 保存是否成功
     */
    public boolean saveMasterAdd(UserBean userBean){
        int result = 0;
        try{
            userBean.setUid(IdUtils.getUid());
            userBean.setCreateDate(new Date());
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            //密码加密规则，是loginname+password明文之后，md5
            String passwordMd5 = GlobalUtils.hex_md5(userBean.getLoginname()+userBean.getPassword());
            StringBuffer sqlBF = new StringBuffer();
            sqlBF.append("insert into user(uid,name,mphone,password,gender,type,loginname,remarks,createdate) ");
            sqlBF.append("          values(?,    ?,   ?,       ?,      ?,   ?,    ?,        ? ,     ?)");
            result = runner.update(sqlBF.toString(),userBean.getUid(),userBean.getName(), userBean.getMphone(),
                    passwordMd5, userBean.getGender(), userBean.getType(), userBean.getLoginname(), userBean.getRemarks(),userBean.getCreateDate());
        }catch (SQLException e){
            e.printStackTrace();
        }
        return result == 1;
    }
    public boolean checkLoginnameDuplicate(String loginName){
        QueryRunner runner = null;
        boolean result = false;
        try {
            runner = new QueryRunner(DBConnUtil.getDataSource());
            SingleValueBean value = runner.query(" select 1 as valueinfo from user where loginname = '" + loginName +"'",
                    new BeanHandler<SingleValueBean>(SingleValueBean.class));
            if(value == null){
                return false;
            }
            result = value.getValueInfo() == null? false:true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 查询所有掌门的信息
     * @return 包含所有掌门信息的 list
     */
    public List<UserBean> queryAllMasters(){
        List<UserBean> userBeans = null;
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            userBeans = runner.query("select uid,name,mphone,gender,loginname,remarks " +
                            " from user where type = '1' and isdel = '0' ",
                    new BeanListHandler<UserBean>(UserBean.class));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userBeans;
    }

    /**
     * 通过uid获取 制定掌门的信息
     * @param uid 要获取信息的掌门ID
     * @return 返回要获取的掌门信息
     */
    public UserBean getMasterDataByUid(String uid){
        UserBean user = null;
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            StringBuffer sqlBF = new StringBuffer();
            sqlBF.append("select uid,name,mphone,gender,loginname,loginname as loginnameorginal ");
            sqlBF.append("  from user ");
            sqlBF.append(" where uid = ? ");
            user = runner.query(sqlBF.toString(), new BeanHandler<UserBean>(UserBean.class),uid);
        }catch (SQLException e){
            e.printStackTrace();
        }

        return user;
    }

    /**
     * 保存对制定master的修改信息
     * @param user
     * @return
     * @throws SQLException
     */
    public boolean saveMasterModify(UserBean user){
        int result = 0;
        try{
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            StringBuffer sqlBF = new StringBuffer();
            sqlBF.append(" update user  ");
            sqlBF.append(" set name = ?,mphone = ?,gender = ?, ");
            sqlBF.append(" loginname = ?,remarks = ? ");
            sqlBF.append(" where uid = ? ");
            result = runner.update(sqlBF.toString(),user.getName(), user.getMphone(),
                    user.getGender(), user.getLoginname(), user.getRemarks(), user.getUid());
        }catch (SQLException e){
            e.printStackTrace();
        }

        return result == 1;
    }

    public boolean saveMasterDel(String uid){
        int result = 0;
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            result = runner.update(" update user set isdel = '1' where uid = ? ", uid);
            System.out.println(result);
        }catch (SQLException e){
            e.printStackTrace();
        }
        return result == 1;
    }
}
