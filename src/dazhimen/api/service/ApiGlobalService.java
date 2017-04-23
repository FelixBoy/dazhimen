package dazhimen.api.service;

import dazhimen.api.bean.other.ApiGlobalSearchBean;
import dazhimen.api.exception.ApiException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

/**
 * Created by Administrator on 2017/4/8.
 */
public class ApiGlobalService {
    public List<ApiGlobalSearchBean> globalSearch(String keyword) throws ApiException {
        List<ApiGlobalSearchBean> globalSearchBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            globalSearchBeans = sqlSession.selectList("dazhimen.api.bean.global.globalSearch", "%" + keyword + "%");
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，全局检索失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return globalSearchBeans;
    }
}
