package dazhimen.bg.service;

import dazhimen.bg.bean.SingleValueBean;
import dazhimen.bg.bean.UserBean;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import util.GlobalUtils;
import util.IdUtils;

import java.sql.SQLException;
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
    public boolean saveMasterAdd(UserBean userBean) throws BgException {
        int result = 0;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean value = sqlSession.selectOne("dazhimen.bg.bean.User.checkLoginname", userBean.getLoginname());
            boolean checkLoginNameresult;
            if(value == null){
                checkLoginNameresult = false;
            }else{
                checkLoginNameresult = value.getValueInfo() == null? false:true;
            }
            if(checkLoginNameresult){
                throw new BgException("登录名已经存在，新增掌门失败");
            }
            userBean.setUid(new IdUtils().getUid());
            //密码加密规则，是loginname+password明文之后，md5
            String passwordMd5 = GlobalUtils.hex_md5(userBean.getLoginname()+userBean.getPassword());
            userBean.setPassword(passwordMd5);

            result = sqlSession.insert("dazhimen.bg.bean.User.addMater", userBean);
            sqlSession.commit();
        }catch (BgException e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch (Exception e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，新增掌门失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }

    /**
     * 查询所有掌门的信息
     * @return 包含所有掌门信息的 list
     */
    public List<UserBean> queryAllMasters() throws BgException {
        SqlSession sqlSession = null;
        List<UserBean> userBeans = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            userBeans = sqlSession.selectList("dazhimen.bg.bean.User.listAllMaster");
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有掌门信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return userBeans;
    }
    /**
     * 查询所有管理员的信息
     * @return 包含所有掌门信息的 list
     */
    public List<UserBean> queryAllAdmin() throws BgException {
        SqlSession sqlSession = null;
        List<UserBean> userBeans = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            userBeans = sqlSession.selectList("dazhimen.bg.bean.User.listAllAdmin");
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有管理员信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return userBeans;
    }
    /**
     * 通过uid获取 制定掌门的信息
     * @param uid 要获取信息的掌门ID
     * @return 返回要获取的掌门信息
     */
    public UserBean getMasterDataByUid(String uid) throws BgException {
        SqlSession sqlSession = null;
        UserBean user = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            user = sqlSession.selectOne("dazhimen.bg.bean.User.getMasterById", uid);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询指定掌门信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return user;
    }

    /**
     * 保存对制定master的修改信息
     * @param user
     * @return
     * @throws SQLException
     */
    public boolean saveMasterModify(UserBean user) throws BgException {
        SqlSession sqlSession = null;
        int result = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            String loginanme = user.getLoginname();
            String loinameOrginal = user.getLoginnameorginal();
            if(!loginanme.equals(loinameOrginal)){
                SingleValueBean value = sqlSession.selectOne("dazhimen.bg.bean.User.checkLoginname", user.getLoginname());
                boolean checkLoginNameresult;
                if(value == null){
                    checkLoginNameresult = false;
                }else{
                    checkLoginNameresult = value.getValueInfo() == null? false:true;
                }
                if(checkLoginNameresult){
                    throw new BgException("登录名已经存在，修改掌门信息失败");
                }
            }
            result = sqlSession.update("dazhimen.bg.bean.User.saveMasterModify", user);
            sqlSession.commit();
        }catch (BgException e){
            sqlSession.rollback();;
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch (Exception e){
            sqlSession.rollback();;
            e.printStackTrace();
            throw new BgException("出现异常，修改掌门信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }

    public boolean saveMasterDel(String uid) throws BgException {
        int result = 0;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            result = sqlSession.update("dazhimen.bg.bean.User.saveMasterDel", uid);
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，删除掌门信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
    public boolean saveAddAdmin(UserBean userBean) throws BgException {
        int result = 0;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean value = sqlSession.selectOne("dazhimen.bg.bean.User.checkLoginname", userBean.getLoginname());
            boolean checkLoginNameresult;
            if(value == null){
                checkLoginNameresult = false;
            }else{
                checkLoginNameresult = value.getValueInfo() == null? false:true;
            }
            if(checkLoginNameresult){
                throw new BgException("登录名已经存在，新增管理员失败");
            }
            userBean.setUid(new IdUtils().getUid());
            //密码加密规则，是loginname+password明文之后，md5
            String passwordMd5 = GlobalUtils.hex_md5(userBean.getLoginname()+userBean.getPassword());
            userBean.setPassword(passwordMd5);

            result = sqlSession.insert("dazhimen.bg.bean.User.addMater", userBean);
            sqlSession.commit();
        }catch (BgException e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch (Exception e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，新增管理员失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }

    public boolean saveModifyAdmin(UserBean user) throws BgException {
        SqlSession sqlSession = null;
        int result = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            String loginanme = user.getLoginname();
            String loinameOrginal = user.getLoginnameorginal();
            if(!loginanme.equals(loinameOrginal)){
                SingleValueBean value = sqlSession.selectOne("dazhimen.bg.bean.User.checkLoginname", user.getLoginname());
                boolean checkLoginNameresult;
                if(value == null){
                    checkLoginNameresult = false;
                }else{
                    checkLoginNameresult = value.getValueInfo() == null? false:true;
                }
                if(checkLoginNameresult){
                    throw new BgException("登录名已经存在，修改管理员信息失败");
                }
            }
            result = sqlSession.update("dazhimen.bg.bean.User.saveMasterModify", user);
            sqlSession.commit();
        }catch (BgException e){
            sqlSession.rollback();;
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch (Exception e){
            sqlSession.rollback();;
            e.printStackTrace();
            throw new BgException("出现异常，修改管理员信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
    public boolean saveDeleteAdmin(String uid) throws BgException {
        int result = 0;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            result = sqlSession.update("dazhimen.bg.bean.User.saveMasterDel", uid);
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，删除管理员失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
}
