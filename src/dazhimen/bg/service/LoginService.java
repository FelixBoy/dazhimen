package dazhimen.bg.service;

import dazhimen.bg.bean.LoginBean;
import dazhimen.bg.bean.SingleValueBean;
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
}
