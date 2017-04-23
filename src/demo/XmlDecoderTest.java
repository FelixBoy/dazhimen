package demo;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import java.util.Iterator;

/**
 * Created by Administrator on 2017/4/23.
 */
public class XmlDecoderTest {
    public static void main(String[] args){
        String str = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n" +
                "<returnsms>\n" +
                "    <returnstatus>Success</returnstatus>\n" +
                "    <message>操作成功</message>\n" +
                "    <remainpoint>111209</remainpoint>\n" +
                "    <taskID>1704233218227421</taskID>\n" +
                "    <successCounts>1</successCounts>\n" +
                "</returnsms>";
        SAXReader saxReader = new SAXReader();
        try {
            Document xmlDocument = DocumentHelper.parseText(str);
            Element configRoot = xmlDocument.getRootElement();
            for (Iterator it = configRoot.elementIterator(); it.hasNext();) {
                Element element = (Element) it.next();
                System.out.println(element.getName());
                System.out.println(element.getData());
            }
        } catch (DocumentException e) {
            e.printStackTrace();
        }
    }
}
