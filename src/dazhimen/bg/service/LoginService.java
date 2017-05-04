package dazhimen.bg.service;

import dazhimen.bg.bean.login.LoginBean;
import dazhimen.bg.bean.SingleValueBean;
import dazhimen.bg.bean.login.LoginUserBean;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import util.CheckIsExistsUtils;
import util.GlobalUtils;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2017/3/17.
 */
public class LoginService {
    public boolean checkIsLoginnameExists(String loginname) throws BgException {
        boolean result = false;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean value = sqlSession.selectOne("dazhimen.bg.bean.Login.checkIsLoginnameExists", loginname);
            if(value == null){
                return false;
            }
            result = value.getValueInfo() == null? false:true;
        } catch (Exception e) {
            e.printStackTrace();
            throw new BgException("出现异常，登录失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result;
    }
    public boolean checkPassword(String loginname, String password) throws BgException {
        boolean result = false;
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            LoginUserBean userBean = userBean = sqlSession.selectOne("dazhimen.bg.bean.Login.getUserInfoByLoginname", loginname);
            if(userBean == null || userBean.getUid() == null || userBean.getUname() == null || userBean.getUtype() == null){
                throw new BgException("获取登录用户的信息出错");
            }

            LoginBean loginBean = new LoginBean();
            loginBean.setLoginname(loginname);
            String finallyPassword = GlobalUtils.hex_md5(userBean.getUid() + password);
            loginBean.setPassword(finallyPassword);
            SingleValueBean value = sqlSession.selectOne("dazhimen.bg.bean.Login.checkPassword", loginBean);
            if(value == null){
                return false;
            }
            result = value.getValueInfo() == null? false:true;
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，登录失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result;
    }

    public LoginUserBean getUserInfoByLoginname(String loginname) throws BgException {
        SqlSession sqlSession = null;
        LoginUserBean userBean = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            userBean = sqlSession.selectOne("dazhimen.bg.bean.Login.getUserInfoByLoginname", loginname);
            if(userBean == null || userBean.getUid() == null || userBean.getUname() == null || userBean.getUtype() == null){
                throw new BgException("获取登录用户的信息出错");
            }
        }catch(BgException e){
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch(Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，获取登录用户信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return userBean;
    }

    /**
     *  获取当前登录用户拥有的权限信息
     * @param uid  要获取权限的 用户
     * @return  存储了用户权限的map
     */
    public HashMap<String, String> getUserPermission(String uid) throws BgException {
        HashMap<String, String> hashMap = new HashMap<String, String>();
        SqlSession sqlSession = null;
        try{
            if(!CheckIsExistsUtils.checkUidIsExists(uid)){
                throw new BgException("出现异常，传入的uid不存在");
            }
            sqlSession = MyBatisUtil.createSession();
            List<String> permissionList = sqlSession.selectList("dazhimen.bg.bean.Login.getUserPermission", uid);
            if(permissionList == null || permissionList.size() == 0){
                return hashMap;
            }else{
                for(int i = 0 ; i < permissionList.size(); i++){
                    hashMap.put(permissionList.get(i), null);
                }
            }
        }catch(BgException e){
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询用户对应的权限出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return hashMap;
    }
}
