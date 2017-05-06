package dazhimen.bg.service;

import dazhimen.bg.bean.playsort.*;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

/**
 * 首页轮播和首页排序的Service类
 */
public class PlaySortService {

    /**
     * 取消掌门首页排序
     * @param uid
     * @return
     */
    public boolean saveDeleteMasterSort(String uid) throws BgException {
        SqlSession sqlSession = null;
        int result = 0;
        try {
            sqlSession = MyBatisUtil.createSession();
            String indexSort = sqlSession.selectOne("dazhimen.bg.bean.PlaySort.getMasterIndexSortById", uid);
            if (indexSort == null || indexSort.equals("")) {
                throw new BgException("查询掌门对应的首页排序出错");
            }
            result = sqlSession.update("dazhimen.bg.bean.PlaySort.deleteMasterIndexSort", uid);
            sqlSession.update("dazhimen.bg.bean.PlaySort.dealMasterIndexSort", indexSort);
            sqlSession.commit();
        }catch (BgException e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch (Exception e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，取消掌门首页排序出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
    /**
     * 取消新闻首页排序
     * @param nid
     * @return
     */
    public boolean saveDeleteNewsSort(String nid) throws BgException {
        SqlSession sqlSession = null;
        int result = 0;
        try {
            sqlSession = MyBatisUtil.createSession();
            String indexSort = sqlSession.selectOne("dazhimen.bg.bean.PlaySort.getNewsIndexSortById", nid);
            if (indexSort == null || indexSort.equals("")) {
                throw new BgException("查询新闻对应的首页排序出错");
            }
            result = sqlSession.update("dazhimen.bg.bean.PlaySort.deleteNewsIndexSort", nid);
            sqlSession.update("dazhimen.bg.bean.PlaySort.dealNewsIndexSort", indexSort);
            sqlSession.commit();
        }catch (BgException e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch (Exception e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，取消新闻首页排序出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
    /**
     * 取消技能包首页排序
     * @param pid
     * @return
     */
    public boolean saveDeleteSkillPackSort(String pid) throws BgException {
        SqlSession sqlSession = null;
        int result = 0;
        try {
            sqlSession = MyBatisUtil.createSession();
            String indexSort = sqlSession.selectOne("dazhimen.bg.bean.PlaySort.getProductIndexSortById", pid);
            if (indexSort == null || indexSort.equals("")) {
                throw new BgException("查询技能包对应的首页排序出错");
            }
            result = sqlSession.update("dazhimen.bg.bean.PlaySort.deleteProductIndexSort", pid);
            sqlSession.update("dazhimen.bg.bean.PlaySort.dealSkillPackIndexSort", indexSort);
            sqlSession.commit();
        }catch (BgException e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch (Exception e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，取消技能包首页排序出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }

    /**
     * 取消经验包首页排序
     * @param pid
     * @return
     */
    public boolean saveDeleteExperiencePackSort(String pid) throws BgException {
        SqlSession sqlSession = null;
        int result = 0;
        try {
            sqlSession = MyBatisUtil.createSession();
            String indexSort = sqlSession.selectOne("dazhimen.bg.bean.PlaySort.getProductIndexSortById", pid);
            if (indexSort == null || indexSort.equals("")) {
                throw new BgException("查询经验包对应的首页排序出错");
            }
            result = sqlSession.update("dazhimen.bg.bean.PlaySort.deleteProductIndexSort", pid);
            sqlSession.update("dazhimen.bg.bean.PlaySort.dealExperiencePackIndexSort", indexSort);
            sqlSession.commit();
        }catch (BgException e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch (Exception e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，取消经验包首页排序出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
    /**
     * 保存添加技能包首页排序
     * @param pid
     * @return
     * @throws BgException
     */
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

    /**
     * 保存添加经验包首页排序
     * @param pid
     * @return
     * @throws BgException
     */
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

    /**
     * 保存添加新闻首页排序
     * @param nid
     * @return
     * @throws BgException
     */
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

    /**
     * 保存添加掌门首页排序
     * @param nid
     * @return
     * @throws BgException
     */
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

    /**
     * 清空技能包首页排序
     * @throws BgException
     */
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

    /**
     * 清空经验包首页排序
     * @throws BgException
     */
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

    /**
     * 保存清空新闻首页排序
     * @throws BgException
     */
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

    /**
     * 保存清空掌门首页排序
     * @throws BgException
     */
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

    /**
     * 查询所有首页排序的技能包
     * @return
     * @throws BgException
     */
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
    /**
     * 查询所有首页排序的经验包
     * @return
     * @throws BgException
     */
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
    /**
     * 查询所有首页排序的新闻
     * @return
     * @throws BgException
     */
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
    /**
     * 查询所有首页排序的掌门
     * @return
     * @throws BgException
     */
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

    /**
     * 查询所有首页轮播
     * @return
     * @throws BgException
     */
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
    /**
     * 查询可以添加 首页排序的 技能包数据
     * @return
     * @throws BgException
     */
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
    /**
     * 查询可以添加 首页排序的 经验包数据
     * @return
     * @throws BgException
     */
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
    /**
     * 查询可以添加 首页排序的 新闻数据
     * @return
     * @throws BgException
     */
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
    /**
     * 查询可以添加 首页排序的 掌门数据
     * @return
     * @throws BgException
     */
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
    /**
     * 查询可以添加 首页轮播的 新闻和产品数据
     * @return
     * @throws BgException
     */
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

    /**
     * 保存新增首页轮播
     * @param id
     * @param type
     * @return
     * @throws BgException
     */
    public boolean saveAddIndexPlay(String id, String type) throws BgException {
        SqlSession sqlSession = null;
        int result = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            if(type.equals("1") || type.equals("2")){
                result = sqlSession.update("dazhimen.bg.bean.PlaySort.saveAddProductIndexPlay", id);
            }else{
                result = sqlSession.update("dazhimen.bg.bean.PlaySort.saveAddNewsIndexPlay", id);
            }

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

    /**
     * 保存取消首页轮播
     * @param id
     * @param type
     * @return
     * @throws BgException
     */
    public boolean saveDeleteIndexPlay(String id, String type) throws BgException {
        SqlSession sqlSession = null;
        int result = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            if(type.equals("1") || type.equals("2")){
                result = sqlSession.update("dazhimen.bg.bean.PlaySort.saveDeleteProductIndexPlay", id);
            }else{
                result = sqlSession.update("dazhimen.bg.bean.PlaySort.saveDeleteNewsIndexPlay", id);
            }
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
