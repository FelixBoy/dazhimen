package dazhimen.api.controller;

import com.google.gson.Gson;
import dazhimen.api.bean.ApiMasterBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import dazhimen.api.service.ApiMasterService;
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
 * Created by Administrator on 2017/3/31.
 */
@Controller
@RequestMapping("/api/master")
public class ApiMasterController {

    @RequestMapping(value = "/getHomePageMasterInfo",method = RequestMethod.POST)
    public void getHomePageMasterInfo(HttpServletRequest resq,
                                     HttpServletResponse resp){
        try {
            if(resq.getCharacterEncoding() == null)
                resq.setCharacterEncoding(Constant.CharSet);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            ApiUtils.checkSignature(resq);
            ApiMasterService masterService = new ApiMasterService();
            List<ApiMasterBean> masterBeans = masterService.getHomePageMasterInfo(resq.getParameter("getcount"));
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            if(masterBeans != null && masterBeans.size() == 0){
                jsonObj.put("data",new Gson().toJson(null));
            }else{
                masterBeans = dealApiHomePageMasterBean(resq, masterBeans);
                jsonObj.put("data",new Gson().toJson(masterBeans));
            }
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
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
        }
    }

    @RequestMapping(value = "/getMoreMasterInfo",method = RequestMethod.POST)
    public void getMoreMasterInfo(HttpServletRequest resq,
                                      HttpServletResponse resp){
        try {
            if(resq.getCharacterEncoding() == null)
                resq.setCharacterEncoding(Constant.CharSet);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            ApiUtils.checkSignature(resq);
            ApiMasterService masterService = new ApiMasterService();
            List<ApiMasterBean> masterBeans = masterService.getMoreMasterInfo(resq.getParameter("getcount"));
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            if(masterBeans != null && masterBeans.size() == 0){
                jsonObj.put("data",new Gson().toJson(null));
            }else{
                masterBeans = dealApiHomePageMasterBean(resq, masterBeans);
                jsonObj.put("data",new Gson().toJson(masterBeans));
            }
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
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
        }
    }
    @RequestMapping(value = "/searchMasterInfo",method = RequestMethod.POST)
    public void searchMasterInfo(HttpServletRequest resq,
                                  HttpServletResponse resp){
        try {
            if(resq.getCharacterEncoding() == null)
                resq.setCharacterEncoding(Constant.CharSet);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            ApiUtils.checkSignature(resq);
            checkSearchMasterInfo(resq);
            ApiMasterService masterService = new ApiMasterService();
            List<ApiMasterBean> masterBeans = masterService.searchMasterInfo(resq.getParameter("keyword"));
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            if(masterBeans != null && masterBeans.size() == 0){
                jsonObj.put("data",new Gson().toJson(null));
            }else{
                masterBeans = dealApiHomePageMasterBean(resq, masterBeans);
                jsonObj.put("data",new Gson().toJson(masterBeans));
            }
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
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
        }
    }

    @RequestMapping(value = "/getMasterInfoById",method = RequestMethod.POST)
    public void getMasterInfoById(HttpServletRequest resq,
                                      HttpServletResponse resp){
        try {
            if(resq.getCharacterEncoding() == null)
                resq.setCharacterEncoding(Constant.CharSet);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            ApiUtils.checkSignature(resq);
            checkGetMasterInforPara(resq);
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
        ApiMasterBean masterBean = null;
        try{
            ApiMasterService masterService = new ApiMasterService();
            masterBean = masterService.getMasterInfoById(resq.getParameter("masterid"));
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
        if(masterBean != null){
            String localIp = resq.getLocalAddr();//获取本地ip
            int localPort = resq.getLocalPort();//获取本地的端口
            String appName = resq.getContextPath();
            String headerImgUrl = "http://" + localIp + ":" + localPort + appName + "/" + masterBean.getHeaderimgurl();
            masterBean.setHeaderimgurl(headerImgUrl);
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            jsonObj.put("data", new Gson().toJson(masterBean));
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }else{
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg","无法获取指定masterid的掌门信息");
            try {
                resp.getWriter().write(jsonObj.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    private List<ApiMasterBean> dealApiHomePageMasterBean(HttpServletRequest resq,
                                                            List<ApiMasterBean> masterBeans){
        String localIp = resq.getLocalAddr();//获取本地ip
        int localPort = resq.getLocalPort();//获取本地的端口
        String appName = resq.getContextPath();
        for(int i = 0; i < masterBeans.size(); i++){
            ApiMasterBean masterBean = masterBeans.get(i);

            String headerImgUrl = "http://" + localIp + ":" + localPort + appName + "/" + masterBean.getHeaderimgurl();
            masterBean.setHeaderimgurl(headerImgUrl);
        }
        return masterBeans;
    }
    private void checkGetMasterInforPara(HttpServletRequest resq) throws ParameterCheckException {
        String masterid = resq.getParameter("masterid");
        if(masterid == null){
            throw new ParameterCheckException("未取到参数[masterid]");
        }
        if(masterid.equals("")){
            throw new ParameterCheckException("参数[masterid]的值为空");
        }
    }
    private void checkSearchMasterInfo(HttpServletRequest resq) throws ParameterCheckException {
        String keyword = resq.getParameter("keyword");
        if(keyword == null){
            throw new ParameterCheckException("未取到参数[keyword]");
        }
        if(keyword.equals("")){
            throw new ParameterCheckException("参数[keyword]的值为空");
        }
    }

}
