package dazhimen.api.bean.order;

/**
 * Created by Administrator on 2017/4/6.
 */
public class ApiProductPriceBean {
    private Double price = null;
    private String pname = null;
    private Integer derateProportion = null;
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

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }
}
