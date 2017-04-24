package dazhimen.bg.bean.login;

import java.util.HashMap;

/**
 * Created by Administrator on 2017/4/15.
 */
public class LoginUserBean {
    private String uid = null;
    private String uname = null;
    private String utype = null;
    private String utypeStr = null;
    private String loginname = null;
    private String gender = null;
    private String mphone = null;
    private String introduction = null;

    private HashMap<String, String> userPermissionMap = null;

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getMphone() {
        return mphone;
    }

    public void setMphone(String mphone) {
        this.mphone = mphone;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public HashMap<String, String> getUserPermissionMap() {
        return userPermissionMap;
    }

    public void setUserPermissionMap(HashMap<String, String> userPermissionMap) {
        this.userPermissionMap = userPermissionMap;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getUtype() {
        return utype;
    }

    public void setUtype(String utype) {
        this.utype = utype;
    }

    public String getUtypeStr() {
        return utypeStr;
    }

    public void setUtypeStr(String utypeStr) {
        this.utypeStr = utypeStr;
    }

    public String getLoginname() {
        return loginname;
    }

    public void setLoginname(String loginname) {
        this.loginname = loginname;
    }
}
