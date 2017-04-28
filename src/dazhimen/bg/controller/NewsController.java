package dazhimen.bg.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dazhimen.bg.bean.news.*;
import dazhimen.bg.exception.BgException;
import dazhimen.bg.service.NewsService;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import util.Constant;
import util.web.ResponseUtil;

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
    @RequestMapping("/fwdManageNewsPage.do")
    public String fwdManageNewsPage(){
        return "/news/manageNews";
    }
    @RequestMapping("/queryAllNews.do")
    public void queryAllNews(HttpServletRequest resq, HttpServletResponse resp){
        try{
            String page = resq.getParameter("page");
            String rows = resq.getParameter("rows");
            String queryByParamFlag = resq.getParameter("queryByParamFlag");
            String result = null;
            NewsService newsService = new NewsService();
            if(queryByParamFlag == null || queryByParamFlag.equals("")){
                result = newsService.queryAllNews(page, rows);
            }else{
                String nidCondition = resq.getParameter("nidCondition");
                String ntitleCondition = resq.getParameter("ntitleCondition");
                String starttimeCondition = resq.getParameter("starttimeCondition");
                String endtimeCondition = resq.getParameter("endtimeCondition");
                String statusCondition = resq.getParameter("statusCondition");
                QueryNewsParamBean paramBean = new QueryNewsParamBean();
                paramBean.setNidCondition(nidCondition);
                paramBean.setNtitleCondition(ntitleCondition);
                paramBean.setStatusCondition(statusCondition);
                paramBean.setStarttimeCondition(starttimeCondition);
                paramBean.setEndtimeCondition(endtimeCondition);
                result = newsService.queryAllNewsByParams(page, rows, paramBean);
            }
            ResponseUtil.writeMsg(resp, result);
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询所有新闻信息失败");
        }

    }
    @RequestMapping("/fwdModifyNewsStatusPage.do")
    public String fwdModifyNewsStatusPage(HttpServletRequest resq){
        resq.setAttribute("nid", resq.getParameter("nid"));
        resq.setAttribute("status" ,resq.getParameter("status"));
        return "/news/modifyNewsStatus";
    }
    @RequestMapping("/saveModifyNewsStatus.do")
    public void saveModifyNewsStatus(HttpServletRequest resq,HttpServletResponse resp) {
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            String nid = resq.getParameter("nid");
            String status = resq.getParameter("status");
            NewsService newsService = new NewsService();
            newsService.saveModifyNewsStatus(nid, status);
            ResponseUtil.writeMsg(resp, "修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，修改新闻状态失败");
        }
    }
    @RequestMapping(value="fwdAddNewsPage.do")
    public String fwdAddNewsPage(){
        return "/news/addNews";
    }
    @RequestMapping(value="/saveAddNews.do", method = RequestMethod.POST)
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

    /**
     * 删除新闻
     * @param resq
     * @param resp
     */
    @RequestMapping("/saveDeleteNews.do")
    public void saveDeleteNews(HttpServletRequest resq, HttpServletResponse resp){
        NewsService newsService = new NewsService();
        try {
            newsService.saveDeleteNews(resq);
            ResponseUtil.writeMsg(resp, "删除成功");
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }

    /**
     * 转向查看新闻页面
     * @param resq
     * @return
     */
    @RequestMapping("/fwdViewNewsPage.do")
    public String fwdViewNewsPage(HttpServletRequest resq){
        resq.setAttribute("nid", resq.getParameter("nid"));
        return "/news/viewNews";
    }

    /**
     * 获取新闻的数据，用于查看
     * @param resq
     * @param resp
     */
    @RequestMapping("/getViewNewsData.do")
    public void getViewNewsData(HttpServletRequest resq, HttpServletResponse resp){
        String nid = resq.getParameter("nid");
        NewsService newsService = new NewsService();
        try {
            ViewNewsBean newsBean = newsService.getViewNewsData(nid);
            JSONObject jsonObject =  new JSONObject();
            jsonObject.put("listimgurl", resq.getContextPath() + "/" +newsBean.getListimgurl());
            jsonObject.put("mainimgurl", resq.getContextPath() + "/" +newsBean.getMainimgurl());
            jsonObject.put("contenthtml", newsBean.getNewscontenthtml());
            ResponseUtil.writeMsg(resp, jsonObject.toString());
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }

    /**
     * 转向修改新闻页面
     * @param resq
     * @return
     */
    @RequestMapping("/fwdModifyNewsTitlePage.do")
    public String fwdModifyNewsPage(HttpServletRequest resq){
        resq.setAttribute("nid", resq.getParameter("nid"));
        return "/news/modifyNewsTitle";
    }

    /**
     * 获取修改新闻页面的数据
     * @param resq
     * @param resp
     */
    @RequestMapping("/getModifyNewsTitleData.do")
    public void getModifyNewsTitleData(HttpServletRequest resq, HttpServletResponse resp){
        String nid = resq.getParameter("nid");
        NewsService newsService = new NewsService();
        try {
            ModifyNewsDataBean newsBean = newsService.getModifyNewsTitleData(nid);
            newsBean.setListimgurl(resq.getContextPath() + "/" + newsBean.getListimgurl());
            newsBean.setMainimgurl(resq.getContextPath() + "/" + newsBean.getMainimgurl());
            ResponseUtil.writeMsg(resp, new Gson().toJson(newsBean));
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }
    @RequestMapping("/saveModifyNewsTitle.do")
    public void saveModifyNewsTitle(HttpServletRequest resq, HttpServletResponse resp){
        String newsTitle = resq.getParameter("newstitle");
        String nid = resq.getParameter("nid");
        NewsService newsService = new NewsService();
        try {
            String basePath = resq.getSession().getServletContext().getRealPath("/");
            newsService.saveModifyNewsTitle(nid, newsTitle, basePath);
            ResponseUtil.writeMsg(resp, "修改标题成功");
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }
    /**
     * 转向修改新闻列表图片页面
     * @param nid 新闻id
     * @return
     */
    @RequestMapping("/fwdModifyNewsListImgPage.do")
    public ModelAndView fwdModifyNewsListImgPage(@RequestParam("nid") String nid){
        ModelAndView mav = new ModelAndView("/news/modifyNewsListImg");
        mav.addObject("nid", nid);
        return mav;
    }

    /**
     * 保存修改新闻列表图片
     * @param resq
     * @return
     */
    @RequestMapping("/saveModifyNewsListImg.do")
    public ModelAndView saveModifyNewsListImg(HttpServletRequest resq){
        NewsService newsService = new NewsService();
        ModelAndView mav = new ModelAndView("fileUploadAfterAction");
        try {
            String nid = resq.getParameter("nid");
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) resq;
            CommonsMultipartFile listImgFile = (CommonsMultipartFile) multipartRequest.getFile("listimgmodify");
            String basePath = resq.getSession().getServletContext().getRealPath("/");
            newsService.saveModifyNewsListImg(nid,listImgFile,basePath);
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
        jsonObj.addProperty("msg","修改新闻列表图片成功");
        mav.addObject("parameters", jsonObj.toString());
        return mav;
    }

    /**
     * 转向修改新闻主图页面
     * @param nid 新闻id
     * @return
     */
    @RequestMapping("/fwdModifyNewsMainImgPage.do")
    public ModelAndView fwdModifyNewsMainImgPage(@RequestParam("nid") String nid){
        ModelAndView mav = new ModelAndView("/news/modifyNewsMainImg");
        mav.addObject("nid", nid);
        return mav;
    }
    /**
     * 保存修改新闻主图
     * @param resq
     * @return
     */
    @RequestMapping("/saveModifyNewsMainImg.do")
    public ModelAndView saveModifyNewsMainImg(HttpServletRequest resq){
        NewsService newsService = new NewsService();
        ModelAndView mav = new ModelAndView("fileUploadAfterAction");
        try {
            String nid = resq.getParameter("nid");
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) resq;
            CommonsMultipartFile mainImgFile = (CommonsMultipartFile) multipartRequest.getFile("mainimgmodify");
            String basePath = resq.getSession().getServletContext().getRealPath("/");
            newsService.saveModifyNewsMainImg(nid,mainImgFile,basePath);
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
        jsonObj.addProperty("msg","修改新闻主图成功");
        mav.addObject("parameters", jsonObj.toString());
        return mav;
    }
    /**
     * 转向修改新闻内容页面
     * @param resq
     * @return
     */
    @RequestMapping("/fwdModifyNewsContentPage.do")
    public String fwdModifyNewsContentPage(HttpServletRequest resq){
        resq.setAttribute("nid", resq.getParameter("nid"));
        return "/news/modifyNewsContent";
    }
    private List<ViewNewsContentBean> dealModifynewsDataBean(List<ViewNewsContentBean> newsContentBeans, HttpServletRequest resq){

        if(newsContentBeans != null && newsContentBeans.size() > 0){
            for(int i = 0; i < newsContentBeans.size(); i++){
                ViewNewsContentBean newsContentBean = newsContentBeans.get(i);
                if(newsContentBean.getContenttype().equals("2")){
                    newsContentBean.setContentvalue(resq.getContextPath() + "/" + newsContentBean.getContentvalue());
                }
            }
        }
        return newsContentBeans;
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
