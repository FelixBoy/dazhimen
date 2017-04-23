package dazhimen.api.bean.other;

/**
 * Created by Administrator on 2017/4/2.
 */
public class ApiIndexPlayBean {
    private String id = "";
    private String imgurl = "";
    private String contenttype = "";
    private String producttype = "";
    private String isstart = "";

    private String dealNull(String value){
        if(value == null){
            return "";
        }else{
            return value;
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = dealNull(id);
    }

    public String getImgurl() {
        return imgurl;
    }

    public void setImgurl(String imgurl) {
        this.imgurl = dealNull(imgurl);
    }

    public String getContenttype() {
        return contenttype;
    }

    public void setContenttype(String contenttype) {
        this.contenttype = dealNull(contenttype);
    }

    public String getProducttype() {
        return producttype;
    }

    public void setProducttype(String producttype) {
        this.producttype = dealNull(producttype);
    }

    public String getIsstart() {
        return isstart;
    }

    public void setIsstart(String isstart) {
        this.isstart = dealNull(isstart);
    }
}
