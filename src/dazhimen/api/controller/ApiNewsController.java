package dazhimen.api.controller;

import com.google.gson.Gson;
import dazhimen.api.bean.product.ApiCustomerCollectProductBean;
import dazhimen.api.bean.news.ApiHomePageNewsBean;
import dazhimen.api.bean.news.ApiMoreNewsBean;
import dazhimen.api.bean.news.ApiNewsContentBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import dazhimen.api.service.ApiNewsService;
import dazhimen.api.service.ApiProductService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import util.ApiUtils;
import util.Constant;
import util.web.ResponseUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created by Administrator on 2017/4/12.
 */
@Controller
@RequestMapping("/api/news")
public class ApiNewsController {
    @RequestMapping(value = "/getNewsURLById", method = RequestMethod.POST)
    public void getNewsURLById(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            checkGetNewsContentByIdPara(resq);
            ApiNewsService newsService = new ApiNewsService();
            String newsURL = newsService.getNewsURLById(resq.getParameter("nid"));
            String localIp = resq.getLocalAddr();//获取本地ip
            if(Constant.isDeployInAliyun){
                localIp = Constant.AliyunIP;
            }
            int localPort = resq.getLocalPort();//获取本地的端口
            String appName = resq.getContextPath();
            newsURL = "http://" + localIp + ":" + localPort + appName + "/" + newsURL;

            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "200");
            jsonObject.put("msg", "获取成功");
            String iscollection = newsService.getNewsIsCollection(resq.getParameter("nid"), resq.getParameter("cid"));
            jsonObject.put("iscollection", iscollection);
            jsonObject.put("contenturl", newsURL);
            ResponseUtil.writeMsg(resp, jsonObject.toString());
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }

    }
    @RequestMapping(value = "getCustomerCollectList", method = RequestMethod.POST)
    public void getCustomerCollectList(HttpServletRequest resq, HttpServletResponse resp) {
        String cid = null;
        try {
            ApiUtils.checkSignature(resq);
            cid = resq.getParameter("cid");
            if(cid == null){
                throw new ParameterCheckException("未取到参数[cid]");
            }
            if(cid.equals("")){
                throw new ParameterCheckException("参数[cid]的值为空");
            }
            ApiProductService productService = new ApiProductService();
            List<ApiCustomerCollectProductBean> productBeans = productService.getCustomerCollectProduct(cid);
            ApiNewsService newsService = new ApiNewsService();
            List<ApiHomePageNewsBean> newsBeans = newsService.getCustomerCollectNews(cid);
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "200");
            jsonObject.put("msg", "获取成功");
            Gson gson = new Gson();
            if(productBeans == null || productBeans.size()==0){
                jsonObject.put("productlist", gson.toJson(null));
            }else{
                productBeans = dealCollectProductBean(resq,productBeans);
                jsonObject.put("productlist", gson.toJson(productBeans));
            }
            if(newsBeans == null || newsBeans.size() == 0){
                jsonObject.put("newslist", gson.toJson(null));
            }else{
                newsBeans = dealApiHomePageNewsBean(resq, newsBeans);
                jsonObject.put("newslist", gson.toJson(newsBeans));
            }
            ResponseUtil.writeMsg(resp, jsonObject.toString());
        }catch (ParameterCheckException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }
    @RequestMapping(value = "cancelCollectNews", method = RequestMethod.POST)
    public void cancelCollectNews(HttpServletRequest resq, HttpServletResponse resp) {
        try {
            ApiUtils.checkSignature(resq);
            checkCollectNewsPara(resq);
            String cid = resq.getParameter("cid");
            String nid = resq.getParameter("nid");
            ApiNewsService newsService = new ApiNewsService();
            newsService.cancelCollectNews(cid, nid);
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","取消收藏成功");
            ResponseUtil.writeMsg(resp, jsonObj.toString());
        }catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }catch (ParameterCheckException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }

    @RequestMapping(value = "collectNews", method = RequestMethod.POST)
    public void collectNews(HttpServletRequest resq, HttpServletResponse resp) {
        try {
            ApiUtils.checkSignature(resq);
            checkCollectNewsPara(resq);
            String cid = resq.getParameter("cid");
            String nid = resq.getParameter("nid");
            ApiNewsService newsService = new ApiNewsService();
            boolean result = newsService.collectNews(cid, nid);

            if(result){
                JSONObject jsonObj = new JSONObject();
                jsonObj.put("code","200");
                jsonObj.put("msg","收藏成功");
                ResponseUtil.writeMsg(resp, jsonObj.toString());
            }else{
                ResponseUtil.writeFailMsgToApiResult(resp, "收藏失败");
            }
        }catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }catch (ParameterCheckException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }
    @RequestMapping(value = "searchNews", method = RequestMethod.POST)
    public void searchNews(HttpServletRequest resq, HttpServletResponse resp) {
        try {
            ApiUtils.checkSignature(resq);
            checkSearhNewsPara(resq);
            ApiNewsService newsService = new ApiNewsService();
            List<ApiMoreNewsBean> newsBeans = newsService.searchNews(resq.getParameter("keyword"));
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            String totalCount = newsService.getNewsTotalCount();
            jsonObj.put("totalCount", totalCount);
            if(newsBeans == null || newsBeans.size() == 0){
                jsonObj.put("data",new Gson().toJson(null));
            }else{
                JSONArray newsResult = dealApiMoreNewsBean(resq, newsBeans);
                jsonObj.put("data",newsResult);
            }
            ResponseUtil.writeMsg(resp, jsonObj.toString());
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }
    @RequestMapping(value = "getMoreNews", method = RequestMethod.POST)
    public void getMoreNews(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            ApiNewsService newsService = new ApiNewsService();
            List<ApiMoreNewsBean> newsBeans = newsService.getMoreNews(resq.getParameter("getcount"));
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            String totalCount = newsService.getNewsTotalCount();
            jsonObj.put("totalCount", totalCount);
            if(newsBeans == null || newsBeans.size() == 0){
                jsonObj.put("data",new Gson().toJson(null));
            }else{
                JSONArray newsResult = dealApiMoreNewsBean(resq, newsBeans);
                jsonObj.put("data",newsResult);
            }
            ResponseUtil.writeMsg(resp, jsonObj.toString());
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }

    }
    @RequestMapping(value = "getHomePageNews", method = RequestMethod.POST)
    public void getHomePageNews(HttpServletRequest resq, HttpServletResponse resp){
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
            ResponseUtil.writeMsg(resp, jsonObj.toString());
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }
    @RequestMapping(value = "getNewsContentById", method = RequestMethod.POST)
    public void getNewsContentById(HttpServletRequest resq, HttpServletResponse resp){
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
            String iscollection = newsService.getNewsIsCollection(resq.getParameter("nid"), resq.getParameter("cid"));
            jsonObject.put("iscollection", iscollection);
            jsonObject.put("data", dataObject.toString());
            ResponseUtil.writeMsg(resp, jsonObject.toString());
        }catch (ParameterCheckException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
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
    private JSONArray dealApiMoreNewsBean(HttpServletRequest resq, List<ApiMoreNewsBean> newsBeans){
        String localIp = resq.getLocalAddr();//获取本地ip
        if(Constant.isDeployInAliyun){
            localIp = Constant.AliyunIP;
        }
        int localPort = resq.getLocalPort();//获取本地的端口
        String appName = resq.getContextPath();
        List<String> createDateList = new ArrayList<String>();
        for(int i = 0; i < newsBeans.size(); i++){
            ApiMoreNewsBean newsBean = newsBeans.get(i);
            String listImgUrl = "http://" + localIp + ":" + localPort + appName + "/" + newsBean.getListimgurl();
            newsBean.setListimgurl(listImgUrl);
            if(!createDateList.contains(newsBean.getCreatedate())){
                createDateList.add(newsBean.getCreatedate());
            }
        }
        JSONArray jsonArray = new JSONArray();
        for(int i = 0; i < createDateList.size(); i++){
            String createDate_i = createDateList.get(i);
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("createdate", createDate_i);
            List<ApiHomePageNewsBean> homePageNewsBeans = new ArrayList<ApiHomePageNewsBean>();
            for(int j = 0; j < newsBeans.size(); j++){
                ApiMoreNewsBean moreNewsBean = newsBeans.get(j);
                String newsBeanCreateDate = moreNewsBean.getCreatedate();
                if(newsBeanCreateDate.equals(createDate_i)){
                    ApiHomePageNewsBean homePageNewsBean = new ApiHomePageNewsBean();
                    homePageNewsBean.setNid(moreNewsBean.getNid());
                    homePageNewsBean.setListimgurl(moreNewsBean.getListimgurl());
                    homePageNewsBean.setTitle(moreNewsBean.getTitle());
                    homePageNewsBeans.add(homePageNewsBean);
                }
            }
            jsonObject.put("newslist", new Gson().toJson(homePageNewsBeans));
            jsonArray.add(jsonObject);
        }
        return jsonArray;
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
    private void checkSearhNewsPara(HttpServletRequest resq) throws ParameterCheckException {
        String keyword = resq.getParameter("keyword");
        if(keyword == null){
            throw new ParameterCheckException("未取到参数[keyword]");
        }
        if(keyword.equals("")){
            throw new ParameterCheckException("参数[keyword]的值为空");
        }
    }
    private void checkCollectNewsPara(HttpServletRequest resq) throws ParameterCheckException {
        String cid = resq.getParameter("cid");
        if(cid == null){
            throw new ParameterCheckException("未取到参数[cid]");
        }
        if(cid.equals("")){
            throw new ParameterCheckException("参数[cid]的值为空");
        }
        String nid = resq.getParameter("nid");
        if(nid == null){
            throw new ParameterCheckException("未取到参数[nid]");
        }
        if(nid.equals("")){
            throw new ParameterCheckException("参数[nid]的值为空");
        }
    }
    private List<ApiCustomerCollectProductBean> dealCollectProductBean(HttpServletRequest resq,
                                                                       List<ApiCustomerCollectProductBean> productBeans){
        String localIp = resq.getLocalAddr();//获取本地ip
        if(Constant.isDeployInAliyun){
            localIp = Constant.AliyunIP;
        }
        int localPort = resq.getLocalPort();//获取本地的端口
        String appName = resq.getContextPath();
        for(int i = 0; i < productBeans.size(); i++){
            ApiCustomerCollectProductBean productBean = productBeans.get(i);

            String listImgUrl = "http://" + localIp + ":" + localPort + appName + "/" + productBean.getListimgurl();
            productBean.setListimgurl(listImgUrl);
        }
        return productBeans;
    }
}
