package dazhimen.bg.bean.order;

/**
 * Created by Administrator on 2017/4/16.
 */
public class QueryOrderParamBean {
    private String cnameCondition = null;
    private String mphoneCondition = null;
    private String producttypeCondition = null;
    private String paymenttypeCondition = null;
    private String starttimeCondition = null;
    private String endtimeCondition = null;
    private String startAmountCondition = null;
    private String endAmountCondition = null;
    private Integer startnum = null;
    private Integer getrows = null;

    public String getCnameCondition() {
        return cnameCondition;
    }

    public void setCnameCondition(String cnameCondition) {
        this.cnameCondition = cnameCondition;
    }

    public String getMphoneCondition() {
        return mphoneCondition;
    }

    public void setMphoneCondition(String mphoneCondition) {
        this.mphoneCondition = mphoneCondition;
    }

    public String getProducttypeCondition() {
        return producttypeCondition;
    }

    public void setProducttypeCondition(String producttypeCondition) {
        this.producttypeCondition = producttypeCondition;
    }

    public String getPaymenttypeCondition() {
        return paymenttypeCondition;
    }

    public void setPaymenttypeCondition(String paymenttypeCondition) {
        this.paymenttypeCondition = paymenttypeCondition;
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

    public String getStartAmountCondition() {
        return startAmountCondition;
    }

    public void setStartAmountCondition(String startAmountCondition) {
        this.startAmountCondition = startAmountCondition;
    }

    public String getEndAmountCondition() {
        return endAmountCondition;
    }

    public void setEndAmountCondition(String endAmountCondition) {
        this.endAmountCondition = endAmountCondition;
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
