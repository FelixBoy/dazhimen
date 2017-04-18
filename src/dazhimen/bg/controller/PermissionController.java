package dazhimen.bg.controller;

import com.google.gson.Gson;
import com.sun.xml.internal.bind.v2.runtime.reflect.opt.Const;
import dazhimen.bg.bean.permission.AddRoleBean;
import dazhimen.bg.bean.permission.ListViewRoleBean;
import dazhimen.bg.exception.BgException;
import dazhimen.bg.service.PermissionService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
        for(int i = 0; i < rolePermission.length; i++){
            if(rolePermission[i] != null && !rolePermission[i].equals("")){
                permissionList.add(rolePermission[i]);
            }
        }
        addRoleBean.setPermissionList(permissionList);
        return addRoleBean;
    }
}
