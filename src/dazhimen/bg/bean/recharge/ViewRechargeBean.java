package dazhimen.bg.bean.recharge;

/**
 * Created by Administrator on 2017/4/5.
 */
public class ViewRechargeBean {
    private String recid = null;
    private Double recamount = null;
    private String cid = null;
    private String cname = null;
    private String paymenttype = null;
    private String cnickname = null;
    private String mphone = null;
    private String transaction_id = null;
    private String recdatetime = null;

    public String getPaymenttype() {
        return paymenttype;
    }

    public void setPaymenttype(String paymenttype) {
        this.paymenttype = paymenttype;
    }

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

    public String getTransaction_id() {
        return transaction_id;
    }

    public void setTransaction_id(String transaction_id) {
        this.transaction_id = transaction_id;
    }

    public String getRecdatetime() {
        return recdatetime;
    }

    public void setRecdatetime(String recdatetime) {
        this.recdatetime = recdatetime;
    }
}
