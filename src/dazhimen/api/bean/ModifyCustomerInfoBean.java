package dazhimen.api.bean;

/**
 * Created by Administrator on 2017/3/18.
 */
public class ModifyCustomerInfoBean {
    private String cid = null;
    private String nickname = null;
    private String name = null;
    private String headerurl = null;
    private String mphone = null;
    private String email = null;
    private String education = null;
    private String gender = null;

    @Override
    public String toString() {
        return "ModifyCustomerInfoBean{" +
                "cid='" + cid + '\'' +
                ", nickname='" + nickname + '\'' +
                ", name='" + name + '\'' +
                ", headerurl='" + headerurl + '\'' +
                ", mphone='" + mphone + '\'' +
                ", email='" + email + '\'' +
                ", education='" + education + '\'' +
                ", gender='" + gender + '\'' +
                '}';
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getHeaderurl() {
        return headerurl;
    }

    public void setHeaderurl(String headerurl) {
        this.headerurl = headerurl;
    }

    public String getMphone() {
        return mphone;
    }

    public void setMphone(String mphone) {
        this.mphone = mphone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }
}
