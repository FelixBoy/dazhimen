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
import util.Constant;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

/**
 * Created by Administrator on 2017/4/12.
 */
@Controller
@RequestMapping("/news")
public class NewsController {
    @RequestMapping("/fwdManageNewsPage")
    public String fwdManageNewsPage(){
        return "/news/manageNews";
    }
    @RequestMapping("/queryAllNews")
    public void queryAllNews(HttpServletRequest resq, HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try{
            String page = resq.getParameter("page");
            String rows = resq.getParameter("rows");
            String queryByParamFlag = resq.getParameter("queryByParamFlag");
            String result = null;
            NewsService newsService = new NewsService();
            if(queryByParamFlag == null || queryByParamFlag.equals("")){
                result = newsService.queryAllNews(page, rows);
            }else{
//                String pidCondition = resq.getParameter("pidCondition");
//                String pnameCondition = resq.getParameter("pnameCondition");
//                String typeCondition = resq.getParameter("typeCondition");
//                String starttimeCondition = resq.getParameter("starttimeCondition");
//                String endtimeCondition = resq.getParameter("endtimeCondition");
//                String statusCondition = resq.getParameter("statusCondition");
//                QueryProductParamBean paramBean = new QueryProductParamBean();
//                paramBean.setPidCondition(pidCondition);
//                paramBean.setPnameCondition(pnameCondition);
//                paramBean.setTypeCondition(typeCondition);
//                paramBean.setStatusCondition(statusCondition);
//                paramBean.setStarttimeCondition(starttimeCondition);
//                paramBean.setEndtimeCondition(endtimeCondition);
//                result = productService.queryAllProductsByParams(page, rows, paramBean);
            }
            resp.getWriter().write(result);
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询所有产品信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }

    }
    @RequestMapping("/fwdModifyNewsStatusPage")
    public String fwdModifyNewsStatusPage(HttpServletRequest resq){
        resq.setAttribute("nid", resq.getParameter("nid"));
        resq.setAttribute("status" ,resq.getParameter("status"));
        return "/news/modifyNewsStatus";
    }
    @RequestMapping("/saveModifyNewsStatus")
    public void saveModifyNewsStatus(HttpServletRequest resq,HttpServletResponse resp) {
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            String nid = resq.getParameter("nid");
            String status = resq.getParameter("status");
            NewsService newsService = new NewsService();
            newsService.saveModifyNewsStatus(nid, status);
            resp.getWriter().write("修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，修改新闻状态失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping(value="fwdAddNewsPage")
    public String fwdAddNewsPage(){
        return "/news/addNews";
    }
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
