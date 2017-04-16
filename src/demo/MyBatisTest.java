package demo;

import dazhimen.bg.bean.user.UserBean;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

/**
 * Created by Administrator on 2017/3/28.
 */
public class MyBatisTest {
    public static void main(String[] args){
        SqlSession sqlSession = MyBatisUtil.createSession();
        List<UserBean> userBeanList = sqlSession.selectList("dazhimen.bg.bean.User.listAll");
        System.out.println(userBeanList);
        MyBatisUtil.closeSession(sqlSession);
    }
    public static  void testListAll()
    {
//        SqlSession session=sqlSessionFactory.openSession();
//        List<User> users=session.selectList("user.User.listAll");
//        System.out.println(users);
    }
    public static void testQueryOne()
    {
//        SqlSession session=sqlSessionFactory.openSession();
//        User user = session.selectOne("user.User.getOne", 1);
//        System.out.println(user);
    }
    //事务需要程序员处理
    public static  void testInsertOne()
    {
//        User u=new User();
//        u.setId(UUID.randomUUID().toString());
//        u.setName("sbsbb");
//        u.setAge(18);
//        u.setAddress("china");
//        SqlSession session=sqlSessionFactory.openSession();
//        int count=session.insert("user.User.insertOne", u);
//        session.commit();
//        System.out.println(count);
    }
    public static  void testUpdateOne()
    {
//        SqlSession session=sqlSessionFactory.openSession();
//        User u=new User();
//        //u=session.selectOne("cn.itcast.mybatis.getOne", "2");
//        u.setId("2");
//        u.setName("clclclclclcfei");
//        u.setAge(100);
//        u.setAddress("USA");
//        int count=session.update("user.User.updateOne", u);
//        session.commit();
//        System.out.println(count);
    }
    public static void testDeleteOne()
    {
//        SqlSession session=sqlSessionFactory.openSession();
//        User u=new User();
//        u.setId("2");
//        int count=session.delete("user.User.deleteOne", u);
//        session.commit();
//        System.out.println(count);
    }
}
