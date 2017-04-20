package util;
import dazhimen.bg.bean.login.LoginUserBean;

import java.security.MessageDigest;
import java.util.HashMap;

/**
 * Created by Administrator on 2017/3/16.
 */
public class GlobalUtils {
    public static String hex_md5(String plainText) {
        String str_MD5 = plainText;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(plainText.getBytes());
            byte b[] = md.digest();

            int i;

            StringBuffer buf = new StringBuffer("");
            for (int offset = 0; offset < b.length; offset++) {
                i = b[offset];
                if (i < 0)
                    i += 256;
                if (i < 16)
                    buf.append("0");
                buf.append(Integer.toHexString(i));
            }
            str_MD5 = buf.toString();
        } catch (Exception e) {
           e.printStackTrace();
        }
        return str_MD5;
    }

    /**
     *  检测用户是否拥有某个权限
     * @param permission 要判定的权限
     * @param userBean  要判定权限的用户
     * @return 当前用户是否拥有改权限，true拥有，false没有
     */
    public static boolean checkUserPermission(String permission, LoginUserBean userBean){
        HashMap<String, String> userPermissionMap = userBean.getUserPermissionMap();
        if(userBean.getLoginname().equals(Constant.defaultAdministrator) || userPermissionMap.containsKey(permission)){
            return true;
        }
        return false;
    }
}
