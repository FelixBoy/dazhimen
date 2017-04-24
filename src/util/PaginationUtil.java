package util;

import dazhimen.bg.bean.MasterPaginationParamBean;
import dazhimen.bg.bean.PaginationParamBean;

/**
 * Created by Administrator on 2017/4/5.
 */
public class PaginationUtil {
    public static PaginationParamBean getPaginationParamBean(String page, String rows){
        int currentpage = Integer.parseInt((page == null || page == "0") ? "1": page);//第几页
        int pagesize = Integer.parseInt((rows == null || rows == "0") ? "10": rows);//每页多少行
        int startnum = 0;
        if(currentpage-1>0){
            startnum = (currentpage-1)*pagesize;
        }
        PaginationParamBean paramBean = new PaginationParamBean();
        paramBean.setStartnum(startnum);
        paramBean.setGetrows(pagesize);
        return paramBean;
    }
    public static MasterPaginationParamBean getMasterPaginationParamBean(String page, String rows, String userid){
        int currentpage = Integer.parseInt((page == null || page == "0") ? "1": page);//第几页
        int pagesize = Integer.parseInt((rows == null || rows == "0") ? "10": rows);//每页多少行
        int startnum = 0;
        if(currentpage-1>0){
            startnum = (currentpage-1)*pagesize;
        }
        MasterPaginationParamBean paramBean = new MasterPaginationParamBean();
        paramBean.setStartnum(startnum);
        paramBean.setGetrows(pagesize);
        paramBean.setUid(userid);
        return paramBean;
    }
}
