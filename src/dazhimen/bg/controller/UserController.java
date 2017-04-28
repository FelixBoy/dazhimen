package dazhimen.bg.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dazhimen.bg.bean.login.LoginUserBean;
import dazhimen.bg.bean.user.ModifyPasswordBean;
import dazhimen.bg.bean.user.QueryMasterParamBean;
import dazhimen.bg.bean.user.ResetPasswordBean;
import dazhimen.bg.bean.user.UserBean;
import dazhimen.bg.exception.BgException;
import dazhimen.bg.service.LoginService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import dazhimen.bg.service.UserService;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import util.Constant;
import util.GlobalUtils;
import util.web.ResponseUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by zhj on 2017/3/13.
 * 后台用户相关业务处理的Controller
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @RequestMapping("/fwdTipsInforPage.do")
    public String fwdTipsInforPage(HttpServletRequest resq, HttpServletResponse resp){
        String menuid = resq.getParameter("menuid");
        String tipsInfor = "欢迎使用大职门系统";
        HttpSession sessionObj = resq.getSession(false);
        LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
        if(menuid.equals("product_news")){
            boolean hasPerProduct = GlobalUtils.checkUserPermission(Constant.Per_Product, userBean);
            boolean hasPerNews =  GlobalUtils.checkUserPermission(Constant.Per_News, userBean);
            if(hasPerProduct && hasPerNews){
                tipsInfor = "产品与新闻管理<br/>请点击相应子菜单";
            }
            if(!hasPerNews && hasPerProduct){
                tipsInfor = "产品管理<br/>请点击相应子菜单";
            }
            if(hasPerNews && !hasPerProduct){
                tipsInfor = "新闻管理<br/>请点击相应子菜单";
            }
        }
        if(menuid.equals("customer_recharge_order")){
            boolean hasPerCustomer = GlobalUtils.checkUserPermission(Constant.Per_Customer, userBean);
            boolean hasPerRecharge = GlobalUtils.checkUserPermission(Constant.Per_Recharge, userBean);
            boolean hasPerOrder = GlobalUtils.checkUserPermission(Constant.Per_Order, userBean);
            if(hasPerCustomer && hasPerRecharge && hasPerOrder){
                tipsInfor = "会员、充值、订单查询<br/>请点击相应子菜单";
            }
            if(hasPerCustomer && !hasPerRecharge && hasPerOrder){
                tipsInfor = "会员、订单查询<br/>请点击相应子菜单";
            }
            if(hasPerCustomer && hasPerRecharge && !hasPerOrder){
                tipsInfor = "会员、充值查询<br/>请点击相应子菜单";
            }
            if(!hasPerCustomer && hasPerRecharge && hasPerOrder){
                tipsInfor = "充值、订单查询<br/>请点击相应子菜单";
            }
            if(hasPerCustomer && !hasPerRecharge && !hasPerOrder){
                tipsInfor = "会员查询<br/>请点击相应子菜单";
            }
            if(!hasPerCustomer && hasPerRecharge && !hasPerOrder){
                tipsInfor = "充值查询<br/>请点击相应子菜单";
            }
            if(!hasPerCustomer && !hasPerRecharge && hasPerOrder){
                tipsInfor = "订单查询<br/>请点击相应子菜单";
            }
        }
        if(menuid.equals("play_sort")){
            boolean hasPerIndexPlay = GlobalUtils.checkUserPermission(Constant.Per_Indexplay, userBean);
            boolean hasPerIndexSort = GlobalUtils.checkUserPermission(Constant.Per_Indexsort, userBean);
            if(hasPerIndexPlay && hasPerIndexSort){
                tipsInfor = "首页轮播与首页排序配置<br/>请点击相应子菜单";
            }
            if(hasPerIndexPlay && !hasPerIndexSort){
                tipsInfor = "首页轮播配置<br/>请点击相应子菜单";
            }
            if(!hasPerIndexPlay && hasPerIndexSort){
                tipsInfor = "首页排序配置<br/>请点击相应子菜单";
            }
        }
        if(menuid.equals("master_admin_permission")){
            boolean hasPerMaster = GlobalUtils.checkUserPermission(Constant.Per_Master, userBean);
            boolean hasPerAdmin =  GlobalUtils.checkUserPermission(Constant.Per_Admin, userBean);
            boolean hasPerPermission = GlobalUtils.checkUserPermission(Constant.Per_Permission, userBean);
            if(hasPerMaster && hasPerAdmin && hasPerPermission){
                tipsInfor = "掌门、管理员、权限管理<br/>请点击相应子菜单";
            }
            if(hasPerMaster && hasPerAdmin && !hasPerPermission){
                tipsInfor = "掌门、管理员管理<br/>请点击相应子菜单";
            }
            if(hasPerMaster && !hasPerAdmin && hasPerPermission){
                tipsInfor = "掌门、权限管理<br/>请点击相应子菜单";
            }
            if(!hasPerMaster && hasPerAdmin && hasPerPermission){
                tipsInfor = "管理员、权限管理<br/>请点击相应子菜单";
            }
            if(hasPerMaster && !hasPerAdmin && !hasPerPermission){
                tipsInfor = "掌门管理<br/>请点击相应子菜单";
            }
            if(!hasPerMaster && hasPerAdmin && !hasPerPermission){
                tipsInfor = "管理员管理<br/>请点击相应子菜单";
            }
            if(!hasPerMaster && !hasPerAdmin && hasPerPermission){
                tipsInfor = "权限管理<br/>请点击相应子菜单";
            }
        }
        resq.setAttribute("info", tipsInfor);
        return "tipsInfo";
    }

    /**
     * 转向修改密码页面
     * @param resq
     * @return
     */
    @RequestMapping("/fwdModifyPasswordPage.do")
    public String fwdModifyPasswordPage(HttpServletRequest resq){
        return "/user/modifyPassword";
    }

    /**
     * 保存用户修改密码
     * @param resq
     * @param resp
     */
    @RequestMapping("/saveModifyPassword.do")
    public void saveModifyPassword(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ModifyPasswordBean modifyPasswordBean = getModifyPasswordBean(resq);
            UserService userService = new UserService();
            boolean result = userService.saveModifyPassword(modifyPasswordBean);
            if(result)
                ResponseUtil.writeMsg(resp, "修改成功");
            else
                ResponseUtil.writeFailMsgToBrowse(resp, "修改失败");
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }
    @RequestMapping("/fwdMainPage.do")
    public String forwardMainPage(HttpServletRequest resq){
        HttpSession sessionObj = resq.getSession(false);
        LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
        LoginService loginService = new LoginService();
        HashMap<String, String> permissionMap = null;
        try {
            permissionMap = loginService.getUserPermission(userBean.getUid());
        } catch (BgException e) {
            e.printStackTrace();
        }
        userBean.setUserPermissionMap(permissionMap);
        return "main";
    }

    @RequestMapping("/fwdMasterManagePage.do")
    public String fowardMasterManagePage(){
        return "/user/master/manageMaster";
    }

    @RequestMapping("/fwdMasterAddPage.do")
    public String forwardMasterAddPage(){
        return "user/master/addMaster";
    }
    @RequestMapping("/saveMasterAdd.do")
    public ModelAndView saveMasterAdd(HttpServletRequest resq,HttpServletResponse resp) {
        resp.setCharacterEncoding(Constant.CharSet);
        ModelAndView mav = new ModelAndView("fileUploadAfterAction");
        try{
            UserBean userBean = getAddMasterBean(resq);
            UserService userService = new UserService();
            boolean result = userService.saveMasterAdd(userBean);
            if(result){
                JsonObject jsonObj = new JsonObject();
                jsonObj.addProperty("code", "200");
                jsonObj.addProperty("msg","新增掌门成功");
                mav.addObject("parameters", jsonObj.toString());
                return mav;
            }else{
                JsonObject jsonObj = new JsonObject();
                jsonObj.addProperty("code", "400");
                jsonObj.addProperty("msg","新增掌门失败");
                mav.addObject("parameters", jsonObj.toString());
                return mav;
            }
        }catch (BgException e){
            e.printStackTrace();
            JsonObject jsonObj = new JsonObject();
            jsonObj.addProperty("code", "400");
            jsonObj.addProperty("msg",e.getMessage());
            mav.addObject("parameters", jsonObj.toString());
            return mav;
        }catch (Exception e){
            e.printStackTrace();
            JsonObject jsonObj = new JsonObject();
            jsonObj.addProperty("code", "400");
            jsonObj.addProperty("msg","出现异常，新增掌门失败");
            mav.addObject("parameters", jsonObj.toString());
            return mav;
        }
    }

    @RequestMapping("/fwdViewMasterPage.do")
    public String fwdViewMasterPage(@RequestParam("uid") String uid, HttpServletResponse resp, Map model){
        model.put("uid", uid);
        return "/user/master/viewMaster";
    }
    @RequestMapping("/queryAllMasters.do")
    public void queryAllMasters(HttpServletRequest resq, HttpServletResponse resp) {
        try {
            UserService userService = new UserService();
            String page = resq.getParameter("page");
            String rows = resq.getParameter("rows");
            String result = null;
            String queryByParamFlag = resq.getParameter("queryByParamFlag");
            if(queryByParamFlag == null || queryByParamFlag.equals("")){
                result = userService.queryAllMasters(page, rows);
            }else{
                String uidCondition = resq.getParameter("uidCondition");
                String mphoneCondition = resq.getParameter("mphoneCondition");
                String nameCondition = resq.getParameter("nameCondition");
                String genderCondition = resq.getParameter("genderCondition");
                String loginnameCondition = resq.getParameter("loginnameCondition");
                String starttimeCondition = resq.getParameter("starttimeCondition");
                String endtimeCondition = resq.getParameter("endtimeCondition");
                QueryMasterParamBean paramBean = new QueryMasterParamBean();
                paramBean.setUidCondition(uidCondition);
                paramBean.setMphoneCondition(mphoneCondition);
                paramBean.setNameCondition(nameCondition);
                paramBean.setGenderCondition(genderCondition);
                paramBean.setStarttimeCondition(starttimeCondition);
                paramBean.setEndtimeCondition(endtimeCondition);
                paramBean.setLoginnameCondition(loginnameCondition);
                result = userService.queryAllMastersByParam(page, rows, paramBean);
            }
            ResponseUtil.writeMsg(resp, result);
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询所有掌门信息失败");
        }
    }
    @RequestMapping("/fwdMasterModifyPage.do")
    public String forwardMasterModifyPage(@RequestParam("uid") String uid, HttpServletResponse resp, Map model){
        model.put("uid", uid);
        return "/user/master/modifyMaster";
    }
    @RequestMapping("/getMasterData.do")
    public void getMasterData(@RequestParam("uid") String uid, HttpServletRequest resq, HttpServletResponse resp){
        try{
            UserService userService = new UserService();
            UserBean user = userService.getMasterDataByUid(uid);
            user.setHeaderimg(resq.getContextPath() + "/" + user.getHeaderimg());
            Gson gson = new Gson();
            String userJson = gson.toJson(user);
            ResponseUtil.writeMsg(resp, userJson);
        }catch (BgException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询指定掌门信息失败");
        }
    }
    @RequestMapping("/getAdminData.do")
    public void getAdminData(@RequestParam("uid") String uid, HttpServletResponse resp){
        try{
            UserService userService = new UserService();
            UserBean user = userService.getAdminDataByUid(uid);
            Gson gson = new Gson();
            String userJson = gson.toJson(user);
            ResponseUtil.writeMsg(resp, userJson);
        }catch (BgException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询指定管理员信息失败");
        }
    }
    @RequestMapping("/saveMasterModify.do")
    public ModelAndView saveMasterModify(HttpServletRequest resq,HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        ModelAndView mav = new ModelAndView("fileUploadAfterAction");
        try {
            UserBean user = getModifyMasterBean(resq);
            UserService userService = new UserService();
            boolean result = userService.saveMasterModify(user);
            if(result){
                JsonObject jsonObj = new JsonObject();
                jsonObj.addProperty("code", "200");
                jsonObj.addProperty("msg","修改掌门成功");
                mav.addObject("parameters", jsonObj.toString());
                return mav;
            }else{
                JsonObject jsonObj = new JsonObject();
                jsonObj.addProperty("code", "400");
                jsonObj.addProperty("msg","修改掌门失败");
                mav.addObject("parameters", jsonObj.toString());
                return mav;
            }
        } catch (BgException e){
            e.printStackTrace();
            JsonObject jsonObj = new JsonObject();
            jsonObj.addProperty("code", "400");
            jsonObj.addProperty("msg",e.getMessage());
            mav.addObject("parameters", jsonObj.toString());
            return mav;
        }catch (Exception e){
            e.printStackTrace();
            JsonObject jsonObj = new JsonObject();
            jsonObj.addProperty("code", "400");
            jsonObj.addProperty("msg","出现异常，修改掌门失败");
            mav.addObject("parameters", jsonObj.toString());
            return mav;
        }
    }
    @RequestMapping("/saveMasterDel.do")
    public void saveMasterDel(@RequestParam("uid") String uid,HttpServletRequest resq, HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try{
            UserService userService = new UserService();
            if(userService.saveMasterDel(resq, uid)){
                ResponseUtil.writeMsg(resp, "删除成功");
            }
        }catch (BgException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，删除掌门信息失败");
        }
    }

    @RequestMapping("/fwdManageAdminPage.do")
    public String fwdManageAdminPage() {
        return "user/admin/manageAdmin";
    }
    @RequestMapping("/queryAllAdmin.do")
    public void queryAllAdmin(HttpServletRequest resq, HttpServletResponse resp) {
        try {
            UserService userService = new UserService();
            String page = resq.getParameter("page");
            String rows = resq.getParameter("rows");
            String result = null;
            String queryByParamFlag = resq.getParameter("queryByParamFlag");
            if(queryByParamFlag == null || queryByParamFlag.equals("")){
                result = userService.queryAllAdmin(page, rows);
            }else{
                String uidCondition = resq.getParameter("uidCondition");
                String mphoneCondition = resq.getParameter("mphoneCondition");
                String nameCondition = resq.getParameter("nameCondition");
                String genderCondition = resq.getParameter("genderCondition");
                String loginnameCondition = resq.getParameter("loginnameCondition");
                String starttimeCondition = resq.getParameter("starttimeCondition");
                String endtimeCondition = resq.getParameter("endtimeCondition");
                QueryMasterParamBean paramBean = new QueryMasterParamBean();
                paramBean.setUidCondition(uidCondition);
                paramBean.setMphoneCondition(mphoneCondition);
                paramBean.setNameCondition(nameCondition);
                paramBean.setGenderCondition(genderCondition);
                paramBean.setStarttimeCondition(starttimeCondition);
                paramBean.setEndtimeCondition(endtimeCondition);
                paramBean.setLoginnameCondition(loginnameCondition);
                result = userService.queryAllAdminByParam(page, rows, paramBean);
            }
            ResponseUtil.writeMsg(resp, result);
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }catch (Exception e){
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询所有管理员信息失败");
        }
    }

    @RequestMapping("/fwdAddAdminPage.do")
    public String fwdAddAdminPage(){
        return "user/admin/addAdmin";
    }

    @RequestMapping("/saveAddAdmin.do")
    public void saveAddAdmin(HttpServletResponse resp, UserBean userBean) {
        try{
            UserService userService = new UserService();
            boolean result = userService.saveAddAdmin(userBean);
            if(result){
                ResponseUtil.writeMsg(resp,"添加成功");
            }else{
                ResponseUtil.writeMsg(resp,"添加失败");
            }
        }catch (BgException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，新增管理员失败");
        }
    }

    @RequestMapping("/fwdModifyAdminPage.do")
    public String fwdModifyAdminPage(@RequestParam("uid") String uid, HttpServletResponse resp, Map model){
        model.put("uid", uid);
        return "user/admin/modifyAdmin";
    }

    @RequestMapping("/saveModifyAdmin.do")
    public void saveModifyAdmin(HttpServletResponse resp, UserBean user){
        UserService userService = new UserService();
        boolean result = false;
        try {
            result = userService.saveModifyAdmin(user);

            if(result){
                ResponseUtil.writeMsg(resp, "修改成功");
            }else{
                ResponseUtil.writeMsg(resp, "修改失败");
            }
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            ResponseUtil.writeFailMsgToBrowse(resp,"出现异常，修改管理员信息失败");
        }
    }
    @RequestMapping("/saveDeleteAdmin.do")
    public void saveDeleteAdmin(@RequestParam("uid") String uid, HttpServletResponse resp){
        try{
            UserService userService = new UserService();
            if(userService.saveDeleteAdmin(uid)){
                ResponseUtil.writeMsg(resp, "删除成功");
            }
        }catch (BgException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，删除管理员信息失败");
        }
    }

    /**
     * 重置用户的登录密码
     * @param resq
     * @param resp
     */
    @RequestMapping("/saveResetUserPassword.do")
    public void saveResetUserPassword(HttpServletRequest resq, HttpServletResponse resp){
        UserService userService = new UserService();
        try {
            ResetPasswordBean resetPasswordBean = getResetPasswordBean(resq);
            boolean result = userService.saveResetUserPassword(resetPasswordBean);
            if(result){
                ResponseUtil.writeMsg(resp, "重置密码成功");
            }else{
                ResponseUtil.writeMsg(resp, "重置密码失败");
            }
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }

    }
    private ResetPasswordBean getResetPasswordBean(HttpServletRequest resq) throws BgException {
        String uid = resq.getParameter("uid");
        if(uid == null || uid.equals("")){
            throw new BgException("传入的uid为空，重置失败");
        }
        String password = resq.getParameter("password");
        if(password == null || password.equals("")){
            throw new BgException("传入的password为空，重置失败");
        }
        ResetPasswordBean resetPasswordBean = new ResetPasswordBean();
        resetPasswordBean.setUid(uid);
        resetPasswordBean.setPassword(password);
        return resetPasswordBean;
    }
    private UserBean getAddMasterBean(HttpServletRequest resq){
        UserBean user = new UserBean();
        user.setLoginname(resq.getParameter("loginname").trim());
        user.setPassword(resq.getParameter("password").trim());
        user.setName(resq.getParameter("name").trim());
        user.setMphone(resq.getParameter("mphone").trim());
        user.setIdentity(resq.getParameter("identity").trim());

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) resq;
        CommonsMultipartFile headerimgFile = (CommonsMultipartFile) multipartRequest.getFile("headerimg");
        user.setHeaderimgFile(headerimgFile);
        user.setGender(resq.getParameter("gender"));
        user.setType(resq.getParameter("type"));
        user.setIntroduction(resq.getParameter("introduction"));

        String basePath = resq.getSession().getServletContext().getRealPath("/");
        user.setBasepath(basePath);
        return user;
    }
    private UserBean getModifyMasterBean(HttpServletRequest resq){
        UserBean user = new UserBean();
        user.setUid(resq.getParameter("uid"));
        user.setLoginname(resq.getParameter("loginname").trim());
        user.setLoginnameorginal(resq.getParameter("loginnameorginal"));
        user.setName(resq.getParameter("name").trim());
        user.setMphone(resq.getParameter("mphone").trim());
        user.setIdentity(resq.getParameter("identity").trim());

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) resq;
        CommonsMultipartFile headerimgFile = (CommonsMultipartFile) multipartRequest.getFile("headerimgInModify");
        user.setHeaderimgFile(headerimgFile);
        user.setGender(resq.getParameter("gender"));
        user.setIntroduction(resq.getParameter("introduction"));
        String basePath = resq.getSession().getServletContext().getRealPath("/");
        user.setBasepath(basePath);
        return user;
    }
    private ModifyPasswordBean getModifyPasswordBean(HttpServletRequest resq) throws BgException {
        String uid = resq.getParameter("uid");
        if(uid == null || uid.trim().equals("")){
            throw new BgException("传入的uid值为空，修改密码失败");
        }
        String oldPassword = resq.getParameter("oldpassword");
        if(oldPassword == null || oldPassword.trim().equals("")){
            throw new BgException("传入的oldpassword值为空，修改密码失败");
        }
        String newPassword = resq.getParameter("newpassword");
        if(newPassword == null || newPassword.trim().equals("")){
            throw new BgException("传入的newpassword值为空，修改密码失败");
        }
        String newPasswordcheck = resq.getParameter("newpasswordcheck");
        if(newPasswordcheck == null || newPasswordcheck.trim().equals("")){
            throw new BgException("传入的newpasswordcheck值为空，修改密码失败");
        }
        if(!newPassword.trim().equals(newPasswordcheck.trim())){
            throw new BgException("新密码两次输入不一致，修改密码失败");
        }
        String loginname = resq.getParameter("loginname");
        if(loginname == null || loginname.trim().equals("")){
            throw new BgException("传入的loginname值为空，修改密码失败");
        }
        ModifyPasswordBean modifyPasswordBean = new ModifyPasswordBean();
        modifyPasswordBean.setUid(uid);
        modifyPasswordBean.setOldpassword(oldPassword.trim());
        modifyPasswordBean.setNewpassword(newPassword.trim());
        modifyPasswordBean.setNewpasswordcheck(newPasswordcheck.trim());
        modifyPasswordBean.setLoginname(loginname);
        return modifyPasswordBean;
    }
}
