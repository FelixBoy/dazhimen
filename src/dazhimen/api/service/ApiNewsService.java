package dazhimen.api.service;

import dazhimen.api.bean.*;
import dazhimen.api.bean.news.ApiHomePageNewsBean;
import dazhimen.api.bean.news.ApiMoreNewsBean;
import dazhimen.api.bean.news.ApiNewsContentBean;
import dazhimen.api.bean.news.ApiQueryNewsCollectionParamBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import util.CheckIsExistsUtils;
import util.Constant;

import java.util.List;
/**
 * Created by Administrator on 2017/4/12.
 */
public class ApiNewsService {
    public List<ApiHomePageNewsBean> getCustomerCollectNews(String cid) throws ApiException {
        List<ApiHomePageNewsBean> newsBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            newsBeans = sqlSession.selectList("dazhimen.api.bean.ApiNews.getCustomerCollectNews", cid);
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，查询会员收藏的新闻信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return newsBeans;
    }
    public void cancelCollectNews(String cid, String nid) throws ApiException {
        CheckIsExistsUtils checkUtil = new CheckIsExistsUtils();
        if(!checkUtil.checkCidIsExists(cid)){
            throw new ApiException("传入的[cid]值，无效。在数据库中不存在。");
        }
        if(!checkUtil.checkNidIsExists(nid)){
            throw new ApiException("传入的[nid]值，无效。在数据库中不存在，或者已经下架。");
        }
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            ApiQueryNewsCollectionParamBean paramBean = new ApiQueryNewsCollectionParamBean();
            paramBean.setCid(cid);
            paramBean.setNid(nid);
            sqlSession.delete("dazhimen.api.bean.ApiNews.cancelCollectNews",paramBean);
            sqlSession.commit();
        } catch (Exception e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException("取消收藏新闻失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public boolean collectNews(String cid, String nid) throws ApiException {
        int result = 0;
        SqlSession sqlSession = null;
        CheckIsExistsUtils checkUtil = new CheckIsExistsUtils();
        if(!checkUtil.checkCidIsExists(cid)){
            throw new ApiException("传入的[cid]值，无效。在数据库中不存在。");
        }
        if(!checkUtil.checkNidIsExists(nid)){
            throw new ApiException("传入的[nid]值，无效。在数据库中不存在，或者已经下架。");
        }
        try {
            sqlSession = MyBatisUtil.createSession();
            ApiQueryNewsCollectionParamBean paramBean = new ApiQueryNewsCollectionParamBean();
            paramBean.setCid(cid);
            paramBean.setNid(nid);
            SingleValueBean value = sqlSession.selectOne("dazhimen.api.bean.ApiNews.getNewsIsCollection", paramBean);
            if(value != null && value.getValueInfo()!= null && value.getValueInfo().equals("1")){
                return true;
            }
            result = sqlSession.insert("dazhimen.api.bean.ApiNews.collectNews", paramBean);
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
    public List<ApiMoreNewsBean> searchNews(String keyword) throws ApiException {
        List<ApiMoreNewsBean> newsBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            newsBeans = sqlSession.selectList("dazhimen.api.bean.ApiNews.searchNews", keyword);
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，检索新闻出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return newsBeans;
    }
    public List<ApiMoreNewsBean> getMoreNews(String getcount) throws ParameterCheckException, ApiException {
        if(getcount != null && !getcount.equals("")){
            try{
                Integer.parseInt(getcount);
            }catch (Exception e){
                throw new ParameterCheckException("传入的参数[getCount]不是有效的数字");
            }
        }
        List<ApiMoreNewsBean> newsBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            if(getcount == null || getcount.equals("")){
                newsBeans = sqlSession.selectList("dazhimen.api.bean.ApiNews.getMoreNews");
            }else{
                newsBeans = sqlSession.selectList("dazhimen.api.bean.ApiNews.getMoreNewsByCount", Integer.parseInt(getcount));
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，获取更多新闻出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return newsBeans;
    }
    public List<ApiNewsContentBean> getNewsContentById(String nid) throws ApiException {
        List<ApiNewsContentBean> contentBeans = null;
        CheckIsExistsUtils checkUtil = new CheckIsExistsUtils();
        if(!checkUtil.checkNidIsExists(nid)){
            throw new ApiException("传入的[nid]值，无效。在数据库中不存在。");
        }
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            contentBeans = sqlSession.selectList("dazhimen.api.bean.ApiNews.getNewsContentById", nid);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ApiException("出现异常，获取指定新闻内容出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return contentBeans;
    }
    public String getNewsIsCollection(String nid, String cid) throws ApiException {

        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            if(cid != null && !cid.equals("")){
                ApiQueryNewsCollectionParamBean paramBean = new ApiQueryNewsCollectionParamBean();
                paramBean.setCid(cid);
                paramBean.setNid(nid);
                SingleValueBean value = sqlSession.selectOne("dazhimen.api.bean.ApiNews.getNewsIsCollection", paramBean);
                if(value != null && value.getValueInfo()!= null && value.getValueInfo().equals("1")){
                    return "1";
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，查询新闻收藏状态出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return "0";
    }
    public String getNewsTotalCount(){
        SqlSession sqlSession = null;
        String totalCount = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            totalCount = sqlSession.selectOne("dazhimen.api.bean.ApiNews.getNewsTotalCount");
            if(totalCount == null || totalCount.equals("")){
                return "0";
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return totalCount;
    }
    public List<ApiHomePageNewsBean> getHomePageNews(String getcount) throws ParameterCheckException, ApiException {
        int getCountInt = 0;
        if(getcount == null || getcount.equals("")){
            getCountInt = 2;
        }else{
            try {
                getCountInt = Integer.parseInt(getcount);
            }catch (NumberFormatException e){
                e.printStackTrace();
                throw new ParameterCheckException("参数[getcount]不是数字，格式化出错");
            }
        }
        List<ApiHomePageNewsBean> newsBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            newsBeans = sqlSession.selectList("dazhimen.api.bean.ApiNews.getHomePageNews",getCountInt);
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，查询首页新闻出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return newsBeans;
    }
    public ApiHomePageNewsBean getNewsInforById(String nid) throws ParameterCheckException, ApiException {
        ApiHomePageNewsBean newsBean = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            newsBean = sqlSession.selectOne("dazhimen.api.bean.ApiNews.getNewsInforById",nid);
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，查询指定新闻信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return newsBean;
    }

    /**
     * 获取指定新闻对应的html文件的url
     * @param nid 新闻id
     * @return 内容文件url
     */
    public String getNewsURLById(String nid) throws ApiException {
        CheckIsExistsUtils checkUtil = new CheckIsExistsUtils();
        if(!checkUtil.checkNidIsExists(nid)){
            throw new ApiException("传入的[nid]值，无效。在数据库中不存在。");
        }
        SqlSession sqlSession = null;
        String fileUrl = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            fileUrl = sqlSession.selectOne("dazhimen.api.bean.ApiNews.getNewsURLById", nid);
            if(fileUrl == null || fileUrl.equals("")){
                throw new ApiException("出现异常，获取新闻URL出错");
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，获取新闻URL出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return fileUrl;
    }
    public String getShareURL() throws ApiException {
        SqlSession sqlSession = null;
        String shareURL = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            shareURL = sqlSession.selectOne("dazhimen.api.bean.ApiNews.getShareURL", Constant.shareNewsId);
            if(shareURL == null || shareURL.equals("")){
                throw new ApiException("出现异常，获取分享链接出错");
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，获取分享链接出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return shareURL;
    }
}
