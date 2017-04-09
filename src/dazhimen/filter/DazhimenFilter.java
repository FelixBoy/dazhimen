package dazhimen.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

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
        String resqURL = resq.getRequestURL().toString();
        System.out.println(resqURL.contains("dazhimen/api/"));

        System.out.println("before filter -- " + resqURL + "  session===" + resq.getSession().getId());
        filterChain.doFilter(servletRequest,servletResponse);
        System.out.println("after filter ");
    }

    @Override
    public void destroy() {
        System.out.println("destory filter");
    }
}
