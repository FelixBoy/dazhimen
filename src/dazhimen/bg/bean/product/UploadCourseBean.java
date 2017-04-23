package dazhimen.bg.bean.product;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * Created by Administrator on 2017/3/26.
 */
public class UploadCourseBean {
    private String pid = null;
    private String courseid = null;
    private String coursename = null;
    private String sort = null;
    private String istry = null;
    private CommonsMultipartFile audio = null;
    private String audiopath = null;
    private String basePath = null;

    public String getAudiopath() {
        return audiopath;
    }

    public void setAudiopath(String audiopath) {
        this.audiopath = audiopath;
    }

    public String getBasePath() {
        return basePath;
    }

    public void setBasePath(String basePath) {
        this.basePath = basePath;
    }

    @Override
    public String toString() {
        return "UploadCourseBean{" +
                "pid='" + pid + '\'' +
                ", courseid='" + courseid + '\'' +
                ", coursename='" + coursename + '\'' +
                ", sort='" + sort + '\'' +
                ", istry='" + istry + '\'' +
                ", audio=" + audio +
                '}';
    }

    public String getCourseid() {
        return courseid;
    }

    public void setCourseid(String courseid) {
        this.courseid = courseid;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
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

    public CommonsMultipartFile getAudio() {
        return audio;
    }

    public void setAudio(CommonsMultipartFile audio) {
        this.audio = audio;
    }
}
