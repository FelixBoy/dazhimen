package dazhimen.api.controller;

import com.google.gson.Gson;
import dazhimen.api.bean.ApiGlobalSearchBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import dazhimen.api.service.ApiGlobalService;
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
 * Created by Administrator on 2017/4/8.
 */
@Controller
@RequestMapping("/api/global")
public class ApiGlobalController {
    @RequestMapping(value = "/globalSearch", method = RequestMethod.POST)
    public void globalSearch(HttpServletRequest resq, HttpServletResponse resp){
        try {
            if(resq.getCharacterEncoding() == null)
                resq.setCharacterEncoding(Constant.CharSet);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            ApiUtils.checkSignature(resq);
            checkGlobalSearchPara(resq);
            ApiGlobalService globalService = new ApiGlobalService();
            List<ApiGlobalSearchBean> searchBeans = globalService.globalSearch(resq.getParameter("keyword"));
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "200");
            jsonObject.put("msg", "获取成功");
            if(searchBeans == null || searchBeans.size()==0){
                jsonObject.put("data", new Gson().toJson(null));
            }else{
                jsonObject.put("data", new Gson().toJson(searchBeans));
            }
            try {
                resp.getWriter().write(jsonObject.toString());
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
    private void checkGlobalSearchPara(HttpServletRequest resq) throws ParameterCheckException {
        String keyword = resq.getParameter("keyword");
        if(keyword == null){
            throw new ParameterCheckException("未取到参数[keyword]");
        }
        if(keyword.equals("")){
            throw new ParameterCheckException("参数[keyword]的值为空");
        }
    }
}