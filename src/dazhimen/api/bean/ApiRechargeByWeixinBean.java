package dazhimen.api.bean;

/**
 * Created by Administrator on 2017/4/4.
 */
public class ApiRechargeByWeixinBean {
    private String recid = null;
    private String cid = null;
    private Double recamount = null;

    public String getRecid() {
        return recid;
    }

    public void setRecid(String recid) {
        this.recid = recid;
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public Double getRecamount() {
        return recamount;
    }

    public void setRecamount(Double recamount) {
        this.recamount = recamount;
    }
}
