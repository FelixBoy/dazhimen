package dazhimen.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2017/3/22.
 */
@Controller
@RequestMapping("/demo")
public class DemoController {
    @RequestMapping(value="fwdTestFileUploadCallBack")
    public String fwdTestFileUploadCallBack(){
        return "/demo/testFileUploadCallBack1";
    }
    @RequestMapping(value="saveFileUpload", method = RequestMethod.POST)
    public ModelAndView saveFileUpload(HttpServletRequest resq, HttpServletResponse resp){
        ModelAndView mav = new ModelAndView("fileUploadAfterAction");
        mav.addObject("message", "testmessage");
        mav.addObject("parameters", "testPara");
        return mav;
    }

    @RequestMapping(value="fwdTestMsgBox")
    public String fwdTestMsgBox(){
        return "/demo/msgbox";
    }
    @RequestMapping(value="/fwdSuspensionInfor")
    public String fwdSuspensionInfor(){
        return "/demo/SuspensionInfor";
    }
}
