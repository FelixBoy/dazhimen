package dazhimen.bg.controller;

import com.google.gson.Gson;
import dazhimen.bg.bean.UserBean;
import dazhimen.bg.exception.BgException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import dazhimen.bg.service.UserService;
import util.Constant;

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
    public void saveMasterAdd(HttpServletResponse resp, UserBean userBean) {
        resp.setCharacterEncoding(Constant.CharSet);
        try{
            UserService userService = new UserService();
            boolean result = userService.saveMasterAdd(userBean);
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
                resp.getWriter().write("出现异常，新增掌门失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }

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
    public void getMasterData(@RequestParam("uid") String uid, HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try{
            UserService userService = new UserService();
            UserBean user = userService.getMasterDataByUid(uid);
            Gson gson = new Gson();
            String userJson = gson.toJson(user);
            resp.getWriter().write(userJson);
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
    @RequestMapping("/saveMasterModify")
    public void saveMasterModify(HttpServletResponse resp, UserBean user){
        resp.setCharacterEncoding(Constant.CharSet);
        UserService userService = new UserService();
        boolean result = false;
        try {
            result = userService.saveMasterModify(user);

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
                resp.getWriter().write("出现异常，修改掌门信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
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
}
