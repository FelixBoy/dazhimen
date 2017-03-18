package util;
import java.security.MessageDigest;
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
}
