package dazhimen.listener;

import com.sun.xml.internal.bind.v2.runtime.reflect.opt.Const;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import util.Constant;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.File;
import java.net.URLDecoder;
import java.util.Iterator;

/**
 * Created by Administrator on 2017/4/20.
 */
public class DazhimenListener  implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        System.out.println("======dazhimenListener   init===");

        String configFilePath = getConfigFilePath();
        File configFile = new File(configFilePath);
        Document configFileDocument = null;
        SAXReader reader = new SAXReader();
        try {
            configFileDocument = reader.read(configFile);
            Element configRoot = configFileDocument.getRootElement();
            for (Iterator it = configRoot.elementIterator(); it.hasNext();) {
                Element element = (Element) it.next();
                String itemName = element.attributeValue("name");
                String itemValue = element.attributeValue("value");
                if(itemName.equals("isDeployInAliyun")){
                    Constant.isDeployInAliyun = Boolean.parseBoolean(itemValue);
                }
                if(itemName.equals("AliyunIP")){
                    Constant.AliyunIP = itemValue;
                }
                if(itemName.equals("defaultAdministrator")){
                    Constant.defaultAdministrator = itemValue;
                }
            }
        } catch (DocumentException e) {
            e.printStackTrace();
        }
    }
    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        System.out.println("======dazhimenListener   destroy===");
    }
    private String getConfigFilePath() {

        String projectPath = Thread.currentThread().getContextClassLoader()
                .getResource("/").getPath();
        int index = projectPath.indexOf("WEB-INF");
        if (index >= 0) {
            projectPath = projectPath.substring(0, index);
        }
        String frameAppPluginPath = projectPath + "config/dazhimen-config.xml";
        return URLDecoder.decode(frameAppPluginPath);
    }
}
