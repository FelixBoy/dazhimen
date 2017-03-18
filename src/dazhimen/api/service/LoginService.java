package dazhimen.api.service;

import bean.CustomerBean;
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
public class LoginService {
    public CustomerBean doThirdPartLogin(ThirdPartLoginBean loginBean) throws ParameterCheckException {
        if(loginBean == null){
            throw new ParameterCheckException("LoginService的doThirdPartLogin方法，参数为null");
        }
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            CustomerBean customerBean = null;
            if(loginBean.getLoginType().equals("1")){
                customerBean = runner.query(" select cid,headerurl,mphone,nickname," +
                                " name,gender,email,education from customer where qq = ? ",
                        new BeanHandler<CustomerBean>(CustomerBean.class), loginBean.getQq());
            }else if(loginBean.getLoginType().equals("2")){
                customerBean = runner.query(" select cid,headerurl,mphone,nickname," +
                                " name,gender,email,education from customer where weixin = ? ",
                        new BeanHandler<CustomerBean>(CustomerBean.class), loginBean.getWeixin());
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
                    throw new ParameterCheckException("新增客户信息出错");
                }
                customerBean = getCustomerInfoByCid(cid);
            }
            return customerBean;
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ParameterCheckException(e.getMessage());
        } catch (ParameterCheckException e){
            e.printStackTrace();
            throw new ParameterCheckException(e.getMessage());
        }
    }
    private CustomerBean getCustomerInfoByCid(String cid){
        CustomerBean customerBean = null;
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            customerBean = runner.query(" select cid,headerurl,mphone,nickname," +
                            " name,gender,email,education from customer where cid = ? ",
                    new BeanHandler<CustomerBean>(CustomerBean.class), cid);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customerBean;
    }
    public CustomerBean doMphoneLogin(MphoneLoginBean loginBean) throws ParameterCheckException {
        if(loginBean == null){
            throw new ParameterCheckException("doMphoneLogin，参数为null");
        }
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            CustomerBean customerBean = runner.query(" select cid,headerurl,mphone,nickname," +
                            " name,gender,email,education from customer where mphone = ? ",
                    new BeanHandler<CustomerBean>(CustomerBean.class), loginBean.getMphone());
            if(customerBean == null){
                StringBuffer sqlBF = new StringBuffer();
                sqlBF.append("insert into customer(cid,mphone,createdate) ");
                sqlBF.append("               values(?,    ?,       ?) ");
                String cid = IdUtils.getCid();
                int result = runner.update(sqlBF.toString(), cid, loginBean.getMphone(),new Date());
                if (!(result == 1)) {
                    throw new ParameterCheckException("新增客户信息出错");
                }
                customerBean = getCustomerInfoByCid(cid);
            }
            return customerBean;
        }catch (SQLException e) {
            e.printStackTrace();
            throw new ParameterCheckException(e.getMessage());
        } catch (ParameterCheckException e){
            e.printStackTrace();
            throw new ParameterCheckException(e.getMessage());
        }
    }
}
