package demo;

import dazhimen.bg.bean.news.GenNewsContentBean;
import dazhimen.bg.bean.news.NewsContentBean;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import util.Constant;

import java.util.List;

/**
 * Created by Administrator on 2017/4/21.
 */
public class GenNewHtmlTest {
    public static void main(String[] args){
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            String title = sqlSession.selectOne("dazhimen.bg.bean.News.getNewsInforById" ,"n170412007");
            if(title == null || title.equals("")){
                throw new Exception("获取title出现异常");
            }
            List<GenNewsContentBean> contentBeans = sqlSession.selectList("dazhimen.bg.bean.News.getNewsContentById", "n170412007");
            System.out.println(genNewsHtml(title,contentBeans));
        }catch (Exception e){

        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public static String genNewsHtml(String tilte, List<GenNewsContentBean> contentBeans){
        StringBuffer newsHtmlBF = new StringBuffer();
        newsHtmlBF.append(genHtmlTagBegin());
        newsHtmlBF.append(genHeaderTag(tilte));
        newsHtmlBF.append(genBodyTagBegin());
        newsHtmlBF.append(genNewsTitle(tilte));
        newsHtmlBF.append(genNewsContent(contentBeans));
        newsHtmlBF.append(genBodyTagEnd());
        return newsHtmlBF.toString();
    }
    private static String genHtmlTagBegin(){
        StringBuffer htmlBF = new StringBuffer();
        htmlBF.append("<!DOCTYPE html>" + System.getProperty("line.separator"));
        htmlBF.append("<html lang=\"zh\">"  + System.getProperty("line.separator"));
        return htmlBF.toString();
    }
    private static String genHeaderTag(String pageTitle){
        StringBuffer htmlHeaderBF = new StringBuffer();
        htmlHeaderBF.append("   <head>"  + System.getProperty("line.separator"));
        htmlHeaderBF.append("       <meta charset=\"UTF-8\">" + System.getProperty("line.separator"));
        htmlHeaderBF.append("       <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no\">" + System.getProperty("line.separator"));
        htmlHeaderBF.append("       <title>" + pageTitle + "</title>" + System.getProperty("line.separator"));
        htmlHeaderBF.append("       <style type=\"text/css\">" + System.getProperty("line.separator"));
        htmlHeaderBF.append("           * {margin: 0; padding: 0;}" + System.getProperty("line.separator"));
        htmlHeaderBF.append("           .top {padding: 10px 15px; font-size: 25px;}" + System.getProperty("line.separator"));
        htmlHeaderBF.append("           .content {padding: 10px 25px;}" + System.getProperty("line.separator"));
        htmlHeaderBF.append("           .content .subtitle {padding-top:10px;padding-bottom:10px; padding-left:20px; font-size: 20px;}" + System.getProperty("line.separator"));
        htmlHeaderBF.append("           .content img {width: 100%;padding-top: 10px; padding-bottom:10px;}" + System.getProperty("line.separator"));
        htmlHeaderBF.append("           .content .main {color: #575757; text-indent: 2em}" + System.getProperty("line.separator"));
        htmlHeaderBF.append("           @media screen and (max-width: 350px) {" + System.getProperty("line.separator"));
        htmlHeaderBF.append("           .top {padding: 10px 20px; font-size: 25px;}" + System.getProperty("line.separator"));
        htmlHeaderBF.append("           .top .title {font-size: 12px;}" + System.getProperty("line.separator"));
        htmlHeaderBF.append("           }" + System.getProperty("line.separator"));
        htmlHeaderBF.append("       </style>" + System.getProperty("line.separator"));
        htmlHeaderBF.append("   </head>" + System.getProperty("line.separator"));
        return htmlHeaderBF.toString();
    }
    private static String genBodyTagBegin(){
        StringBuffer bodyBF = new StringBuffer();
        bodyBF.append(" <body>" + System.getProperty("line.separator"));
        bodyBF.append("     <div>" + System.getProperty("line.separator"));
        return bodyBF.toString();
    }
    private static String genNewsTitle(String newsTitle){
        StringBuffer newTitleBF = new StringBuffer();
        newTitleBF.append("     <div class=\"top\">" + System.getProperty("line.separator"));
        newTitleBF.append("         <p><b>" + newsTitle + "</b></p>" + System.getProperty("line.separator"));
		newTitleBF.append("     </div>" + System.getProperty("line.separator"));
		return newTitleBF.toString();
    }
    private static String genNewsContent(List<GenNewsContentBean> newsContentBeans){
        StringBuffer newsContentBF = new StringBuffer();
        newsContentBF.append("      <div class=\"content\">" + System.getProperty("line.separator"));
        for(int i = 0 ; i < newsContentBeans.size(); i++){
            GenNewsContentBean contentBean = newsContentBeans.get(i);
            String contentType = contentBean.getContenttype();
            if(contentType.equals(Constant.NewsContentType_SubTitle)){
                newsContentBF.append("          <p class=\"subtitle\"><b>" + contentBean.getContentvalue() + "</b></p>" + System.getProperty("line.separator"));
            }
            if(contentType.equals(Constant.NewsContentType_Img)){
                String imgUrl = contentBean.getContentvalue();
                imgUrl = imgUrl.substring(imgUrl.lastIndexOf("/") + 1);
                newsContentBF.append("          <img src=\"" + imgUrl + "\"/>" + System.getProperty("line.separator"));
            }
            if(contentType.equals(Constant.NewsContentType_Text)){
                newsContentBF.append("          <div class=\"main\">" + contentBean.getContentvalue() + "</div>" + System.getProperty("line.separator"));
            }
        }
        newsContentBF.append("      </div>" + System.getProperty("line.separator"));
        return newsContentBF.toString();
    }
    private static String genBodyTagEnd(){
        StringBuffer bodyBF = new StringBuffer();
        bodyBF.append("     </div>" + System.getProperty("line.separator"));
        bodyBF.append(" </body>" + System.getProperty("line.separator"));
        return bodyBF.toString();
    }
    private static String genHtmlTagEnd(){
        StringBuffer htmlBF = new StringBuffer();
        htmlBF.append("</html>"  + System.getProperty("line.separator"));
        return htmlBF.toString();
    }
}
