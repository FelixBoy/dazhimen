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
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest resq = (HttpServletRequest)servletRequest;
        HttpServletResponse resp = (HttpServletResponse)servletResponse;
        try {
            if(resq.getCharacterEncoding() == null)
                resq.setCharacterEncoding(Constant.CharSet);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        String resqURI = resq.getRequestURI();
        if(resqURI.equals("/dazhimen/login/doLoginCheck.do") || isApiInvoke(resqURI)){
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
    private boolean isApiInvoke(String resqURI){
        return resqURI.contains("dazhimen/api/");
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
    @Override
    public void destroy() {
    }
}
