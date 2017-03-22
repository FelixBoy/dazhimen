package demo;

import com.sun.xml.internal.bind.v2.runtime.reflect.opt.Const;
import util.Constant;
import util.GlobalUtils;
import util.IdUtils;
import util.SeqUtils;

import java.sql.SQLException;

/**
 * Created by Administrator on 2017/3/15.
 */
public class TempTest {
    public static void main(String[] args) throws SQLException {
        System.out.println(GlobalUtils.hex_md5("abc1231.1com.dazhimen.product20170318153922"+ Constant.signKey));
    }
}
