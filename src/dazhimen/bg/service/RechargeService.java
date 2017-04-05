package dazhimen.bg.service;

import dazhimen.api.exception.ApiException;
import dazhimen.bg.bean.PaginationParamBean;
import dazhimen.bg.bean.SingleValueBean;
import dazhimen.bg.bean.ViewRechargeBean;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import net.sf.json.JSONObject;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

/**
 * Created by Administrator on 2017/4/5.
 */
public class RechargeService {
    public String queryAllRecharge(String page, String rows) throws BgException {
        int currentpage = Integer.parseInt((page == null || page == "0") ? "1": page);//第几页
        int pagesize = Integer.parseInt((rows == null || rows == "0") ? "10": rows);//每页多少行

        List<ViewRechargeBean> rechargeBeans = null;
        SqlSession sqlSession = null;
        Integer totalCount = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean allRechargeCountValue = sqlSession.selectOne("getAllRechargeCount");
            if(allRechargeCountValue == null || allRechargeCountValue.getValueInfo() == null){
                throw new ApiException("获取充值数据总条数出错");
            }
            totalCount = Integer.parseInt(allRechargeCountValue.getValueInfo());
            int startnum = 0;
            if(currentpage-1>0){
                startnum = (currentpage-1)*pagesize;
            }
            PaginationParamBean paramBean = new PaginationParamBean();
            paramBean.setStartnum(startnum);
            paramBean.setGetrows(pagesize);
            rechargeBeans = sqlSession.selectList("dazhimen.bg.bean.Recharge.queryAllRecharge", paramBean);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有充值信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", rechargeBeans);
        return jsonObject.toString();
    }
}
