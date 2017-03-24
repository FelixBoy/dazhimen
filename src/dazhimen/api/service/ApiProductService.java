package dazhimen.api.service;

import dazhimen.api.bean.ApiProductBean;
import dazhimen.api.exception.ParameterCheckException;
import db.DBConnUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import util.Constant;

import java.sql.SQLException;
import java.util.List;

/**
 * Created by Administrator on 2017/3/24.
 */
public class ApiProductService {
    public List<ApiProductBean> getHomePageSkillPack(String getCount) throws ParameterCheckException {
        int getCountInt = 0;
        if(getCount == null || getCount.equals("")){
            getCountInt = 2;
        }else{
            try {
                getCountInt = Integer.parseInt(getCount);
            }catch (NumberFormatException e){
                e.printStackTrace();
                throw new ParameterCheckException("参数[getcount]不是数字，格式化出错");
            }

        }
        List<ApiProductBean> productBeans = null;
        try {
            productBeans = getProductByCountAndType(getCountInt, Constant.SkillPack);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ParameterCheckException("查询首页技能包出错");
        }
        return productBeans;
    }
    public List<ApiProductBean> getHomePageExperiencePack(String getCount) throws ParameterCheckException {
        int getCountInt = 0;
        if(getCount == null || getCount.equals("")){
            getCountInt = 2;
        }else{
            try {
                getCountInt = Integer.parseInt(getCount);
            }catch (NumberFormatException e){
                e.printStackTrace();
                throw new ParameterCheckException("参数[getcount]不是数字，格式化出错");
            }

        }
        List<ApiProductBean> productBeans = null;
        try {
            productBeans = getProductByCountAndType(getCountInt, Constant.ExperiencePack);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ParameterCheckException("查询首页经验包出错");
        }
        return productBeans;
    }
    private List<ApiProductBean> getProductByCountAndType(int getCount, String type) throws SQLException {
        List<ApiProductBean> productBeans = null;
        QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
        productBeans = runner.query("select pid,pname,listimage as listimgurl," +
                        "updatedatetime as updatetimeo,price as priceo " +
                        " from product " +
                        " where isdel = '0' and type = ? and status !='3' " +
                        " order by indexsort,createdatetime " +
                        " limit " + getCount,
                new BeanListHandler<ApiProductBean>(ApiProductBean.class),type);
        return productBeans;
    }
}
