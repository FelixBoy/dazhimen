package service;

import db.DBConnUtil;
import entity.User;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.List;

/**
 * Created by zhj on 2017/3/13.
 */
public class UserService {
    public boolean saveMasterAdd(User user) throws SQLException {
        user.setUid("000004");
        QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
        StringBuffer sqlBF = new StringBuffer();
        sqlBF.append("insert into user(uid,name,mphone,password,gender,type,loginname,remarks) ");
        sqlBF.append("          values(?,    ?,   ?,       ?,      ?,   ?,    ?,        ? )");
        int result = runner.update(sqlBF.toString(),user.getUid(),user.getName(), user.getMphone(),
                user.getPassword(), user.getGender(), user.getType(), user.getLoginname(), user.getRemarks());
        return result == 1;
    }

    public List<User> queryAllMasters() throws SQLException {
        QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
        List<User> users = runner.query("select uid,name,mphone,gender,loginname from user where type = '1'",
                new BeanListHandler<User>(User.class));
        return users;
    }
}
