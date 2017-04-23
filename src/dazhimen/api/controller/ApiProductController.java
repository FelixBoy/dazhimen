package dazhimen.api.controller;

import com.google.gson.Gson;
import dazhimen.api.bean.product.ApiListViewCourseBean;
import dazhimen.api.bean.product.ApiProductBean;
import dazhimen.api.bean.product.ApiSpecifyProductBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import dazhimen.api.service.ApiProductService;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import util.ApiUtils;
import util.Constant;
import util.web.ResponseUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2017/3/24.
 */
@Controller
@RequestMapping("/api/product/")
public class ApiProductController {

    @RequestMapping(value = "/updateCourseViewCount",method = RequestMethod.POST)
    public void updateCourseViewCount(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            checkUpdateCourseViewCountPara(resq);
            ApiProductService productService = new ApiProductService();
            productService.updateCourseViewCount(resq.getParameter("courseid"), resq.getParameter("cid"));
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","更新成功");
            ResponseUtil.writeMsg(resp, jsonObj.toString());
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }

    }
    @RequestMapping(value = "/getHomePageSkillPack",method = RequestMethod.POST)
    public void getHomePageSkillPack(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            ApiProductService productService = new ApiProductService();
            List<ApiProductBean> productBeans = productService.getHomePageSkillPack(resq.getParameter("getcount"));
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            if(productBeans == null || productBeans.size() == 0){
                jsonObj.put("data",new Gson().toJson(null));
            }else{
                productBeans = dealApiHomePageProductBean(resq, productBeans);
                jsonObj.put("data",new Gson().toJson(productBeans));
            }
            ResponseUtil.writeMsg(resp, jsonObj.toString());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }catch (ParameterCheckException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }
    @RequestMapping(value = "/getHomePageExperiencePack",method = RequestMethod.POST)
    public void getHomePageExperiencePack(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            ApiProductService productService = new ApiProductService();
            List<ApiProductBean> productBeans = productService.getHomePageExperiencePack(resq.getParameter("getcount"));
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            if(productBeans == null || productBeans.size() == 0){
                jsonObj.put("data",new Gson().toJson(null));
            }else{
                productBeans = dealApiHomePageProductBean(resq, productBeans);
                jsonObj.put("data",new Gson().toJson(productBeans));
            }
            ResponseUtil.writeMsg(resp, jsonObj.toString());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }catch (ParameterCheckException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }
    @RequestMapping(value = "/getMoreSkillPack",method = RequestMethod.POST)
    public void getMoreSkillPack(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            ApiProductService productService = new ApiProductService();
            List<ApiProductBean> productBeans = productService.getMoreSkillPack(resq.getParameter("getcount"));
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            String totalCount = productService.getProductTotalCountByType(Constant.SkillPack);
            jsonObj.put("totalCount", Integer.parseInt(totalCount));
            if(productBeans == null || productBeans.size() == 0){
                jsonObj.put("data",new Gson().toJson(null));
            }else{
                productBeans = dealApiHomePageProductBean(resq, productBeans);
                jsonObj.put("data",new Gson().toJson(productBeans));
            }
            ResponseUtil.writeMsg(resp, jsonObj.toString());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }catch (ParameterCheckException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }
    @RequestMapping(value = "/getExperienceSkillPack",method = RequestMethod.POST)
    public void getExperienceSkillPack(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            ApiProductService productService = new ApiProductService();
            List<ApiProductBean> productBeans = productService.getMoreExperiencePack(resq.getParameter("getcount"));
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            String totalCount = productService.getProductTotalCountByType(Constant.ExperiencePack);
            jsonObj.put("totalCount", Integer.parseInt(totalCount));
            if(productBeans == null || productBeans.size() == 0){
                jsonObj.put("data",new Gson().toJson(null));
            }else{
                productBeans = dealApiHomePageProductBean(resq, productBeans);
                jsonObj.put("data",new Gson().toJson(productBeans));
            }
            ResponseUtil.writeMsg(resp, jsonObj.toString());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }catch (ParameterCheckException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }
    @RequestMapping(value = "/searchSkillPack",method = RequestMethod.POST)
    public void searchSkillPack(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            checkSearhProductPara(resq);
            ApiProductService productService = new ApiProductService();
            List<ApiProductBean> productBeans = productService.searchSkillPack(resq.getParameter("keyword"));
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            String totalCount = productService.getProductTotalCountByType(Constant.SkillPack);
            jsonObj.put("totalCount", Integer.parseInt(totalCount));
            if(productBeans == null || productBeans.size() == 0){
                jsonObj.put("data",new Gson().toJson(null));
            }else{
                productBeans = dealApiHomePageProductBean(resq, productBeans);
                jsonObj.put("data",new Gson().toJson(productBeans));
            }
            ResponseUtil.writeMsg(resp, jsonObj.toString());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }catch (ParameterCheckException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }
    @RequestMapping(value = "/searchExperiencePack",method = RequestMethod.POST)
    public void searchExperiencePack(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            checkSearhProductPara(resq);
            ApiProductService productService = new ApiProductService();
            List<ApiProductBean> productBeans = productService.searchExperiencePack(resq.getParameter("keyword"));
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            String totalCount = productService.getProductTotalCountByType(Constant.ExperiencePack);
            jsonObj.put("totalCount", Integer.parseInt(totalCount));
            if(productBeans == null || productBeans.size() == 0){
                jsonObj.put("data",new Gson().toJson(null));
            }else{
                productBeans = dealApiHomePageProductBean(resq, productBeans);
                jsonObj.put("data",new Gson().toJson(productBeans));
            }
            ResponseUtil.writeMsg(resp, jsonObj.toString());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }catch (ParameterCheckException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }
    @RequestMapping(value = "/getProductInforById",method = RequestMethod.POST)
    public void getProductInforById(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            checkGetProductInforPara(resq);
        }catch (ParameterCheckException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
            return;
        }
        ApiProductService productService = new ApiProductService();
        String pid = resq.getParameter("pid");
        String cid = resq.getParameter("cid");
        ApiSpecifyProductBean productBean = null;
        try{
            productBean = productService.getProductInforById(pid, cid);
        }catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
            return;
        }
        if(productBean != null){
            String localIp = resq.getLocalAddr();//获取本地ip
            if(Constant.isDeployInAliyun){
                localIp = Constant.AliyunIP;
            }
            int localPort = resq.getLocalPort();//获取本地的端口
            String appName = resq.getContextPath();
            String mainImgUrl = "http://" + localIp + ":" + localPort + appName + "/" + productBean.getMainimgurl();
            productBean.setMainimgurl(mainImgUrl);
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            jsonObj.put("data", new Gson().toJson(productBean));
            ResponseUtil.writeMsg(resp, jsonObj.toString());
        }else{
            ResponseUtil.writeFailMsgToApiResult(resp, "无法获取指定pid的产品信息");
        }
    }
    @RequestMapping(value = "/collectProduct", method = RequestMethod.POST)
    public void collectProduct(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            checkCollectProductPara(resq);
            String pid = resq.getParameter("pid");
            String cid = resq.getParameter("cid");
            ApiProductService productService = new ApiProductService();
            boolean result = productService.collectProduct(cid, pid);

            if(result){
                JSONObject jsonObj = new JSONObject();
                jsonObj.put("code","200");
                jsonObj.put("msg","收藏成功");
                jsonObj.put("data", new Gson().toJson(null));
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
    @RequestMapping(value = "/cancelCollectProduct", method = RequestMethod.POST)
    public void cancelCollectProduct(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            checkCollectProductPara(resq);
        }catch (ParameterCheckException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
            return;
        }
        String pid = resq.getParameter("pid");
        String cid = resq.getParameter("cid");
        ApiProductService productService = new ApiProductService();
        try {
            productService.cancelCollectProduct(cid, pid);
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
            return;
        }

        JSONObject jsonObj = new JSONObject();
        jsonObj.put("code","200");
        jsonObj.put("msg","取消收藏成功");
        jsonObj.put("data", new Gson().toJson(null));
        ResponseUtil.writeMsg(resp, jsonObj.toString());
    }

    @RequestMapping(value = "/getProductCourseList", method = RequestMethod.POST)
    public void getProductCourseList(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            checkGetProductInforPara(resq);
        }catch (ParameterCheckException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
            return;
        }
        String pid = resq.getParameter("pid");
        String cid = resq.getParameter("cid");
        ApiProductService productService = new ApiProductService();
        List<ApiListViewCourseBean> courseBeans = null;
        String isbuy = null;
        String iscollection = null;
        String updateCount = null;
        String mainImgPath = null;
        String mainImgUrl = null;
        try {
            courseBeans = productService.getProductCourseList(pid);
            isbuy = productService.getProductIsBuy(cid, pid);
            iscollection = productService.getProductIsCollection(cid, pid);
            updateCount = productService.getProductAudioUpdateCount(pid);
            mainImgPath = productService.getMainImgPath(pid);
            String localIp = resq.getLocalAddr();//获取本地ip
            if(Constant.isDeployInAliyun){
                localIp = Constant.AliyunIP;
            }
            int localPort = resq.getLocalPort();//获取本地的端口
            String appName = resq.getContextPath();
            mainImgUrl = "http://" + localIp + ":" + localPort + appName + "/" + mainImgPath;
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
            return;
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", "200");
        jsonObject.put("msg", "获取成功");

        JSONObject dataObject = new JSONObject();
        dataObject.put("isbuy", isbuy);
        dataObject.put("iscollection", iscollection);
        dataObject.put("updatecount", updateCount);
        dataObject.put("mainimgurl", mainImgUrl);
        if(courseBeans == null || courseBeans.size()==0){
            dataObject.put("courselist", new Gson().toJson(null));
        }else{
            courseBeans = dealApiListViewCourseBean(resq,courseBeans);
            dataObject.put("courselist", new Gson().toJson(courseBeans));
        }
        jsonObject.put("data", dataObject.toString());
        ResponseUtil.writeMsg(resp, jsonObject.toString());
    }

    @RequestMapping(value = "/getReverseCourseList", method = RequestMethod.POST)
    public void getReverseCourseList(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            checkGetProductInforPara(resq);
        }catch (ParameterCheckException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
            return;
        }
        String pid = resq.getParameter("pid");
        String cid = resq.getParameter("cid");
        ApiProductService productService = new ApiProductService();
        List<ApiListViewCourseBean> courseBeans = null;
        String isbuy = null;
        String iscollection = null;
        String updateCount = null;
        String mainImgPath = null;
        String mainImgUrl = null;
        try {
            courseBeans = productService.getReverseCourseList(pid);
            isbuy = productService.getProductIsBuy(cid, pid);
            iscollection = productService.getProductIsCollection(cid, pid);
            updateCount = productService.getProductAudioUpdateCount(pid);
            mainImgPath = productService.getMainImgPath(pid);
            String localIp = resq.getLocalAddr();//获取本地ip
            if(Constant.isDeployInAliyun){
                localIp = Constant.AliyunIP;
            }
            int localPort = resq.getLocalPort();//获取本地的端口
            String appName = resq.getContextPath();
            mainImgUrl = "http://" + localIp + ":" + localPort + appName + "/" + mainImgPath;
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
            return;
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", "200");
        jsonObject.put("msg", "获取成功");

        JSONObject dataObject = new JSONObject();
        dataObject.put("isbuy", isbuy);
        dataObject.put("iscollection", iscollection);
        dataObject.put("updatecount", updateCount);
        dataObject.put("mainimgurl", mainImgUrl);
        if(courseBeans == null || courseBeans.size()==0){
            dataObject.put("courselist", new Gson().toJson(null));
        }else{
            courseBeans = dealApiListViewCourseBean(resq,courseBeans);
            dataObject.put("courselist", new Gson().toJson(courseBeans));
        }
        jsonObject.put("data", dataObject.toString());
        ResponseUtil.writeMsg(resp, jsonObject.toString());
    }
    private void checkGetProductInforPara(HttpServletRequest resq) throws ParameterCheckException {
        String pid = resq.getParameter("pid");
        if(pid == null){
            throw new ParameterCheckException("未取到参数[pid]");
        }
        if(pid.equals("")){
            throw new ParameterCheckException("参数[pid]的值为空");
        }
    }
    private void checkCollectProductPara(HttpServletRequest resq) throws ParameterCheckException {
        String pid = resq.getParameter("pid");
        if(pid == null){
            throw new ParameterCheckException("未取到参数[pid]");
        }
        if(pid.equals("")){
            throw new ParameterCheckException("参数[pid]的值为空");
        }
        String cid = resq.getParameter("cid");
        if(cid == null){
            throw new ParameterCheckException("未取到参数[cid]");
        }
        if(cid.equals("")){
            throw new ParameterCheckException("参数[cid]的值为空");
        }
    }
    private List<ApiListViewCourseBean> dealApiListViewCourseBean(HttpServletRequest resq,
                                                            List<ApiListViewCourseBean> courseBeans){
        String localIp = resq.getLocalAddr();//获取本地ip
        if(Constant.isDeployInAliyun){
            localIp = Constant.AliyunIP;
        }
        int localPort = resq.getLocalPort();//获取本地的端口
        String appName = resq.getContextPath();
        for(int i = 0; i < courseBeans.size(); i++){
            ApiListViewCourseBean courseBean = courseBeans.get(i);
            Date createDateO = courseBean.getCreatedateo();
            SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
            Calendar cal = Calendar.getInstance();
            cal.setTime(createDateO);
            String createdate = cal.get(Calendar.MONTH) + 1 + "月" + cal.get(Calendar.DAY_OF_MONTH)+"日";
            courseBean.setCreatedate(createdate);
            courseBean.setCreatedateo(null);

            String audioUrl = "http://" + localIp + ":" + localPort + appName + "/" + courseBean.getAudiourl();
            courseBean.setAudiourl(audioUrl);
            String listimgurl = "http://" + localIp + ":" + localPort + appName + "/" + courseBean.getListimgurl();
            courseBean.setListimgurl(listimgurl);
        }
        return courseBeans;
    }
    private List<ApiProductBean> dealApiHomePageProductBean(HttpServletRequest resq,
                                                    List<ApiProductBean> productBeans){
        String localIp = resq.getLocalAddr();//获取本地ip
        if(Constant.isDeployInAliyun){
            localIp = Constant.AliyunIP;
        }
        int localPort = resq.getLocalPort();//获取本地的端口
        String appName = resq.getContextPath();
        for(int i = 0; i < productBeans.size(); i++){
            ApiProductBean productBean = productBeans.get(i);

            Date updatetimeo = productBean.getUpdatetimeo();
            SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
            Calendar cal = Calendar.getInstance();
            cal.setTime(updatetimeo);
            String updateTime = cal.get(Calendar.MONTH) + 1 + "." + cal.get(Calendar.DAY_OF_MONTH);
            productBean.setUpdatetime(updateTime);
            productBean.setUpdatetimeo(null);

            String listImgUrl = "http://" + localIp + ":" + localPort + appName + "/" + productBean.getListimgurl();
            productBean.setListimgurl(listImgUrl);
        }
        return productBeans;
    }
    private void checkSearhProductPara(HttpServletRequest resq) throws ParameterCheckException {
        String keyword = resq.getParameter("keyword");
        if(keyword == null){
            throw new ParameterCheckException("未取到参数[keyword]");
        }
        if(keyword.equals("")){
            throw new ParameterCheckException("参数[keyword]的值为空");
        }
    }
    private void checkUpdateCourseViewCountPara(HttpServletRequest resq) throws ParameterCheckException {
        String courseid = resq.getParameter("courseid");
        if(courseid == null){
            throw new ParameterCheckException("未取到参数[courseid]");
        }
        if(courseid.equals("")){
            throw new ParameterCheckException("参数[courseid]的值为空");
        }
    }
}
