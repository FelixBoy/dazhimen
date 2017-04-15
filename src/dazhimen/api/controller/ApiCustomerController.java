package dazhimen.api.controller;

import dazhimen.api.bean.ApiCustomerBean;
import dazhimen.api.exception.ApiException;
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
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import util.ApiUtils;
import util.Constant;
import util.web.ResponseUtil;

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

    @RequestMapping(value="modifyHeader", method = RequestMethod.POST)
    public void modifyHeader(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            String cid = resq.getParameter("cid");
            if(cid == null){
                throw new ParameterCheckException("未取到参数[cid]");
            }
            if(cid.equals("")){
                throw new ParameterCheckException("参数[cid]的值为空");
            }
            MultipartRequest multipartRequest = (MultipartRequest)resq;
            CommonsMultipartFile multipartFile = (CommonsMultipartFile)multipartRequest.getFile("headerfile");
            if(multipartFile == null || multipartFile.isEmpty()){
                throw new ParameterCheckException("获取用户上传的头像出错");
            }
            String basePath = resq.getSession().getServletContext().getRealPath("/");
            ApiCustomerService customerService = new ApiCustomerService();
            customerService.modifyHeader(cid, multipartFile, basePath);

            ApiLoginService apiLoginService = new ApiLoginService();
            ApiCustomerBean customerBean = apiLoginService.getCustomerInfoByCid(cid);
            String headerUrl = customerBean.getHeaderurl();
            if(headerUrl != null && !headerUrl.equals("")){
                if(!headerUrl.contains("http")){
                    String localIp = resq.getLocalAddr();//获取本地ip
                    if(Constant.isDeployInAliyun){
                        localIp = Constant.AliyunIP;
                    }
                    int localPort = resq.getLocalPort();//获取本地的端口
                    String appName = resq.getContextPath();
                    String newHeaderUrl = "http://" + localIp + ":" + localPort + appName + "/" + headerUrl;
                    customerBean.setHeaderurl(newHeaderUrl);
                }
            }
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            jsonObj.put("data",new Gson().toJson(customerBean));
            ResponseUtil.writeMsg(resp, jsonObj.toString());
        } catch (ParameterCheckException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }

    }
    @RequestMapping(value="getPersonalInfo", method = RequestMethod.POST)
    public void getPersonalInfo(HttpServletRequest resq, HttpServletResponse resp){
        try {
            checkGetPersonalInfoPara(resq);
            ApiUtils.checkSignature(resq);
            String cid = resq.getParameter("cid");
            ApiLoginService apiLoginService = new ApiLoginService();
            ApiCustomerBean customerBean = apiLoginService.getCustomerInfoByCid(cid);
            String headerUrl = customerBean.getHeaderurl();
            if(headerUrl != null && !headerUrl.equals("")){
                if(!headerUrl.contains("http")){
                    String localIp = resq.getLocalAddr();//获取本地ip
                    if(Constant.isDeployInAliyun){
                        localIp = Constant.AliyunIP;
                    }
                    int localPort = resq.getLocalPort();//获取本地的端口
                    String appName = resq.getContextPath();
                    String newHeaderUrl = "http://" + localIp + ":" + localPort + appName + "/" + headerUrl;
                    customerBean.setHeaderurl(newHeaderUrl);
                }
            }
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            jsonObj.put("data",new Gson().toJson(customerBean));
            ResponseUtil.writeMsg(resp, jsonObj.toString());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }catch (ParameterCheckException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }
    @RequestMapping(value="modifyPersonalInfo", method = RequestMethod.POST)
    public void modifyPersonalInfo(HttpServletRequest resq, HttpServletResponse resp){
        try {
            checkModifyPersonalInfoPara(resq);
            ApiUtils.checkSignature(resq);
            ModifyCustomerInfoBean customerInfoBean = getModifyPersonalInfoBean(resq);
            ApiCustomerService customerService = new ApiCustomerService();
            customerService.modifyPersonalInfo(customerInfoBean);
            ApiLoginService loginService = new ApiLoginService();
            ApiCustomerBean customerBean = loginService.getCustomerInfoByCid(customerInfoBean.getCid());
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            jsonObj.put("data",new Gson().toJson(customerBean));
            ResponseUtil.writeMsg(resp, jsonObj.toString());
        } catch (ApiException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }catch (ParameterCheckException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
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
        if(cid.equals("")){
            throw new ParameterCheckException("参数[cid]的值为空");
        }
        if(mphone.equals("")){
            throw new ParameterCheckException("参数[mphone]的值为空");
        }
        if(verifycode.equals("")){
            throw new ParameterCheckException("参数[verifycode]的值为空");
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
