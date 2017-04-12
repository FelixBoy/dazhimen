package dazhimen.bg.controller;

import com.google.gson.JsonObject;
import dazhimen.bg.bean.AddNewsBean;
import dazhimen.bg.bean.NewsContentBean;
import dazhimen.bg.exception.BgException;
import dazhimen.bg.service.NewsService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

/**
 * Created by Administrator on 2017/4/12.
 */
@Controller
@RequestMapping("/news")
public class NewsController {
    @RequestMapping(value="/saveAddNews", method = RequestMethod.POST)
    public ModelAndView saveAddNews(HttpServletRequest resq, HttpServletResponse resp){
        AddNewsBean addNewsBean = getAddNewsBean(resq);
        String basePath = resq.getSession().getServletContext().getRealPath("/");
        ModelAndView mav = new ModelAndView("fileUploadAfterAction");
        NewsService newsService = new NewsService();
        try {
            newsService.saveAddNews(addNewsBean, basePath);
        } catch (BgException e) {
            e.printStackTrace();
            JsonObject jsonObj = new JsonObject();
            jsonObj.addProperty("code", "400");
            jsonObj.addProperty("msg",e.getMessage());
            mav.addObject("parameters", jsonObj.toString());
            return mav;
        }
        JsonObject jsonObj = new JsonObject();
        jsonObj.addProperty("code", "200");
        jsonObj.addProperty("msg","新闻上传成功");
        mav.addObject("parameters", jsonObj.toString());
        return mav;
    }
    private AddNewsBean getAddNewsBean(HttpServletRequest resq){
        AddNewsBean addNewsBean = new AddNewsBean();
        MultipartRequest multipartRequest = (MultipartRequest)resq;
        String title = resq.getParameter("newstitle");
        CommonsMultipartFile listImgFile = (CommonsMultipartFile)multipartRequest.getFile("newslistimg");
        CommonsMultipartFile mainImgFile = (CommonsMultipartFile)multipartRequest.getFile("newsmainimg");

        addNewsBean.setTitle(title);
        addNewsBean.setMainImgFile(mainImgFile);
        addNewsBean.setListImgFile(listImgFile);

        List<NewsContentBean> newContentBeans = new ArrayList<NewsContentBean>();
        Enumeration<String> names = resq.getParameterNames();
        while(names.hasMoreElements()) {

            String parameterName = names.nextElement();
            if(parameterName.startsWith("type_")){
                String contentId = parameterName.substring(5);
                String typeValue = resq.getParameter(parameterName);
                String sortvalue = resq.getParameter("sort_" + contentId);
                NewsContentBean contentBean = new NewsContentBean();
                contentBean.setContenttype(typeValue);
                contentBean.setContentsort(sortvalue);
                if(typeValue.equals("1")){
                    String subtitle = resq.getParameter(contentId);
                    contentBean.setContentsubtitle(subtitle);
                }else if(typeValue.equals("2")){
                    CommonsMultipartFile file = (CommonsMultipartFile) multipartRequest.getFile(contentId);
                    contentBean.setContentfile(file);
                }else{
                    String text = resq.getParameter(contentId);
                    contentBean.setContenttext(text);
                }
                newContentBeans.add(contentBean);
            }
        }
        addNewsBean.setContentBeans(newContentBeans);
        return addNewsBean;
    }
}
