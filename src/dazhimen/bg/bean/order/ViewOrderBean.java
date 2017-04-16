package dazhimen.bg.bean.order;

/**
 * Created by Administrator on 2017/4/7.
 */
public class ViewOrderBean {
    private String orid = null;
    private String ordatetime = null;
    private Double ordersum = null;
    private String paymenttype = null;
    private String transaction_id = null;
    private String cid = null;
    private String cname = null;
    private String pid = null;
    private String pname = null;
    private String ptype = null;

    public String getOrid() {
        return orid;
    }

    public void setOrid(String orid) {
        this.orid = orid;
    }

    public String getOrdatetime() {
        return ordatetime;
    }

    public void setOrdatetime(String ordatetime) {
        this.ordatetime = ordatetime;
    }

    public Double getOrdersum() {
        return ordersum;
    }

    public void setOrdersum(Double ordersum) {
        this.ordersum = ordersum;
    }

    public String getPaymenttype() {
        return paymenttype;
    }

    public void setPaymenttype(String paymenttype) {
        this.paymenttype = paymenttype;
    }

    public String getTransaction_id() {
        return transaction_id;
    }

    public void setTransaction_id(String transaction_id) {
        this.transaction_id = transaction_id;
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getPtype() {
        return ptype;
    }

    public void setPtype(String ptype) {
        this.ptype = ptype;
    }
}
