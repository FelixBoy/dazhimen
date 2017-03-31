package dazhimen.bg.bean;

public class CustomerBean {
    private String cid = null;
    private String nickname = "";
    private String name = "";
    private String headerurl = "";
    private String mphone = "";
    private String email = "";
    private String education = "";
    private String gender = "";
    private String qquid = "";
    private String weixinuid = "";

    @Override
    public String toString() {
        return "CustomerBean{" +
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

    public String getQquid() {
        return qquid;
    }

    public void setQquid(String qquid) {
        this.qquid = qquid;
    }

    public String getWeixinuid() {
        return weixinuid;
    }

    public void setWeixinuid(String weixinuid) {
        this.weixinuid = weixinuid;
    }
}
