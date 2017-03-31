package dazhimen.api.service;

import dazhimen.api.bean.ApiQueryCustomerExistsParamBean;
import dazhimen.api.bean.ModifyCustomerInfoBean;
import dazhimen.api.bean.SingleValueBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import dazhimen.bg.exception.BgException;
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
        String cid = customerInfoBean.getCid();
        String mphone = customerInfoBean.getMphone();
        if(cid.equals("")){
            throw new ParameterCheckException("参数[cid]的值为空");
        }
        if(mphone.equals("")){
            throw new ParameterCheckException("参数[mphone]的值为空");
        }
        //校验验证码
        if(!checkVerifyCode(customerInfoBean.getVerifycode())){
            throw new ParameterCheckException("验证码输入错误");
        }
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            ApiQueryCustomerExistsParamBean paramBean = new ApiQueryCustomerExistsParamBean();
            paramBean.setCid(cid);
            paramBean.setMphone(mphone);
            SingleValueBean value = sqlSession.selectOne("dazhimen.api.bean.ApiCustomer.checkMphoneIsOccupy", paramBean);
            boolean checkMphoneIsOccupy;
            if(value == null){
                checkMphoneIsOccupy = false;
            }else{
                checkMphoneIsOccupy = value.getValueInfo() == null? false:true;
            }
            if(checkMphoneIsOccupy){
                throw new ApiException("手机号码已经被占用，修改个人信息失败");
            }
            sqlSession.update("dazhimen.api.bean.ApiCustomer.modifyPersonalInfo", customerInfoBean);
            sqlSession.commit();
        } catch (ApiException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException(e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException("修改个人信息出错");
        }finally
        {
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
