package dazhimen.api.service;

import dazhimen.api.bean.ModifyCustomerInfoBean;
import dazhimen.api.exception.ParameterCheckException;
import db.DBConnUtil;
import org.apache.commons.dbutils.QueryRunner;

import java.sql.SQLException;

/**
 * Created by Administrator on 2017/3/18.
 */
public class ApiCustomerService {
    public void modifyPersonalInfo(ModifyCustomerInfoBean customerInfoBean) throws ParameterCheckException {
        if(customerInfoBean == null){
            throw new ParameterCheckException("ApiCustomerService的modifyPersonalInfo方法，参数为null");
        }
        //校验验证码
        if(!checkVerifyCode(customerInfoBean.getVerifycode())){
            throw new ParameterCheckException("验证码输入错误");
        }
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            StringBuffer sqlBF = new StringBuffer();
            sqlBF.append(" update customer " +
                            " set nickname = ?,mphone = ?,name = ?," +
                            "     gender = ?,email = ?,education = ? " +
                            " where cid = ? ");
            int result = runner.update(sqlBF.toString(), customerInfoBean.getNickname(), customerInfoBean.getMphone(), customerInfoBean.getName(),
                    customerInfoBean.getGender(), customerInfoBean.getEmail(), customerInfoBean.getEducation(), customerInfoBean.getCid());
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ParameterCheckException("修改客户信息出错");
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
