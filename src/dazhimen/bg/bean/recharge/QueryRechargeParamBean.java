package dazhimen.bg.bean.recharge;

/**
 * Created by Administrator on 2017/4/16.
 */
public class QueryRechargeParamBean {
    private String cidCondition = null;
    private String nicknameCondition = null;
    private String nameCondition = null;
    private String paymenttypeCondition = null;
    private String starttimeCondition = null;
    private String endtimeCondition = null;
    private String startAmountCondition = null;
    private String endAmountCondition = null;
    private Integer startnum = null;
    private Integer getrows = null;

    public String getCidCondition() {
        return cidCondition;
    }

    public void setCidCondition(String cidCondition) {
        this.cidCondition = cidCondition;
    }

    public String getNicknameCondition() {
        return nicknameCondition;
    }

    public void setNicknameCondition(String nicknameCondition) {
        this.nicknameCondition = nicknameCondition;
    }

    public String getNameCondition() {
        return nameCondition;
    }

    public void setNameCondition(String nameCondition) {
        this.nameCondition = nameCondition;
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
