package dazhimen.bg.controller;

import com.google.gson.Gson;
import com.sun.xml.internal.bind.v2.runtime.reflect.opt.Const;
import dazhimen.bg.bean.permission.*;
import dazhimen.bg.exception.BgException;
import dazhimen.bg.service.PermissionService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import util.Constant;
import util.web.ResponseUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/4/18.
 */
@Controller
@RequestMapping("/permission")
public class PermissionController {
    @RequestMapping("/fwdManagePermissionPage")
    public String fwdManagePermissionPage(){
        return "/permission/managePermission";
    }
    @RequestMapping("/queryAllRole")
    public void queryAllRole(HttpServletRequest resq, HttpServletResponse resp){
        try {
            PermissionService permissionService = new PermissionService();
            String page = resq.getParameter("page");
            String rows = resq.getParameter("rows");
            String result = null;
            String queryByParamFlag = resq.getParameter("queryByParamFlag");
            if(queryByParamFlag == null || queryByParamFlag.equals("")){
                result = permissionService.queryAllRole(page, rows);
            }

            ResponseUtil.writeMsg(resp, result);
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }
    @RequestMapping("/saveDeleteRole")
    public void saveDeleteRole(@RequestParam("rid") String rid, HttpServletResponse resp){
        PermissionService permissionService = new PermissionService();
        try {
            permissionService.saveDeleteRole(rid);
            ResponseUtil.writeMsg(resp, "删除角色成功");
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp,e.getMessage());
        }
    }

    @RequestMapping("/forwardAddRolePage")
    public String forwardAddRolePage(){
        return "/permission/addRole";
    }
    @RequestMapping("/saveAddRole")
    public void saveAddRole(HttpServletRequest resq, HttpServletResponse resp){
        AddRoleBean addRoleBean = getAddRoleBean(resq);
        PermissionService permissionService = new PermissionService();
        try {
            permissionService.saveAddRole(addRoleBean);
            ResponseUtil.writeMsg(resp, "新增角色成功");
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }
    @RequestMapping("/fwdViewRolePage")
    public String fwdViewRolePage(HttpServletRequest resq){
        resq.setAttribute("rid", resq.getParameter("rid"));
        return "/permission/viewRole";
    }
    @RequestMapping("/getRoleInfor")
    public void getRoleInfor(HttpServletRequest resq, HttpServletResponse resp){
        String rid = resq.getParameter("rid");
        PermissionService permissionService = new PermissionService();
        try {
            ViewRoleInforBean roleInforBean = permissionService.getRoleInfor(rid);
            ResponseUtil.writeMsg(resp, new Gson().toJson(roleInforBean));
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }
    @RequestMapping("/queryIrRoleModule")
    public void queryIrRoleModule(HttpServletRequest resq, HttpServletResponse resp){
        String rid = resq.getParameter("rid");
        PermissionService permissionService = new PermissionService();
        try {
            List<ViewIrRoleModuleBean> irRoleModuleBeans = permissionService.queryIrRoleModule(rid);
            ResponseUtil.writeMsg(resp, new Gson().toJson(irRoleModuleBeans));
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }
    @RequestMapping("/fwdModifyRolePage")
    public String fwdModifyRolePage(HttpServletRequest resq){
        resq.setAttribute("rid", resq.getParameter("rid"));
        return "/permission/modifyRole";
    }
    @RequestMapping("/getModifyRoleInfor")
    public void getModifyRoleInfor(HttpServletRequest resq, HttpServletResponse resp){
        String rid = resq.getParameter("rid");
        PermissionService permissionService = new PermissionService();
        try {
            String result = permissionService.getModifyRoleInfor(rid);
            ResponseUtil.writeMsg(resp, result);
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }
    @RequestMapping("/saveModifyRole")
    public void saveModifyRole(HttpServletRequest resq, HttpServletResponse resp){
        ModifyRoleBean modifyRoleBean = getModifyRoleBean(resq);
        PermissionService permissionService = new PermissionService();
        try {
            permissionService.saveModifyRole(modifyRoleBean);
            ResponseUtil.writeMsg(resp, "修改角色成功");
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }
    @RequestMapping("/fwdAdjustRoleUserPage")
    public String fwdAdjustRoleUserPage(HttpServletRequest resq){
        resq.setAttribute("rid", resq.getParameter("rid"));
        return "/permission/adjustRoleUser";
    }
    @RequestMapping("/getRoleInforInAdjustUser")
    public void getRoleInforInAdjustUser(HttpServletRequest resq, HttpServletResponse resp){
        String rid = resq.getParameter("rid");
        PermissionService permissionService = new PermissionService();
        try {
            String result = permissionService.getRoleInforInAdjustUser(rid);
            ResponseUtil.writeMsg(resp, result);
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }
    @RequestMapping("/queryIrRoleUser")
    public void queryIrRoleUser(HttpServletRequest resq, HttpServletResponse resp){
        String rid = resq.getParameter("rid");
        PermissionService permissionService = new PermissionService();
        try {
            List<ViewIrRoleUserBean> irRoleUserBeans = permissionService.queryIrRoleUser(rid);
            ResponseUtil.writeMsg(resp, new Gson().toJson(irRoleUserBeans));
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }
    @RequestMapping("/forwardAddIrRoleUserPage")
    public ModelAndView forwardAddIrRoleUserPage(@RequestParam("rid") String rid){
        ModelAndView mav = new ModelAndView("/permission/addIrRoleUser");
        mav.addObject("rid", rid);
        return mav;
    }
    @RequestMapping("/getAddIrRoleUserData")
    public void getAddIrRoleUserData(HttpServletRequest resq, HttpServletResponse resp){
        String rid = resq.getParameter("rid");
        PermissionService permissionService = new PermissionService();
        try {
            List<ViewIrRoleUserBean> irRoleUserBeans = permissionService.getAddIrRoleUserData(rid);
            ResponseUtil.writeMsg(resp, new Gson().toJson(irRoleUserBeans));
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }

    /**
     * 添加角色下的有权人员
     * @param resq
     * @param resp
     */
    @RequestMapping("/saveAddIrRoleUser")
    public void saveAddIrRoleUser(HttpServletRequest resq, HttpServletResponse resp){
        String rid = resq.getParameter("rid");
        String uid = resq.getParameter("uid");
        PermissionService permissionService = new PermissionService();
        try {
            boolean result = permissionService.saveAddIrRoleUser(rid, uid);
            if(result){
                ResponseUtil.writeMsg(resp, "添加人员成功");
            }else{
                ResponseUtil.writeFailMsgToBrowse(resp, "添加人员失败");
            }
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }

    /**
     * 移除角色下的有权人员
     * @param resq
     * @param resp
     */
    @RequestMapping("/saveRemoveRoleUser")
    public void saveRemoveRoleUser(HttpServletRequest resq, HttpServletResponse resp){
        String rid = resq.getParameter("rid");
        String uid = resq.getParameter("uid");
        PermissionService permissionService = new PermissionService();
        try {
            permissionService.saveRemoveRoleUser(rid, uid);
            ResponseUtil.writeMsg(resp, "移除人员成功");
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }
    private AddRoleBean getAddRoleBean(HttpServletRequest resq){
        AddRoleBean addRoleBean = new AddRoleBean();
        addRoleBean.setName(resq.getParameter("name"));
        String isMasterCanOwn = resq.getParameter("ismastercanown");
        if(isMasterCanOwn == null || isMasterCanOwn.equals("")){
            addRoleBean.setIsmastercanown("0");
        }else{
            addRoleBean.setIsmastercanown(isMasterCanOwn);
        }
        String introduction = resq.getParameter("introduction");
        addRoleBean.setIntroduction(introduction);
        ArrayList<String> permissionList = new ArrayList<String>();
        String[] rolePermission = resq.getParameterValues("rolepermission");
        if(rolePermission != null && rolePermission.length != 0){
            for(int i = 0; i < rolePermission.length; i++){
                if(rolePermission[i] != null && !rolePermission[i].equals("")){
                    permissionList.add(rolePermission[i]);
                }
            }
        }
        addRoleBean.setPermissionList(permissionList);
        return addRoleBean;
    }

    private ModifyRoleBean getModifyRoleBean(HttpServletRequest resq){
        ModifyRoleBean modifyRoleBean = new ModifyRoleBean();
        modifyRoleBean.setRid(resq.getParameter("rid"));
        modifyRoleBean.setName(resq.getParameter("name"));
        String introduction = resq.getParameter("introduction");
        modifyRoleBean.setIntroduction(introduction);
        ArrayList<String> permissionList = new ArrayList<String>();
        String[] rolePermission = resq.getParameterValues("rolepermission");
        if(rolePermission != null && rolePermission.length != 0){
            for(int i = 0; i < rolePermission.length; i++){
                if(rolePermission[i] != null && !rolePermission[i].equals("")){
                    permissionList.add(rolePermission[i]);
                }
            }
        }
        modifyRoleBean.setPermissionList(permissionList);
        return modifyRoleBean;
    }
}
