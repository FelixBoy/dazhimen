package dazhimen.bg.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dazhimen.bg.bean.UserBean;
import dazhimen.bg.exception.BgException;
import net.sf.morph.wrap.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import dazhimen.bg.service.UserService;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import util.Constant;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Created by zhj on 2017/3/13.
 * 后台用户相关业务处理的Controller
 */
@Controller
@RequestMapping("/user")
public class UserController {
    /**
     * 转向主页面
     * @return
     */
    @RequestMapping("/fwdMainPage")
    public String forwardMainPage(){
        return "main";
    }

    @RequestMapping("/fwdMasterManagePage")
    public String fowardMasterManagePage(){
        return "/user/master/masterManage";
    }

    @RequestMapping("/fwdMasterAddPage")
    public String forwardMasterAddPage(){
        return "user/master/masterAdd";
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
        return "/user/master/masterView";
    }
    @RequestMapping("/queryAllMasters")
    public void queryAllMasters(HttpServletResponse resp) {
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            UserService userService = new UserService();
            List<UserBean> users = userService.queryAllMasters();
            Gson gson = new Gson();
            String usersJson = gson.toJson(users);
            resp.getWriter().write(usersJson);
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询所有掌门信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/fwdMasterModifyPage")
    public String forwardMasterModifyPage(@RequestParam("uid") String uid, HttpServletResponse resp, Map model){
        model.put("uid", uid);
        return "/user/master/masterModify";
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
    public void saveMasterDel(@RequestParam("uid") String uid, HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try{
            UserService userService = new UserService();
            if(userService.saveMasterDel(uid)){
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
    public void queryAllAdmin(HttpServletResponse resp) {
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            UserService userService = new UserService();
            List<UserBean> users = userService.queryAllAdmin();
            Gson gson = new Gson();
            String usersJson = gson.toJson(users);
            resp.getWriter().write(usersJson);
        } catch (BgException e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write(e.getMessage());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }catch (Exception e){
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询所有掌门信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
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
