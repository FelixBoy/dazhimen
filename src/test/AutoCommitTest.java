package test;

import com.alibaba.druid.pool.DruidPooledConnection;
import db.DBConnUtil;
import org.apache.commons.dbutils.QueryRunner;

import java.sql.SQLException;

/**
 * Created by Administrator on 2017/3/19.
 */
public class AutoCommitTest {
    public static void main(String[] args){
        DruidPooledConnection conn = null;
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            conn = DBConnUtil.getDataSource().getConnection();
            conn.setAutoCommit(false);
            int result = runner.update(conn,"insert into test(id,name) values(?,?) ",
                    "222","哈哈");
            if(result == 1){
                throw new SQLException("aaa");
            }
            runner.update(conn,"insert into test(id,name) values(?,?) ",
                    "3333", "哈哈哈");
            conn.commit();
            conn.setAutoCommit(true);
            conn.close();
        } catch (SQLException e) {
            if(null != conn)
                try {
                    conn.rollback();
                    conn.close();
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            e.printStackTrace();
        }
    }
}
