package db;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.IOException;
import java.io.InputStream;

/**
 * Created by Administrator on 2017/3/28.
 */
public class MyBatisUtil {
    private static SqlSessionFactory factory;
    private static ApplicationContext ctx = null;
    static {
            if (ctx == null) {
//                ctx = new ClassPathXmlApplicationContext("classpath:aliyun-mybatis.xml");
                ctx = new ClassPathXmlApplicationContext("classpath:application-jdbc-mybatis.xml");
            }
            factory = (SqlSessionFactory)ctx.getBean("sqlSessionFactory");
    }
    public static SqlSession createSession() {
        return factory.openSession();
    }

    public static void closeSession(SqlSession session) {
        if(session!=null) session.close();
    }
}
