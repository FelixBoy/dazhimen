package dazhimen.api.controller;

import com.google.gson.Gson;
import dazhimen.api.bean.ApiProductBean;
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
                jsonObj.put("data",new Gson().toJson(productBeans));
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
                jsonObj.put("data",new Gson().toJson(productBeans));
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
        } catch (ParameterCheckException e) {
            e.printStackTrace();
        }

    }
    private void checkGetProductInforPara(HttpServletRequest resq) throws ParameterCheckException {
        String pid = resq.getParameter("pid");
        if(pid == null){
            throw new ParameterCheckException("未取到参数[pid]");
        }
    }
    private List<ApiProductBean> dealApiHomePageProductBean(HttpServletRequest resq,
                                                    List<ApiProductBean> productBeans){
        String localIp = resq.getLocalAddr();//获取本地ip
        int localPort = resq.getLocalPort();//获取本地的端口
        String appName = resq.getContextPath();
        for(int i = 0; i < productBeans.size(); i++){
            ApiProductBean productBean = productBeans.get(i);


            Double priceo = productBean.getPriceo();
            String price = priceo.toString()+"/年";
            productBean.setPrice(price);
            productBean.setPriceo(null);

            Date updatetimeo = productBean.getUpdatetimeo();
            SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
            Calendar cal = Calendar.getInstance();
            cal.setTime(updatetimeo);
            String updateTime = cal.get(Calendar.MONTH) + 1 + "." + cal.get(Calendar.DAY_OF_MONTH)+"更新";
            productBean.setUpdatetime(updateTime);
            productBean.setUpdatetimeo(null);

            String listImgUrl = "http://" + localIp + ":" + localPort + appName + "/" + productBean.getListimgurl();
            productBean.setListimgurl(listImgUrl);
        }
        return productBeans;
    }
}
