package bean;

/**
 * Created by Administrator on 2017/3/18.
 */
public class CustomerBean {
    private String cid = null;
    private String nickname = "";
    private String name = "";
    private String headerurl = "";
    private String mphone = "";
    private String email = "";
    private String education = "";
    private String gender = "";

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

    private String dealNull(String value){
        if(value == null){
            return "";
        }else{
            return value;
        }
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = dealNull(cid);
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = dealNull(nickname);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = dealNull(name);
    }

    public String getHeaderurl() {
        return headerurl;
    }

    public void setHeaderurl(String headerurl) {
        this.headerurl = dealNull(headerurl);
    }

    public String getMphone() {
        return mphone;
    }

    public void setMphone(String mphone) {
        this.mphone = dealNull(mphone);
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = dealNull(email);
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = dealNull(education);
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = dealNull(gender);
    }
}
