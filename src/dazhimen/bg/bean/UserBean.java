package dazhimen.bg.bean;

import java.util.Date;

/**
 * Created by zhj on 2017/3/13.
 */
public class UserBean {
    private String uid = null;//主键。后台用户ID，分为两种身份，掌门和管理员。生成规则：u+年+月+日+3位数字。例如：u170312001
    private String name = null;//用户姓名
    private String mphone = null;//手机号码
    private String password = null; //密码，密文存储。加密规则为：md5(uid+明文password)
    private String gender = null; //性别。1:男，2:女
    private String type = null; //人员类型。1:掌门，2:管理员
    private String loginname = null; //登录系统时的账户名称
    private String remarks = null; //备注信息
    private String isdel = null; //用户是否为已删除状态。1:已删除，0:正常状态
    private String loginnameorginal = null;//用户判定修改登录名时的重复
    private Date createDate = null; //用户创建时间

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getLoginnameorginal() {
        return loginnameorginal;
    }

    public void setLoginnameorginal(String loginnameorginal) {
        this.loginnameorginal = loginnameorginal;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMphone() {
        return mphone;
    }

    public void setMphone(String mphone) {
        this.mphone = mphone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getLoginname() {
        return loginname;
    }

    public void setLoginname(String loginname) {
        this.loginname = loginname;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getIsdel() {
        return isdel;
    }

    public void setIsdel(String isdel) {
        this.isdel = isdel;
    }

    @Override
    public String toString() {
        return "User{" +
                "uid='" + uid + '\'' +
                ", name='" + name + '\'' +
                ", mphone='" + mphone + '\'' +
                ", password='" + password + '\'' +
                ", gender='" + gender + '\'' +
                ", type='" + type + '\'' +
                ", loginname='" + loginname + '\'' +
                ", remarks='" + remarks + '\'' +
                ", isdel='" + isdel + '\'' +
                '}';
    }
}
