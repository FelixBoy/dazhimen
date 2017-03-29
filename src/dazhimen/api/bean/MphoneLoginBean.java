package dazhimen.api.bean;

/**
 * Created by Administrator on 2017/3/18.
 */
public class MphoneLoginBean {
    private String mphone = "";
    private String verifyCode = "";
    private String cid = "";

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    @Override
    public String toString() {
        return "MphoneLoginBean{" +
                "mphone='" + mphone + '\'' +
                ", verifyCode='" + verifyCode + '\'' +
                ", cid='" + cid + '\'' +
                '}';
    }

    public String getMphone() {
        return mphone;
    }

    public void setMphone(String mphone) {
        this.mphone = mphone;
    }

    public String getVerifyCode() {
        return verifyCode;
    }

    public void setVerifyCode(String verifyCode) {
        this.verifyCode = verifyCode;
    }
}
