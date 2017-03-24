package dazhimen.api.service;

import dazhimen.api.bean.ApiCustomerBean;
import dazhimen.api.bean.MphoneLoginBean;
import dazhimen.api.bean.ThirdPartLoginBean;
import dazhimen.api.exception.ParameterCheckException;
import db.DBConnUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import util.IdUtils;
import java.sql.SQLException;
import java.util.Date;

/**
 * Created by Administrator on 2017/3/18.
 */
public class ApiLoginService {
    public ApiCustomerBean doThirdPartLogin(ThirdPartLoginBean loginBean) throws ParameterCheckException {
        if(loginBean == null){
            throw new ParameterCheckException("ApiLoginService的doThirdPartLogin方法，参数为null");
        }
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            ApiCustomerBean customerBean = null;
            if(loginBean.getLoginType().equals("1")){
                customerBean = runner.query(" select cid,headerurl,mphone,nickname," +
                                " name,gender,email,education from customer where qq = ? ",
                        new BeanHandler<ApiCustomerBean>(ApiCustomerBean.class), loginBean.getQq());
            }else if(loginBean.getLoginType().equals("2")){
                customerBean = runner.query(" select cid,headerurl,mphone,nickname," +
                                " name,gender,email,education from customer where weixin = ? ",
                        new BeanHandler<ApiCustomerBean>(ApiCustomerBean.class), loginBean.getWeixin());
            }
            if(customerBean == null) {
                StringBuffer sqlBF = new StringBuffer();
                sqlBF.append("insert into customer(cid,nickname,headerurl,gender,age," +
                        "qq,qquid,weixin,weixinuid,createdate) ");
                sqlBF.append("               values(?,    ?,       ?,       ?,      ?, " +
                        "  ?,   ?,  ? ,     ?,      ?)");
                String cid = IdUtils.getCid();
                int result = runner.update(sqlBF.toString(), cid, loginBean.getNickname(), loginBean.getHeaderurl(),
                        loginBean.getGender(), loginBean.getAge(), loginBean.getQq(), loginBean.getQqUid(),
                        loginBean.getWeixin(), loginBean.getWeixinUid(), new Date());
                if (!(result == 1)) {
                    throw new ParameterCheckException("新增会员信息出错");
                }
                customerBean = getCustomerInfoByCid(cid);
            }
            return customerBean;
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ParameterCheckException("新增会员信息出错");
        } catch (ParameterCheckException e){
            e.printStackTrace();
            throw new ParameterCheckException("新增会员信息出错");
        }
    }
    public ApiCustomerBean getCustomerInfoByCid(String cid) throws ParameterCheckException {
        ApiCustomerBean customerBean = null;
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            customerBean = runner.query(" select cid,headerurl,mphone,nickname," +
                            " name,gender,email,education from customer where cid = ? ",
                    new BeanHandler<ApiCustomerBean>(ApiCustomerBean.class), cid);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ParameterCheckException("查询会员信息出错");
        }
        return customerBean;
    }
    public ApiCustomerBean doMphoneLogin(MphoneLoginBean loginBean) throws ParameterCheckException {
        if(loginBean == null){
            throw new ParameterCheckException("ApiLoginService的doMphoneLogin，参数为null");
        }
        //校验验证码
        if(!checkVerifyCode(loginBean.getVerifyCode())){
            throw new ParameterCheckException("验证码输入错误");
        }
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            ApiCustomerBean customerBean = runner.query(" select cid,headerurl,mphone,nickname," +
                            " name,gender,email,education from customer where mphone = ? ",
                    new BeanHandler<ApiCustomerBean>(ApiCustomerBean.class), loginBean.getMphone());
            if(customerBean == null){
                StringBuffer sqlBF = new StringBuffer();
                sqlBF.append("insert into customer(cid,mphone,createdate) ");
                sqlBF.append("               values(?,    ?,       ?) ");
                String cid = IdUtils.getCid();
                int result = runner.update(sqlBF.toString(), cid, loginBean.getMphone(),new Date());
                if (!(result == 1)) {
                    throw new ParameterCheckException("新增会员信息出错");
                }
                customerBean = getCustomerInfoByCid(cid);
            }
            return customerBean;
        }catch (SQLException e) {
            e.printStackTrace();
            throw new ParameterCheckException("新增会员信息出错");
        } catch (ParameterCheckException e){
            e.printStackTrace();
            throw new ParameterCheckException("新增会员信息出错");
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
