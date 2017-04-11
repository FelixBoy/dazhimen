package util;

/**
 * Created by Administrator on 2017/3/15.
 * 系统中用到的常量定义
 */
public class Constant {
    //字符集
    public static final String CharSet = "utf-8";

    public static final String orderSeqName = "order_seq";
    //uid中编码中，最后面部分的，数字序列的长度
    public static final int orderSeqLength = 5;

    public static final String recSeqName = "recharge_seq";
    //uid中编码中，最后面部分的，数字序列的长度
    public static final int recSeqLength = 5;
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

    //数据库中 courseid编码序列的名称
    public static final String courseSeqName = "course_seq";
    //cid中编码中，最后面部分的，数字序列的长度
    public static final int courseSeqLength = 5;

    //加密签名Key
    public static final String signKey = "dazhimen666";
    //产品上传产品文件 前缀路径
    public static final String productPrefixPath = "upload\\product\\";

    //数据库中存储 上传产品文件的目录 前缀
    public static final String uploadProductDbPrefixPath = "upload/product/";

    //掌门新增上传掌门头像文件 前缀路径
    public static final String masterPrefixPath = "upload\\master\\";

    //数据库中存储 上传掌门头像文件的目录 前缀
    public static final String uploadMasterDbPrefixPath = "upload/master/";

    //掌门新增上传会员头像文件 前缀路径
    public static final String customerPrefixPath = "upload\\customer\\";

    //数据库中存储 上传掌门头像文件的目录 前缀
    public static final String uploadCustomerDbPrefixPath = "upload/customer/";

    //技能包的code值
    public static final String SkillPack = "1";
    //经验包的code值
    public static final String ExperiencePack = "2";
    //验证码长度
    public static final int verifyCodeLength = 4;

    //
    public static final String paymentType_Balance = "1";
    public static final String paymentType_WXPay = "2";
    public static final String paymentType_AliPay = "3";

    //是否部署在阿里云
    public static final boolean isDeployInAliyun = true;
    //阿里云Ip
    public static final String AliyunIP = "47.92.73.149";

    public static final String FrontEndVersion = "v1.3";
}
