package dazhimen.api.bean;

/**
 * Created by Administrator on 2017/3/29.
 */
public class ApiQueryProductCollectionParamBean {
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
