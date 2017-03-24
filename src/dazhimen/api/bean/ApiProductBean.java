package dazhimen.api.bean;

import java.util.Date;

/**
 * Created by Administrator on 2017/3/24.
 */
public class ApiProductBean {
    private String pid = "";
    private String listimgurl = "";
    private String pname = "";
    private Date updatetimeo = null;
    private String updatetime = "";
    private Double priceo = null;
    private String price = "";

    @Override
    public String toString() {
        return "ApiProductBean{" +
                "pid='" + pid + '\'' +
                ", listimgurl='" + listimgurl + '\'' +
                ", pname='" + pname + '\'' +
                ", updatetimeo=" + updatetimeo +
                ", updatetime='" + updatetime + '\'' +
                ", priceo=" + priceo +
                ", price='" + price + '\'' +
                '}';
    }

    private String dealNull(String value){
        if(value == null){
            return "";
        }else{
            return value;
        }
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = dealNull(pid);
    }

    public String getListimgurl() {
        return listimgurl;
    }

    public void setListimgurl(String listimgurl) {
        this.listimgurl = dealNull(listimgurl);
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = dealNull(pname);
    }

    public Date getUpdatetimeo() {
        return updatetimeo;
    }

    public void setUpdatetimeo(Date updatetimeo) {
        this.updatetimeo = updatetimeo;
    }

    public Double getPriceo() {
        return priceo;
    }

    public void setPriceo(Double priceo) {
        this.priceo = priceo;
    }

    public String getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(String updatetime) {
        this.updatetime = dealNull(updatetime);
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = dealNull(price);
    }
}
