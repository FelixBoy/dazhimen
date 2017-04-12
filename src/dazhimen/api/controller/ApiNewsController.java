package dazhimen.api.controller;

import com.google.gson.Gson;
import dazhimen.api.bean.ApiHomePageNewsBean;
import dazhimen.api.bean.ApiNewsContentBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import dazhimen.api.service.ApiNewsService;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import util.ApiUtils;
import util.Constant;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

/**
 * Created by Administrator on 2017/4/12.
 */
@Controller
@RequestMapping("/api/news")
public class ApiNewsController {
    @RequestMapping(value = "getHomePageNews", method = RequestMethod.POST)
    public void getHomePageNews(HttpServletRequest resq, HttpServletResponse resp){
        try {
            if(resq.getCharacterEncoding() == null)
                resq.setCharacterEncoding(Constant.CharSet);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            ApiUtils.checkSignature(resq);
            ApiNewsService newsService = new ApiNewsService();
            List<ApiHomePageNewsBean> newsBeans = newsService.getHomePageNews(resq.getParameter("getcount"));
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            if(newsBeans == null || newsBeans.size() == 0){
                jsonObj.put("data",new Gson().toJson(null));
            }else{
                newsBeans = dealApiHomePageNewsBean(resq, newsBeans);
                jsonObj.put("data",new Gson().toJson(newsBeans));
            }
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        } catch (ApiException e) {
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping(value = "getNewsContentById", method = RequestMethod.POST)
    public void getNewsContentById(HttpServletRequest resq, HttpServletResponse resp){
        try {
            if(resq.getCharacterEncoding() == null)
                resq.setCharacterEncoding(Constant.CharSet);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            ApiUtils.checkSignature(resq);
            checkGetNewsContentByIdPara(resq);
            ApiNewsService newsService = new ApiNewsService();
            List<ApiNewsContentBean> contentBeans = newsService.getNewsContentById(resq.getParameter("nid"));
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "200");
            jsonObject.put("msg", "获取成功");

            JSONObject dataObject = new JSONObject();
            ApiHomePageNewsBean newsBean = newsService.getNewsInforById(resq.getParameter("nid"));
            dataObject.put("nid", newsBean.getNid());
            dataObject.put("title", newsBean.getTitle());
            if(contentBeans == null || contentBeans.size()==0){
                dataObject.put("contentlist", new Gson().toJson(null));
            }else{
                contentBeans = dealNewsContentBean(resq,contentBeans);
                dataObject.put("contentlist", new Gson().toJson(contentBeans));
            }
            jsonObject.put("data", dataObject.toString());
            try {
                resp.getWriter().write(jsonObject.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }catch (ParameterCheckException e){
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        } catch (ApiException e) {
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    private List<ApiHomePageNewsBean> dealApiHomePageNewsBean(HttpServletRequest resq, List<ApiHomePageNewsBean> newsBeans){
            String localIp = resq.getLocalAddr();//获取本地ip
            if(Constant.isDeployInAliyun){
                localIp = Constant.AliyunIP;
            }
            int localPort = resq.getLocalPort();//获取本地的端口
            String appName = resq.getContextPath();
            for(int i = 0; i < newsBeans.size(); i++){
                ApiHomePageNewsBean newsBean = newsBeans.get(i);

                String listImgUrl = "http://" + localIp + ":" + localPort + appName + "/" + newsBean.getListimgurl();
                newsBean.setListimgurl(listImgUrl);
            }
            return newsBeans;
    }
    private List<ApiNewsContentBean> dealNewsContentBean(HttpServletRequest resq, List<ApiNewsContentBean> contentBeans){
        String localIp = resq.getLocalAddr();//获取本地ip
        if(Constant.isDeployInAliyun){
            localIp = Constant.AliyunIP;
        }
        int localPort = resq.getLocalPort();//获取本地的端口
        String appName = resq.getContextPath();
        for(int i = 0; i < contentBeans.size(); i++){
            ApiNewsContentBean contentBean = contentBeans.get(i);
            if(contentBean.getContenttype().equals("2")){
                String imgurl = "http://" + localIp + ":" + localPort + appName + "/" + contentBean.getContentvalue();
                contentBean.setContentvalue(imgurl);
            }
        }
        return contentBeans;
    }
    private void checkGetNewsContentByIdPara(HttpServletRequest resq) throws ParameterCheckException {
        String nid = resq.getParameter("nid");
        if(nid == null){
            throw new ParameterCheckException("未取到参数[nid]");
        }
        if(nid.equals("")){
            throw new ParameterCheckException("参数[nid]的值为空");
        }
    }
}
