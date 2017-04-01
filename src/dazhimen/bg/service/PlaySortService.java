package dazhimen.bg.service;

import dazhimen.bg.bean.IndexPlayBean;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

/**
 * Created by Administrator on 2017/4/1.
 */
public class PlaySortService {
    public List<IndexPlayBean> queryAllIndexPlay() throws BgException {
        List<IndexPlayBean> indexPlayBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            indexPlayBeans = sqlSession.selectList("dazhimen.bg.bean.PlaySort.listAllIndexPlay");
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询首页轮播列表出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return indexPlayBeans;
    }

    public List<IndexPlayBean> getAddIndexPlayData() throws BgException {
        List<IndexPlayBean> indexPlayBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            indexPlayBeans = sqlSession.selectList("dazhimen.bg.bean.PlaySort.getAddIndexPlayData");
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询新增轮播数据出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return indexPlayBeans;
    }

    public boolean saveAddIndexPlay(String pid) throws BgException {
        SqlSession sqlSession = null;
        int result = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            result = sqlSession.update("dazhimen.bg.bean.PlaySort.saveAddIndexPlay", pid);
            sqlSession.commit();
        }catch (Exception e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，保存首页轮播数据出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
    public boolean saveDeleteIndexPlay(String pid) throws BgException {
        SqlSession sqlSession = null;
        int result = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            result = sqlSession.update("dazhimen.bg.bean.PlaySort.saveDeleteIndexPlay", pid);
            sqlSession.commit();
        }catch (Exception e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，取消首页轮播数据出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
}
