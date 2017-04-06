package dazhimen.api.bean;

/**
 * Created by Administrator on 2017/4/6.
 */
public class ApiBuyProductByBalance {
    private String orid = null;
    private Double ordersum = null;
    private String paymenttype = null;
    private String cid = null;

    public String getOrid() {
        return orid;
    }

    public void setOrid(String orid) {
        this.orid = orid;
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

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }
}
