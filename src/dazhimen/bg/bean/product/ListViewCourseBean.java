package dazhimen.bg.bean.product;

/**
 * Created by Administrator on 2017/3/26.
 */
public class ListViewCourseBean {
    private String courseid = null;
    private String coursename = null;
    private String sortstr = null;
    private String istry = null;
    private String audiourl = null;
    private Integer viewcount = null;
    private String filename = null;
    private String filesize = null;

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getFilesize() {
        return filesize;
    }

    public void setFilesize(String filesize) {
        this.filesize = filesize;
    }

    public Integer getViewcount() {
        return viewcount;
    }

    public void setViewcount(Integer viewcount) {
        this.viewcount = viewcount;
    }

    public String getCourseid() {
        return courseid;
    }

    public void setCourseid(String courseid) {
        this.courseid = courseid;
    }

    public String getCoursename() {
        return coursename;
    }

    public void setCoursename(String coursename) {
        this.coursename = coursename;
    }

    public String getSortstr() {
        return sortstr;
    }

    public void setSortstr(String sortstr) {
        this.sortstr = sortstr;
    }

    public String getIstry() {
        return istry;
    }

    public void setIstry(String istry) {
        this.istry = istry;
    }

    public String getAudiourl() {
        return audiourl;
    }

    public void setAudiourl(String audiourl) {
        this.audiourl = audiourl;
    }
}
