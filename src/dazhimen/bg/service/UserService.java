package dazhimen.bg.service;

import dazhimen.bg.bean.SingleValueBean;
import dazhimen.bg.bean.UserBean;
import db.DBConnUtil;
import db.MyBatisUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.ibatis.session.SqlSession;
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
        userBean.setUid(new IdUtils().getUid());
        //密码加密规则，是loginname+password明文之后，md5
        String passwordMd5 = GlobalUtils.hex_md5(userBean.getLoginname()+userBean.getPassword());
        userBean.setPassword(passwordMd5);
        SqlSession sqlSession = MyBatisUtil.createSession();
        result = sqlSession.insert("dazhimen.bg.bean.User.addMater", userBean);
        sqlSession.commit();
        MyBatisUtil.closeSession(sqlSession);
        return result == 1;
    }
    public boolean checkLoginnameDuplicate(String loginName){
        boolean result = false;
        SqlSession sqlSession = MyBatisUtil.createSession();
        SingleValueBean value = sqlSession.selectOne("checkLoginname", loginName);
        MyBatisUtil.closeSession(sqlSession);
        if(value == null){
            return false;
        }
        result = value.getValueInfo() == null? false:true;
        return result;
    }

    /**
     * 查询所有掌门的信息
     * @return 包含所有掌门信息的 list
     */
    public List<UserBean> queryAllMasters(){
        SqlSession sqlSession = MyBatisUtil.createSession();
        List<UserBean> userBeans = sqlSession.selectList("dazhimen.bg.bean.User.listAllMaster");
        MyBatisUtil.closeSession(sqlSession);
        return userBeans;
    }

    /**
     * 通过uid获取 制定掌门的信息
     * @param uid 要获取信息的掌门ID
     * @return 返回要获取的掌门信息
     */
    public UserBean getMasterDataByUid(String uid){
        SqlSession sqlSession = MyBatisUtil.createSession();
        UserBean user = sqlSession.selectOne("dazhimen.bg.bean.User.getMasterById", uid);
        MyBatisUtil.closeSession(sqlSession);
        return user;
    }

    /**
     * 保存对制定master的修改信息
     * @param user
     * @return
     * @throws SQLException
     */
    public boolean saveMasterModify(UserBean user){
        SqlSession sqlSession = MyBatisUtil.createSession();
        int result = sqlSession.update("dazhimen.bg.bean.User.saveMasterModify", user);
        sqlSession.commit();
        MyBatisUtil.closeSession(sqlSession);
        return result == 1;
    }

    public boolean saveMasterDel(String uid){
        SqlSession sqlSession = MyBatisUtil.createSession();
        int result = sqlSession.update("dazhimen.bg.bean.User.saveMasterDel", uid);
        sqlSession.commit();
        MyBatisUtil.closeSession(sqlSession);
        return result == 1;
    }
}
