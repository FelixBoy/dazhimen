package dazhimen.api.bean;

import java.util.Date;

/**
 * Created by Administrator on 2017/3/18.
 */
public class ThirdPartLoginBean {
    private String loginType = null;
    private String qq = null;
    private String qqUid = null;
    private String weixin = null;
    private String weixinUid = null;
    private String nickname = null;
    private String headerurl = null;
    private String gender = null;
    private Integer age = null;
    private Date createDate = null;

    @Override
    public String toString() {
        return "ThirdPartLoginBean{" +
                "loginType='" + loginType + '\'' +
                ", qq='" + qq + '\'' +
                ", qqUid='" + qqUid + '\'' +
                ", weixin='" + weixin + '\'' +
                ", weixinUid='" + weixinUid + '\'' +
                ", nickname='" + nickname + '\'' +
                ", headerUrl='" + headerurl + '\'' +
                ", gender='" + gender + '\'' +
                ", age=" + age +
                ", createDate=" + createDate +
                '}';
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getLoginType() {
        return loginType;
    }

    public void setLoginType(String loginType) {
        this.loginType = loginType;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getQqUid() {
        return qqUid;
    }

    public void setQqUid(String qqUid) {
        this.qqUid = qqUid;
    }

    public String getWeixin() {
        return weixin;
    }

    public void setWeixin(String weixin) {
        this.weixin = weixin;
    }

    public String getWeixinUid() {
        return weixinUid;
    }

    public void setWeixinUid(String weixinUid) {
        this.weixinUid = weixinUid;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getHeaderurl() {
        return headerurl;
    }

    public void setHeaderurl(String headerurl) {
        this.headerurl = headerurl;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

}
