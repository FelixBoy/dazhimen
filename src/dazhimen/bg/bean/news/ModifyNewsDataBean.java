package dazhimen.bg.bean.news;

import java.util.List;

/**
 * Created by Administrator on 2017/4/22.
 */
public class ModifyNewsDataBean {
    private String nid = null;
    private String title = null;
    private String mainimgurl = null;
    private String listimgurl = null;

    public String getNid() {
        return nid;
    }

    public void setNid(String nid) {
        this.nid = nid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMainimgurl() {
        return mainimgurl;
    }

    public void setMainimgurl(String mainimgurl) {
        this.mainimgurl = mainimgurl;
    }

    public String getListimgurl() {
        return listimgurl;
    }

    public void setListimgurl(String listimgurl) {
        this.listimgurl = listimgurl;
    }
}
