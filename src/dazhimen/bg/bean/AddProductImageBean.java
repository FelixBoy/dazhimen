package dazhimen.bg.bean;

/**
 * Created by Administrator on 2017/3/29.
 */
public class AddProductImageBean {
    private String imageid = null;
    private String path = null;
    private String pid = null;

    @Override
    public String toString() {
        return "AddProductImageBean{" +
                "imageid='" + imageid + '\'' +
                ", path='" + path + '\'' +
                ", pid='" + pid + '\'' +
                '}';
    }

    public String getImageid() {
        return imageid;
    }

    public void setImageid(String imageid) {
        this.imageid = imageid;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }
}
