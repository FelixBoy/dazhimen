package util;

/**
 * Created by Administrator on 2017/3/15.
 * 系统中用到的常量定义
 */

public class Constant {
    //各模块用于控制权限的id
    public static final String Per_Product = "product_manage";
    public static final String Per_News = "news_manage";
    public static final String Per_Customer = "customer_query";
    public static final String Per_Recharge= "recharge_query";
    public static final String Per_Order = "order_query";
    public static final String Per_Indexplay = "indexplay_manage";
    public static final String Per_Indexsort = "indexsort_manange";
    public static final String Per_Master = "master_manage";
    public static final String Per_Admin = "admin_manage";
    public static final String Per_Permission = "permission_manage";

    //首页各类实体排序的个数
    public static final Integer IndexSortNumber_SkillPack = 2;
    public static final Integer IndexSortNumber_ExperiencePack = 2;
    public static final Integer IndexSortNumber_NewsPack = 2;
    public static final Integer IndexSortNumber_Master = 2;

    public static final String NewsContentType_SubTitle = "1";
    public static final String NewsContentType_Img = "2";
    public static final String NewsContentType_Text = "3";


    //文件后缀名常量
    public static final String FileSuffix_JPG = ".jpg";
    public static final String FileSuffix_PNG = ".png";
    public static final String FileSuffix_GIF = ".gif";
    public static final String FileSuffix_MP3 = ".mp3";
    public static final String FileSuffix_CSS = ".css";
    public static final String FileSuffix_JS = ".js";
    public static final String FileSuffix_HTML = ".html";
    //session中存储登录用户信息的key值
    public static final String LoginUserKey = "loginuser";
    //字符集
    public static final String CharSet = "utf-8";
    //数据库中rid（新角色id)的序列名称
    public static final String roleSeqName = "role_seq";
    //rid中编码中，最后面部分的，数字序列的长度
    public static final int roleSeqLength = 3;
    //数据库中nid（新闻id)的序列名称
    public static final String newsSeqName = "news_seq";
    //nid中编码中，最后面部分的，数字序列的长度
    public static final int newsSeqLength = 3;
    //数据库中contentid（新闻内容id)的序列名称
    public static final String newsContentSeqName = "news_content_seq";
    //contentid中编码中，最后面部分的，数字序列的长度
    public static final int newsContentSeqLength = 5;

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
    //产品上传新闻文件 前缀路径
    public static final String newsPrefixPath = "upload\\news\\";

    //数据库中存储 上传新闻文件的目录 前缀
    public static final String uploadNewsDbPrefixPath = "upload/news/";
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

    //支付类型常量
    public static final String paymentType_Balance = "1";
    public static final String paymentType_WXPay = "2";
    public static final String paymentType_AliPay = "3";

    public static final String FrontEndVersion = "v1.4";

    //=====以下这些变量，是从配置文件中加载的
    //是否部署在阿里云
    public static boolean isDeployInAliyun = false;
    //阿里云Ip
    public static String AliyunIP = null;
    //默认管理员账户的登录名
    public static String defaultAdministrator = null;
}
