package db;

import com.alibaba.druid.pool.DruidDataSource;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.sql.SQLException;

/**
 * Created by zhj on 2017/3/7.
 */
public class DBUtilsUtil {
 //封装数据库连接的相关操作，并向外提供连接池接口
 private static ApplicationContext ctx = null;

    /**
     * 获取关于数据库配置的上下文对象
     * @return
     */
 public static synchronized ApplicationContext getCtx() {
     if (ctx == null) {
             ctx = new ClassPathXmlApplicationContext("classpath:application-jdbc-dbutils.xml");
     }
     return ctx;
 }

    /**
     * 获取数据源对象
     * @return
     * @throws SQLException
     */
 public static synchronized DruidDataSource getDataSource() throws SQLException {
     DruidDataSource dataSource = (DruidDataSource) getCtx().getBean("dataSource");
     return dataSource;
 }
}
