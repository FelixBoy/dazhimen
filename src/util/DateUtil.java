package util;

import dazhimen.bg.bean.DBDateTimeBean;
import db.DBUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import java.sql.SQLException;
import java.util.Date;

/**
 * Created by Administrator on 2017/3/25.
 */
public class DateUtil {
    public Date getDBDate(){
        Date dbDate = null;
        try {
            QueryRunner runner = new QueryRunner(DBUtils.getDataSource());
            DBDateTimeBean dateTimeBean = runner.query(" select now() as dbdate ", new BeanHandler<DBDateTimeBean>(DBDateTimeBean.class));
            dbDate = dateTimeBean.getDbdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dbDate;
    }
}
