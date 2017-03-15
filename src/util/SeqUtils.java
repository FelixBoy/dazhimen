package util;

import db.DBConnUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ArrayHandler;

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
    public static synchronized String getSeqNextVal(String seqName){
        QueryRunner runner = null;
        try {
            runner = new QueryRunner(DBConnUtil.getDataSource());
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("获取数据库连接，创建runner出现错误");
        }
        Object[] results = null;
        try {
            results = runner.query("select nextval('" + seqName + "')", new ArrayHandler());
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("查询用户的下一个序列ID的方法");
        }
        Integer nextVal = Integer.valueOf(results[0].toString());
        return nextVal+"";
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
