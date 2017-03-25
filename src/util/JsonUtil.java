package util;

/**
 * Created by Administrator on 2017/3/25.
 */
public class JsonUtil {
    public String encode(String jsonString)  {
        jsonString = jsonString.replaceAll("\r", "&#xD;");
        jsonString = jsonString.replaceAll("\n", "&#xA;");
        jsonString = jsonString.replaceAll("\t", "&#x9;");
        jsonString = jsonString.replaceAll("'",  "&apos;");
        jsonString = jsonString.replaceAll("\"", "&quot;");
        jsonString = jsonString.replaceAll("\b", "&back;");
        jsonString = jsonString.replaceAll("\f", "&page;");
        jsonString = jsonString.replaceAll("\\\\", "&slash;");
        return jsonString;
    }
}
