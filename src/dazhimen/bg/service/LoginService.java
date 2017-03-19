package dazhimen.bg.service;

import dazhimen.bg.bean.SingleValueBean;
import db.DBConnUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import java.sql.SQLException;

/**
 * Created by Administrator on 2017/3/17.
 */
public class LoginService {
    public boolean checkIsLoginnameExists(String lgoinname){
        boolean result = false;
        try{
        QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
        SingleValueBean value = runner.query(" select 1 as valueinfo " +
                            " from user " +
                            " where loginname = ? " +
                            "   and isdel = '0' ",
                new BeanHandler<SingleValueBean>(SingleValueBean.class),
                lgoinname);
            if(value == null){
                return false;
            }
            result = value.getValueInfo() == null? false:true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    public boolean checkPassword(String loginname, String password){
        boolean result = false;
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            SingleValueBean value = runner.query("select 1 as valueinfo " +
                            " from user " +
                            " where loginname = ? " +
                            " and password = ? " +
                            " and isdel = '0' ",
                    new BeanHandler<SingleValueBean>(SingleValueBean.class),
                    loginname,password);
            if(value == null){
                return false;
            }
            result = value.getValueInfo() == null? false:true;
        }catch (SQLException e){
            e.printStackTrace();
        }
        return result;
    }
}
