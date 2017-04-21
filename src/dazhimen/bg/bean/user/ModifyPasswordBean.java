package dazhimen.bg.bean.user;

/**
 * Created by Administrator on 2017/4/21.
 */
public class ModifyPasswordBean {
    private String uid = null;
    private String oldpassword = null;
    private String newpassword = null;
    private String loginname = null;
    private String newpasswordcheck = null;

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getOldpassword() {
        return oldpassword;
    }

    public void setOldpassword(String oldpassword) {
        this.oldpassword = oldpassword;
    }

    public String getNewpassword() {
        return newpassword;
    }

    public void setNewpassword(String newpassword) {
        this.newpassword = newpassword;
    }

    public String getNewpasswordcheck() {
        return newpasswordcheck;
    }

    public String getLoginname() {
        return loginname;
    }

    public void setLoginname(String loginname) {
        this.loginname = loginname;
    }

    public void setNewpasswordcheck(String newpasswordcheck) {
        this.newpasswordcheck = newpasswordcheck;
    }
}
