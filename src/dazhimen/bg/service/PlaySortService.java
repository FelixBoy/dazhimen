package dazhimen.bg.service;

import dazhimen.bg.bean.playsort.*;
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
            UpdateIndexSortBean indexSortBean = new UpdateIndexSortBean();
            indexSortBean.setId(pid);
            indexSortBean.setIndexsort(nextIndexSortPosition);
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

    public boolean saveAddExperiencePackIndexSort(String pid) throws BgException {
        SqlSession sqlSession = null;
        int result = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            String nextIndexSortPosition = sqlSession.selectOne("dazhimen.bg.bean.PlaySort.getExperiencePackNextSortPosition");
            if(nextIndexSortPosition == null || nextIndexSortPosition.equals("")){
                throw new BgException("获得经验包下一个排序位置出错");
            }
            UpdateIndexSortBean indexSortBean = new UpdateIndexSortBean();
            indexSortBean.setId(pid);
            indexSortBean.setIndexsort(nextIndexSortPosition);
            result = sqlSession.update("dazhimen.bg.bean.PlaySort.saveAddExperiencePackIndexSort", indexSortBean);
            sqlSession.commit();
        }catch (BgException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException(e.getMessage());
        }catch(Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，保存经验包首页排序数据出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
    public boolean saveAddNewsIndexSort(String nid) throws BgException {
        SqlSession sqlSession = null;
        int result = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            String nextIndexSortPosition = sqlSession.selectOne("dazhimen.bg.bean.PlaySort.getNewsNextSortPosition");
            if(nextIndexSortPosition == null || nextIndexSortPosition.equals("")){
                throw new BgException("获得新闻下一个排序位置出错");
            }
            UpdateIndexSortBean indexSortBean = new UpdateIndexSortBean();
            indexSortBean.setId(nid);
            indexSortBean.setIndexsort(nextIndexSortPosition);
            result = sqlSession.update("dazhimen.bg.bean.PlaySort.saveAddNewsIndexSort", indexSortBean);
            sqlSession.commit();
        }catch (BgException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException(e.getMessage());
        }catch(Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，保存新闻首页排序数据出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }

    public boolean saveAddMasterIndexSort(String nid) throws BgException {
        SqlSession sqlSession = null;
        int result = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            String nextIndexSortPosition = sqlSession.selectOne("dazhimen.bg.bean.PlaySort.getMasterNextSortPosition");
            if(nextIndexSortPosition == null || nextIndexSortPosition.equals("")){
                throw new BgException("获得掌门下一个排序位置出错");
            }
            UpdateIndexSortBean indexSortBean = new UpdateIndexSortBean();
            indexSortBean.setId(nid);
            indexSortBean.setIndexsort(nextIndexSortPosition);
            result = sqlSession.update("dazhimen.bg.bean.PlaySort.saveAddMasterIndexSort", indexSortBean);
            sqlSession.commit();
        }catch (BgException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException(e.getMessage());
        }catch(Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，保存掌门首页排序数据出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
    public void clearSkillPackIndexSort() throws BgException {
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            sqlSession.update("dazhimen.bg.bean.PlaySort.clearSkillPackIndexSort");
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，清空技能包首页排序出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public void clearExperiencePackIndexSort() throws BgException {
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            sqlSession.update("dazhimen.bg.bean.PlaySort.clearExperiencePackIndexSort");
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，清空经验包首页排序出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public void clearNewsIndexSort() throws BgException {
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            sqlSession.update("dazhimen.bg.bean.PlaySort.clearNewsIndexSort");
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，清空新闻首页排序出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }

    public void clearMasterIndexSort() throws BgException {
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            sqlSession.update("dazhimen.bg.bean.PlaySort.clearMasterIndexSort");
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，清空掌门首页排序出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
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
    public List<ProductIndexSortBean> queryAllExperiencePackIndexSort() throws BgException {
        List<ProductIndexSortBean> productBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            productBeans = sqlSession.selectList("dazhimen.bg.bean.PlaySort.queryAllExperiencePackIndexSort");
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有经验包首页排序出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return productBeans;
    }
    public List<NewsIndexSortBean> queryAllNewsIndexSort() throws BgException {
        List<NewsIndexSortBean> newsBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            newsBeans = sqlSession.selectList("dazhimen.bg.bean.PlaySort.queryAllNewsIndexSort");
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有新闻首页排序出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return newsBeans;
    }
    public List<MasterIndexSortBean> queryAllMasterIndexSort() throws BgException {
        List<MasterIndexSortBean> masterBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            masterBeans = sqlSession.selectList("dazhimen.bg.bean.PlaySort.queryAllMasterIndexSort");
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有掌门首页排序出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return masterBeans;
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
    public List<ProductIndexSortBean> getAddExperiencePackIndexSortData() throws BgException {
        List<ProductIndexSortBean> productBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            productBeans = sqlSession.selectList("dazhimen.bg.bean.PlaySort.getAddExperiencePackIndexSortData");
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询产品首页排序内容出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return productBeans;
    }
    public List<NewsIndexSortBean> getAddNewsIndexSortData() throws BgException {
        List<NewsIndexSortBean> newsBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            newsBeans = sqlSession.selectList("dazhimen.bg.bean.PlaySort.getAddNewsIndexSortData");
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询新闻首页排序内容出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return newsBeans;
    }

    public List<MasterIndexSortBean> getAddMasterIndexSortData() throws BgException {
        List<MasterIndexSortBean> masterBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            masterBeans = sqlSession.selectList("dazhimen.bg.bean.PlaySort.getAddMasterIndexSortData");
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询掌门首页排序内容出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return masterBeans;
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
