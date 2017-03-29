package dazhimen.bg.bean;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.util.List;

/**
 * Created by Administrator on 2017/3/19.
 */
public class UploadProductBean {
    private String pid = null;
    private String pname = null;
    private String type = null;
    private Double price = null;
    private Double derateProportion = null;
    private String introduction = null;
    private String indexSort = null;
    private String indexPlay = null;
    private CommonsMultipartFile listImgFile = null;
    private String listimage = null;
    private List<MultipartFile> mainImgFiles = null;
    private String uid = null;
    private String basePath = null;

    @Override
    public String toString() {
        return "UploadProductBean{" +
                "pid='" + pid + '\'' +
                ", pname='" + pname + '\'' +
                ", type='" + type + '\'' +
                ", price=" + price +
                ", derateProportion=" + derateProportion +
                ", introduction='" + introduction + '\'' +
                ", indexSort='" + indexSort + '\'' +
                ", indexPlay='" + indexPlay + '\'' +
                ", listImgFile=" + listImgFile +
                ", listimage='" + listimage + '\'' +
                ", mainImgFiles=" + mainImgFiles +
                ", uid='" + uid + '\'' +
                ", basePath='" + basePath + '\'' +
                '}';
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getDerateProportion() {
        return derateProportion;
    }

    public void setDerateProportion(Double derateProportion) {
        this.derateProportion = derateProportion;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public String getIndexSort() {
        return indexSort;
    }

    public void setIndexSort(String indexSort) {
        this.indexSort = indexSort;
    }

    public String getIndexPlay() {
        return indexPlay;
    }

    public void setIndexPlay(String indexPlay) {
        this.indexPlay = indexPlay;
    }

    public CommonsMultipartFile getListImgFile() {
        return listImgFile;
    }

    public void setListImgFile(CommonsMultipartFile listImgFile) {
        this.listImgFile = listImgFile;
    }

    public String getListimage() {
        return listimage;
    }

    public void setListimage(String listimage) {
        this.listimage = listimage;
    }

    public List<MultipartFile> getMainImgFiles() {
        return mainImgFiles;
    }

    public void setMainImgFiles(List<MultipartFile> mainImgFiles) {
        this.mainImgFiles = mainImgFiles;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getBasePath() {
        return basePath;
    }

    public void setBasePath(String basePath) {
        this.basePath = basePath;
    }
}
