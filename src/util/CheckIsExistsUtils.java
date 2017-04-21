package util;

import dazhimen.api.exception.ApiException;
import dazhimen.api.bean.SingleValueBean;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;


/**
 * Created by Administrator on 2017/3/27.
 */
public class CheckIsExistsUtils {
    public static boolean checkRidIsExists(String rid) throws BgException {
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            String value = sqlSession.selectOne("dazhimen.bg.bean.Permission.checkRidIsExists", rid);
            if(value != null && !value.equals("") && value.equals("1")){
                return true;
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，检验rid是否存在失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return false;
    }
    public static boolean checkUidIsExists(String uid) throws BgException {
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            String value = sqlSession.selectOne("dazhimen.bg.bean.User.checkUidIsExists", uid);
            if(value != null && !value.equals("") && value.equals("1")){
                return true;
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，检验uid是否存在失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return false;
    }
    public static boolean checkNidIsExists(String nid) throws ApiException {
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean value = sqlSession.selectOne("dazhimen.api.bean.ApiNews.checkNidIsExists", nid);
            if(value != null && value.getValueInfo()!= null && value.getValueInfo().equals("1")){
                return true;
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，检验nid是否存在失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return false;
    }

    public static boolean checkCourseidIsExists(String courseid) throws ApiException {
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean value = sqlSession.selectOne("dazhimen.api.bean.ApiProduct.checkCourseidIsExists", courseid);
            if(value != null && value.getValueInfo()!= null && value.getValueInfo().equals("1")){
                return true;
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，检验Courseid是否存在失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return false;
    }

    public static boolean checkCidIsExists(String cid) throws ApiException {
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean value = sqlSession.selectOne("dazhimen.api.bean.ApiCustomer.checkCidIsExists", cid);
            if(value != null && value.getValueInfo()!= null && value.getValueInfo().equals("1")){
                return true;
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，检验Cid是否存在失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return false;
    }

    public static boolean checkPidIsExists(String pid) throws ApiException {
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean value = sqlSession.selectOne("dazhimen.api.bean.ApiProduct.checkPidIsExists", pid);
            if(value != null && value.getValueInfo()!= null && value.getValueInfo().equals("1")){
                return true;
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，检验Pid是否存在失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return false;
    }
}
