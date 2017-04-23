package dazhimen.api.bean.order;

/**
 * Created by Administrator on 2017/4/6.
 */
public class ApiUpdateCustomerBalanceBean {
    private Double changeamount = null;
    private String cid = null;

    public Double getChangeamount() {
        return changeamount;
    }

    public void setChangeamount(Double changeamount) {
        this.changeamount = changeamount;
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }
}
