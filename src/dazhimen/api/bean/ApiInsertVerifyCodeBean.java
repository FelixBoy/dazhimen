package dazhimen.api.bean;

/**
 * Created by Administrator on 2017/4/23.
 */
public class ApiInsertVerifyCodeBean {
    private String vid = null;
    private String mphone = null;
    private String code = null;
    private String expiredatetime = null;

    public String getVid() {
        return vid;
    }

    public void setVid(String vid) {
        this.vid = vid;
    }

    public String getMphone() {
        return mphone;
    }

    public void setMphone(String mphone) {
        this.mphone = mphone;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getExpiredatetime() {
        return expiredatetime;
    }

    public void setExpiredatetime(String expiredatetime) {
        this.expiredatetime = expiredatetime;
    }
}
