package dazhimen.bg.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dazhimen.bg.bean.user.QueryMasterParamBean;
import dazhimen.bg.bean.user.UserBean;
import dazhimen.bg.exception.BgException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import dazhimen.bg.service.UserService;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import util.Constant;
import util.web.ResponseUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Map;

/**
 * Created by zhj on 2017/3/13.
 * 后台用户相关业务处理的Controller
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @RequestMapping("/fwdTipsInforPage")
    public String fwdTipsInforPage(HttpServletRequest resq){
        try {
            resq.setCharacterEncoding("utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        String tipinfo = resq.getParameter("tipinfo");
        resq.setAttribute("info", tipinfo);
        return "tipsInfo";
    }
    @RequestMapping("/fwdMainPage")
    public String forwardMainPage(){
        return "main";
    }

    @RequestMapping("/fwdMasterManagePage")
    public String fowardMasterManagePage(){
        return "/user/master/manageMaster";
    }

    @RequestMapping("/fwdMasterAddPage")
    public String forwardMasterAddPage(){
        return "user/master/addMaster";
    }
    @RequestMapping("/saveMasterAdd")
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

    @RequestMapping("/fwdViewMasterPage")
    public String fwdViewMasterPage(@RequestParam("uid") String uid, HttpServletResponse resp, Map model){
        model.put("uid", uid);
        return "/user/master/viewMaster";
    }
    @RequestMapping("/queryAllMasters")
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
    @RequestMapping("/fwdMasterModifyPage")
    public String forwardMasterModifyPage(@RequestParam("uid") String uid, HttpServletResponse resp, Map model){
        model.put("uid", uid);
        return "/user/master/modifyMaster";
    }
    @RequestMapping("/getMasterData")
    public void getMasterData(@RequestParam("uid") String uid, HttpServletRequest resq, HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try{
            UserService userService = new UserService();
            UserBean user = userService.getMasterDataByUid(uid);
            user.setHeaderimg(resq.getContextPath() + "/" + user.getHeaderimg());
            Gson gson = new Gson();
            String userJson = gson.toJson(user);
            resp.getWriter().write(userJson);
        }catch (BgException e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write(e.getMessage());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询指定掌门信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/getAdminData")
    public void getAdminData(@RequestParam("uid") String uid, HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try{
            UserService userService = new UserService();
            UserBean user = userService.getAdminDataByUid(uid);
            Gson gson = new Gson();
            String userJson = gson.toJson(user);
            resp.getWriter().write(userJson);
        }catch (BgException e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write(e.getMessage());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询指定管理员信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/saveMasterModify")
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
    @RequestMapping("/saveMasterDel")
    public void saveMasterDel(@RequestParam("uid") String uid,HttpServletRequest resq, HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try{
            UserService userService = new UserService();
            if(userService.saveMasterDel(resq, uid)){
                resp.getWriter().write("删除成功");
            }
        }catch (BgException e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write(e.getMessage());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，删除掌门信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }

    @RequestMapping("/fwdManageAdminPage")
    public String fwdManageAdminPage() {
        return "user/admin/manageAdmin";
    }
    @RequestMapping("/queryAllAdmin")
    public void queryAllAdmin(HttpServletRequest resq, HttpServletResponse resp) {
        resp.setCharacterEncoding(Constant.CharSet);
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

    @RequestMapping("/fwdAddAdminPage")
    public String fwdAddAdminPage(){
        return "user/admin/addAdmin";
    }

    @RequestMapping("/saveAddAdmin")
    public void saveAddAdmin(HttpServletResponse resp, UserBean userBean) {
        resp.setCharacterEncoding(Constant.CharSet);
        try{
            UserService userService = new UserService();
            boolean result = userService.saveAddAdmin(userBean);
            if(result){
                resp.getWriter().write("添加成功");
            }else{
                resp.getWriter().write("添加失败");
            }
        }catch (BgException e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write(e.getMessage());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，新增管理员失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }

    @RequestMapping("/fwdModifyAdminPage")
    public String fwdModifyAdminPage(@RequestParam("uid") String uid, HttpServletResponse resp, Map model){
        model.put("uid", uid);
        return "user/admin/modifyAdmin";
    }

    @RequestMapping("/saveModifyAdmin")
    public void saveModifyAdmin(HttpServletResponse resp, UserBean user){
        resp.setCharacterEncoding(Constant.CharSet);
        UserService userService = new UserService();
        boolean result = false;
        try {
            result = userService.saveModifyAdmin(user);

            if(result){
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write("修改成功");
            }else{
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write("修改失败");
            }
        } catch (BgException e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write(e.getMessage());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，修改管理员信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/saveDeleteAdmin")
    public void saveDeleteAdmin(@RequestParam("uid") String uid, HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try{
            UserService userService = new UserService();
            if(userService.saveDeleteAdmin(uid)){

                resp.getWriter().write("删除成功");
            }
        }catch (BgException e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write(e.getMessage());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，删除管理员信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    private UserBean getAddMasterBean(HttpServletRequest resq){
        UserBean user = new UserBean();
        user.setLoginname(resq.getParameter("loginname"));
        user.setPassword(resq.getParameter("password"));
        user.setName(resq.getParameter("name"));
        user.setMphone(resq.getParameter("mphone"));
        user.setIdentity(resq.getParameter("identity"));

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
        user.setLoginname(resq.getParameter("loginname"));
        user.setLoginnameorginal(resq.getParameter("loginnameorginal"));
        user.setName(resq.getParameter("name"));
        user.setMphone(resq.getParameter("mphone"));
        user.setIdentity(resq.getParameter("identity"));

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) resq;
        CommonsMultipartFile headerimgFile = (CommonsMultipartFile) multipartRequest.getFile("headerimgInModify");
        user.setHeaderimgFile(headerimgFile);
        user.setGender(resq.getParameter("gender"));
        user.setIntroduction(resq.getParameter("introduction"));
        String basePath = resq.getSession().getServletContext().getRealPath("/");
        user.setBasepath(basePath);
        return user;
    }
}
