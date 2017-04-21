package dazhimen.bg.bean.news;

/**
 * Created by Administrator on 2017/4/21.
 */
public class GenNewsContentBean {
    private String contenttype = "";
    private String contentvalue = "";
    private String contentSort = "";

    public String getContentSort() {
        return contentSort;
    }

    public void setContentSort(String contentSort) {
        this.contentSort = contentSort;
    }

    public String getContenttype() {
        return contenttype;
    }

    public void setContenttype(String contenttype) {
        this.contenttype = contenttype;
    }

    public String getContentvalue() {
        return contentvalue;
    }

    public void setContentvalue(String contentvalue) {
        this.contentvalue = contentvalue;
    }
}
