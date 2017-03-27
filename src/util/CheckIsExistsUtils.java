package util;

import dazhimen.bg.bean.SingleValueBean;
import db.DBConnUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import java.sql.SQLException;

/**
 * Created by Administrator on 2017/3/27.
 */
public class CheckIsExistsUtils {

    public boolean checkCidIsExists(String cid) throws SQLException {
        QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
        StringBuffer sqlBF = new StringBuffer();
        sqlBF.append(" select 1 as valueinfo ");
        sqlBF.append("   from customer ");
        sqlBF.append("  where cid = ? ");
        sqlBF.append("    and isdel = '0' ");
        SingleValueBean value = runner.query(sqlBF.toString(), new BeanHandler<SingleValueBean>(SingleValueBean.class),cid);
        if(value != null && value.getValueInfo()!= null && value.getValueInfo().equals("1")){
            return true;
        }
        return false;
    }

    public boolean checkPidIsExists(String pid) throws SQLException {
        QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
        StringBuffer sqlBF = new StringBuffer();
        sqlBF.append(" select 1 as valueinfo ");
        sqlBF.append("   from product ");
        sqlBF.append("  where pid = ? ");
        sqlBF.append("    and status != '3' ");
        sqlBF.append("    and isdel = '0' ");
        SingleValueBean value = runner.query(sqlBF.toString(), new BeanHandler<SingleValueBean>(SingleValueBean.class),pid);
        if(value != null && value.getValueInfo()!= null && value.getValueInfo().equals("1")){
            return true;
        }
        return false;
    }
}
