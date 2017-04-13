package dazhimen.bg.service;

import dazhimen.bg.bean.IndexPlayBean;
import dazhimen.bg.bean.indexsort.ProductIndexSortBean;
import dazhimen.bg.bean.indexsort.UpdateSkillPackIndexSortBean;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

/**
 * Created by Administrator on 2017/4/1.
 */
public class PlaySortService {
    public boolean saveAddSkillPackIndexSort(String pid) throws BgException {
        SqlSession sqlSession = null;
        int result = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            String nextIndexSortPosition = sqlSession.selectOne("dazhimen.bg.bean.PlaySort.getSkillPackNextSortPosition");
            if(nextIndexSortPosition == null || nextIndexSortPosition.equals("")){
                throw new BgException("获得技能包下一个排序位置出错");
            }
            UpdateSkillPackIndexSortBean indexSortBean = new UpdateSkillPackIndexSortBean();
            indexSortBean.setPid(pid);
            indexSortBean.setNextIndexSort(nextIndexSortPosition);
            result = sqlSession.update("dazhimen.bg.bean.PlaySort.saveAddSkillPackIndexSort", indexSortBean);
            sqlSession.commit();
        }catch (BgException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException(e.getMessage());
        }catch(Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，保存技能包首页排序数据出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
    public List<ProductIndexSortBean> queryAllSkillPackIndexSort() throws BgException {
        List<ProductIndexSortBean> productBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            productBeans = sqlSession.selectList("dazhimen.bg.bean.PlaySort.queryAllSkillPackIndexSort");
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有技能包首页排序出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return productBeans;
    }
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
    public List<ProductIndexSortBean> getAddSkillPackIndexSortData() throws BgException {
        List<ProductIndexSortBean> productBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            productBeans = sqlSession.selectList("dazhimen.bg.bean.PlaySort.getAddSkillPackIndexSortData");
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询产品首页排序内容出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return productBeans;
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
