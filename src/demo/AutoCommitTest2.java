package demo;

import com.alibaba.druid.pool.DruidPooledConnection;
import db.DBConnUtil;
import org.apache.commons.dbutils.QueryRunner;

import java.sql.SQLException;

/**
 * Created by Administrator on 2017/3/19.
 */
public class AutoCommitTest2 {
    public static void main(String[] args){
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            DruidPooledConnection conn = DBConnUtil.getDataSource().getConnection();
//            conn.setAutoCommit(false);
            int result = runner.update(conn,"insert into test(id,name) values(?,?) ",
                    "444","哈哈");
            if(result == 1){
                throw new SQLException("aaa");
            }
            runner.update(conn,"insert into test(id,name) values(?,?) ",
                    "555", "哈哈哈");
//            conn.commit();
//            conn.setAutoCommit(true);
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
