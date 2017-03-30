package dazhimen.api.service;

import dazhimen.api.bean.*;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import util.CheckIsExistsUtils;
import util.Constant;
import java.util.List;

/**
 * Created by Administrator on 2017/3/24.
 */
public class ApiProductService {
    public List<ApiProductBean> getHomePageSkillPack(String getCount) throws ParameterCheckException, ApiException {
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
        } catch (Exception e) {
            e.printStackTrace();
            throw new ApiException("查询首页技能包出错");
        }
        return productBeans;
    }
    public List<ApiProductBean> getHomePageExperiencePack(String getCount) throws ParameterCheckException, ApiException {
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
        } catch (Exception e) {
            e.printStackTrace();
            throw new ApiException("查询首页经验包出错");
        }
        return productBeans;
    }
    private List<ApiProductBean> getProductByCountAndType(int getCount, String type) throws BgException {
        List<ApiProductBean> productBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            ApiQueryProductParamBean paramBean = new ApiQueryProductParamBean();
            paramBean.setGetcount(getCount);
            paramBean.setType(type);
            productBeans = sqlSession.selectList("dazhimen.api.bean.ApiProduct.getProductByCountAndType",paramBean);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询产品信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }

        return productBeans;
    }
    public ApiSpecifyProductBean getProductInforById(String pid, String cid) throws ApiException {
        SqlSession sqlSession = null;
        ApiSpecifyProductBean productBean = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            productBean = sqlSession.selectOne("dazhimen.api.bean.ApiProduct.getProductInforById", pid);
            if(cid != null && !cid.equals("")){
                productBean.setIscollection(getProductIsCollection(cid, pid));
                productBean.setIsbuy(getProductIsBuy(cid, pid));
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new ApiException("查询指定产品信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return productBean;
    }
    public String getProductIsBuy(String cid, String pid) throws ApiException {

        SqlSession sqlSession = null;
        try{
            ApiQueryProductCollectionParamBean paramBean = new ApiQueryProductCollectionParamBean();
            paramBean.setCid(cid);
            paramBean.setPid(pid);
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean value  =  sqlSession.selectOne("dazhimen.api.bean.ApiProduct.getProductIsBuy", paramBean);
            if(value != null && value.getValueInfo()!= null && value.getValueInfo().equals("1")){
                return "1";
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，查询产品购买状态出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return "0";
    }
    public String getProductIsCollection(String cid, String pid) throws ApiException {

        SqlSession sqlSession = null;
        try{
            ApiQueryProductCollectionParamBean paramBean = new ApiQueryProductCollectionParamBean();
            paramBean.setCid(cid);
            paramBean.setPid(pid);
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean value = sqlSession.selectOne("dazhimen.api.bean.ApiProduct.getProductIsCollection", paramBean);
            if(value != null && value.getValueInfo()!= null && value.getValueInfo().equals("1")){
                return "1";
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，查询产品收藏状态出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return "0";
    }
    public boolean collectProduct(String cid, String pid) throws ApiException {
        //缺少对 pid和cid是否为数据库中，有效数据的检测
        int result = 0;
        SqlSession sqlSession = null;
        CheckIsExistsUtils checkUtil = new CheckIsExistsUtils();
        if(!checkUtil.checkCidIsExists(cid)){
            throw new ApiException("传入的[cid]值，无效。在数据库中不存在。");
        }
        if(!checkUtil.checkPidIsExists(pid)){
            throw new ApiException("传入的[pid]值，无效。在数据库中不存在，或者产品已经下架。");
        }
        try {
            sqlSession = MyBatisUtil.createSession();
            ApiQueryProductCollectionParamBean paramBean = new ApiQueryProductCollectionParamBean();
            paramBean.setCid(cid);
            paramBean.setPid(pid);
            SingleValueBean value = sqlSession.selectOne("dazhimen.api.bean.ApiProduct.getProductIsCollection", paramBean);
            if(value != null && value.getValueInfo()!= null && value.getValueInfo().equals("1")){
                return true;
            }
            result = sqlSession.insert("dazhimen.api.bean.ApiProduct.collectProduct", paramBean);
            sqlSession.commit();
        }catch (Exception e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException("出现异常，收藏失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
    public void cancelCollectProduct(String cid, String pid) throws ApiException {
        CheckIsExistsUtils checkUtil = new CheckIsExistsUtils();
        if(!checkUtil.checkCidIsExists(cid)){
            throw new ApiException("传入的[cid]值，无效。在数据库中不存在。");
        }
        if(!checkUtil.checkPidIsExists(pid)){
            throw new ApiException("传入的[pid]值，无效。在数据库中不存在，或者产品已经下架。");
        }
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            ApiQueryProductCollectionParamBean paramBean = new ApiQueryProductCollectionParamBean();
            paramBean.setCid(cid);
            paramBean.setPid(pid);
            sqlSession.delete("dazhimen.api.bean.ApiProduct.cancelCollectProduct",paramBean);
            sqlSession.commit();
        } catch (Exception e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException("取消收藏产品失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }

    public List<ApiListViewCourseBean> getProductCourseList(String pid) throws ApiException{
        CheckIsExistsUtils checkUtil = new CheckIsExistsUtils();
        if(!checkUtil.checkPidIsExists(pid)){
            throw new ApiException("传入的[pid]值，无效。在数据库中不存在，或者产品已经下架。");
        }
        List<ApiListViewCourseBean> courseBeans = null;
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            courseBeans = sqlSession.selectList("dazhimen.api.bean.ApiProduct.getProductCourseList", pid);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ApiException("出现异常，获取产品课程列表出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return courseBeans;
    }
}
