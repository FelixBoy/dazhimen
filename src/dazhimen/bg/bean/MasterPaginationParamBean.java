package dazhimen.bg.bean;

/**
 * Created by Administrator on 2017/4/24.
 */
public class MasterPaginationParamBean {
    private Integer startnum = null;
    private Integer getrows = null;
    private String uid = null;

    public Integer getStartnum() {
        return startnum;
    }

    public void setStartnum(Integer startnum) {
        this.startnum = startnum;
    }

    public Integer getGetrows() {
        return getrows;
    }

    public void setGetrows(Integer getrows) {
        this.getrows = getrows;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }
}
