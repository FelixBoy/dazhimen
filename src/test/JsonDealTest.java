package test;

import com.google.gson.Gson;
import entity.User;
import service.UserService;

import java.sql.SQLException;
import java.util.List;

/**
 * Created by zhj on 2017/3/13.
 */
public class JsonDealTest {
    public static void main(String[] args) throws SQLException, IllegalAccessException, NoSuchMethodException {
        UserService userService = new UserService();
        List<User> users = userService.queryAllMasters();
        User user = users.get(0);
        Gson gson = new Gson();
        System.out.println(gson.toJson(users));
//      System.out.println(JsonUtil.toJson(users.toArray()));
    }
}
