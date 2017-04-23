package util;

import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;

/**
 * Created by Administrator on 2017/3/25.
 */
public class DateUtil {
    /**
     * 说明：将字符串转成时间
     */

    public static Date stringToDate(String dateString, String format) throws BgException {
        if (dateString == null) {
            return null;
        }
        if (dateString.equalsIgnoreCase("")) {
            throw new BgException("传入参数中的[时间串]为空");
        }
        if (format == null || format.equalsIgnoreCase("")) {
            throw new BgException("传入参数中的[时间格式]为空");
        }

        Hashtable<Integer, String> h = new Hashtable<Integer, String>();
        if (format.indexOf("yyyy") != -1)
            h.put(new Integer(format.indexOf("yyyy")), "yyyy");
        else if (format.indexOf("yy") != -1)
            h.put(new Integer(format.indexOf("yy")), "yy");
        if (format.indexOf("MM") != -1)
            h.put(new Integer(format.indexOf("MM")), "MM");
        else if (format.indexOf("mm") != -1)
            h.put(new Integer(format.indexOf("mm")), "MM");
        if (format.indexOf("dd") != -1)
            h.put(new Integer(format.indexOf("dd")), "dd");
        if (format.indexOf("hh24") != -1)
            h.put(new Integer(format.indexOf("hh24")), "HH");
        else if (format.indexOf("hh") != -1) {
            h.put(new Integer(format.indexOf("hh")), "HH");
        } else if (format.indexOf("HH") != -1) {
            h.put(new Integer(format.indexOf("HH")), "HH");
        }
        if (format.indexOf("mi") != -1)
            h.put(new Integer(format.indexOf("mi")), "mm");
        else if (format.indexOf("mm") != -1 && h.containsValue("HH"))
            h.put(new Integer(format.lastIndexOf("mm")), "mm");
        if (format.indexOf("ss") != -1)
            h.put(new Integer(format.indexOf("ss")), "ss");
        if (format.indexOf("SSS") != -1)
            h.put(new Integer(format.indexOf("SSS")), "SSS");

        for (int intStart = 0; format.indexOf("-", intStart) != -1; intStart++) {
            intStart = format.indexOf("-", intStart);
            h.put(new Integer(intStart), "-");
        }
        for (int intStart = 0; format.indexOf(".", intStart) != -1; intStart++) {
            intStart = format.indexOf(".", intStart);
            h.put(new Integer(intStart), ".");
        }
        for (int intStart = 0; format.indexOf("/", intStart) != -1; intStart++) {
            intStart = format.indexOf("/", intStart);
            h.put(new Integer(intStart), "/");
        }

        for (int intStart = 0; format.indexOf(" ", intStart) != -1; intStart++) {
            intStart = format.indexOf(" ", intStart);
            h.put(new Integer(intStart), " ");
        }

        for (int intStart = 0; format.indexOf(":", intStart) != -1; intStart++) {
            intStart = format.indexOf(":", intStart);
            h.put(new Integer(intStart), ":");
        }

        if (format.indexOf("年") != -1)
            h.put(new Integer(format.indexOf("年")), "年");
        if (format.indexOf("月") != -1)
            h.put(new Integer(format.indexOf("月")), "月");
        if (format.indexOf("日") != -1)
            h.put(new Integer(format.indexOf("日")), "日");
        if (format.indexOf("时") != -1)
            h.put(new Integer(format.indexOf("时")), "时");
        if (format.indexOf("分") != -1)
            h.put(new Integer(format.indexOf("分")), "分");
        if (format.indexOf("秒") != -1)
            h.put(new Integer(format.indexOf("秒")), "秒");

        String javaFormat = new String();
        int i = 0;
        while (h.size() != 0) {
            Enumeration<Integer> e = h.keys();
            int n = 0;
            while (e.hasMoreElements()) {
                i = ((Integer) e.nextElement()).intValue();
                if (i >= n)
                    n = i;
            }
            String temp = (String) h.get(new Integer(n));
            h.remove(new Integer(n));
            javaFormat = temp + javaFormat;
        }
        SimpleDateFormat df = new SimpleDateFormat(javaFormat);
        df.setLenient(false);// 这个的功能是不把1996-13-3 转换为1997-1-3
        Date myDate = new Date();
        try {
            myDate = df.parse(dateString);
        } catch (ParseException e) {
            /**
             * 解析抛出异常后， 如果判定此异常为"夏时制"起始日期导致， 则使用"松散模式"再次解析日期，并返回结果。
             *
             *   1940-06-03 01:00:00 ~ 1940-09-30 23:00:00
             *	 1941-03-16 01:00:00 ~ 1941-09-30 23:00:00
             *   1986-05-04 01:00:00 ~ 1986-09-13 23:00:00
             *   1987-04-12 01:00:00 ~ 1987-09-12 23:00:00
             *   1988-04-10 01:00:00 ~ 1988-09-10 23:00:00
             *	 1989-04-16 01:00:00 ~ 1989-09-16 23:00:00
             *   1990-04-15 01:00:00 ~ 1990-09-15 23:00:00
             *   1991-04-14 01:00:00 ~ 1991-09-14 23:00:00
             * 20131015 lzx
             */
            try {
                df.setLenient(true);

                Calendar c = Calendar.getInstance();
                c.setTime(df.parse(dateString));

                if ((c.get(Calendar.YEAR) == 1991 && c.get(Calendar.MONTH) == 3
                        && c.get(Calendar.DAY_OF_MONTH) == 14 && c
                        .get(Calendar.HOUR_OF_DAY) == 1)
                        || (c.get(Calendar.YEAR) == 1990
                        && c.get(Calendar.MONTH) == 3
                        && c.get(Calendar.DAY_OF_MONTH) == 15 && c
                        .get(Calendar.HOUR_OF_DAY) == 1)
                        || (c.get(Calendar.YEAR) == 1989
                        && c.get(Calendar.MONTH) == 3
                        && c.get(Calendar.DAY_OF_MONTH) == 16 && c
                        .get(Calendar.HOUR_OF_DAY) == 1)
                        || (c.get(Calendar.YEAR) == 1988
                        && c.get(Calendar.MONTH) == 3
                        && c.get(Calendar.DAY_OF_MONTH) == 10 && c
                        .get(Calendar.HOUR_OF_DAY) == 1)
                        || (c.get(Calendar.YEAR) == 1987
                        && c.get(Calendar.MONTH) == 3
                        && c.get(Calendar.DAY_OF_MONTH) == 12 && c
                        .get(Calendar.HOUR_OF_DAY) == 1)
                        || (c.get(Calendar.YEAR) == 1986
                        && c.get(Calendar.MONTH) == 4
                        && c.get(Calendar.DAY_OF_MONTH) == 4 && c
                        .get(Calendar.HOUR_OF_DAY) == 1)
                        || (c.get(Calendar.YEAR) == 1941
                        && c.get(Calendar.MONTH) == 2
                        && c.get(Calendar.DAY_OF_MONTH) == 16 && c
                        .get(Calendar.HOUR_OF_DAY) == 1)
                        || (c.get(Calendar.YEAR) == 1940
                        && c.get(Calendar.MONTH) == 5
                        && c.get(Calendar.DAY_OF_MONTH) == 3 && c
                        .get(Calendar.HOUR_OF_DAY) == 1)) {
                    myDate = c.getTime();
                } else {
                    throw new BgException("日期格式转换错误!将【" + dateString + "】按照格式【"
                            + javaFormat + "】转换成时间时出错");
                }
            } catch (ParseException e1) {
                throw new BgException("日期格式转换错误!将【" + dateString + "】按照格式【"
                        + javaFormat + "】转换成时间时出错");
            }
        }
        return myDate;
    }
    /**
     * 将字符串转化为日期. 要求传入6位(yyyyMM)或者8位(yyyyMMdd)的参数
     *
     * @return Date
     */
    public static Date stringToDate(String dateString) throws BgException {
        Date vdate = null;
        String vformat = null;
        if (dateString == null)
            return null;
        if (dateString.length() != 4 && dateString.length() != 6
                && dateString.length() != 7 && dateString.length() != 8
                && dateString.length() != 10 && dateString.length() != 14
                && dateString.length() != 19) {
            throw new BgException("时间串【" + dateString + "】输入格式错误,请输入合法的日期格式!");
        }
        if (dateString.length() == 4) {
            vformat = "yyyy";
        } else if (dateString.length() == 6) {
            vformat = "yyyyMM";
        } else if (dateString.length() == 7) {
            dateString = dateString.substring(0, 4)
                    + dateString.substring(5, 7);
            vformat = "yyyyMM";
        } else if (dateString.length() == 8) {
            vformat = "yyyyMMdd";
        } else if (dateString.length() == 10) {
            dateString = dateString.substring(0, 4)
                    + dateString.substring(5, 7) + dateString.substring(8, 10);
            vformat = "yyyyMMdd";
        } else if (dateString.length() == 14) {
            vformat = "yyyyMMddHHmmss";
        } else if (dateString.length() == 19) {
            vformat = "yyyy-MM-dd HH:mm:ss";
        }
        vdate = stringToDate(dateString, vformat);
        return vdate;
    }
}
