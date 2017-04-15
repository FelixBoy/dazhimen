package dazhimen.bg.bean.login;

/**
 * Created by Administrator on 2017/3/29.
 */
public class LoginBean {
    private String loginname = null;
    private String password = null;

    @Override
    public String toString() {
        return "LoginBean{" +
                "loginname='" + loginname + '\'' +
                ", password='" + password + '\'' +
                '}';
    }

    public String getLoginname() {
        return loginname;
    }

    public void setLoginname(String loginname) {
        this.loginname = loginname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
