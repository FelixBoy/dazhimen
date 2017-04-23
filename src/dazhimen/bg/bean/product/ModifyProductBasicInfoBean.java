package dazhimen.bg.bean.product;

/**
 * Created by Administrator on 2017/4/8.
 */
public class ModifyProductBasicInfoBean {
    private String pid = null;
    private String pname = null;
    private Double price = null;
    private Integer derateProportion = null;
    private String introduction = null;

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

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getDerateProportion() {
        return derateProportion;
    }

    public void setDerateProportion(Integer derateProportion) {
        this.derateProportion = derateProportion;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }
}
