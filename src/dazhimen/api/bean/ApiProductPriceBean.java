package dazhimen.api.bean;

/**
 * Created by Administrator on 2017/4/6.
 */
public class ApiProductPriceBean {
    private Double price = null;
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
}