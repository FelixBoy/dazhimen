package dazhimen.api.service;

import dazhimen.api.bean.ApiMasterBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

/**
 * Created by Administrator on 2017/3/31.
 */
public class ApiMasterService {
    public List<ApiMasterBean> getHomePageMasterInfo(String getCount) throws ApiException, ParameterCheckException {
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
        SqlSession sqlSession = null;
        List<ApiMasterBean> masterBeans = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            masterBeans = sqlSession.selectList("dazhimen.api.bean.ApiMaster.getHomePageMasterInfo", getCountInt);
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，查询首页掌门信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return masterBeans;
    }
    public ApiMasterBean getMasterInfoById(String masterid) throws ApiException{
        SqlSession sqlSession = null;
        ApiMasterBean masterBean = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            masterBean = sqlSession.selectOne("dazhimen.api.bean.ApiMaster.getMasterInfoById", masterid);
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，获取制定掌门信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return masterBean;
    }

    public List<ApiMasterBean> getMoreMasterInfo(String getCount) throws ParameterCheckException, ApiException {
        if(getCount != null && !getCount.equals("")){
            try{
                Integer.parseInt(getCount);
            }catch (Exception e){
                throw new ParameterCheckException("传入的参数[getCount]不是有效的数字");
            }
        }
        List<ApiMasterBean> masterBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            if(getCount == null || getCount.equals("")){
                masterBeans = sqlSession.selectList("dazhimen.api.bean.ApiMaster.getMoreMasterInfo");
            }else{
                masterBeans = sqlSession.selectList("dazhimen.api.bean.ApiMaster.getMoreMasterInfoByCount", Integer.parseInt(getCount));
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，获取更多掌门信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return masterBeans;
    }

    public List<ApiMasterBean> searchMasterInfo(String keyword) throws ParameterCheckException, ApiException {
        List<ApiMasterBean> masterBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            masterBeans = sqlSession.selectList("dazhimen.api.bean.ApiMaster.searchMasterInfo", "%" + keyword + "%");
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，检索掌门信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return masterBeans;
    }
}
