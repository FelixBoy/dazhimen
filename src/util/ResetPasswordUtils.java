package util;

import dazhimen.bg.bean.PaginationParamBean;
import dazhimen.bg.bean.user.ResetPasswordBean;
import dazhimen.bg.bean.user.UserBean;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

/**
 * Created by Administrator on 2017/5/4.
 */
public class ResetPasswordUtils {
    public static void main(String[] args){
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            PaginationParamBean paginationParamBean = new PaginationParamBean();
            paginationParamBean.setStartnum(0);
            paginationParamBean.setGetrows(100000);
            List<UserBean> admins = sqlSession.selectList("dazhimen.bg.bean.User.listAllAdmin",paginationParamBean);
            for(int i = 0; i < admins.size(); i++){
                UserBean admin = admins.get(i);
                String uid = admin.getUid();
                ResetPasswordBean resetPasswordBean = new ResetPasswordBean();
                resetPasswordBean.setUid(uid);
                String passwordMd5 = GlobalUtils.hex_md5("123456");
                resetPasswordBean.setPassword(GlobalUtils.hex_md5(uid + passwordMd5));
                int result = sqlSession.update("dazhimen.bg.bean.User.saveResetUserPassword", resetPasswordBean);
                if(result == 1){
                    System.out.println("将【" + admin.getName()+"】的密码重置为[123456]");
                }
            }
            List<UserBean> masters = sqlSession.selectList("dazhimen.bg.bean.User.listAllMaster", paginationParamBean);
            for(int i = 0; i < masters.size(); i++){
                UserBean master = masters.get(i);
                String uid = master.getUid();
                ResetPasswordBean resetPasswordBean = new ResetPasswordBean();
                resetPasswordBean.setUid(uid);
                String passwordMd5 = GlobalUtils.hex_md5("123456");
                resetPasswordBean.setPassword(GlobalUtils.hex_md5(uid + passwordMd5));
                int result = sqlSession.update("dazhimen.bg.bean.User.saveResetUserPassword", resetPasswordBean);
                if(result == 1){
                    System.out.println("将【" + master.getName()+"】的密码重置为[123456]");
                }
                sqlSession.commit();
            }
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
        } finally{
            MyBatisUtil.closeSession(sqlSession);
        }
    }
}
