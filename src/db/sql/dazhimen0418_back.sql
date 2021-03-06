/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : dazhimen

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2017-04-18 14:05:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for codemap
-- ----------------------------
DROP TABLE IF EXISTS `codemap`;
CREATE TABLE `codemap` (
  `codeid` varchar(20) NOT NULL COMMENT '字典的id',
  `codename` varchar(100) DEFAULT NULL COMMENT '字典的名称',
  `codevalue` varchar(10) NOT NULL COMMENT '字典id对应的值',
  `codetext` varchar(255) DEFAULT NULL COMMENT '字典值对应的文本',
  PRIMARY KEY (`codeid`,`codevalue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of codemap
-- ----------------------------
INSERT INTO `codemap` VALUES ('education', '学历', '1', '义务教育');
INSERT INTO `codemap` VALUES ('education', '学历', '2', '高中');
INSERT INTO `codemap` VALUES ('education', '学历', '3', '专科');
INSERT INTO `codemap` VALUES ('education', '学历', '4', '本科');
INSERT INTO `codemap` VALUES ('education', '学历', '5', '硕士研究生');
INSERT INTO `codemap` VALUES ('education', '学历', '6', '博士研究生');
INSERT INTO `codemap` VALUES ('gender', '性别', '1', '男');
INSERT INTO `codemap` VALUES ('gender', '性别', '2', '女');
INSERT INTO `codemap` VALUES ('indexsort', '首页排序', '1', '排序1');
INSERT INTO `codemap` VALUES ('indexsort', '首页排序', '10', '排序10');
INSERT INTO `codemap` VALUES ('indexsort', '首页排序', '2', '排序2');
INSERT INTO `codemap` VALUES ('indexsort', '首页排序', '3', '排序3');
INSERT INTO `codemap` VALUES ('indexsort', '首页排序', '4', '排序4');
INSERT INTO `codemap` VALUES ('indexsort', '首页排序', '5', '排序5');
INSERT INTO `codemap` VALUES ('indexsort', '首页排序', '6', '排序6');
INSERT INTO `codemap` VALUES ('indexsort', '首页排序', '7', '排序7');
INSERT INTO `codemap` VALUES ('indexsort', '首页排序', '8', '排序8');
INSERT INTO `codemap` VALUES ('indexsort', '首页排序', '9', '排序9');
INSERT INTO `codemap` VALUES ('indexsort', '首页排序', '99', '按上架时间排序');
INSERT INTO `codemap` VALUES ('newsstatus', '新闻状态', '0', '下架');
INSERT INTO `codemap` VALUES ('newsstatus', '新闻状态', '1', '上架');
INSERT INTO `codemap` VALUES ('paymenttype', '支付方式', '1', '余额支付');
INSERT INTO `codemap` VALUES ('paymenttype', '支付方式', '2', '微信支付');
INSERT INTO `codemap` VALUES ('paymenttype', '支付方式', '3', '支付宝支付');
INSERT INTO `codemap` VALUES ('productstatus', '产品状态', '1', '上架');
INSERT INTO `codemap` VALUES ('productstatus', '产品状态', '2', '预告');
INSERT INTO `codemap` VALUES ('productstatus', '产品状态', '3', '下架');
INSERT INTO `codemap` VALUES ('producttype', '产品类型', '1', '技能包');
INSERT INTO `codemap` VALUES ('producttype', '产品类型', '2', '经验包');
INSERT INTO `codemap` VALUES ('rightorwrong', '对叉号标志', '0', '×');
INSERT INTO `codemap` VALUES ('rightorwrong', '对叉号标志', '1', '√');
INSERT INTO `codemap` VALUES ('usertype', '后台用户类型', '1', '掌门');
INSERT INTO `codemap` VALUES ('usertype', '后台用户类型', '2', '管理员');
INSERT INTO `codemap` VALUES ('yesorno', '是否标志', '0', '否');
INSERT INTO `codemap` VALUES ('yesorno', '是否标志', '1', '是');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `courseid` varchar(14) NOT NULL COMMENT '主键。课程id。生成规则：cou+年+月+日+5位数字。例如：cou17031300002',
  `coursename` varchar(100) DEFAULT NULL COMMENT '课程名称',
  `istry` varchar(1) DEFAULT '0' COMMENT '是否试学。1:试学，0:非试学。',
  `sort` varchar(3) DEFAULT NULL COMMENT '排序标志。999代表按时间排序。1-99代表按手动指定的序号排序。',
  `audiopath` varchar(500) DEFAULT NULL COMMENT '音频存储地址',
  `createdate` datetime DEFAULT NULL COMMENT '新增日期',
  `updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `viewcount` varchar(10) DEFAULT '0' COMMENT '播放次数，默认是0',
  `pid` varchar(12) DEFAULT NULL COMMENT '所属产品ID',
  PRIMARY KEY (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程信息表。';

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('cou17032700007', '课程1', null, '999', 'upload/product/p17032700050/course/cou17032700007.mp3', '2017-03-27 22:32:47', '2017-03-27 22:32:47', '8', 'p17032700050');
INSERT INTO `course` VALUES ('cou17032700008', '课程2', '1', '999', 'upload/product/p17032700050/course/cou17032700008.mp3', '2017-03-27 22:33:06', '2017-03-27 22:33:06', '6', 'p17032700050');
INSERT INTO `course` VALUES ('cou17032700009', '课程1', null, '999', 'upload/product/p17032700050/course/cou17032700009.mp3', '2017-03-27 22:33:19', '2017-03-27 22:33:19', '2', 'p17032700050');
INSERT INTO `course` VALUES ('cou17032700010', '课程1', null, '999', 'upload/product/p17032700050/course/cou17032700010.mp3', '2017-03-27 22:33:49', '2017-03-27 22:33:49', '2', 'p17032700050');
INSERT INTO `course` VALUES ('cou17032800011', '课程1', '1', '999', 'upload/product/p17032700049/course/cou17032800011.mp3', '2017-03-28 11:49:15', '2017-03-28 11:49:15', '19', 'p17032700049');
INSERT INTO `course` VALUES ('cou17032800012', '大音频课程', null, '999', 'upload/product/p17032700049/course/cou17032800012.mp3', '2017-03-28 16:30:52', '2017-03-28 16:30:52', '4', 'p17032700049');
INSERT INTO `course` VALUES ('cou17041500014', '26的课程', '1', '999', 'upload/product/p17032700049/course/cou17041500014.mp3', '2017-04-15 17:37:31', '2017-04-15 17:37:31', '1', 'p17032700049');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `cid` varchar(12) NOT NULL COMMENT '主键。户ID，默认规则为：c+年+月+日+5位数字，例如 c17031100001',
  `nickname` varchar(40) DEFAULT NULL COMMENT '昵称，不超过20个字符',
  `mphone` varchar(11) DEFAULT NULL COMMENT '绑定的手机号码',
  `name` varchar(40) DEFAULT NULL COMMENT '客户姓名，不超过20个字符',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱地址',
  `education` varchar(1) DEFAULT NULL COMMENT '学历，1:义务教育，2:高中，3:专科，4:本科，5:硕士研究生，6:博士研究生',
  `headerurl` varchar(500) DEFAULT NULL COMMENT '用户头像图片文件，存储地址',
  `gender` varchar(2) DEFAULT NULL COMMENT '性别:男或者女',
  `remarks` varchar(500) DEFAULT NULL COMMENT '备注信息',
  `isdel` varchar(1) DEFAULT '0' COMMENT '用户是否已被删除，1:已删除，0:正常状态',
  `qq` varchar(20) DEFAULT NULL COMMENT '客户QQ号',
  `qquid` varchar(100) DEFAULT NULL COMMENT '客户QQ号对应的uid',
  `weixin` varchar(50) DEFAULT NULL COMMENT '用户微信号',
  `weixinuid` varchar(100) DEFAULT NULL COMMENT '用户微信号对应的UID',
  `accoutbalance` decimal(6,2) unsigned DEFAULT '0.00' COMMENT '账户余额',
  `createdate` datetime DEFAULT NULL COMMENT '客户账号生成时间',
  `age` int(3) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='前台客户信息表。';

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('c17033100040', '出轨', '13520197512', 'FLY', '177688028@qq.com', '0', 'upload/customer/c17033100040/c17033100040_header.jpg', '男', null, '0', null, null, null, 'oMQfAwXcAKPXmWzOVOlsuEd5TcPI', '2.06', '2017-03-31 14:30:48', null);
INSERT INTO `customer` VALUES ('c17033100041', '大职门', '18203659178', '', '', '0', 'https://q.qlogo.cn/qqapp/1106037492/F02412E525995D97B2D870458D239D5B/100', '男', null, '0', null, 'F02412E525995D97B2D870458D239D5B', null, null, '1.92', '2017-03-31 14:34:38', null);
INSERT INTO `customer` VALUES ('c17040700042', null, '18765826282', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-07 14:03:53', null);
INSERT INTO `customer` VALUES ('c17040700043', null, '18203659804', null, null, null, null, null, null, '0', null, null, null, null, '0.01', '2017-04-07 21:26:54', null);
INSERT INTO `customer` VALUES ('c17040700044', null, '13960850472', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-07 21:56:30', null);
INSERT INTO `customer` VALUES ('c17040800045', null, '15203659178', null, null, null, null, null, null, '0', null, null, null, null, '0.02', '2017-04-08 02:28:40', null);
INSERT INTO `customer` VALUES ('c17040900056', '电子邮', '18765806282', null, '2222s', '4', null, '男', null, '0', null, null, null, null, '0.00', '2017-04-09 10:16:38', null);
INSERT INTO `customer` VALUES ('c17040900071', '齐路军', '15688731300', '齐路军', '', '0', null, '男', null, '0', null, null, null, null, '0.00', '2017-04-09 22:07:45', null);
INSERT INTO `customer` VALUES ('c17040900074', '小8', '18765806281', '哈喽', 'tuuj', '4', 'upload/customer/c17040900074/c17040900074_header.png', '男', null, '0', null, null, null, 'oMQfAwSdglfEertT0X_TQKVrw-bk', '0.01', '2017-04-09 23:32:39', null);
INSERT INTO `customer` VALUES ('c17040900075', '声动科技', null, null, null, null, 'http://wx.qlogo.cn/mmopen/LYtgjZVNSVWast5VGBHd2NcLiaZopmicjaW6j8PajhQFDALu5ed4ZgOEBbhCPIh9cCgibIz4a63PI1RCs22WwkhibR01bEEfbK7m/0', '0', null, '0', null, null, null, 'oMQfAwbDWWjmukOi5QgbnODyHBEo', '0.00', '2017-04-09 23:39:08', null);
INSERT INTO `customer` VALUES ('c17041400076', '慢慢', '18769796233', '郑海', 'ffff1@qq.com11', '6', 'https://wx.qlogo.cn/mmopen/ajNVdqHZLLC63ovIp93dZEGn4uGWlRIrEInFjzibjDyuelZXwxjVpWCLlpnrnHY4VvUM4gwJaC0QTdDmjoezXcA/0', '男', null, '0', null, null, null, 'oMQfAwc9nREJYc4k7XVje6Aosuks', '0.06', '2017-04-14 18:23:40', null);

-- ----------------------------
-- Table structure for ir_customer_news
-- ----------------------------
DROP TABLE IF EXISTS `ir_customer_news`;
CREATE TABLE `ir_customer_news` (
  `cid` varchar(12) NOT NULL,
  `nid` varchar(10) NOT NULL,
  PRIMARY KEY (`cid`,`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ir_customer_news
-- ----------------------------
INSERT INTO `ir_customer_news` VALUES ('c17033100040', 'n170413011');
INSERT INTO `ir_customer_news` VALUES ('c17041400076', 'n170412007');

-- ----------------------------
-- Table structure for ir_customer_product
-- ----------------------------
DROP TABLE IF EXISTS `ir_customer_product`;
CREATE TABLE `ir_customer_product` (
  `cid` varchar(12) NOT NULL COMMENT '前台客户ID',
  `pid` varchar(12) NOT NULL COMMENT '收藏的产品ID',
  PRIMARY KEY (`cid`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户收藏产品的信息表。';

-- ----------------------------
-- Records of ir_customer_product
-- ----------------------------
INSERT INTO `ir_customer_product` VALUES ('c17033100040', 'p17032700049');
INSERT INTO `ir_customer_product` VALUES ('c17033100040', 'p17032700050');
INSERT INTO `ir_customer_product` VALUES ('c17033100040', 'p17033000051');
INSERT INTO `ir_customer_product` VALUES ('c17033100040', 'p17040700053');
INSERT INTO `ir_customer_product` VALUES ('c17033100040', 'p17040700054');
INSERT INTO `ir_customer_product` VALUES ('c17033100040', 'p17040700055');
INSERT INTO `ir_customer_product` VALUES ('c17033100040', 'p17040700056');
INSERT INTO `ir_customer_product` VALUES ('c17033100040', 'p17040700057');
INSERT INTO `ir_customer_product` VALUES ('c17033100040', 'p17041100058');
INSERT INTO `ir_customer_product` VALUES ('c17033100041', 'p17032700050');
INSERT INTO `ir_customer_product` VALUES ('c17033100041', 'p17033000051');
INSERT INTO `ir_customer_product` VALUES ('c17033100041', 'p17040700054');
INSERT INTO `ir_customer_product` VALUES ('c17033100041', 'p17040700056');
INSERT INTO `ir_customer_product` VALUES ('c17040700044', 'p17032700049');
INSERT INTO `ir_customer_product` VALUES ('c17040800045', 'p17032700049');
INSERT INTO `ir_customer_product` VALUES ('c17040800045', 'p17040700056');
INSERT INTO `ir_customer_product` VALUES ('c17040800045', 'p17040700057');
INSERT INTO `ir_customer_product` VALUES ('c17040900071', 'p17040700053');
INSERT INTO `ir_customer_product` VALUES ('c17040900071', 'p17040700054');
INSERT INTO `ir_customer_product` VALUES ('c17040900074', 'p17032700050');
INSERT INTO `ir_customer_product` VALUES ('c17040900074', 'p17040700055');

-- ----------------------------
-- Table structure for ir_customer_view_course
-- ----------------------------
DROP TABLE IF EXISTS `ir_customer_view_course`;
CREATE TABLE `ir_customer_view_course` (
  `cid` varchar(12) NOT NULL COMMENT '会员id',
  `courseid` varchar(14) NOT NULL COMMENT '音频id',
  PRIMARY KEY (`cid`,`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录用户已读课程音频的表';

-- ----------------------------
-- Records of ir_customer_view_course
-- ----------------------------
INSERT INTO `ir_customer_view_course` VALUES ('c17033100040', 'cou17032700009');
INSERT INTO `ir_customer_view_course` VALUES ('c17033100040', 'cou17032700010');
INSERT INTO `ir_customer_view_course` VALUES ('c17033100040', 'cou17032800011');
INSERT INTO `ir_customer_view_course` VALUES ('c17033100040', 'cou17032800012');
INSERT INTO `ir_customer_view_course` VALUES ('c17033100041', 'cou17032700007');
INSERT INTO `ir_customer_view_course` VALUES ('c17041400076', 'cou17032700009');
INSERT INTO `ir_customer_view_course` VALUES ('c17041400076', 'cou17032700010');
INSERT INTO `ir_customer_view_course` VALUES ('c17041400076', 'cou17032800011');
INSERT INTO `ir_customer_view_course` VALUES ('c17041400076', 'cou17041500014');

-- ----------------------------
-- Table structure for ir_order_product
-- ----------------------------
DROP TABLE IF EXISTS `ir_order_product`;
CREATE TABLE `ir_order_product` (
  `orid` varchar(13) NOT NULL COMMENT '订单ID',
  `pid` varchar(12) NOT NULL COMMENT '订单中的产品ID',
  PRIMARY KEY (`orid`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单与产品的关联关系表。';

-- ----------------------------
-- Records of ir_order_product
-- ----------------------------
INSERT INTO `ir_order_product` VALUES ('or17040600003', 'p17033000051');
INSERT INTO `ir_order_product` VALUES ('or17040600004', 'p17032700049');
INSERT INTO `ir_order_product` VALUES ('or17040600005', 'p17032700050');
INSERT INTO `ir_order_product` VALUES ('or17040700006', 'p17033000051');
INSERT INTO `ir_order_product` VALUES ('or17040700007', 'p17032700049');
INSERT INTO `ir_order_product` VALUES ('or17040700008', 'p17032700050');
INSERT INTO `ir_order_product` VALUES ('or17040700009', 'p17040700053');
INSERT INTO `ir_order_product` VALUES ('or17040700010', 'p17040700056');
INSERT INTO `ir_order_product` VALUES ('or17040700011', 'p17040700055');
INSERT INTO `ir_order_product` VALUES ('or17040700012', 'p17040700052');
INSERT INTO `ir_order_product` VALUES ('or17040700013', 'p17040700054');
INSERT INTO `ir_order_product` VALUES ('or17040700014', 'p17040700056');
INSERT INTO `ir_order_product` VALUES ('or17040700015', 'p17040700052');
INSERT INTO `ir_order_product` VALUES ('or17040700016', 'p17040700053');
INSERT INTO `ir_order_product` VALUES ('or17040700017', 'p17040700055');
INSERT INTO `ir_order_product` VALUES ('or17040700018', 'p17040700054');
INSERT INTO `ir_order_product` VALUES ('or17040700020', 'p17040700057');
INSERT INTO `ir_order_product` VALUES ('or17040700024', 'p17040700052');
INSERT INTO `ir_order_product` VALUES ('or17040700025', 'p17040700053');
INSERT INTO `ir_order_product` VALUES ('or17040700026', 'p17032700050');
INSERT INTO `ir_order_product` VALUES ('or17040800027', 'p17032700049');
INSERT INTO `ir_order_product` VALUES ('or17040800028', 'p17040700053');
INSERT INTO `ir_order_product` VALUES ('or17040800029', 'p17032700050');
INSERT INTO `ir_order_product` VALUES ('or17040800030', 'p17040700052');
INSERT INTO `ir_order_product` VALUES ('or17040900031', 'p17040700057');
INSERT INTO `ir_order_product` VALUES ('or17040900032', 'p17032700050');
INSERT INTO `ir_order_product` VALUES ('or17041000033', 'p17032700050');
INSERT INTO `ir_order_product` VALUES ('or17041000034', 'p17032700049');
INSERT INTO `ir_order_product` VALUES ('or17041100043', 'p17040700053');
INSERT INTO `ir_order_product` VALUES ('or17041100044', 'p17040700055');
INSERT INTO `ir_order_product` VALUES ('or17041400045', 'p17032700050');

-- ----------------------------
-- Table structure for ir_role_module_op
-- ----------------------------
DROP TABLE IF EXISTS `ir_role_module_op`;
CREATE TABLE `ir_role_module_op` (
  `rid` varchar(4) NOT NULL,
  `mid` varchar(3) NOT NULL,
  `opid` varchar(3) NOT NULL,
  PRIMARY KEY (`rid`,`mid`,`opid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色可以对模块进行哪些操作的关联关系表。';

-- ----------------------------
-- Records of ir_role_module_op
-- ----------------------------

-- ----------------------------
-- Table structure for ir_user_role
-- ----------------------------
DROP TABLE IF EXISTS `ir_user_role`;
CREATE TABLE `ir_user_role` (
  `uid` varchar(10) NOT NULL COMMENT '用户ID',
  `rid` varchar(4) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`uid`,`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户分配的角色信息表。';

-- ----------------------------
-- Records of ir_user_role
-- ----------------------------

-- ----------------------------
-- Table structure for module
-- ----------------------------
DROP TABLE IF EXISTS `module`;
CREATE TABLE `module` (
  `mid` varchar(3) NOT NULL COMMENT '模块编号。生成规则为m+2位数字。例如：m01，m02等',
  `name` varchar(100) DEFAULT NULL COMMENT '模块名称',
  `remarks` varchar(500) DEFAULT NULL COMMENT '模块备注',
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统中的模块信息表。';

-- ----------------------------
-- Records of module
-- ----------------------------

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `nid` varchar(10) NOT NULL COMMENT '主键。内容ID。生成规则：n+年+月+日+3位数字。例如：n170313001',
  `title` varchar(100) DEFAULT NULL,
  `mainimgurl` varchar(500) DEFAULT NULL COMMENT '对应新闻主图的存储路径',
  `listimgurl` varchar(500) DEFAULT NULL COMMENT '对应新闻列表图片的存储路径',
  `uid` varchar(10) DEFAULT NULL COMMENT '发布用户的ID',
  `status` varchar(1) DEFAULT '0' COMMENT '新闻状态。1:已上架，0:未上架。',
  `createdatetime` datetime DEFAULT NULL COMMENT '新闻创建时间',
  `createdate` date DEFAULT NULL COMMENT '新闻生成日期，只有年月日，用于给接口提供数据时排序',
  `indexsort` varchar(2) DEFAULT '99' COMMENT '首页排序顺序。0代表按时间排序。1-99代表按手动指定的顺序排列。',
  `indexplay` varchar(1) DEFAULT '0' COMMENT '是否进行首页轮播。1:首页轮播，0:不进行首页轮播。',
  `isdel` varchar(1) DEFAULT '0' COMMENT '是否是删除状态。1:已删除，0:正常状态。',
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='职场新闻内容表。';

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES ('n170412007', '大学生就业与恋爱', 'upload/news/n170412007/n170412007_mainimg.jpg', 'upload/news/n170412007/n170412007_listimg.jpg', null, '1', '2017-04-15 17:42:46', '2017-04-11', '99', '0', '0');
INSERT INTO `news` VALUES ('n170412008', '新闻2', 'upload/news/n170412008/n170412008_mainimg.jpg', 'upload/news/n170412008/n170412008_listimg.jpg', null, '1', '2017-04-15 17:42:46', '2017-04-12', '99', '0', '0');
INSERT INTO `news` VALUES ('n170413009', '新闻测试22', 'upload/news/n170413009/n170413009_mainimg.jpg', 'upload/news/n170413009/n170413009_listimg.jpg', null, '1', '2017-04-15 17:42:46', '2017-04-13', '99', '0', '0');
INSERT INTO `news` VALUES ('n170413010', '新闻测试33', 'upload/news/n170413010/n170413010_mainimg.jpg', 'upload/news/n170413010/n170413010_listimg.jpg', null, '1', '2017-04-15 17:42:46', '2017-04-13', '1', '0', '0');
INSERT INTO `news` VALUES ('n170413011', '新闻测试4', 'upload/news/n170413011/n170413011_mainimg.jpg', 'upload/news/n170413011/n170413011_listimg.jpg', null, '1', '2017-04-15 17:42:46', '2017-04-13', '2', '0', '0');
INSERT INTO `news` VALUES ('n170416014', '添加新闻测试1', 'upload/news/n170416014/n170416014_mainimg.jpg', 'upload/news/n170416014/n170416014_listimg.jpg', null, '1', '2017-04-16 17:01:43', '2017-04-16', '99', '1', '0');

-- ----------------------------
-- Table structure for news_content
-- ----------------------------
DROP TABLE IF EXISTS `news_content`;
CREATE TABLE `news_content` (
  `contentid` varchar(13) NOT NULL COMMENT '新闻内容id，生成规则是:nc+年月日+5数字',
  `contenttype` varchar(1) DEFAULT NULL COMMENT '内容类型，1:副标题，2:图片文件，3:文本信息',
  `contentvalue` varchar(5000) DEFAULT NULL,
  `contentsort` varchar(2) DEFAULT NULL COMMENT '内容在页面中的排序',
  `nid` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`contentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of news_content
-- ----------------------------
INSERT INTO `news_content` VALUES ('nc17041200009', '2', 'upload/news/n170412007/nc17041200009_contentimg.jpg', '5', 'n170412007');
INSERT INTO `news_content` VALUES ('nc17041200010', '3', '大学生恋爱内容', '6', 'n170412007');
INSERT INTO `news_content` VALUES ('nc17041200011', '2', 'upload/news/n170412007/nc17041200011_contentimg.png', '7', 'n170412007');
INSERT INTO `news_content` VALUES ('nc17041200012', '1', '大学就业', '1', 'n170412007');
INSERT INTO `news_content` VALUES ('nc17041200013', '3', '大学就业内容', '2', 'n170412007');
INSERT INTO `news_content` VALUES ('nc17041200014', '2', 'upload/news/n170412007/nc17041200014_contentimg.png', '3', 'n170412007');
INSERT INTO `news_content` VALUES ('nc17041200015', '1', '大学生恋爱', '4', 'n170412007');
INSERT INTO `news_content` VALUES ('nc17041200016', '3', '新闻2.1内容2', '5', 'n170412008');
INSERT INTO `news_content` VALUES ('nc17041200017', '1', '新闻2.2', '6', 'n170412008');
INSERT INTO `news_content` VALUES ('nc17041200018', '3', '新闻2.2内容', '7', 'n170412008');
INSERT INTO `news_content` VALUES ('nc17041200019', '1', '新闻2.1', '1', 'n170412008');
INSERT INTO `news_content` VALUES ('nc17041200020', '3', '新闻2.1内容1', '2', 'n170412008');
INSERT INTO `news_content` VALUES ('nc17041200021', '2', 'upload/news/n170412008/nc17041200021_contentimg.jpg', '3', 'n170412008');
INSERT INTO `news_content` VALUES ('nc17041200022', '2', 'upload/news/n170412008/nc17041200022_contentimg.png', '4', 'n170412008');
INSERT INTO `news_content` VALUES ('nc17041300023', '2', 'upload/news/n170413009/nc17041300023_contentimg.png', '5', 'n170413009');
INSERT INTO `news_content` VALUES ('nc17041300024', '1', '副标题1', '1', 'n170413009');
INSERT INTO `news_content` VALUES ('nc17041300025', '3', '副标题1的内容', '2', 'n170413009');
INSERT INTO `news_content` VALUES ('nc17041300026', '2', 'upload/news/n170413009/nc17041300026_contentimg.jpg', '3', 'n170413009');
INSERT INTO `news_content` VALUES ('nc17041300027', '1', '副标题2', '4', 'n170413009');
INSERT INTO `news_content` VALUES ('nc17041300028', '1', 'fff', '1', 'n170413010');
INSERT INTO `news_content` VALUES ('nc17041300029', '3', '发发', '2', 'n170413010');
INSERT INTO `news_content` VALUES ('nc17041300030', '2', 'upload/news/n170413010/nc17041300030_contentimg.jpg', '3', 'n170413010');
INSERT INTO `news_content` VALUES ('nc17041300031', '1', 'fff', '4', 'n170413010');
INSERT INTO `news_content` VALUES ('nc17041300032', '1', '范德萨', '1', 'n170413011');
INSERT INTO `news_content` VALUES ('nc17041300033', '3', '大师傅', '2', 'n170413011');
INSERT INTO `news_content` VALUES ('nc17041300034', '1', '阿范德萨', '3', 'n170413011');
INSERT INTO `news_content` VALUES ('nc17041300035', '2', 'upload/news/n170413011/nc17041300035_contentimg.png', '4', 'n170413011');
INSERT INTO `news_content` VALUES ('nc17041600036', '3', '发添加新闻测试1', '5', 'n170416014');
INSERT INTO `news_content` VALUES ('nc17041600037', '2', 'upload/news/n170416014/nc17041600037_contentimg.jpg', '6', 'n170416014');
INSERT INTO `news_content` VALUES ('nc17041600038', '1', '添加新闻测试1', '1', 'n170416014');
INSERT INTO `news_content` VALUES ('nc17041600039', '2', 'upload/news/n170416014/nc17041600039_contentimg.jpg', '2', 'n170416014');
INSERT INTO `news_content` VALUES ('nc17041600040', '3', '添加新闻测试1', '3', 'n170416014');
INSERT INTO `news_content` VALUES ('nc17041600041', '1', '添加新闻测试1', '4', 'n170416014');

-- ----------------------------
-- Table structure for operation
-- ----------------------------
DROP TABLE IF EXISTS `operation`;
CREATE TABLE `operation` (
  `opid` varchar(3) NOT NULL COMMENT '主键。操作Id。生成规则：op+1位数字。例如op1。',
  `opname` varchar(100) DEFAULT NULL COMMENT '操作名称',
  `remarks` varchar(500) DEFAULT NULL COMMENT '操作备注',
  PRIMARY KEY (`opid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作信息表。';

-- ----------------------------
-- Records of operation
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `orid` varchar(13) NOT NULL COMMENT '主键。订单ID，生成规则是；or+年+月+日+5位数字。例如，or17031100002',
  `ordatetime` datetime DEFAULT NULL COMMENT '下单时间',
  `ordersum` decimal(6,2) unsigned NOT NULL COMMENT '订单金额',
  `paymenttype` varchar(1) NOT NULL COMMENT '支付方式。1:余额支付，2:微信支付，3:支付宝支付',
  `transaction_id` varchar(70) DEFAULT NULL COMMENT '第三方支付订单id',
  `cid` varchar(12) DEFAULT NULL COMMENT '下单的前台客户id',
  `isdel` varchar(1) DEFAULT '0' COMMENT '当前订单是否为已删除状态。1:已删除，0:正常状态',
  PRIMARY KEY (`orid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单表。';

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('or17040600003', '2017-04-06 21:53:04', '0.01', '1', null, 'c17033100040', '0');
INSERT INTO `orders` VALUES ('or17040600004', '2017-04-06 21:54:57', '0.01', '1', null, 'c17033100040', '0');
INSERT INTO `orders` VALUES ('or17040600005', '2017-04-06 22:14:51', '0.01', '1', null, 'c17033100040', '0');
INSERT INTO `orders` VALUES ('or17040700006', '2017-04-07 11:11:48', '0.01', '1', null, 'c17033100041', '0');
INSERT INTO `orders` VALUES ('or17040700007', '2017-04-07 11:12:31', '0.01', '1', null, 'c17033100041', '0');
INSERT INTO `orders` VALUES ('or17040700008', '2017-04-07 11:13:28', '0.01', '1', null, 'c17033100041', '0');
INSERT INTO `orders` VALUES ('or17040700009', '2017-04-07 11:19:11', '0.01', '1', null, 'c17033100041', '0');
INSERT INTO `orders` VALUES ('or17040700010', '2017-04-07 11:21:22', '0.01', '1', null, 'c17033100041', '0');
INSERT INTO `orders` VALUES ('or17040700011', '2017-04-07 11:22:28', '0.01', '1', null, 'c17033100041', '0');
INSERT INTO `orders` VALUES ('or17040700012', '2017-04-07 11:49:52', '0.01', '1', null, 'c17033100041', '0');
INSERT INTO `orders` VALUES ('or17040700013', '2017-04-07 11:56:33', '0.01', '1', null, 'c17033100041', '0');
INSERT INTO `orders` VALUES ('or17040700014', '2017-04-07 12:04:39', '0.01', '1', null, 'c17033100040', '0');
INSERT INTO `orders` VALUES ('or17040700015', '2017-04-07 12:06:37', '0.01', '1', null, 'c17033100040', '0');
INSERT INTO `orders` VALUES ('or17040700016', '2017-04-07 12:07:34', '0.01', '1', null, 'c17033100040', '0');
INSERT INTO `orders` VALUES ('or17040700017', '2017-04-07 12:10:03', '0.01', '1', null, 'c17033100040', '0');
INSERT INTO `orders` VALUES ('or17040700018', '2017-04-07 12:22:24', '0.01', '1', null, 'c17033100040', '0');
INSERT INTO `orders` VALUES ('or17040700020', '2017-04-07 21:13:21', '0.01', '2', '4007892001201704076198734345', 'c17033100041', '0');
INSERT INTO `orders` VALUES ('or17040700024', '2017-04-07 21:27:18', '0.01', '2', '4007892001201704076226336841', 'c17040700043', '0');
INSERT INTO `orders` VALUES ('or17040700025', '2017-04-07 21:28:16', '0.01', '2', '4007892001201704076225169990', 'c17040700043', '0');
INSERT INTO `orders` VALUES ('or17040700026', '2017-04-07 21:32:26', '0.01', '1', null, 'c17040700043', '0');
INSERT INTO `orders` VALUES ('or17040800027', '2017-04-08 02:38:11', '0.01', '2', '4007892001201704086241589171', 'c17040800045', '0');
INSERT INTO `orders` VALUES ('or17040800028', '2017-04-08 14:07:25', '0.01', '2', '4007892001201704086287582169', 'c17040800045', '0');
INSERT INTO `orders` VALUES ('or17040800029', '2017-04-08 14:08:32', '0.01', '2', '4007892001201704086290776526', 'c17040800045', '0');
INSERT INTO `orders` VALUES ('or17040800030', '2017-04-08 14:33:21', '0.01', '2', '4007892001201704086291553406', 'c17040800045', '0');
INSERT INTO `orders` VALUES ('or17040900031', '2017-04-09 11:52:35', '0.01', '1', null, 'c17033100040', '0');
INSERT INTO `orders` VALUES ('or17040900032', '2017-04-09 22:08:00', '0.01', '2', '4009332001201704096461552397', 'c17040900071', '0');
INSERT INTO `orders` VALUES ('or17041000033', '2017-04-10 21:18:19', '0.01', '2', '4001382001201704106564111023', 'c17040900074', '0');
INSERT INTO `orders` VALUES ('or17041000034', '2017-04-10 21:33:22', '0.01', '2', '4001382001201704106572427375', 'c17040900074', '0');
INSERT INTO `orders` VALUES ('or17041100043', '2017-04-11 12:30:03', '0.01', '2', '4001382001201704116617344382', 'c17040900074', '0');
INSERT INTO `orders` VALUES ('or17041100044', '2017-04-11 15:41:33', '0.01', '1', null, 'c17040900074', '0');
INSERT INTO `orders` VALUES ('or17041400045', '2017-04-14 20:30:53', '0.01', '3', '2013112011001004330000121536', 'c17041400076', '0');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `pid` varchar(12) NOT NULL COMMENT '主键。产品ID，生成规则：p+年+月+日+5位数字。例如：p17031200001',
  `pname` varchar(100) DEFAULT NULL COMMENT '产品名称',
  `type` varchar(1) DEFAULT NULL COMMENT '产品类型。1:技能包，2:经验包。',
  `price` decimal(10,2) unsigned DEFAULT NULL COMMENT '产品价格',
  `derateProportion` int(2) unsigned DEFAULT '0' COMMENT '产品余额支付减免比例',
  `introduction` varchar(4000) DEFAULT NULL COMMENT '产品文本介绍',
  `listimage` varchar(500) DEFAULT NULL COMMENT '列表图片地址',
  `indexplay` varchar(1) DEFAULT NULL COMMENT '首页轮播状态。1:首页轮播，0:非首页轮播。',
  `indexsort` varchar(2) DEFAULT '99' COMMENT '首页排名。99代表按上架时间排序，1-998代表手动排序的顺序',
  `uid` varchar(12) DEFAULT NULL COMMENT '负责此产品的掌门的ID',
  `status` varchar(1) DEFAULT '3' COMMENT '产品状态。1:上架，2:预告，3:下架。默认是，下架状态',
  `createdatetime` datetime DEFAULT NULL COMMENT '产品创建时间',
  `isdel` varchar(1) DEFAULT '0' COMMENT '产品是否为删除状态。1:已删除，0:正常状态。',
  `updatedatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `buycount` int(6) unsigned DEFAULT '0' COMMENT '购买人数',
  `istry` varchar(1) DEFAULT NULL COMMENT '是否可以试学。产品是否可以试学，取决于产品下是否存在试学课程',
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品表。';

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('p17032700048', '测试产品', '1', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，\r\n产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17032700048/p17032700048_listimg.jpg', '0', '99', 'u170324003', '1', '2017-03-27 22:10:22', '1', '2017-03-27 22:10:22', '0', null);
INSERT INTO `product` VALUES ('p17032700049', '测试产品1', '2', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17032700049/p17032700049_listimg.jpg', '1', '1', 'u170324003', '1', '2017-03-27 22:30:59', '0', '2017-03-27 22:30:59', '4', '1');
INSERT INTO `product` VALUES ('p17032700050', '测试商品2', '1', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17032700050/p17032700050_listimg.jpg', '0', '99', 'u170324003', '1', '2017-03-27 22:32:18', '0', '2017-03-27 22:32:18', '7', null);
INSERT INTO `product` VALUES ('p17033000051', '测试112', '2', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17033000051/p17033000051_listimg.png', '0', '99', 'u170324004', '1', '2017-03-30 22:12:38', '0', '2017-03-30 22:12:38', '2', null);
INSERT INTO `product` VALUES ('p17040700052', '技能包1', '1', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17040700052/p17040700052_listimg.jpg', '0', '1', 'u170324003', '1', '2017-04-07 11:11:38', '0', '2017-04-07 11:11:38', '4', null);
INSERT INTO `product` VALUES ('p17040700053', '技能包2', '1', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17040700053/p17040700053_listimg.jpg', '1', '2', 'u170324003', '1', '2017-04-07 11:12:21', '0', '2017-04-07 11:12:21', '5', null);
INSERT INTO `product` VALUES ('p17040700054', '技能包3', '1', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17040700054/p17040700054_listimg.jpg', '0', '99', 'u170324003', '2', '2017-04-07 11:12:43', '0', '2017-04-07 11:12:43', '2', null);
INSERT INTO `product` VALUES ('p17040700055', '经验包1', '2', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17040700055/p17040700055_listimg.jpg', '0', '99', 'u170324003', '1', '2017-04-07 11:13:08', '0', '2017-04-07 11:13:08', '3', null);
INSERT INTO `product` VALUES ('p17040700056', '经验包2', '2', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17040700056/p17040700056_listimg.jpg', '0', '2', 'u170324003', '2', '2017-04-07 11:13:36', '0', '2017-04-07 11:13:36', '2', null);
INSERT INTO `product` VALUES ('p17040700057', '经验包3', '2', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17040700057/p17040700057_listimg.jpg', '0', '99', 'u170324003', '1', '2017-04-07 11:15:23', '0', '2017-04-07 11:15:23', '2', null);
INSERT INTO `product` VALUES ('p17041100058', '大学生职业恋爱观', '1', '22.00', '2', '大学生恋爱只能报', 'upload/product/p17041100058/p17041100058_listimg.png', '0', '99', 'u170324003', '1', '2017-04-11 14:12:53', '0', '2017-04-11 14:12:53', '0', null);
INSERT INTO `product` VALUES ('p17041800059', '测试totalCount', '2', '0.02', '0', '', 'upload/product/p17041800059/p17041800059_listimg.jpg', '0', '99', 'u170411007', '1', '2017-04-18 11:19:21', '0', '2017-04-18 11:19:21', '0', null);

-- ----------------------------
-- Table structure for product_image
-- ----------------------------
DROP TABLE IF EXISTS `product_image`;
CREATE TABLE `product_image` (
  `imageid` varchar(15) NOT NULL COMMENT '主键。产品主图id。生成规则：所属产品ID+‘_2位数字’。例如p17031200001_01',
  `path` varchar(500) DEFAULT NULL COMMENT '对应的图片存储路径',
  `pid` varchar(12) DEFAULT NULL COMMENT '所属的产品id',
  PRIMARY KEY (`imageid`),
  UNIQUE KEY `index_productimg_pid` (`pid`) USING BTREE COMMENT '产品id的唯一索引，用于在数据库层面，限制一个产品一张主图'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品对应的图片表。';

-- ----------------------------
-- Records of product_image
-- ----------------------------
INSERT INTO `product_image` VALUES ('p17032700049_1', 'upload/product/p17032700049/p17032700049_mainimg_1.jpg', 'p17032700049');
INSERT INTO `product_image` VALUES ('p17032700050_1', 'upload/product/p17032700050/p17032700050_mainimg_1.jpg', 'p17032700050');
INSERT INTO `product_image` VALUES ('p17033000051_1', 'upload/product/p17033000051/p17033000051_mainimg_1.png', 'p17033000051');
INSERT INTO `product_image` VALUES ('p17040700052_1', 'upload/product/p17040700052/p17040700052_mainimg_1.jpg', 'p17040700052');
INSERT INTO `product_image` VALUES ('p17040700053_1', 'upload/product/p17040700053/p17040700053_mainimg_1.jpg', 'p17040700053');
INSERT INTO `product_image` VALUES ('p17040700054_1', 'upload/product/p17040700054/p17040700054_mainimg_1.jpg', 'p17040700054');
INSERT INTO `product_image` VALUES ('p17040700055_1', 'upload/product/p17040700055/p17040700055_mainimg_1.png', 'p17040700055');
INSERT INTO `product_image` VALUES ('p17040700056_1', 'upload/product/p17040700056/p17040700056_mainimg_1.jpg', 'p17040700056');
INSERT INTO `product_image` VALUES ('p17040700057_1', 'upload/product/p17040700057/p17040700057_mainimg_1.jpg', 'p17040700057');
INSERT INTO `product_image` VALUES ('p17041100058_1', 'upload/product/p17041100058/p17041100058_mainimg_1.png', 'p17041100058');
INSERT INTO `product_image` VALUES ('p17041800059_1', 'upload/product/p17041800059/p17041800059_mainimg_1.jpg', 'p17041800059');

-- ----------------------------
-- Table structure for recharge
-- ----------------------------
DROP TABLE IF EXISTS `recharge`;
CREATE TABLE `recharge` (
  `recid` varchar(12) NOT NULL COMMENT '主键。充值id，规则为，r+年+月+日+5位数字，例如r17031100001',
  `recamount` decimal(10,2) NOT NULL COMMENT '充值金额',
  `cid` varchar(12) NOT NULL COMMENT '充值客户的id',
  `paymenttype` varchar(1) DEFAULT NULL COMMENT '充值的支付方式，2:微信支付，3:支付宝支付',
  `transaction_id` varchar(70) DEFAULT NULL COMMENT '第三方支付订单id',
  `recdatetime` datetime NOT NULL COMMENT '充值时间',
  `isdel` varchar(1) DEFAULT '0' COMMENT '当前充值是否为已删除状态。1:已删除，0:正常。',
  PRIMARY KEY (`recid`),
  UNIQUE KEY `index_transaction_id` (`transaction_id`) USING BTREE COMMENT '微信支付订单号，应该加唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值信息表。';

-- ----------------------------
-- Records of recharge
-- ----------------------------
INSERT INTO `recharge` VALUES ('r17040600085', '0.01', 'c17033100040', '2', '4007892001201704066103917592', '2017-04-06 21:21:49', '0');
INSERT INTO `recharge` VALUES ('r17040600086', '0.01', 'c17033100040', '2', '4007892001201704066107301874', '2017-04-06 21:22:24', '0');
INSERT INTO `recharge` VALUES ('r17040600087', '0.01', 'c17033100040', '2', '4007892001201704066105965061', '2017-04-06 21:22:49', '0');
INSERT INTO `recharge` VALUES ('r17040600089', '0.01', 'c17033100040', '2', '4007892001201704066104109311', '2017-04-06 21:27:15', '0');
INSERT INTO `recharge` VALUES ('r17040600090', '0.01', 'c17033100040', '2', '4007892001201704066109420447', '2017-04-06 21:32:09', '0');
INSERT INTO `recharge` VALUES ('r17040600091', '0.01', 'c17033100040', '2', '4007892001201704066112333061', '2017-04-06 21:36:36', '0');
INSERT INTO `recharge` VALUES ('r17040700092', '0.01', 'c17033100040', '2', '4007892001201704076143263302', '2017-04-07 10:15:58', '0');
INSERT INTO `recharge` VALUES ('r17040700093', '0.01', 'c17033100040', '2', '4007892001201704076148355104', '2017-04-07 10:16:55', '0');
INSERT INTO `recharge` VALUES ('r17040700094', '0.01', 'c17033100040', '2', '4007892001201704076143259974', '2017-04-07 10:17:37', '0');
INSERT INTO `recharge` VALUES ('r17040700095', '0.01', 'c17033100040', '2', '4007892001201704076145107463', '2017-04-07 10:18:36', '0');
INSERT INTO `recharge` VALUES ('r17040700096', '0.01', 'c17033100040', '2', '4007892001201704076146551832', '2017-04-07 10:19:47', '0');
INSERT INTO `recharge` VALUES ('r17040700097', '0.01', 'c17033100040', '2', '4007892001201704076143396075', '2017-04-07 10:22:16', '0');
INSERT INTO `recharge` VALUES ('r17040700098', '0.01', 'c17040700043', '2', '4007892001201704076228370260', '2017-04-07 21:29:06', '0');
INSERT INTO `recharge` VALUES ('r17040700099', '0.01', 'c17040700043', '2', '4007892001201704076223499249', '2017-04-07 21:32:01', '0');
INSERT INTO `recharge` VALUES ('r17040800100', '0.01', 'c17040800045', '2', '4007892001201704086244794576', '2017-04-08 02:37:23', '0');
INSERT INTO `recharge` VALUES ('r17040800101', '0.01', 'c17040800045', '2', '4007892001201704086261236188', '2017-04-08 10:10:37', '0');
INSERT INTO `recharge` VALUES ('r17041000102', '0.01', 'c17033100040', '2', '4007892001201704106492647350', '2017-04-10 09:52:49', '0');
INSERT INTO `recharge` VALUES ('r17041000103', '0.01', 'c17033100040', '2', '4007892001201704106507107908', '2017-04-10 12:22:56', '0');
INSERT INTO `recharge` VALUES ('r17041000104', '0.01', 'c17033100040', '2', '4007892001201704106521008437', '2017-04-10 14:19:53', '0');
INSERT INTO `recharge` VALUES ('r17041000112', '0.01', 'c17040900074', '2', '4001382001201704106564934448', '2017-04-10 20:40:14', '0');
INSERT INTO `recharge` VALUES ('r17041000113', '0.01', 'c17040900074', '2', '4001382001201704106563168668', '2017-04-10 20:46:34', '0');
INSERT INTO `recharge` VALUES ('r17041000114', '0.01', 'c17033100040', '2', '4007892001201704106567698392', '2017-04-10 21:44:15', '0');
INSERT INTO `recharge` VALUES ('r17041400122', '0.01', 'c17041400076', '3', '2017041421001004110200909520', '2017-04-14 18:48:25', '0');
INSERT INTO `recharge` VALUES ('r17041400128', '0.01', 'c17041400076', '3', '2017041421001004110200960119', '2017-04-14 18:48:20', '0');
INSERT INTO `recharge` VALUES ('r17041400130', '0.01', 'c17041400076', '3', '2017041421001004110201051721', '2017-04-14 19:47:19', '0');
INSERT INTO `recharge` VALUES ('r17041500132', '0.01', 'c17041400076', null, '4004202001201704157111162572', '2017-04-15 17:53:26', '0');
INSERT INTO `recharge` VALUES ('r17041500133', '0.01', 'c17041400076', '2', '4004202001201704157111207964', '2017-04-15 17:54:27', '0');
INSERT INTO `recharge` VALUES ('r17041500134', '0.01', 'c17041400076', '3', '2017041521001004110202832948', '2017-04-15 17:54:58', '0');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `rid` varchar(4) NOT NULL COMMENT '主键。角色ID。命名规则是：r+3为数字。例如：r001。',
  `name` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `introduction` varchar(500) DEFAULT NULL COMMENT '角色介绍',
  `ismastercanown` varchar(1) DEFAULT NULL COMMENT '是否允许分配给掌门。1:允许。0:不允许。',
  `isdel` varchar(1) DEFAULT NULL COMMENT '角色是否为删除状态。1:已删除，0:正常状态',
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色信息表。有一个需要注意的属性：是否允许分配给掌门。\r\n';

-- ----------------------------
-- Records of role
-- ----------------------------

-- ----------------------------
-- Table structure for sequence
-- ----------------------------
DROP TABLE IF EXISTS `sequence`;
CREATE TABLE `sequence` (
  `seq_name` varchar(50) NOT NULL COMMENT '序列名称',
  `current_val` int(5) unsigned NOT NULL COMMENT '序列当前值',
  `increment_val` int(1) NOT NULL DEFAULT '1' COMMENT '序列默认不长',
  `max_val` int(6) NOT NULL COMMENT '当前序列的最大值，current_val达到最大值时，会从0再开始',
  PRIMARY KEY (`seq_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自动生成序列的表';

-- ----------------------------
-- Records of sequence
-- ----------------------------
INSERT INTO `sequence` VALUES ('course_seq', '14', '1', '100000');
INSERT INTO `sequence` VALUES ('customer_seq', '76', '1', '100000');
INSERT INTO `sequence` VALUES ('news_content_seq', '41', '1', '100000');
INSERT INTO `sequence` VALUES ('news_seq', '14', '1', '1000');
INSERT INTO `sequence` VALUES ('order_seq', '45', '1', '100000');
INSERT INTO `sequence` VALUES ('product_seq', '59', '1', '100000');
INSERT INTO `sequence` VALUES ('recharge_seq', '134', '1', '100000');
INSERT INTO `sequence` VALUES ('user_seq', '32', '1', '1000');

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `id` varchar(10) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` varchar(10) NOT NULL COMMENT '主键。后台用户ID，分为两种身份，掌门和管理员。生成规则：u+年+月+日+3位数字。例如：u170312001',
  `name` varchar(40) DEFAULT NULL COMMENT '用户姓名',
  `mphone` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `password` varchar(50) DEFAULT NULL COMMENT '密码，密文存储。加密规则为：md5(uid+明文password)',
  `gender` varchar(1) DEFAULT NULL COMMENT '性别。1:男，2:女',
  `type` varchar(1) DEFAULT NULL COMMENT '人员类型。1:掌门，2:管理员。',
  `loginname` varchar(10) DEFAULT NULL COMMENT '登录系统时的账户名称',
  `remarks` varchar(500) DEFAULT NULL COMMENT '备注信息',
  `isdel` varchar(1) DEFAULT '0' COMMENT '用户是否为已删除状态。1:已删除，0:正常状态。',
  `createdate` datetime DEFAULT NULL COMMENT '用户创建时间',
  `identity` varchar(100) DEFAULT NULL COMMENT '如果是掌门时，用于存储掌门的身份信息',
  `introduction` varchar(3000) DEFAULT NULL COMMENT '掌门的介绍信息',
  `headerimg` varchar(500) DEFAULT NULL COMMENT '掌门头像的存储地址',
  `indexsort` varchar(2) DEFAULT '99' COMMENT '掌门的首页排序',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台用户信息表。注意，type字段用于区分 当前用户是掌门还是管理员。';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('u170324003', '大职门掌门人', '18769462356', '8880443972f045283ee4e0729e668fa6', '1', '1', 'dzm', null, '0', '2017-03-31 20:33:45', '职业掌门人', '这是一个资深的职业经理人', 'upload/master/u170331005/u170331005.jpg', '99');
INSERT INTO `user` VALUES ('u170324004', '小军', '18765421364', 'fce369dc41110b892caab8d222c08e29', '1', '1', 'xj', null, '0', '2017-03-31 20:36:29', '地产公司执行副总裁', '资深副总裁', 'upload/master/u170331006/u170331006.png', '99');
INSERT INTO `user` VALUES ('u170411007', '翻', '18203659178', 'ff363e0824433b49d368d995b176513d', '1', '1', '贴身', null, '0', '2017-04-11 11:36:44', '掌门', '掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试掌门测试', 'upload/master/u170411007/u170411007.png', '99');
INSERT INTO `user` VALUES ('u170411008', '机器人', '13209871211', 'd05bb85671262bdd6ab32ec52956abe9', '1', '1', '机器人', null, '0', '2017-04-11 11:45:21', '总裁', '专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗专打极地大乱斗', 'upload/master/u170411008/u170411008.png', '99');
INSERT INTO `user` VALUES ('u170411009', '哈喽', '13420987121', 'd7e3f09b0475d39a28c841041250e3b4', '1', '1', '哈喽', null, '0', '2017-04-11 11:46:43', '领舞者', '广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞广场舞', 'upload/master/u170411009/u170411009.png', '99');
INSERT INTO `user` VALUES ('u170411010', '管家', '13520987512', 'ac7486b6daa849beaebf6b7f3de65185', '1', '1', '管家', null, '0', '2017-04-11 11:47:27', '管家', '介绍', 'upload/master/u170411010/u170411010.png', '1');
INSERT INTO `user` VALUES ('u170411011', '大职门', '13210987654', '8d8178ddd3d5d040bd3696d5b98ed655', '1', '1', '大职门', null, '0', '2017-04-11 11:48:11', '总裁', '总裁介绍', 'upload/master/u170411011/u170411011.png', '2');
INSERT INTO `user` VALUES ('u170411012', '秘书', '13210231452', '19c4d17876fa0d3b1fa1c34c7ea5b0ad', '1', '1', '大职门秘书', null, '0', '2017-04-11 11:48:48', '秘书', '秘书简介', 'upload/master/u170411012/u170411012.png', '99');
INSERT INTO `user` VALUES ('u170411013', '前台', '13520198764', '462472361fb60b154a581985d87e43b5', '1', '1', '前台', null, '0', '2017-04-11 11:49:27', '前台', '前台简介', 'upload/master/u170411013/u170411013.png', '99');
INSERT INTO `user` VALUES ('u170411014', '后段', '13209876540', '186b04046b5cf1a2526f8073a7575fe9', '1', '1', '后端', null, '0', '2017-04-11 11:50:11', '后段', '后段介绍', 'upload/master/u170411014/u170411014.png', '99');
INSERT INTO `user` VALUES ('u170411015', '武当', '13320987650', '5fe5e03f97c781210776b9bb381f3bb9', '1', '1', '武当', null, '0', '2017-04-11 11:50:50', '武当', '武当介绍', 'upload/master/u170411015/u170411015.png', '99');
INSERT INTO `user` VALUES ('u170416031', '管理员', '18765423456', '270b32e9bbb3b63da5694441120f66d0', '2', '2', 'admin', '防守打法', '0', '2017-04-16 20:28:25', null, null, null, '99');
INSERT INTO `user` VALUES ('u170416032', '管理员1', '15645671234', '4d0cff64cc60b4ba83787da367219957', '1', '2', 'admin1', '发生的发', '0', '2017-04-16 20:28:59', null, null, null, '99');

-- ----------------------------
-- Table structure for verifycode
-- ----------------------------
DROP TABLE IF EXISTS `verifycode`;
CREATE TABLE `verifycode` (
  `vid` varchar(12) NOT NULL COMMENT '验证码ID，生成规则=v+年+月+日+5位数字，例如v17032500001',
  `mphone` varchar(15) DEFAULT NULL COMMENT '要获取验证码的手机号',
  `code` varchar(10) DEFAULT NULL COMMENT '验证码',
  `expiredatetime` varchar(50) DEFAULT NULL COMMENT '验证码超时时间，用于计算的 str 时间戳类型',
  `expiredate` datetime DEFAULT NULL COMMENT '验证码超时时间，用于展示的日期类型',
  PRIMARY KEY (`vid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of verifycode
-- ----------------------------

-- ----------------------------
-- Procedure structure for test_next_val
-- ----------------------------
DROP PROCEDURE IF EXISTS `test_next_val`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `test_next_val`(in p_seq_name varchar(50),out r_next_val int)
begin
start transaction; 
update sequence set current_val = (current_val + increment_val) % max_val  where seq_name = p_seq_name;
select current_val into r_next_val  from sequence where seq_name = p_seq_name;
commit;
end
;;
DELIMITER ;

-- ----------------------------
-- Function structure for currval
-- ----------------------------
DROP FUNCTION IF EXISTS `currval`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `currval`(v_seq_name VARCHAR(50)) RETURNS int(11)
begin     
    declare value integer;       
    set value = 0;       
    select current_val into value  from sequence where seq_name = v_seq_name; 
   return value; 
end
;;
DELIMITER ;

-- ----------------------------
-- Function structure for getcodetxt
-- ----------------------------
DROP FUNCTION IF EXISTS `getcodetxt`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getcodetxt`(p_codeid VARCHAR(20),p_codevalue varchar(10)) RETURNS varchar(255) CHARSET utf8
begin     
    declare value varchar(255);       
    set value = '';       
    select codetext into value  from codemap where codeid = p_codeid and codevalue = p_codevalue; 
   return value; 
end
;;
DELIMITER ;

-- ----------------------------
-- Function structure for nextval
-- ----------------------------
DROP FUNCTION IF EXISTS `nextval`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `nextval`(v_seq_name VARCHAR(50)) RETURNS int(11)
begin
    update sequence set current_val = (current_val + increment_val) % max_val  where seq_name = v_seq_name;
    return currval(v_seq_name);
end
;;
DELIMITER ;
