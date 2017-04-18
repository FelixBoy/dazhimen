package dazhimen.bg.service;

import dazhimen.bg.bean.PaginationParamBean;
import dazhimen.bg.bean.permission.AddIrRoleModuleBean;
import dazhimen.bg.bean.permission.AddRoleBean;
import dazhimen.bg.bean.permission.ListViewRoleBean;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import net.sf.json.JSONObject;
import org.apache.ibatis.session.SqlSession;
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
}
