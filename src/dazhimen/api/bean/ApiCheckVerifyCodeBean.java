package dazhimen.api.bean;

/**
 * Created by Administrator on 2017/4/23.
 */
public class ApiCheckVerifyCodeBean {
    private String code = null;
    private String expiredatetime = null;

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
