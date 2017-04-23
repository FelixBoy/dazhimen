package dazhimen.api.bean.master;

/**
 * Created by Administrator on 2017/3/31.
 */
public class ApiMasterBean {
    private String masterid = "";
    private String headerimgurl = "";
    private String name = "";
    private String identity = "";
    private String introduction = "";

    private String dealNull(String value){
        if(value == null){
            return "";
        }else{
            return value;
        }
    }

    public String getMasterid() {
        return masterid;
    }

    public void setMasterid(String masterid) {
        this.masterid = dealNull(masterid);
    }

    public String getHeaderimgurl() {
        return headerimgurl;
    }

    public void setHeaderimgurl(String headerimgurl) {
        this.headerimgurl = dealNull(headerimgurl);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = dealNull(name);
    }

    public String getIdentity() {
        return identity;
    }

    public void setIdentity(String identity) {
        this.identity = dealNull(identity);
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = dealNull(introduction);
    }
}
