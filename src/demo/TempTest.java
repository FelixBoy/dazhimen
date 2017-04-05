package demo;

import com.google.gson.Gson;
import com.sun.xml.internal.bind.v2.runtime.reflect.opt.Const;
import dazhimen.api.bean.ApiCustomerBean;
import dazhimen.api.exception.ParameterCheckException;
import dazhimen.api.service.ApiCustomerService;
import dazhimen.api.service.ApiLoginService;
import dazhimen.bg.exception.BgException;
import dazhimen.bg.service.CustomerService;
import db.MyBatisUtil;
import net.sf.json.JSONObject;
import org.apache.ibatis.session.SqlSession;
import util.*;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * Created by Administrator on 2017/3/15.
 */
public class TempTest {
    public static void main(String[] args) throws BgException {
        System.out.println(new SeqUtils().getSeqNextVal("user_seq"));
    }
}
