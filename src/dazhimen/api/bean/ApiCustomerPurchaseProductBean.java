package dazhimen.api.bean;

import java.util.List;

/**
 * Created by Administrator on 2017/3/31.
 */
public class ApiCustomerPurchaseProductBean {
    private String pid = "";
    private String pname = "";
    private String listimgurl = "";
    private String type = "";
    private String courselist = "";
    private String dealNull(String value){
        if(value == null){
            return "";
        }else{
            return value;
        }
    }

    public String getCourselist() {
        return dealNull(courselist);
    }

    public void setCourselist(String courselist) {
        this.courselist = courselist;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = dealNull(pid);
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = dealNull(pname);
    }

    public String getListimgurl() {
        return listimgurl;
    }

    public void setListimgurl(String listimgurl) {
        this.listimgurl = dealNull(listimgurl);
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = dealNull(type);
    }

}
