package dazhimen.api.controller;

import dazhimen.api.bean.ApiCustomerBean;
import dazhimen.api.service.ApiCustomerService;
import com.google.gson.Gson;
import net.sf.json.JSONObject;
import dazhimen.api.bean.ModifyCustomerInfoBean;
import dazhimen.api.exception.ParameterCheckException;
import dazhimen.api.service.ApiLoginService;
import dazhimen.bg.service.LoginService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import util.ApiUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

/**
 * Created by Administrator on 2017/3/18.
 */
@Controller
@RequestMapping("/api/customer")
public class ApiCustomerController {
    @RequestMapping(value="getPersonalInfo", method = RequestMethod.POST)
    public void getPersonalInfo(HttpServletRequest resq, HttpServletResponse resp){
        resp.setCharacterEncoding("utf-8");
        try {
            checkGetPersonalInfoPara(resq);
            ApiUtils.checkSignature(resq);
            String cid = resq.getParameter("cid");
            ApiLoginService apiLoginService = new ApiLoginService();
            ApiCustomerBean customerBean = apiLoginService.getCustomerInfoByCid(cid);
            try {
                JSONObject jsonObj = new JSONObject();
                jsonObj.put("code","200");
                jsonObj.put("msg","成功");
                jsonObj.put("data",new Gson().toJson(customerBean));
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
    @RequestMapping(value="modifyPersonalInfo", method = RequestMethod.POST)
    public void modifyPersonalInfo(HttpServletRequest resq, HttpServletResponse resp){
        try {
            if(resq.getCharacterEncoding() == null)
                resq.setCharacterEncoding("utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        resp.setCharacterEncoding("utf-8");
        try {
            checkModifyPersonalInfoPara(resq);
            ApiUtils.checkSignature(resq);
            ModifyCustomerInfoBean customerInfoBean = getModifyPersonalInfoBean(resq);
            ApiCustomerService customerService = new ApiCustomerService();
            customerService.modifyPersonalInfo(customerInfoBean);
            ApiLoginService loginService = new ApiLoginService();
            ApiCustomerBean customerBean = loginService.getCustomerInfoByCid(customerInfoBean.getCid());
            try {
                JSONObject jsonObj = new JSONObject();
                jsonObj.put("code","200");
                jsonObj.put("msg","成功");
                jsonObj.put("data",new Gson().toJson(customerBean));
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
    private void checkGetPersonalInfoPara(HttpServletRequest resq) throws ParameterCheckException {
        String cid = resq.getParameter("cid");
        if(cid == null){
            throw new ParameterCheckException("未取到参数[cid]");
        }
    }
    private void checkModifyPersonalInfoPara(HttpServletRequest resq) throws ParameterCheckException {
        String cid = resq.getParameter("cid");
        if(cid == null){
            throw new ParameterCheckException("未取到参数[cid]");
        }
        String mphone = resq.getParameter("mphone");
        if(mphone == null){
            throw new ParameterCheckException("未取到参数[mphone]");
        }
        String verifycode = resq.getParameter("verifycode");
        if(verifycode == null){
            throw new ParameterCheckException("未取到参数[verifycode]");
        }
    }
    private ModifyCustomerInfoBean getModifyPersonalInfoBean(HttpServletRequest resq) {
        ModifyCustomerInfoBean customerInfoBean = new ModifyCustomerInfoBean();
        customerInfoBean.setCid(resq.getParameter("cid"));
        customerInfoBean.setMphone(resq.getParameter("mphone"));
        customerInfoBean.setNickname(resq.getParameter("nickname"));
        customerInfoBean.setName(resq.getParameter("name"));
        customerInfoBean.setGender(resq.getParameter("gender"));
        customerInfoBean.setEmail(resq.getParameter("email"));
        customerInfoBean.setEducation(resq.getParameter("education"));
        customerInfoBean.setVerifycode(resq.getParameter("verifycode"));
        return customerInfoBean;
    }
}