package util;

/**
 * Created by Administrator on 2017/3/15.
 * 系统中用到的常量定义
 */
public class Constant {
    //数据库中 uid编码序列的名称
    public static final String userSeqName = "user_seq";
    //uid中编码中，最后面部分的，数字序列的长度
    public static final int userSeqLength = 3;
    //数据库中 cid编码序列的名称
    public static final String customerSeqName = "customer_seq";
    //cid中编码中，最后面部分的，数字序列的长度
    public static final int customerSeqLength = 5;
    //数据库中 cid编码序列的名称
    public static final String productSeqName = "product_seq";
    //cid中编码中，最后面部分的，数字序列的长度
    public static final int productSeqLength = 5;
    //加密签名Key
    public static final String signKey = "dazhimen666";
    //产品上传文件 前缀路径
    public static final String proPrefixPath = "upload\\product\\";

    //数据库中存储 上传文件的目录 前缀
    public static final String uploadDbPrefixPath = "upload/product/";
}
