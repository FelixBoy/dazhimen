package dazhimen.api.controller;

import com.google.gson.Gson;
import dazhimen.api.bean.ApiIndexPlayBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import dazhimen.api.service.ApiIndexPlayService;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import util.ApiUtils;
import util.Constant;
import util.web.ResponseUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

/**
 * Created by Administrator on 2017/4/1.
 */
@Controller
@RequestMapping("/api/indexplay")
public class ApiIndexPlayController {
    @RequestMapping("/getIndexPlay")
    public void getIndexPlay(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ApiUtils.checkSignature(resq);
            ApiIndexPlayService indexPlayService = new ApiIndexPlayService();
            List<ApiIndexPlayBean> indexPlayBeans = indexPlayService.getIndexPlay();
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","200");
            jsonObj.put("msg","成功");
            if(indexPlayBeans == null || indexPlayBeans.size() == 0){
                jsonObj.put("data",new Gson().toJson(null));
            }else{
                indexPlayBeans = dealApiIndexPlayBean(resq, indexPlayBeans);
                jsonObj.put("data",new Gson().toJson(indexPlayBeans));
            }
            ResponseUtil.writeMsg(resp, jsonObj.toString());
        }catch (ApiException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }catch (ParameterCheckException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToApiResult(resp, e.getMessage());
        }
    }
    private List<ApiIndexPlayBean> dealApiIndexPlayBean(HttpServletRequest resq, List<ApiIndexPlayBean> indexPlayBeans){
        String localIp = resq.getLocalAddr();//获取本地ip
        if(Constant.isDeployInAliyun){
            localIp = Constant.AliyunIP;
        }
        int localPort = resq.getLocalPort();//获取本地的端口
        String appName = resq.getContextPath();
        for(int i = 0; i < indexPlayBeans.size(); i++){
            ApiIndexPlayBean indexPlayBean = indexPlayBeans.get(i);

            String imgUrl = "http://" + localIp + ":" + localPort + appName + "/" + indexPlayBean.getImgurl();
            indexPlayBean.setImgurl(imgUrl);
        }
        return indexPlayBeans;
    }
}
