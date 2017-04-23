package dazhimen.api.bean.news;

/**
 * Created by Administrator on 2017/4/12.
 */
public class ApiNewsContentBean {
    private String contenttype = "";
    private String contentvalue = "";
    private String dealNull(String value){
        if(value == null){
            return "";
        }else{
            return value;
        }
    }
    public String getContenttype() {
        return contenttype;
    }

    public void setContenttype(String contenttype) {
        this.contenttype = dealNull(contenttype);
    }

    public String getContentvalue() {
        return contentvalue;
    }

    public void setContentvalue(String contentvalue) {
        this.contentvalue = dealNull(contentvalue);
    }
}
