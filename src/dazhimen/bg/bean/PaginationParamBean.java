package dazhimen.bg.bean;

/**
 * Created by Administrator on 2017/4/5.
 */
public class PaginationParamBean {
    private Integer startnum = null;
    private Integer getrows = null;
    private String pid = null;
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

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }
}
