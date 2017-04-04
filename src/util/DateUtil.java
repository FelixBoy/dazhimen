package util;

import dazhimen.bg.bean.DBDateTimeBean;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.Date;

/**
 * Created by Administrator on 2017/3/25.
 */
public class DateUtil {
    public Date getDBDate() throws BgException {
        Date dbDate = null;
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            DBDateTimeBean dateTimeBean = sqlSession.selectOne("dazhimen.bg.bean.Util.getDBDate");
            dbDate = dateTimeBean.getDbdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return dbDate;
    }
}
