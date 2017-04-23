package dazhimen.api.bean.recharge;

/**
 * Created by Administrator on 2017/4/4.
 */
public class ApiRechargeByWeixinBean {
    private String recid = null;
    private String cid = null;
    private Double recamount = null;
    private String transaction_id = null;
    private String paymenttype = null;

    public String getPaymenttype() {
        return paymenttype;
    }

    public void setPaymenttype(String paymenttype) {
        this.paymenttype = paymenttype;
    }

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

    public String getTransaction_id() {
        return transaction_id;
    }

    public void setTransaction_id(String transaction_id) {
        this.transaction_id = transaction_id;
    }
}
