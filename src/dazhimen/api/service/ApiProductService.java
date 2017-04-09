package dazhimen.api.service;

import dazhimen.api.bean.*;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import util.CheckIsExistsUtils;
import util.Constant;
import java.util.List;

/**
 * Created by Administrator on 2017/3/24.
 */
public class ApiProductService {
    public String getMainImgPath(String pid) throws ApiException {
        SqlSession sqlSession = null;
        String mainImgPath = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            mainImgPath = sqlSession.selectOne("dazhimen.api.bean.ApiProduct.getMainImgPath", pid);
            if(mainImgPath == null || mainImgPath.equals("")){
                throw new ApiException("出现异常，查询产品主图出错");
            }
        }catch (ApiException e){
            e.printStackTrace();
            throw new ApiException(e.getMessage());
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return mainImgPath;
    }
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
    private List<ApiProductBean> getProductByCountAndType(int getCount, String type) throws Exception {
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
            throw new Exception(e);
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }

        return productBeans;
    }
    public List<ApiProductBean> getMoreSkillPack(String getCount) throws ParameterCheckException, ApiException {
        if(getCount != null && !getCount.equals("")){
            try{
                Integer.parseInt(getCount);
            }catch (Exception e){
                throw new ParameterCheckException("传入的参数[getCount]不是有效的数字");
            }
        }
        List<ApiProductBean> productBeans = null;
        try{
            if(getCount == null || getCount.equals("")){
                productBeans = getMoreProductByType(Constant.SkillPack);
            }else{
                productBeans =getMoreProdcutByCountAndType(Integer.parseInt(getCount), Constant.SkillPack);
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，获取更多技能包出错");
        }

        return productBeans;
    }
    public List<ApiProductBean> getMoreExperiencePack(String getCount) throws ParameterCheckException, ApiException {
        if(getCount != null && !getCount.equals("")){
            try{
                Integer.parseInt(getCount);
            }catch (Exception e){
                throw new ParameterCheckException("传入的参数[getCount]不是有效的数字");
            }
        }
        List<ApiProductBean> productBeans = null;
        try{
            if(getCount == null || getCount.equals("")){
                productBeans = getMoreProductByType(Constant.ExperiencePack);
            }else{
                productBeans =getMoreProdcutByCountAndType(Integer.parseInt(getCount), Constant.ExperiencePack);
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，获取更多经验包出错");
        }

        return productBeans;
    }
    public List<ApiProductBean> searchExperiencePack(String keyword) throws ApiException {
        List<ApiProductBean> productBeans = null;
        try {
            productBeans = searchProductByTypeAndKeyword(Constant.ExperiencePack, keyword);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ApiException("检索经验包出错");
        }
        return productBeans;
    }
    public List<ApiProductBean> searchSkillPack(String keyword) throws ApiException {
        List<ApiProductBean> productBeans = null;
        try {
            productBeans = searchProductByTypeAndKeyword(Constant.SkillPack, keyword);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ApiException("检索技能包出错");
        }
        return productBeans;
    }
    private List<ApiProductBean> searchProductByTypeAndKeyword(String type, String keyword) throws Exception {
        List<ApiProductBean> productBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            ApiQueryProductByTypeAndKeyword paramBean = new ApiQueryProductByTypeAndKeyword();
            paramBean.setType(type);
            paramBean.setKeyword("%" + keyword + "%");
            productBeans = sqlSession.selectList("dazhimen.api.bean.ApiProduct.searchProductByTypeAndKeyword",paramBean);
        }catch (Exception e){
            e.printStackTrace();
            throw new Exception(e);
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }

        return productBeans;
    }
    private List<ApiProductBean> getMoreProductByType(String type) throws Exception {
        SqlSession sqlSession = null;
        List<ApiProductBean> productBeans;
        try{
            sqlSession = MyBatisUtil.createSession();
            productBeans = sqlSession.selectList("dazhimen.api.bean.ApiProduct.getMoreProductByType", type);
        }catch (Exception e){
            e.printStackTrace();
            throw new Exception(e);
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return productBeans;
    }
    private List<ApiProductBean> getMoreProdcutByCountAndType(int getCount, String type) throws Exception {
        List<ApiProductBean> productBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            ApiQueryProductParamBean paramBean = new ApiQueryProductParamBean();
            paramBean.setGetcount(getCount);
            paramBean.setType(type);
            productBeans = sqlSession.selectList("dazhimen.api.bean.ApiProduct.getMoreProductByCountAndType",paramBean);
        }catch (Exception e){
            e.printStackTrace();
            throw new Exception(e);
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }

        return productBeans;
    }
    public ApiSpecifyProductBean getProductInforById(String pid, String cid) throws ApiException {
        SqlSession sqlSession = null;
        ApiSpecifyProductBean productBean = null;
        CheckIsExistsUtils checkUtil = new CheckIsExistsUtils();
        if(!checkUtil.checkPidIsExists(pid)){
            throw new ApiException("传入的[pid]值，无效。在数据库中不存在，或者产品已经下架。");
        }
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
    public List<ApiListViewCourseBean> getReverseCourseList(String pid) throws ApiException{
        CheckIsExistsUtils checkUtil = new CheckIsExistsUtils();
        if(!checkUtil.checkPidIsExists(pid)){
            throw new ApiException("传入的[pid]值，无效。在数据库中不存在，或者产品已经下架。");
        }
        List<ApiListViewCourseBean> courseBeans = null;
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            courseBeans = sqlSession.selectList("dazhimen.api.bean.ApiProduct.getReverseCourseList", pid);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ApiException("出现异常，获取产品课程列表出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return courseBeans;
    }

    public String getProductAudioUpdateCount(String pid){
        SqlSession sqlSession = null;
        String updateCount = "";
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean value = sqlSession.selectOne("dazhimen.api.bean.ApiProduct.getProductAudioUpdateCount", pid);
            if(value == null){
                throw new ApiException("查询产品音频更新条数出错");
            }
            updateCount = value.getValueInfo();
        }catch(ApiException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return updateCount;
    }
    public List<ApiCustomerCollectProductBean> getCustomerCollectProduct(String cid) throws ApiException {
        List<ApiCustomerCollectProductBean> productBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            productBeans = sqlSession.selectList("dazhimen.api.bean.ApiProduct.getCustomerCollectProduct", cid);
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，查询会员收藏产品信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return productBeans;
    }
    public void updateCourseViewCount(String courseid, String cid) throws ApiException {
        CheckIsExistsUtils checkIsExistsUtils = new CheckIsExistsUtils();
        if(!checkIsExistsUtils.checkCourseidIsExists(courseid)){
            throw new ApiException("传入的[courseid]值无效，在数据库中不存在");
        }
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            //检查用户是否已经读过此音频
            if(cid != null && !cid.equals("")){
                if(!checkIsExistsUtils.checkCidIsExists(cid)){
                    throw new ApiException("传入的[cid]值无效，在数据库中不存在");
                }
                ApiIrCustomerCourseParaBean checkBean = new ApiIrCustomerCourseParaBean();
                checkBean.setCid(cid);
                checkBean.setCourseid(courseid);
                SingleValueBean singleValueBean = sqlSession.selectOne("dazhimen.api.bean.ApiProduct.checkISCustomerViewedCourse", checkBean);
                if(singleValueBean != null && singleValueBean.getValueInfo() != null && singleValueBean.getValueInfo().equals("1")){
                    return;
                }
                sqlSession.insert("dazhimen.api.bean.ApiProduct.recordCustomerViewCourse",checkBean);
                sqlSession.update("dazhimen.api.bean.ApiProduct.updateCourseViewCount", courseid);
                sqlSession.commit();
            }else{
                sqlSession.update("dazhimen.api.bean.ApiProduct.updateCourseViewCount", courseid);
                sqlSession.commit();
            }
        }catch (ApiException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException(e.getMessage());
        } catch(Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException("出现异常，更新音频viewCount出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
}
