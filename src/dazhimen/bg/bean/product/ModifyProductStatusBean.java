package dazhimen.bg.bean.product;

/**
 * Created by Administrator on 2017/3/29.
 */
public class ModifyProductStatusBean {
    private String status = null;
    private String pid = null;

    @Override
    public String toString() {
        return "ModifyProductStatusBean{" +
                "status='" + status + '\'' +
                ", pid='" + pid + '\'' +
                '}';
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }
}
