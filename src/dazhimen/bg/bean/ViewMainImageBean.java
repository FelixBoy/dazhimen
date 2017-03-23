package dazhimen.bg.bean;

/**
 * Created by Administrator on 2017/3/23.
 */
public class ViewMainImageBean {
    private String imageId = null;
    private String mainImage = null;

    @Override
    public String toString() {
        return "ViewMainImageBean{" +
                "imageId='" + imageId + '\'' +
                ", mainImage='" + mainImage + '\'' +
                '}';
    }

    public String getImageId() {
        return imageId;
    }

    public void setImageId(String imageId) {
        this.imageId = imageId;
    }

    public String getMainImage() {
        return mainImage;
    }

    public void setMainImage(String mainImage) {
        this.mainImage = mainImage;
    }
}
