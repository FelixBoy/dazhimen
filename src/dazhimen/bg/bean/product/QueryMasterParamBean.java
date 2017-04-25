package dazhimen.bg.bean.product;

/**
 * Created by Administrator on 2017/4/25.
 */
public class QueryMasterParamBean {
    private String searchCondition = null;
    private Integer startnum = null;
    private Integer getrows = null;

    public String getSearchCondition() {
        return searchCondition;
    }

    public void setSearchCondition(String searchCondition) {
        this.searchCondition = searchCondition;
    }

    public Integer getStartnum() {
        return startnum;
    }

    public void setStartnum(Integer startnum) {
        this.startnum = startnum;
    }

    public Integer getGetrows() {
        return getrows;
    }

    public void setGetrows(Integer getrows) {
        this.getrows = getrows;
    }
}
