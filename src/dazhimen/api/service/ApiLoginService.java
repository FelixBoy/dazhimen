package dazhimen.api.service;

import dazhimen.api.bean.*;
import dazhimen.api.bean.customer.ApiCustomerBean;
import dazhimen.api.bean.login.MphoneLoginBean;
import dazhimen.api.bean.login.ThirdPartLoginBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import util.CheckIsExistsUtils;
import util.IdUtils;
import util.VerifyCodeUtils;

/**
 * Created by Administrator on 2017/3/18.
 */
public class ApiLoginService {
    public ApiCustomerBean doThirdPartLogin(ThirdPartLoginBean loginBean) throws ParameterCheckException, ApiException {
        if(loginBean == null){
            throw new ParameterCheckException("ApiLoginService的doThirdPartLogin方法，参数为null");
        }
        SqlSession sqlSession = null;
        ApiCustomerBean customerBean = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            if(loginBean.getLoginType().equals("1")){
                customerBean = sqlSession.selectOne("dazhimen.api.bean.ApiLogin.checkCustomerIsExistsByQQuid", loginBean.getQqUid());
            }else if(loginBean.getLoginType().equals("2")){
                customerBean = sqlSession.selectOne("dazhimen.api.bean.ApiLogin.checkCustomerIsExistsByWeixinuid", loginBean.getWeixinUid());
            }
            if(customerBean == null) {
                String cid = new IdUtils().getCid();
                loginBean.setCid(cid);
                int result = sqlSession.insert("dazhimen.api.bean.ApiLogin.saveThirdPartLogin", loginBean);
                if (!(result == 1)) {
                    throw new ApiException("新增会员信息出错");
                }
                sqlSession.commit();
                customerBean = getCustomerInfoByCid(cid);
            }
        } catch (Exception e) {
            sqlSession.rollback();
            e.printStackTrace();
            throw new ApiException("新增会员信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return customerBean;
    }
    public ApiCustomerBean getCustomerInfoByCid(String cid) throws ApiException {
        if(!CheckIsExistsUtils.checkCidIsExists(cid)){
            throw new ApiException("传入的[cid]值无效，在数据库中不存在");
        }
        ApiCustomerBean customerBean = null;
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            customerBean = sqlSession.selectOne("dazhimen.api.bean.ApiLogin.getCustomerInfoByCid", cid);
            if(customerBean == null || customerBean.getCid() == null || customerBean.getCid().equals("")){
                throw new ApiException("出现异常，查询会员信息出错");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ApiException("出现异常，查询会员信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return customerBean;
    }
    public ApiCustomerBean doMphoneLogin(MphoneLoginBean loginBean) throws ParameterCheckException, ApiException {
        if(loginBean == null){
            throw new ParameterCheckException("ApiLoginService的doMphoneLogin，参数为null");
        }
        //校验验证码
        if(!VerifyCodeUtils.checkVerifyCode(loginBean.getVerifyCode()) && !VerifyCodeUtils.checkMobileVerifyCode(loginBean.getMphone(), loginBean.getVerifyCode())){
            throw new ParameterCheckException("验证码输入错误");
        }
        SqlSession sqlSession = null;
        ApiCustomerBean customerBean = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            customerBean = sqlSession.selectOne("dazhimen.api.bean.ApiLogin.checkCustomerIsExistsByMphone", loginBean.getMphone());
            if(customerBean == null){
                String cid = new IdUtils().getCid();
                loginBean.setCid(cid);
                int result = sqlSession.insert("dazhimen.api.bean.ApiLogin.saveMphoneLogin", loginBean);
                if (!(result == 1)) {
                    throw new ApiException("新增会员信息出错");
                }
                sqlSession.commit();
                customerBean = getCustomerInfoByCid(cid);
            }
        }catch (Exception e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException("新增会员信息出错");
        } finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return customerBean;
    }

    public void getVerifyCode(String mphone) throws ApiException {
        String verifyCode = VerifyCodeUtils.genVerifyCode();
        try {
            boolean sendResult = VerifyCodeUtils.sendVerifyCodeToMphone(mphone, verifyCode);
            if(!sendResult){
                throw new ApiException("获取验证码失败");
            }
        } catch (ApiException e) {
            e.printStackTrace();
            throw new ApiException(e.getMessage());
        }
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            ApiInsertVerifyCodeBean insertVerifyCodeBean = new ApiInsertVerifyCodeBean();
            String vid = new IdUtils().getVerifyCodeId();
            insertVerifyCodeBean.setVid(vid);
            insertVerifyCodeBean.setCode(verifyCode);
            insertVerifyCodeBean.setMphone(mphone);
            insertVerifyCodeBean.setExpiredatetime((System.currentTimeMillis() + 1000 * 60 * 5) + "");
            sqlSession.insert("dazhimen.api.bean.ApiLogin.insertVerifyCode", insertVerifyCodeBean);
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException("出现异常，获取验证码失败");
        }finally{
            MyBatisUtil.closeSession(sqlSession);
        }
    }
}
