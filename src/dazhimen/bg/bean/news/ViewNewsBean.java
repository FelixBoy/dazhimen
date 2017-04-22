package dazhimen.bg.bean.news;

/**
 * Created by Administrator on 2017/4/22.
 */
public class ViewNewsBean {
    private String title = null;
    private String mainimgurl = null;
    private String listimgurl = null;
    private String newscontenthtml = null;

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

    public String getNewscontenthtml() {
        return newscontenthtml;
    }

    public void setNewscontenthtml(String newscontenthtml) {
        this.newscontenthtml = newscontenthtml;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
