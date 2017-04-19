package dazhimen.bg.bean.permission;

import java.util.ArrayList;

/**
 * Created by Administrator on 2017/4/19.
 */
public class ModifyRoleBean {
    private String rid = null;
    private String name = null;
    private String introduction = null;
    private ArrayList<String> permissionList = null;

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public ArrayList<String> getPermissionList() {
        return permissionList;
    }

    public void setPermissionList(ArrayList<String> permissionList) {
        this.permissionList = permissionList;
    }
}
