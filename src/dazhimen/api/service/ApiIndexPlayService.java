package dazhimen.api.service;

import dazhimen.api.bean.other.ApiIndexPlayBean;
import dazhimen.api.exception.ApiException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

/**
 * Created by Administrator on 2017/4/2.
 */
public class ApiIndexPlayService {
    public List<ApiIndexPlayBean> getIndexPlay() throws ApiException {
        SqlSession sqlSession = null;
        List<ApiIndexPlayBean> indexPlayBeans = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            indexPlayBeans = sqlSession.selectList("dazhimen.api.bean.ApiIndexPlay.getIndexPlay");
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException("出现异常，获取首页轮播数据出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return indexPlayBeans;
    }
}
