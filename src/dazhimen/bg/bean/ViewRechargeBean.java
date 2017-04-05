package dazhimen.bg.bean;

/**
 * Created by Administrator on 2017/4/5.
 */
public class ViewRechargeBean {
    private String recid = null;
    private Double recamount = null;
    private String cid = null;
    private String cname = null;
    private String cnickname = null;
    private String mphone = null;
    private String issucc = null;
    private String transaction_id = null;
    private String crecdatetime = null;

    public String getCnickname() {
        return cnickname;
    }

    public void setCnickname(String cnickname) {
        this.cnickname = cnickname;
    }

    public String getMphone() {
        return mphone;
    }

    public void setMphone(String mphone) {
        this.mphone = mphone;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getRecid() {
        return recid;
    }

    public void setRecid(String recid) {
        this.recid = recid;
    }

    public Double getRecamount() {
        return recamount;
    }

    public void setRecamount(Double recamount) {
        this.recamount = recamount;
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public String getIssucc() {
        return issucc;
    }

    public void setIssucc(String issucc) {
        this.issucc = issucc;
    }

    public String getTransaction_id() {
        return transaction_id;
    }

    public void setTransaction_id(String transaction_id) {
        this.transaction_id = transaction_id;
    }

    public String getCrecdatetime() {
        return crecdatetime;
    }

    public void setCrecdatetime(String crecdatetime) {
        this.crecdatetime = crecdatetime;
    }
}
