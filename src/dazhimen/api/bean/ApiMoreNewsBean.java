package dazhimen.api.bean;

/**
 * Created by Administrator on 2017/4/12.
 */
public class ApiMoreNewsBean {
    private String nid = "";
    private String listimgurl = "";
    private String title = "";
    private String createdate = null;
    private String dealNull(String value){
        if(value == null){
            return "";
        }else{
            return value;
        }
    }
    public String getNid() {
        return nid;
    }

    public void setNid(String nid) {
        this.nid = dealNull(nid);
    }

    public String getListimgurl() {
        return listimgurl;
    }

    public void setListimgurl(String listimgurl) {
        this.listimgurl = dealNull(listimgurl);
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = dealNull(title);
    }

    public String getCreatedate() {
        return createdate;
    }

    public void setCreatedate(String createdate) {
        this.createdate = createdate;
    }
}
