package dazhimen.bg.service;

import dazhimen.bg.bean.login.LoginBean;
import dazhimen.bg.bean.SingleValueBean;
import dazhimen.bg.bean.login.LoginUserBean;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

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
            LoginBean loginBean = new LoginBean();
            loginBean.setLoginname(loginname);
            loginBean.setPassword(password);
            sqlSession = MyBatisUtil.createSession();
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
}
