package demo;

import com.google.gson.Gson;
import dazhimen.bg.bean.UserBean;
import dazhimen.bg.service.UserService;

import java.sql.SQLException;
import java.util.List;

/**
 * Created by zhj on 2017/3/13.
 */
public class JsonDealTest {
    public static void main(String[] args) throws SQLException, IllegalAccessException, NoSuchMethodException {
        UserService userService = new UserService();
        List<UserBean> users = userService.queryAllMasters();
        UserBean userBean = users.get(0);
        Gson gson = new Gson();
        System.out.println(gson.toJson(users));
//      System.out.println(JsonUtil.toJson(users.toArray()));
    }
}
