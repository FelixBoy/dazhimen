package dazhimen.bg.bean.customer;

/**
 * Created by Administrator on 2017/4/11.
 */
public class QueryCustomerParamBean {
    private String cidCondition = null;
    private String nicknameCondition = null;
    private String nameCondition = null;
    private String weixinCondition = null;
    private String starttimeCondition = null;
    private String endtimeCondition = null;
    private String startBalanceCondition = null;
    private String endBalanceCondition = null;
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

    public String getWeixinCondition() {
        return weixinCondition;
    }

    public void setWeixinCondition(String weixinCondition) {
        this.weixinCondition = weixinCondition;
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

    public String getStartBalanceCondition() {
        return startBalanceCondition;
    }

    public void setStartBalanceCondition(String startBalanceCondition) {
        this.startBalanceCondition = startBalanceCondition;
    }

    public String getEndBalanceCondition() {
        return endBalanceCondition;
    }

    public void setEndBalanceCondition(String endBalanceCondition) {
        this.endBalanceCondition = endBalanceCondition;
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
