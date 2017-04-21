package dazhimen.bg.bean.news;

import dazhimen.bg.bean.news.NewsContentBean;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.util.List;

/**
 * Created by Administrator on 2017/4/12.
 */
public class AddNewsBean {
    private String nid = null;
    private String title = null;
    private CommonsMultipartFile listImgFile = null;
    private CommonsMultipartFile mainImgFile = null;
    private String listimgurl = null;
    private String mainimgurl = null;
    private String htmlfileurl = null;
    private List<NewsContentBean> contentBeans = null;

    @Override
    public String toString() {
        return "AddNewsBean{" +
                "nid='" + nid + '\'' +
                ", title='" + title + '\'' +
                ", listImgFile=" + listImgFile +
                ", mainImgFile=" + mainImgFile +
                ", contentBeans=" + contentBeans +
                '}';
    }

    public String getListimgurl() {
        return listimgurl;
    }

    public void setListimgurl(String listimgurl) {
        this.listimgurl = listimgurl;
    }

    public String getMainimgurl() {
        return mainimgurl;
    }

    public void setMainimgurl(String mainimgurl) {
        this.mainimgurl = mainimgurl;
    }

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

    public CommonsMultipartFile getListImgFile() {
        return listImgFile;
    }

    public void setListImgFile(CommonsMultipartFile listImgFile) {
        this.listImgFile = listImgFile;
    }

    public CommonsMultipartFile getMainImgFile() {
        return mainImgFile;
    }

    public void setMainImgFile(CommonsMultipartFile mainImgFile) {
        this.mainImgFile = mainImgFile;
    }

    public List<NewsContentBean> getContentBeans() {
        return contentBeans;
    }

    public void setContentBeans(List<NewsContentBean> contentBeans) {
        this.contentBeans = contentBeans;
    }

    public String getHtmlfileurl() {
        return htmlfileurl;
    }

    public void setHtmlfileurl(String htmlfileurl) {
        this.htmlfileurl = htmlfileurl;
    }
}
