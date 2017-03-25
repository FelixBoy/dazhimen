package dazhimen.bg.bean;

import java.util.Date;

/**
 * Created by Administrator on 2017/3/25.
 */
public class DBDateTimeBean {
    private Date dbdate = null;

    @Override
    public String toString() {
        return "DBDateTimeBean{" +
                "dbdate=" + dbdate +
                '}';
    }

    public Date getDbdate() {
        return dbdate;
    }

    public void setDbdate(Date dbdate) {
        this.dbdate = dbdate;
    }
}
