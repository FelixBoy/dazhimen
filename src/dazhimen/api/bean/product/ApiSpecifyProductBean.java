package dazhimen.api.bean.product;

import java.util.Date;

/**
 * Created by Administrator on 2017/3/27.
 */
public class ApiSpecifyProductBean {
    private String pid = "";
    private String mainimgurl = "";
    private String pname = "";
    private Double price = null;
    private Double discountprice = null;
    private String buycount = "";
    private String istry = "";
    private String iscollection = "";
    private String isbuy = "";
    private String introduction = "";
    private String isstart = "";

    private String dealNull(String value){
        if(value == null){
            return "";
        }else{
            return value;
        }
    }

    @Override
    public String toString() {
        return "ApiSpecifyProductBean{" +
                "pid='" + pid + '\'' +
                ", mainimgurl='" + mainimgurl + '\'' +
                ", pname='" + pname + '\'' +
                ", price='" + price + '\'' +
                ", buycount='" + buycount + '\'' +
                ", istry='" + istry + '\'' +
                ", iscollection='" + iscollection + '\'' +
                ", isbuy='" + isbuy + '\'' +
                '}';
    }

    public Double getDiscountprice() {
        return discountprice;
    }

    public void setDiscountprice(Double discountprice) {
        this.discountprice = discountprice;
    }

    public String getIsbuy() {
        return isbuy;
    }

    public void setIsbuy(String isbuy) {
        this.isbuy = isbuy;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = dealNull(pid);
    }

    public String getMainimgurl() {
        return mainimgurl;
    }

    public void setMainimgurl(String mainimgurl) {
        this.mainimgurl = dealNull(mainimgurl);
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = dealNull(pname);
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getBuycount() {
        return buycount;
    }

    public void setBuycount(String buycount) {
        this.buycount = dealNull(buycount);
    }

    public String getIstry() {
        return istry;
    }

    public void setIstry(String istry) {
        this.istry = dealNull(istry);
    }

    public String getIscollection() {
        return iscollection;
    }

    public void setIscollection(String iscollection) {
        this.iscollection = dealNull(iscollection);
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = dealNull(introduction);
    }

    public String getIsstart() {
        return isstart;
    }

    public void setIsstart(String isstart) {
        this.isstart = dealNull(isstart);
    }
}
