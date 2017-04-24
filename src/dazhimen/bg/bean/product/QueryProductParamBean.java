package dazhimen.bg.bean.product;

import java.util.Date;

/**
 * Created by Administrator on 2017/4/11.
 */
public class QueryProductParamBean {
    private String pidCondition = null;
    private String pnameCondition = null;
    private String typeCondition = null;
    private String starttimeCondition = null;
    private String endtimeCondition = null;
    private String statusCondition = null;
    private String uid = null;
    private Integer startnum = null;
    private Integer getrows = null;

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getPidCondition() {
        return pidCondition;
    }

    public void setPidCondition(String pidCondition) {
        this.pidCondition = pidCondition;
    }

    public String getPnameCondition() {
        return pnameCondition;
    }

    public void setPnameCondition(String pnameCondition) {
        this.pnameCondition = pnameCondition;
    }

    public String getTypeCondition() {
        return typeCondition;
    }

    public void setTypeCondition(String typeCondition) {
        this.typeCondition = typeCondition;
    }

    public String getStatusCondition() {
        return statusCondition;
    }

    public void setStatusCondition(String statusCondition) {
        this.statusCondition = statusCondition;
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
