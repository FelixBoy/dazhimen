package dazhimen.api.service;

import dazhimen.api.bean.ApiListViewCourseBean;
import dazhimen.api.bean.ApiProductBean;
import dazhimen.api.bean.ApiSpecifyProductBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import dazhimen.bg.bean.SingleValueBean;
import db.DBConnUtil;
import net.sf.morph.wrap.Bean;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import util.CheckIsExistsUtils;
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
                        "updatedatetime as updatetimeo,price " +
                        " from product " +
                        " where isdel = '0' and type = ? and status !='3' " +
                        " order by indexsort,createdatetime " +
                        " limit " + getCount,
                new BeanListHandler<ApiProductBean>(ApiProductBean.class),type);
        return productBeans;
    }
    public ApiSpecifyProductBean getProductInforById(String pid, String cid) throws ApiException {
        StringBuffer sqlBF = new StringBuffer();
        sqlBF.append(" select pid,pname,price,listimage as listimgurl,introduction, ");
        sqlBF.append("        buycount,istry,introduction,'0' as iscollection, '0' as isbuy ");
        sqlBF.append("   from product a ");
        sqlBF.append("  where a.pid = ? ");
        ApiSpecifyProductBean productBean = null;
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            productBean = runner.query(sqlBF.toString(), new BeanHandler<ApiSpecifyProductBean>(ApiSpecifyProductBean.class),pid);

            if(cid != null && !cid.equals("")){
                productBean.setIscollection(getProductIsCollection(cid, pid));
                productBean.setIsbuy(getProductIsBuy(cid, pid));
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ApiException("查询指定产品信息出错");
        }
        return productBean;
    }
    public String getProductIsBuy(String cid, String pid) throws SQLException {
        StringBuffer sqlBF = new StringBuffer();
        sqlBF.append(" select 1 as valueinfo ");
        sqlBF.append("   from orders a, ");
        sqlBF.append("        ir_order_product b ");
        sqlBF.append("  where a.orid = b.orid ");
        sqlBF.append("    and a.cid = ? ");
        sqlBF.append("    and b.pid = ? ");
        QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
        SingleValueBean value  = runner.query(sqlBF.toString(),
                new BeanHandler<SingleValueBean>(SingleValueBean.class),cid,pid);
        if(value != null && value.getValueInfo()!= null && value.getValueInfo().equals("1")){
           return "1";
        }
        return "0";
    }
    public String getProductIsCollection(String cid, String pid) throws SQLException {
        QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
        StringBuffer sqlBF = new StringBuffer();
        sqlBF.append(" select 1 as valueinfo ");
        sqlBF.append("   from ir_customer_product ");
        sqlBF.append("  where cid = ? and pid = ? ");
        SingleValueBean value = runner.query(sqlBF.toString(),
                new BeanHandler<SingleValueBean>(SingleValueBean.class),cid,pid);
        if(value != null && value.getValueInfo()!= null && value.getValueInfo().equals("1")){
            return "1";
        }
        return "0";
    }
    public boolean collectProduct(String cid, String pid) throws ApiException {
        //缺少对 pid和cid是否为数据库中，有效数据的检测
        int result = 0;
        try {

            CheckIsExistsUtils checkUtil = new CheckIsExistsUtils();
            if(!checkUtil.checkCidIsExists(cid)){
                throw new ApiException("传入的[cid]值，无效。在数据库中不存在。");
            }
            if(!checkUtil.checkPidIsExists(pid)){
                throw new ApiException("传入的[pid]值，无效。在数据库中不存在，或者产品已经下架。");
            }
            StringBuffer sqlBF = new StringBuffer();
            sqlBF.append(" select 1 as valueinfo ");
            sqlBF.append("   from ir_customer_product ");
            sqlBF.append("  where cid = ? ");
            sqlBF.append("    and pid = ? ");
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            SingleValueBean value = runner.query(sqlBF.toString(), new BeanHandler<SingleValueBean>(SingleValueBean.class),cid,pid);
            if(value != null && value.getValueInfo()!= null && value.getValueInfo().equals("1")){
                return true;
            }
            sqlBF.setLength(0);
            sqlBF.append(" insert into ir_customer_product(cid,pid) ");
            sqlBF.append("                values(?, ?) ");
            result = runner.update(sqlBF.toString(), cid,pid);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ApiException("收藏产品失败");
        }
        return result == 1;
    }
    public void cancelCollectProduct(String cid, String pid) throws ApiException {
        try {
            CheckIsExistsUtils checkUtil = new CheckIsExistsUtils();
            if(!checkUtil.checkCidIsExists(cid)){
                throw new ApiException("传入的[cid]值，无效。在数据库中不存在。");
            }
            if(!checkUtil.checkPidIsExists(pid)){
                throw new ApiException("传入的[pid]值，无效。在数据库中不存在，或者产品已经下架。");
            }
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            runner.update(" delete from ir_customer_product where cid = ? and pid = ? ", cid, pid);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ApiException("取消收藏产品失败");
        }
    }

    public List<ApiListViewCourseBean> getProductCourseList(String pid) throws ApiException{
        List<ApiListViewCourseBean> courseBeans = null;
        try {
            CheckIsExistsUtils checkUtil = new CheckIsExistsUtils();
            if(!checkUtil.checkPidIsExists(pid)){
                throw new ApiException("传入的[pid]值，无效。在数据库中不存在，或者产品已经下架。");
            }
            StringBuffer sqlBF = new StringBuffer();
            sqlBF.append(" select courseid,coursename,istry,audiopath as audiourl, " +
                    " createdate as createdateo,viewcount ");
            sqlBF.append("   from course a ");
            sqlBF.append("  where pid = ? ");
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            courseBeans = runner.query(sqlBF.toString(), new BeanListHandler<ApiListViewCourseBean>(ApiListViewCourseBean.class),pid);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courseBeans;
    }
}
