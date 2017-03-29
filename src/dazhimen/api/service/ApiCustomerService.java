package dazhimen.api.service;

import dazhimen.api.bean.ModifyCustomerInfoBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

/**
 * Created by Administrator on 2017/3/18.
 */
public class ApiCustomerService {
    public void modifyPersonalInfo(ModifyCustomerInfoBean customerInfoBean) throws ParameterCheckException, ApiException {
        if(customerInfoBean == null){
            throw new ParameterCheckException("ApiCustomerService的modifyPersonalInfo方法，参数为null");
        }
        //校验验证码
        if(!checkVerifyCode(customerInfoBean.getVerifycode())){
            throw new ParameterCheckException("验证码输入错误");
        }
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            sqlSession.update("dazhimen.api.bean.ApiCustomer.modifyPersonalInfo", customerInfoBean);
            sqlSession.commit();
        } catch (Exception e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException("修改客户信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    private boolean checkVerifyCode(String verfiyCode) throws ParameterCheckException {
        if(verfiyCode == null || verfiyCode.equals("")){
            throw new ParameterCheckException("传入的验证码为空");
        }
        if(verfiyCode.equals("1234")){
            return true;
        }
        return false;
    }
}
