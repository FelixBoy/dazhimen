package dazhimen.bg.bean.user;

/**
 * Created by Administrator on 2017/4/16.
 */
public class QueryMasterParamBean {
    private String uidCondition = null;
    private String mphoneCondition = null;
    private String nameCondition = null;
    private String loginnameCondition = null;
    private String genderCondition = null;
    private String starttimeCondition = null;
    private String endtimeCondition = null;
    private Integer startnum = null;
    private Integer getrows = null;
    public String getUidCondition() {
        return uidCondition;
    }

    public void setUidCondition(String uidCondition) {
        this.uidCondition = uidCondition;
    }

    public String getMphoneCondition() {
        return mphoneCondition;
    }

    public void setMphoneCondition(String mphoneCondition) {
        this.mphoneCondition = mphoneCondition;
    }

    public String getNameCondition() {
        return nameCondition;
    }

    public void setNameCondition(String nameCondition) {
        this.nameCondition = nameCondition;
    }

    public String getLoginnameCondition() {
        return loginnameCondition;
    }

    public void setLoginnameCondition(String loginnameCondition) {
        this.loginnameCondition = loginnameCondition;
    }

    public String getGenderCondition() {
        return genderCondition;
    }

    public void setGenderCondition(String genderCondition) {
        this.genderCondition = genderCondition;
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
