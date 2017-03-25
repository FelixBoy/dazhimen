package demo;

import com.google.gson.Gson;
import com.sun.xml.internal.bind.v2.runtime.reflect.opt.Const;
import dazhimen.api.bean.ApiCustomerBean;
import dazhimen.api.exception.ParameterCheckException;
import dazhimen.api.service.ApiCustomerService;
import dazhimen.api.service.ApiLoginService;
import dazhimen.bg.service.CustomerService;
import net.sf.json.JSONObject;
import util.*;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * Created by Administrator on 2017/3/15.
 */
public class TempTest {
    public static void main(String[] args) throws SQLException, ParameterCheckException {
//        System.out.println(GlobalUtils.hex_md5("abc1231.1com.dazhimen.product20170318153922"+ Constant.signKey));
//        System.out.println(GlobalUtils.hex_md5("AB0027144").toUpperCase());
//    for(int i = 1; i < 300; i++)
//        System.out.println(getRandNum(4));
//        DateUtil util = new DateUtil();
//        System.out.println(util.getDBDate());
//        System.out.println(util.getDBDate().getTime());
//        Date date = new Date(util.getDBDate().getTime());
//        System.out.println(date);

        ApiLoginService loginService = new ApiLoginService();
        ApiCustomerBean customerBean = loginService.getCustomerInfoByCid("c17031800007");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code","200");
        jsonObject.put("msg","成功");

        System.out.println(new Gson().toJson(customerBean));
        jsonObject.put("data",new Gson().toJson(customerBean));
        System.out.println(jsonObject.toString());

    }
//    public static String getRandNum(int charCount) {
//        String charValue = "";
//        for (int i = 0; i < charCount; i++) {
//            char c = (char) (randomInt(0, 10) + '0');
//            charValue += String.valueOf(c);
//        }
//        return charValue;
//    }
//    public static int randomInt(int from, int to) {
//        Random r = new Random();
//        return from + r.nextInt(to - from);
//    }
    /*
     * 将时间戳转换为时间
     */
public static String stampToDate(String s){
    String res;
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    long lt = new Long(s);
    Date date = new Date(lt);
    res = simpleDateFormat.format(date);
    return res;
}
}
