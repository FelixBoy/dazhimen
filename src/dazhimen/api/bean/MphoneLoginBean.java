package dazhimen.api.bean;

/**
 * Created by Administrator on 2017/3/18.
 */
public class MphoneLoginBean {
    private String mphone = "";
    private String verifyCode = "";

    @Override
    public String toString() {
        return "MphoneLoginBean{" +
                "mphone='" + mphone + '\'' +
                ", verifyCode='" + verifyCode + '\'' +
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
