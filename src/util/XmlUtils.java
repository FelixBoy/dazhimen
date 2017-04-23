package util;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/23.
 */
public class XmlUtils {
    public static Map<String, String> convertXMLStringToMap(String xml) throws DocumentException {
        SAXReader saxReader = new SAXReader();
        Map<String, String> resultMap = new HashMap<String, String>();
        Document xmlDocument = DocumentHelper.parseText(xml);
        Element configRoot = xmlDocument.getRootElement();
        for (Iterator it = configRoot.elementIterator(); it.hasNext();) {
            Element element = (Element) it.next();
            resultMap.put(element.getName(), element.getData().toString());
        }
        return resultMap;
    }
}
