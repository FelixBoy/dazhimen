package util;

import dazhimen.bg.bean.SingleValueBean;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.sql.SQLException;

/**
 * Created by Administrator on 2017/3/15.
 * 序列生成工具
 */
public class SeqUtils {
    /**
     * 根据指定序列的名称，获取当前序列的下一个值
     * @param seqName 序列名称
     * @return 序列的下一个值
     */
    public static synchronized String getSeqNextVal(String seqName) throws BgException {
        SqlSession sqlSession = null;
        String nextVal = "";
        try {
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean valueBean = sqlSession.selectOne("dazhimen.bg.bean.Util.getSeqNextVal", seqName);
            if(valueBean == null || valueBean.getValueInfo() == null || valueBean.getValueInfo().equals("")){
                throw new Exception("获取[" + seqName + "]序列值出错");
            }
            nextVal = valueBean.getValueInfo();
        } catch (Exception e) {
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return nextVal;
    }

    /**
     * 本方法用0补足序列所缺的位数，从前开始补。例如  2 补全为 00002
     * @param val 要补全0的字符串
     * @param length 补全之后应该达到的长度
     * @return
     */
    public static String autoAttachZeroFromStart(String val, int length){
        //计算需要补0的个数
        int diff = length - val.length();
        StringBuffer resultBF = new StringBuffer();
        for(int i = 0; i < diff; i++){
            resultBF.append("0");
        }
        resultBF.append(val);
        return  resultBF.toString();
    }
}
