package dazhimen.api.bean;

/**
 * Created by Administrator on 2017/4/8.
 */
public class ApiGlobalSearchBean {
    private String id = null;
    private String name = null;
    private String type = null;
    private String dealNull(String value){
        if(value == null){
            return "";
        }else{
            return value;
        }
    }

    @Override
    public String toString() {
        return "ApiGlobalSearchBean{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", type='" + type + '\'' +
                '}';
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = dealNull(id);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = dealNull(name);
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = dealNull(type);
    }
}
