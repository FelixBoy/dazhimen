package dazhimen.bg.service;

import com.google.gson.Gson;
import dazhimen.bg.bean.PaginationParamBean;
import dazhimen.bg.bean.permission.*;
import dazhimen.bg.bean.product.QueryMasterParamBean;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import net.sf.json.JSONObject;
import org.apache.ibatis.session.SqlSession;
import util.CheckIsExistsUtils;
import util.IdUtils;
import util.PaginationUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/4/18.
 */
public class PermissionService {
    public String queryAllRole(String page, String rows) throws BgException {
        SqlSession sqlSession = null;
        Integer totalCount = null;
        List<ListViewRoleBean> roleBeans = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            String allAdminCountValue = sqlSession.selectOne("dazhimen.bg.bean.Permission.getAllRoleCount");
            if(allAdminCountValue == null || allAdminCountValue.equals("")){
                throw new BgException("获取管理员数据总条数出错");
            }
            totalCount = Integer.parseInt(allAdminCountValue);
            PaginationParamBean paramBean = PaginationUtil.getPaginationParamBean(page,rows);
            roleBeans = sqlSession.selectList("dazhimen.bg.bean.Permission.queryAllRole", paramBean);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有角色信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", roleBeans);
        return jsonObject.toString();
    }
    public void saveDeleteRole(String rid) throws BgException {
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            sqlSession.delete("dazhimen.bg.bean.Permission.deleteIrUserRole", rid);
            sqlSession.delete("dazhimen.bg.bean.Permission.deleteIrRoleModule", rid);
            sqlSession.delete("dazhimen.bg.bean.Permission.deleteRole", rid);
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，删除角色失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public void saveAddRole(AddRoleBean addRoleBean) throws BgException {
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            String rid = new IdUtils().getRoleId();
            addRoleBean.setRid(rid);
            sqlSession.insert("dazhimen.bg.bean.Permission.saveAddRole", addRoleBean);
            ArrayList<String> permissionList = addRoleBean.getPermissionList();
            AddIrRoleModuleBean irRoleModuleBean = new AddIrRoleModuleBean();
            if(permissionList != null && permissionList.size() > 0){
                for(int i = 0 ; i < permissionList.size(); i++){
                    irRoleModuleBean.setRid(rid);
                    irRoleModuleBean.setMid(permissionList.get(i));
                    sqlSession.insert("dazhimen.bg.bean.Permission.saveAddIrRoleModule", irRoleModuleBean);
                }
            }
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，新增角色失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public ViewRoleInforBean getRoleInfor(String rid) throws BgException {
        if(rid == null || rid.equals("")){
            throw new BgException("传入的rid参数为空，无法查询");
        }
        SqlSession sqlSession = null;
        ViewRoleInforBean roleInforBean = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            roleInforBean = sqlSession.selectOne("dazhimen.bg.bean.Permission.getRoleInfor", rid);
        }catch (Exception e){

        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return roleInforBean;
    }

    public List<ViewIrRoleModuleBean> queryIrRoleModule(String rid) throws BgException {
        if(rid == null || rid.equals("")){
            throw new BgException("传入的rid参数为空，无法查询");
        }
        SqlSession sqlSession = null;
        List<ViewIrRoleModuleBean> irRoleModuleBeans = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            irRoleModuleBeans = sqlSession.selectList("dazhimen.bg.bean.Permission.queryIrRoleModule", rid);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询角色对应权限模块信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return irRoleModuleBeans;
    }
    public List<ViewIrRoleUserBean> queryIrRoleUser(String rid) throws BgException {
        if(rid == null || rid.equals("")){
            throw new BgException("传入的rid参数为空，无法查询");
        }
        SqlSession sqlSession = null;
        List<ViewIrRoleUserBean> irRoleUserBeans = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            irRoleUserBeans = sqlSession.selectList("dazhimen.bg.bean.Permission.queryIrRoleUser", rid);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询角色对应人员信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return irRoleUserBeans;
    }

    public String getRoleInforInAdjustUser(String rid) throws BgException {
        if(rid == null || rid.equals("")){
            throw new BgException("传入的rid参数为空，无法查询");
        }
        SqlSession sqlSession = null;
        ViewRoleInforBean roleInforBean = null;
        List<ViewIrRoleModuleBean> irRoleModuleBeans = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            roleInforBean = sqlSession.selectOne("dazhimen.bg.bean.Permission.getModifyRoleInfor", rid);
            irRoleModuleBeans = sqlSession.selectList("dazhimen.bg.bean.Permission.queryIrRoleModule", rid);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询角色信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("rid", roleInforBean.getRid());
        jsonObject.put("name", roleInforBean.getName());
        jsonObject.put("ismastercanown", roleInforBean.getIsmastercanown());
        jsonObject.put("introduction", roleInforBean.getIntroduction());
        jsonObject.put("rolepermissionstr", getRolePermissionStr(irRoleModuleBeans));
        return jsonObject.toString();
    }
    public String getModifyRoleInfor(String rid) throws BgException {
        if(rid == null || rid.equals("")){
            throw new BgException("传入的rid参数为空，无法查询");
        }
        SqlSession sqlSession = null;
        ViewRoleInforBean roleInforBean = null;
        List<ViewIrRoleModuleBean> irRoleModuleBeans = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            roleInforBean = sqlSession.selectOne("dazhimen.bg.bean.Permission.getModifyRoleInfor", rid);
            irRoleModuleBeans = sqlSession.selectList("dazhimen.bg.bean.Permission.queryIrRoleModuleInModifyRole", rid);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询角色信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("rid", roleInforBean.getRid());
        jsonObject.put("name", roleInforBean.getName());
        jsonObject.put("ismastercanown", roleInforBean.getIsmastercanown());
        jsonObject.put("introduction", roleInforBean.getIntroduction());
        jsonObject.put("rolepermissionstr", getRolePermissionStr(irRoleModuleBeans));
        return jsonObject.toString();
    }
    public void saveModifyRole(ModifyRoleBean modifyRoleBean) throws BgException {
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            sqlSession.insert("dazhimen.bg.bean.Permission.saveModifyRole", modifyRoleBean);
            sqlSession.delete("dazhimen.bg.bean.Permission.deleteIrRoleModule", modifyRoleBean.getRid());
            ArrayList<String> permissionList = modifyRoleBean.getPermissionList();
            AddIrRoleModuleBean irRoleModuleBean = new AddIrRoleModuleBean();
            if(permissionList != null && permissionList.size() > 0){
                for(int i = 0 ; i < permissionList.size(); i++){
                    irRoleModuleBean.setRid(modifyRoleBean.getRid());
                    irRoleModuleBean.setMid(permissionList.get(i));
                    sqlSession.insert("dazhimen.bg.bean.Permission.saveAddIrRoleModule", irRoleModuleBean);
                }
            }
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，修改角色失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }

    /**
     *  获取添加角色下人员列表的数据
     * @param rid 要查询角色下人员的角色id
     * @return  人员列表的数据
     */
    public List<ViewIrRoleUserBean> getAddIrRoleUserData(String rid) throws BgException {
        if(rid == null || rid.equals("")){
            throw new BgException("传入的rid参数为空，无法查询");
        }
        SqlSession sqlSession = null;
        List<ViewIrRoleUserBean> irRoleUserBeans = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            String isMasterCanOwn = sqlSession.selectOne("dazhimen.bg.bean.Permission.getIsMasterCanOwn", rid);
            if(isMasterCanOwn == null || isMasterCanOwn.equals("")){
                throw new BgException("获取当前角色的基本信息出错");
            }
            if(isMasterCanOwn.equals("1")){
                irRoleUserBeans = sqlSession.selectList("dazhimen.bg.bean.Permission.getAddIrRoleUserDataAll", rid);
            }else{
                irRoleUserBeans = sqlSession.selectList("dazhimen.bg.bean.Permission.getAddIrRoleUserDataAdminOnly", rid);
            }

        }catch (BgException e){
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch(Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询角色对应人员信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return irRoleUserBeans;
    }
    /**
     *  获取添加角色下人员列表的数据
     * @return  人员列表的数据
     */
    public List<ViewIrRoleUserBean> getAddIrRoleUserDataByParams(QueryMasterParamBean paramBean) throws BgException {
        SqlSession sqlSession = null;
        List<ViewIrRoleUserBean> irRoleUserBeans = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            String isMasterCanOwn = sqlSession.selectOne("dazhimen.bg.bean.Permission.getIsMasterCanOwn", paramBean.getRid());
            if(isMasterCanOwn == null || isMasterCanOwn.equals("")){
                throw new BgException("获取当前角色的基本信息出错");
            }
            if(isMasterCanOwn.equals("1")){
                irRoleUserBeans = sqlSession.selectList("dazhimen.bg.bean.Permission.getAddIrRoleUserDataAllByParams", paramBean);
            }else{
                irRoleUserBeans = sqlSession.selectList("dazhimen.bg.bean.Permission.getAddIrRoleUserDataAdminOnlyByParams", paramBean);
            }

        }catch (BgException e){
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch(Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询角色对应人员信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return irRoleUserBeans;
    }

    /**
     * 添加角色下的有权人员
     * @param rid 角色id
     * @param uid 人员id
     * @return 添加是否成功
     * @throws BgException
     */
    public boolean saveAddIrRoleUser(String rid, String uid) throws BgException {
        if(!CheckIsExistsUtils.checkUidIsExists(uid)){
            throw new BgException("传入的参数[uid]不存在，添加拥有角色人员失败");
        }
        if(!CheckIsExistsUtils.checkRidIsExists(rid)){
            throw new BgException("传入的参数[rid]不存在，添加拥有角色人员失败");
        }
        SqlSession sqlSession = null;
        int result = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            AddIrRoleUserBean roleUserBean = new AddIrRoleUserBean();
            roleUserBean.setUid(uid);
            roleUserBean.setRid(rid);
            result = sqlSession.insert("dazhimen.bg.bean.Permission.saveAddIrRoleUser", roleUserBean);
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，添加拥有角色人员失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }

    /**
     * 移除角色下的有权人员
     * @param rid 角色id
     * @param uid 人员id
     * @throws BgException
     */
    public void saveRemoveRoleUser(String rid, String uid) throws BgException {
        if(!CheckIsExistsUtils.checkUidIsExists(uid)){
            throw new BgException("传入的参数[uid]不存在，移除角色下人员失败");
        }
        if(!CheckIsExistsUtils.checkRidIsExists(rid)){
            throw new BgException("传入的参数[rid]不存在，移除角色下人员失败");
        }
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            AddIrRoleUserBean roleUserBean = new AddIrRoleUserBean();
            roleUserBean.setUid(uid);
            roleUserBean.setRid(rid);
            sqlSession.insert("dazhimen.bg.bean.Permission.saveRemoveRoleUser", roleUserBean);
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，移除角色下人员失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    /**
     *  将权限模块列表，转化为对应的字符串
     * @param irRoleModuleBeans
     * @return
     */
    private String getRolePermissionStr(List<ViewIrRoleModuleBean> irRoleModuleBeans){
        StringBuffer strBF = new StringBuffer();
        if(irRoleModuleBeans == null || irRoleModuleBeans.size() == 0){
            return "";
        }else{
            for(int i = 0; i < irRoleModuleBeans.size(); i++){
                if(i == irRoleModuleBeans.size() - 1){
                    strBF.append(irRoleModuleBeans.get(i).getName());
                }else{
                    strBF.append(irRoleModuleBeans.get(i).getName()+",");
                }
            }
            return strBF.toString();
        }
    }
}
