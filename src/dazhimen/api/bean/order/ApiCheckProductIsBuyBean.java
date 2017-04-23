package dazhimen.api.bean.order;

/**
 * Created by Administrator on 2017/4/6.
 */
public class ApiCheckProductIsBuyBean {
    private String cid = null;
    private String pid = null;

    @Override
    public String toString() {
        return "ApiQueryProductCollectionParamBean{" +
                "cid='" + cid + '\'' +
                ", pid='" + pid + '\'' +
                '}';
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }
}
