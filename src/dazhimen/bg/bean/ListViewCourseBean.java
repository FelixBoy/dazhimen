package dazhimen.bg.bean;

/**
 * Created by Administrator on 2017/3/26.
 */
public class ListViewCourseBean {
    private String courseid = null;
    private String coursename = null;
    private String sort = null;
    private String istry = null;
    private String audiourl = null;
    private Integer viewcount = null;
    @Override
    public String toString() {
        return "ListViewCourseBean{" +
                "courseid='" + courseid + '\'' +
                ", coursename='" + coursename + '\'' +
                ", sort='" + sort + '\'' +
                ", istry='" + istry + '\'' +
                ", audiourl='" + audiourl + '\'' +
                '}';
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

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
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
