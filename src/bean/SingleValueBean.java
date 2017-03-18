package bean;

/**
 * Created by Administrator on 2017/3/15.
 */
public class SingleValueBean {

    private String valueInfo = null;

    public String getValueInfo() {
        return valueInfo;
    }

    public void setValueInfo(String valueInfo) {
        this.valueInfo = valueInfo;
    }

    @Override
    public String toString() {
        return "SingleValueBean{" +
                "valueInfo='" + valueInfo + '\'' +
                '}';
    }
}
