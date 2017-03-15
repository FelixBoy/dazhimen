package controller;

import com.google.gson.Gson;
import bean.UserBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import service.UserService;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
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
    public void saveMasterAdd(HttpServletResponse resp, UserBean userBean) throws IOException, SQLException {
        UserService userService = new UserService();
        if(userService.saveMasterAdd(userBean)){
            resp.setCharacterEncoding("utf-8");
            resp.getWriter().write("添加成功");
        }
    }
    @RequestMapping("/checkLoginnameDuplicate")
    public void checkLoginnameDuplicate(@RequestParam("loginname") String loginName, HttpServletResponse resp) {
        UserService userService = new UserService();
        try{
            if(userService.checkLoginnameDuplicate(loginName)){
                resp.setCharacterEncoding("utf-8");
                resp.getWriter().write("true");
            }else{
                resp.setCharacterEncoding("utf-8");
                resp.getWriter().write("");
            }
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    @RequestMapping("/queryAllMasters")
    public String queryAllMasters(HttpServletResponse resp, Map model) throws SQLException, IOException {
        UserService userService = new UserService();
        List<UserBean> users = userService.queryAllMasters();
        Gson gson = new Gson();
        String usersJson = gson.toJson(users);
        resp.setCharacterEncoding("utf-8");
        resp.getWriter().write(usersJson);
        return null;
    }
    @RequestMapping("/fwdMasterModifyPage")
    public String forwardMasterModifyPage(@RequestParam("uid") String uid, HttpServletResponse resp, Map model){
        model.put("uid", uid);
        return "/user/master/masterModify";
    }
    @RequestMapping("/getMasterData")
    public String getMasterData(@RequestParam("uid") String uid, HttpServletResponse resp) throws IOException, SQLException {
        UserService userService = new UserService();
        UserBean user = userService.getMasterDataByUid(uid);
        Gson gson = new Gson();
        String userJson = gson.toJson(user);
        resp.setCharacterEncoding("utf-8");
        resp.getWriter().write(userJson);
        return null;
    }
    @RequestMapping("/saveMasterModify")
    public void saveMasterModify(HttpServletResponse resp, UserBean user) throws SQLException, IOException {
        UserService userService = new UserService();
        if(userService.saveMasterModify(user)){
            resp.setCharacterEncoding("utf-8");
            resp.getWriter().write("修改成功");
        }
    }
    @RequestMapping("/saveMasterDel")
    public void saveMasterDel(@RequestParam("uid") String uid, HttpServletResponse resp) throws IOException, SQLException {
        UserService userService = new UserService();
        if(userService.saveMasterDel(uid)){
            resp.setCharacterEncoding("utf-8");
            resp.getWriter().write("删除成功");
        }
    }
}
