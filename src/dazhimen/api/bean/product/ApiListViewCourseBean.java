package dazhimen.api.bean.product;

import java.util.Date;

/**
 * Created by Administrator on 2017/3/27.
 */
public class ApiListViewCourseBean {
    private String courseid = null;
    private String coursename = null;
    private String istry = null;
    private String audiourl = null;
    private Date createdateo = null;
    private String createdate = "";
    private String viewcount = "";
    private String listimgurl = "";
    @Override
    public String toString() {
        return "ApiListViewCourseBean{" +
                "courseid='" + courseid + '\'' +
                ", coursename='" + coursename + '\'' +
                ", istry='" + istry + '\'' +
                ", audiourl='" + audiourl + '\'' +
                ", createdateo=" + createdateo +
                ", createdate='" + createdate + '\'' +
                ", viewcount='" + viewcount + '\'' +
                '}';
    }

    private String dealNull(String value){
        if(value == null){
            return "";
        }else{
            return value;
        }
    }

    public String getListimgurl() {
        return listimgurl;
    }

    public void setListimgurl(String listimgurl) {
        this.listimgurl = dealNull(listimgurl);
    }

    public String getCourseid() {
        return courseid;
    }

    public void setCourseid(String courseid) {
        this.courseid = dealNull(courseid);
    }

    public String getCoursename() {
        return coursename;
    }

    public void setCoursename(String coursename) {
        this.coursename = dealNull(coursename);
    }

    public String getIstry() {
        return istry;
    }

    public void setIstry(String istry) {
        this.istry = dealNull(istry);
    }

    public String getAudiourl() {
        return audiourl;
    }

    public void setAudiourl(String audiourl) {
        this.audiourl = dealNull(audiourl);
    }

    public Date getCreatedateo() {
        return createdateo;
    }

    public void setCreatedateo(Date createdateo) {
        this.createdateo = createdateo;
    }

    public String getCreatedate() {
        return createdate;
    }

    public void setCreatedate(String createdate) {
        this.createdate = dealNull(createdate);
    }

    public String getViewcount() {
        return viewcount;
    }

    public void setViewcount(String viewcount) {
        this.viewcount = dealNull(viewcount);
    }
}
