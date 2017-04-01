package dazhimen.bg.bean;

/**
 * Created by Administrator on 2017/4/1.
 */
public class IndexPlayBean {
    private String pid = null;
    private String pname = null;
    private String type = null;

    @Override
    public String toString() {
        return "IndexPlayBean{" +
                "pid='" + pid + '\'' +
                ", pname='" + pname + '\'' +
                ", type='" + type + '\'' +
                '}';
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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
