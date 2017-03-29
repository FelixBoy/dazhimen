package dazhimen.api.bean;

/**
 * Created by Administrator on 2017/3/29.
 */
public class ApiQueryProductParamBean {
    private String type = null;
    private Integer getcount = null;

    @Override
    public String toString() {
        return "ApiQueryProductParamBean{" +
                "type='" + type + '\'' +
                ", getcount=" + getcount +
                '}';
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getGetcount() {
        return getcount;
    }

    public void setGetcount(Integer getcount) {
        this.getcount = getcount;
    }
}
