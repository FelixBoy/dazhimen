package dazhimen.api.service;

import dazhimen.api.bean.ApiHomePageNewsBean;
import dazhimen.api.bean.ApiNewsContentBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import util.CheckIsExistsUtils;

import java.util.List;

/**
 * Created by Administrator on 2017/4/12.
 */
public class ApiNewsService {
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
}
