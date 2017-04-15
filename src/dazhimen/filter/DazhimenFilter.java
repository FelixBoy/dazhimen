package dazhimen.filter;

import dazhimen.bg.bean.login.LoginUserBean;
import util.Constant;
import util.web.ResponseUtil;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.UnsupportedEncodingException;

/**
 * Created by Administrator on 2017/4/9.
 */
public class DazhimenFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("init filter ");
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest resq = (HttpServletRequest)servletRequest;
        HttpServletResponse resp = (HttpServletResponse)servletResponse;
        String resqURL = resq.getRequestURL().toString();
        if(resqURL != null || !resqURL.equals("")){
            if(isApiInvoke(resqURL) || isStaticResource(resqURL) || isLoginPage(resqURL)){
                try {
                    if(resq.getCharacterEncoding() == null)
                        resq.setCharacterEncoding(Constant.CharSet);
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
                filterChain.doFilter(servletRequest,servletResponse);
            }else{
                HttpSession session = resq.getSession(false);
                if(session == null || !isSessionContainsLoginUser(session)){
                    String loginPageUrl = resq.getContextPath()+ "/login.jsp";
                    String javaScriptSegment = "<script id=\"script_exe\" defer=\"defer\">location.href=\""+ loginPageUrl + "\";</script>";
                    ResponseUtil.writeJavaScript(resp, javaScriptSegment);
                }else{
                    filterChain.doFilter(servletRequest,servletResponse);
                }
            }
        }
    }
    private boolean isSessionContainsLoginUser(HttpSession session){
        Object loginUserObj = session.getAttribute(Constant.LoginUserKey);
        if(loginUserObj == null){
            return false;
        }else{
            LoginUserBean userBean = (LoginUserBean)loginUserObj;
            if(userBean.getUid() == null || userBean.getUname() == null || userBean.getUtype() == null){
                return false;
            }
            return true;
        }
    }
    private boolean isApiInvoke(String resqURL){
        return resqURL.contains("dazhimen/api/");
    }

    private boolean isStaticResource(String resqURL){
        if(resqURL.endsWith(Constant.FileSuffix_JPG)){
            return true;
        }
        if(resqURL.endsWith(Constant.FileSuffix_PNG)){
            return true;
        }
        if(resqURL.endsWith(Constant.FileSuffix_GIF)){
            return true;
        }
        if(resqURL.endsWith(Constant.FileSuffix_MP3)){
            return true;
        }
        if(resqURL.endsWith(Constant.FileSuffix_CSS)){
            return true;
        }
        if(resqURL.endsWith(Constant.FileSuffix_JS)){
            return true;
        }
        if(resqURL.endsWith(Constant.FileSuffix_HTML)){
            return true;
        }
        return false;
    }
    private boolean isLoginPage(String resqURL){
        if(resqURL.endsWith("login.jsp") || resqURL.endsWith("dazhimen/") || resqURL.endsWith("/doLoginCheck")){
            return true;
        }
        return false;
    }
    @Override
    public void destroy() {
        System.out.println("destory filter");
    }
}
