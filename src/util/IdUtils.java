package util;

import dazhimen.bg.exception.BgException;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.TimeZone;

/**
 * Created by Administrator on 2017/3/15.
 * 各数据库表的 主键ID的生成类
 */
public class IdUtils {
    public String getVerifyCodeId() throws BgException {
        String curDateStr = getCurrentDate();
        String v_seq = new SeqUtils().getSeqNextVal(Constant.verifycodeSeqName);
        v_seq = SeqUtils.autoAttachZeroFromStart(v_seq, Constant.verifycodeSeqLength);
        return "v" + curDateStr + v_seq;
    }
    public String getRoleId() throws BgException {
        String curDateStr = getCurrentDate();
        String n_seq = new SeqUtils().getSeqNextVal(Constant.roleSeqName);
        n_seq = SeqUtils.autoAttachZeroFromStart(n_seq, Constant.roleSeqLength);
        return "r" + curDateStr + n_seq;
    }
    public String getNewsId() throws BgException {
        String curDateStr = getCurrentDate();
        String n_seq = new SeqUtils().getSeqNextVal(Constant.newsSeqName);
        n_seq = SeqUtils.autoAttachZeroFromStart(n_seq, Constant.newsSeqLength);
        return "n" + curDateStr + n_seq;
    }
    public String getCourseIntroductionId() throws BgException {
        String curDateStr = getCurrentDate();
        String ci_seq = new SeqUtils().getSeqNextVal(Constant.courseIntroductionSeqName);
        ci_seq = SeqUtils.autoAttachZeroFromStart(ci_seq, Constant.courseIntroductionSeqLength);
        return "ci" + curDateStr + ci_seq;
    }
    public String getNesContentId() throws BgException {
        String curDateStr = getCurrentDate();
        String nc_seq = new SeqUtils().getSeqNextVal(Constant.newsContentSeqName);
        nc_seq = SeqUtils.autoAttachZeroFromStart(nc_seq, Constant.newsContentSeqLength);
        return "nc" + curDateStr + nc_seq;
    }
    public String getOrderId() throws BgException {
        String curDateStr = getCurrentDate();
        String order_seq = new SeqUtils().getSeqNextVal(Constant.orderSeqName);
        order_seq = SeqUtils.autoAttachZeroFromStart(order_seq, Constant.orderSeqLength);
        return "or" + curDateStr + order_seq;
    }
    public String getRECId() throws BgException {
        String curDateStr = getCurrentDate();
        String rec_seq = new SeqUtils().getSeqNextVal(Constant.recSeqName);
        rec_seq = SeqUtils.autoAttachZeroFromStart(rec_seq, Constant.recSeqLength);
        return "r" + curDateStr + rec_seq;
    }
    /**
     * 自动生成uid的方法
     * @return 生成的uid
     */
    public String getUid() throws BgException {
        String curDateStr = getCurrentDate();
        String user_seq = new SeqUtils().getSeqNextVal(Constant.userSeqName);
        user_seq = SeqUtils.autoAttachZeroFromStart(user_seq, Constant.userSeqLength);
        return "u" + curDateStr + user_seq;
    }

    /**
     * 获取当前日期的方法
     * @return 当前日期，格式为 年(后两位)+月+日，例如 170312
     */
    private String getCurrentDate(){
        Calendar now = Calendar.getInstance(TimeZone.getTimeZone("GMT+08:00"));//获得东八区时间
        SimpleDateFormat s=new SimpleDateFormat("yyMMdd");
        String curDate = s.format(now.getTime());
        return curDate;
    }

    public String getCid() throws BgException {
        String curDateStr = getCurrentDate();
        String customer_seq = new SeqUtils().getSeqNextVal(Constant.customerSeqName);
        customer_seq = SeqUtils.autoAttachZeroFromStart(customer_seq, Constant.customerSeqLength);
        return "c" + curDateStr + customer_seq;
    }

    public String getPid() throws BgException {
        String curDateStr = getCurrentDate();
        String product_seq = new SeqUtils().getSeqNextVal(Constant.productSeqName);
        product_seq = SeqUtils.autoAttachZeroFromStart(product_seq, Constant.productSeqLength);
        return "p" + curDateStr + product_seq;
    }
    public String getCourseid() throws BgException {
        String curDateStr = getCurrentDate();
        String course_seq = new SeqUtils().getSeqNextVal(Constant.courseSeqName);
        course_seq = SeqUtils.autoAttachZeroFromStart(course_seq, Constant.courseSeqLength);
        return "cou" + curDateStr + course_seq;
    }

}
