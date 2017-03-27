package dazhimen.api.controller;

import com.google.gson.Gson;
import dazhimen.api.bean.ApiListViewCourseBean;
import dazhimen.api.bean.ApiProductBean;
import dazhimen.api.bean.ApiSpecifyProductBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import dazhimen.api.service.ApiProductService;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import util.ApiUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
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
    @RequestMapping(value = "/getHomePageSkillPack",method = RequestMethod.POST)
    public void getHomePageSkillPack(HttpServletRequest resq,
                                     HttpServletResponse resp){
        resp.setCharacterEncoding("utf-8");
        try {
            ApiUtils.checkSignature(resq);
            ApiProductService productService = new ApiProductService();
            List<ApiProductBean> productBeans = productService.getHomePageSkillPack(resq.getParameter("getcount"));
            productBeans = dealApiHomePageProductBean(resq, productBeans);
            try {
                JSONObject jsonObj = new JSONObject();
                jsonObj.put("code","200");
                jsonObj.put("msg","成功");
                if(productBeans != null && productBeans.size() == 0){
                    jsonObj.put("data",new Gson().toJson(null));
                }else{
                    jsonObj.put("data",new Gson().toJson(productBeans));
                }

                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e) {
                e.printStackTrace();
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
        }
    }
    @RequestMapping(value = "/getHomePageExperiencePack",method = RequestMethod.POST)
    public void getHomePageExperiencePack(HttpServletRequest resq,
                                     HttpServletResponse resp){
        resp.setCharacterEncoding("utf-8");
        try {
            ApiUtils.checkSignature(resq);
            ApiProductService productService = new ApiProductService();
            List<ApiProductBean> productBeans = productService.getHomePageExperiencePack(resq.getParameter("getcount"));
            productBeans = dealApiHomePageProductBean(resq, productBeans);
            try {
                JSONObject jsonObj = new JSONObject();
                jsonObj.put("code","200");
                jsonObj.put("msg","成功");
                if(productBeans != null && productBeans.size() == 0){
                    jsonObj.put("data",new Gson().toJson(null));
                }else{
                    jsonObj.put("data",new Gson().toJson(productBeans));
                }
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e) {
                e.printStackTrace();
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
        }
    }

    @RequestMapping(value = "/getProductInforById",method = RequestMethod.POST)
    public void getProductInforById(HttpServletRequest resq,
                                          HttpServletResponse resp){
        resp.setCharacterEncoding("utf-8");
        try {
            ApiUtils.checkSignature(resq);
            checkGetProductInforPara(resq);
        }catch (ParameterCheckException e) {
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
        ApiProductService productService = new ApiProductService();
        String pid = resq.getParameter("pid");
        String cid = resq.getParameter("cid");
        ApiSpecifyProductBean productBean = null;
        try{
            productBean = productService.getProductInforById(pid, cid);
        }catch (ApiException e) {
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            return;
        }
        if(productBean != null){
            String localIp = resq.getLocalAddr();//获取本地ip
            int localPort = resq.getLocalPort();//获取本地的端口
            String appName = resq.getContextPath();
            String listImgUrl = "http://" + localIp + ":" + localPort + appName + "/" + productBean.getListimgurl();
            productBean.setListimgurl(listImgUrl);
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            jsonObj.put("data", new Gson().toJson(productBean));
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping(value = "/collectProduct", method = RequestMethod.POST)
    public void collectProduct(HttpServletRequest resq, HttpServletResponse resp){
        resp.setCharacterEncoding("utf-8");
        try {
            ApiUtils.checkSignature(resq);
            checkCollectProductPara(resq);
        }catch (ParameterCheckException e) {
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            return;
        }
        String pid = resq.getParameter("pid");
        String cid = resq.getParameter("cid");
        ApiProductService productService = new ApiProductService();
        boolean result = false;
        try {
            result = productService.collectProduct(cid, pid);
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
            return;
        }

        if(result){
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","收藏成功");
            jsonObj.put("data", new Gson().toJson(null));
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }else{
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg","收藏失败");
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping(value = "/cancelCollectProduct", method = RequestMethod.POST)
    public void cancelCollectProduct(HttpServletRequest resq, HttpServletResponse resp){
        resp.setCharacterEncoding("utf-8");
        try {
            ApiUtils.checkSignature(resq);
            checkCollectProductPara(resq);
        }catch (ParameterCheckException e) {
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            return;
        }
        String pid = resq.getParameter("pid");
        String cid = resq.getParameter("cid");
        ApiProductService productService = new ApiProductService();
        try {
            productService.cancelCollectProduct(cid, pid);
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
            return;
        }

        JSONObject jsonObj = new JSONObject();
        jsonObj.put("code","200");
        jsonObj.put("msg","取消收藏成功");
        jsonObj.put("data", new Gson().toJson(null));
        try {
            resp.getWriter().write(jsonObj.toString());
        } catch (IOException e1) {
            e1.printStackTrace();
        }
    }

    @RequestMapping(value = "/getProductCourseList", method = RequestMethod.POST)
    public void getProductCourseList(HttpServletRequest resq, HttpServletResponse resp){
        resp.setCharacterEncoding("utf-8");
        try {
            ApiUtils.checkSignature(resq);
            checkGetProductInforPara(resq);
        }catch (ParameterCheckException e) {
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",e.getMessage());
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            return;
        }
        String pid = resq.getParameter("pid");
        String cid = resq.getParameter("cid");
        ApiProductService productService = new ApiProductService();
        List<ApiListViewCourseBean> courseBeans = null;
        String isbuy = null;
        String iscollection = null;
        try {
            courseBeans = productService.getProductCourseList(pid);
            isbuy = productService.getProductIsBuy(cid, pid);
            iscollection = productService.getProductIsCollection(cid, pid);
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
            return;
        }catch(SQLException e){
            e.printStackTrace();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg","获取失败");
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            return;
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", "200");
        jsonObject.put("msg", "获取成功");

        JSONObject dataObject = new JSONObject();
        dataObject.put("isbuy", isbuy);
        dataObject.put("iscollection", iscollection);
        if(courseBeans != null && courseBeans.size()==0){
            dataObject.put("courselist", new Gson().toJson(null));
        }else{
            courseBeans = dealApiListViewCourseBean(resq,courseBeans);
            dataObject.put("courselist", new Gson().toJson(courseBeans));
        }
        jsonObject.put("data", dataObject.toString());
        try {
            resp.getWriter().write(jsonObject.toString());
        } catch (IOException e1) {
            e1.printStackTrace();
        }
    }
    private void checkGetProductInforPara(HttpServletRequest resq) throws ParameterCheckException {
        String pid = resq.getParameter("pid");
        if(pid == null){
            throw new ParameterCheckException("未取到参数[pid]");
        }
    }
    private void checkCollectProductPara(HttpServletRequest resq) throws ParameterCheckException {
        String pid = resq.getParameter("pid");
        if(pid == null){
            throw new ParameterCheckException("未取到参数[pid]");
        }
        String cid = resq.getParameter("cid");
        if(cid == null){
            throw new ParameterCheckException("未取到参数[cid]");
        }
    }
    private List<ApiListViewCourseBean> dealApiListViewCourseBean(HttpServletRequest resq,
                                                            List<ApiListViewCourseBean> courseBeans){
        String localIp = resq.getLocalAddr();//获取本地ip
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
        }
        return courseBeans;
    }
    private List<ApiProductBean> dealApiHomePageProductBean(HttpServletRequest resq,
                                                    List<ApiProductBean> productBeans){
        String localIp = resq.getLocalAddr();//获取本地ip
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
}
