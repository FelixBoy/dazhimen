package util;

import dazhimen.api.exception.ParameterCheckException;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2017/3/18.
 */
public class ApiUtils {
    public static synchronized void checkSignatureThirdPart(HttpServletRequest resq) throws ParameterCheckException {
        String deviceID = resq.getParameter("deviceID");
        if(deviceID == null){
            throw new ParameterCheckException("未取到参数[deviceID]");
        }
        String appVername = resq.getParameter("appVername");
        if(appVername == null){
            throw new ParameterCheckException("未取到参数[appVername]");
        }
        String packageName  = resq.getParameter("packageName");
        if(packageName == null){
            throw new ParameterCheckException("未取到参数[packageName]");
        }
        String timestamp = resq.getParameter("timestamp");
        if(timestamp == null){
            throw new ParameterCheckException("未取到参数[timestamp]");
        }
        String yanzhiStr = "";
        String loginType = resq.getParameter("loginType");
        if(loginType.equals("1")){
            yanzhiStr =  resq.getParameter("qq");
        }else if(loginType.equals("2")){
            yanzhiStr = resq.getParameter("weixin");
        }
        String sign = resq.getParameter("sign");
        if(sign == null){
            throw new ParameterCheckException("未取到参数[sign]");
        }
        String sign_Caclulate = GlobalUtils.hex_md5(deviceID + appVername + packageName + timestamp + yanzhiStr);
        if(!sign.equals(sign_Caclulate)){
            throw new ParameterCheckException("参数签名验证未通过");
        }
    }

    public static synchronized void checkSignatureMphone(HttpServletRequest resq) throws ParameterCheckException {
        String deviceID = resq.getParameter("deviceID");
        if(deviceID == null){
            throw new ParameterCheckException("未取到参数[deviceID]");
        }
        String appVername = resq.getParameter("appVername");
        if(appVername == null){
            throw new ParameterCheckException("未取到参数[appVername]");
        }
        String packageName  = resq.getParameter("packageName");
        if(packageName == null){
            throw new ParameterCheckException("未取到参数[packageName]");
        }
        String timestamp = resq.getParameter("timestamp");
        if(timestamp == null){
            throw new ParameterCheckException("未取到参数[timestamp]");
        }
        String yanzhiStr = resq.getParameter("mphone");
        String sign = resq.getParameter("sign");
        if(sign == null){
            throw new ParameterCheckException("未取到参数[sign]");
        }
        String sign_Caclulate = GlobalUtils.hex_md5(deviceID + appVername + packageName + timestamp + yanzhiStr);
        if(!sign.equals(sign_Caclulate)){
            throw new ParameterCheckException("参数签名验证未通过");
        }
    }
}
