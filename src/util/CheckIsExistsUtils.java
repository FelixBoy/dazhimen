package util;

import dazhimen.api.exception.ApiException;
import dazhimen.api.bean.SingleValueBean;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;


/**
 * Created by Administrator on 2017/3/27.
 */
public class CheckIsExistsUtils {

    public boolean checkCidIsExists(String cid) throws ApiException {
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

    public boolean checkPidIsExists(String pid) throws ApiException {
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
