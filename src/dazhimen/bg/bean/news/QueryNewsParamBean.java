package dazhimen.bg.bean.news;

/**
 * Created by Administrator on 2017/4/16.
 */
public class QueryNewsParamBean {
    private String nidCondition = null;
    private String ntitleCondition = null;
    private String starttimeCondition = null;
    private String endtimeCondition = null;
    private String statusCondition = null;
    private Integer startnum = null;
    private Integer getrows = null;

    public String getNidCondition() {
        return nidCondition;
    }

    public void setNidCondition(String nidCondition) {
        this.nidCondition = nidCondition;
    }

    public String getNtitleCondition() {
        return ntitleCondition;
    }

    public void setNtitleCondition(String ntitleCondition) {
        this.ntitleCondition = ntitleCondition;
    }

    public String getStarttimeCondition() {
        return starttimeCondition;
    }

    public void setStarttimeCondition(String starttimeCondition) {
        this.starttimeCondition = starttimeCondition;
    }

    public String getEndtimeCondition() {
        return endtimeCondition;
    }

    public void setEndtimeCondition(String endtimeCondition) {
        this.endtimeCondition = endtimeCondition;
    }

    public String getStatusCondition() {
        return statusCondition;
    }

    public void setStatusCondition(String statusCondition) {
        this.statusCondition = statusCondition;
    }

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
}
