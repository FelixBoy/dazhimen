package dazhimen.bg.bean.product;

/**
 * Created by Administrator on 2017/3/23.
 */
public class ViewProductBean {
    private String pid = null;
    private String pname = null;
    private String type = null;
    private String price = null;
    private String derateProportion = null;
    private String introduction = null;
    private String indexSort = null;
    private String indexPlay = null;
    private String listImage = null;
    private String uid = null;
    private String uname = null;
    private String mphone = null;
    private String gender = null;
    private String loginname = null;

    @Override
    public String toString() {
        return "ViewProductBean{" +
                "pid='" + pid + '\'' +
                ", pname='" + pname + '\'' +
                ", type='" + type + '\'' +
                ", price='" + price + '\'' +
                ", derateProportion='" + derateProportion + '\'' +
                ", introduction='" + introduction + '\'' +
                ", indexSort='" + indexSort + '\'' +
                ", indexPlay='" + indexPlay + '\'' +
                ", listImage='" + listImage + '\'' +
                ", uid='" + uid + '\'' +
                ", uname='" + uname + '\'' +
                ", mphone='" + mphone + '\'' +
                '}';
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getLoginname() {
        return loginname;
    }

    public void setLoginname(String loginname) {
        this.loginname = loginname;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getDerateProportion() {
        return derateProportion;
    }

    public void setDerateProportion(String derateProportion) {
        this.derateProportion = derateProportion;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public String getIndexSort() {
        return indexSort;
    }

    public void setIndexSort(String indexSort) {
        this.indexSort = indexSort;
    }

    public String getIndexPlay() {
        return indexPlay;
    }

    public void setIndexPlay(String indexPlay) {
        this.indexPlay = indexPlay;
    }

    public String getListImage() {
        return listImage;
    }

    public void setListImage(String listImage) {
        this.listImage = listImage;
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

    public String getMphone() {
        return mphone;
    }

    public void setMphone(String mphone) {
        this.mphone = mphone;
    }
}
