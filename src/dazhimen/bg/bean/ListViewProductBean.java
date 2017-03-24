package dazhimen.bg.bean;

import java.util.Date;

/**
 * Created by Administrator on 2017/3/24.
 */
public class ListViewProductBean {
    private String pid = null;
    private String pname = null;
    private String createtime = null;
    private String uname = null;
    private String status = null;
    private String type = null;
    private String statusnum = null;

    @Override
    public String toString() {
        return "ListViewProductBean{" +
                "pid='" + pid + '\'' +
                ", pname='" + pname + '\'' +
                ", createtime='" + createtime + '\'' +
                ", uname='" + uname + '\'' +
                ", status='" + status + '\'' +
                ", type='" + type + '\'' +
                ", statusnum='" + statusnum + '\'' +
                '}';
    }

    public String getStatusnum() {
        return statusnum;
    }

    public void setStatusnum(String statusnum) {
        this.statusnum = statusnum;
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

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
