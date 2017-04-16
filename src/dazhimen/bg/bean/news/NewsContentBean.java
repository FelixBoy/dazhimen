package dazhimen.bg.bean.news;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * Created by Administrator on 2017/4/12.
 */
public class NewsContentBean {
    private String contentid = null;
    private String contenttype = null;
    private String contentsubtitle = null;
    private CommonsMultipartFile contentfile = null;
    private String contenttext = null;
    private String contentsort = null;
    private String contentvalue = null;
    private String nid = null;

    public String getNid() {
        return nid;
    }

    public void setNid(String nid) {
        this.nid = nid;
    }

    public String getContentvalue() {
        return contentvalue;
    }

    public void setContentvalue(String contentvalue) {
        this.contentvalue = contentvalue;
    }

    public String getContentid() {
        return contentid;
    }

    public void setContentid(String contentid) {
        this.contentid = contentid;
    }

    public String getContenttype() {
        return contenttype;
    }

    public void setContenttype(String contenttype) {
        this.contenttype = contenttype;
    }

    public String getContentsubtitle() {
        return contentsubtitle;
    }

    public void setContentsubtitle(String contentsubtitle) {
        this.contentsubtitle = contentsubtitle;
    }

    public CommonsMultipartFile getContentfile() {
        return contentfile;
    }

    public void setContentfile(CommonsMultipartFile contentfile) {
        this.contentfile = contentfile;
    }

    public String getContenttext() {
        return contenttext;
    }

    public void setContenttext(String contenttext) {
        this.contenttext = contenttext;
    }

    public String getContentsort() {
        return contentsort;
    }

    public void setContentsort(String contentsort) {
        this.contentsort = contentsort;
    }
}
