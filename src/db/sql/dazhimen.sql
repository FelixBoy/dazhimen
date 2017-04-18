/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : dazhimen

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2017-04-04 23:01:36
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
INSERT INTO `codemap` VALUES ('indexsort', '首页排序', '999', '按上架时间排序');
INSERT INTO `codemap` VALUES ('productstatus', '产品状态', '1', '上架');
INSERT INTO `codemap` VALUES ('productstatus', '产品状态', '2', '预告');
INSERT INTO `codemap` VALUES ('productstatus', '产品状态', '3', '下架');
INSERT INTO `codemap` VALUES ('producttype', '产品类型', '1', '技能包');
INSERT INTO `codemap` VALUES ('producttype', '产品类型', '2', '经验包');
INSERT INTO `codemap` VALUES ('rightorwrong', '对叉号标志', '0', '×');
INSERT INTO `codemap` VALUES ('rightorwrong', '对叉号标志', '1', '√');
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
INSERT INTO `course` VALUES ('cou17032700006', '课程12', '1', '4', 'upload/product/p17032600047/course/cou17032700006.mp3', '2017-03-27 19:08:07', '2017-03-27 19:08:57', '0', 'p17032600047');
INSERT INTO `course` VALUES ('cou17032700007', '课程12', '0', '999', 'upload/product/p17032700050/course/cou17032700007.mp3', '2017-03-27 22:47:21', '2017-03-29 17:09:07', '0', 'p17032700050');
INSERT INTO `course` VALUES ('cou17032800009', '课程5011212222', '0', '999', 'upload/product/p17032700049/course/cou17032800009.mp3', '2017-03-28 09:49:36', '2017-03-28 12:12:29', '0', 'p17032700049');
INSERT INTO `course` VALUES ('cou17032800013', '1', null, '999', 'upload/product/p17032700048/course/cou17032800013.mp3', '2017-03-28 10:08:56', '2017-03-28 10:08:56', '0', 'p17032700048');
INSERT INTO `course` VALUES ('cou17032800014', '2', '1', '999', 'upload/product/p17032700048/course/cou17032800014.mp3', '2017-03-28 10:15:15', '2017-03-28 10:15:15', '0', 'p17032700048');
INSERT INTO `course` VALUES ('cou17032800015', '3', null, '999', 'upload/product/p17032700048/course/cou17032800015.mp3', '2017-03-28 10:22:17', '2017-03-28 10:22:17', '0', 'p17032700048');
INSERT INTO `course` VALUES ('cou17032800017', '41', '1', '2', 'upload/product/p17032700048/course/cou17032800017.mp3', '2017-03-28 10:27:47', '2017-03-28 12:08:57', '0', 'p17032700048');
INSERT INTO `course` VALUES ('cou17032800020', '11', '0', '2', 'upload/product/p17032800051/course/cou17032800020.mp3', '2017-03-28 12:32:04', '2017-03-28 12:32:16', '0', 'p17032800051');
INSERT INTO `course` VALUES ('cou17033100024', '发发发1', '0', '999', 'upload/product/p17033100059/course/cou17033100024.mp3', '2017-03-31 16:24:40', '2017-03-31 16:29:34', '0', 'p17033100059');

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
  `accoutbalance` decimal(6,2) unsigned DEFAULT '0.00' COMMENT '用户账户余额',
  `createdate` datetime DEFAULT NULL COMMENT '客户账号生成时间',
  `age` int(3) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='前台客户信息表。';

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('c17032900015', null, '18769796233', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-03-29 20:58:11', null);
INSERT INTO `customer` VALUES ('c17033100018', '慢慢', '18769796211', '郑海姐', 'ffff1@qq.com', '0', 'http://q.logo.cn/qqapp/1834573286/xxxxx.jpg', '男', null, '0', null, 'achchda112231211213', null, null, '0.00', '2017-03-31 11:52:40', null);
INSERT INTO `customer` VALUES ('c17033100021', '郑海杰', null, null, null, null, 'https://wx.qlogo.cn/mmopen/ajNVdqHZLLC63ovIp93dZEGn4uGWlRIrEInFjzibjDyuelZXwxjVpWCLlpnrnHY4VvUM4gwJaC0QTdDmjoezXcA/0', '男', null, '0', null, null, null, 'oMQfAwc9nREJYc4k7XVje6Aosuks', '0.20', '2017-03-31 14:19:44', null);
INSERT INTO `customer` VALUES ('c17033100022', '大职门', null, null, null, null, 'https://q.qlogo.cn/qqapp/1106037492/F02412E525995D97B2D870458D239D5B/100', '女', null, '0', null, 'F02412E525995D97B2D870458D239D5B', null, null, '0.00', '2017-03-31 22:48:53', null);
INSERT INTO `customer` VALUES ('c17033100023', 'Target', '13717718808', '范超', '', '0', 'https://wx.qlogo.cn/mmopen/EJOlbD3jCria5kroGLYFMn9nubxu6TBwPHfMDwiavS8ictR4ibljHKiacpBcHpHqWNYTaNhUW9w4ZNaHKPp36dKYth0Wx3opgBMkH/0', '男', null, '0', null, null, null, 'oMQfAwXcAKPXmWzOVOlsuEd5TcPI', '0.00', '2017-03-31 22:50:16', null);
INSERT INTO `customer` VALUES ('c17033100024', null, '13520197512', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-03-31 22:51:42', null);

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
INSERT INTO `ir_customer_product` VALUES ('c17033100018', 'p17032300021');
INSERT INTO `ir_customer_product` VALUES ('c17033100018', 'p17032600047');
INSERT INTO `ir_customer_product` VALUES ('c17033100023', 'p17032200018');
INSERT INTO `ir_customer_product` VALUES ('c17033100023', 'p17032300021');
INSERT INTO `ir_customer_product` VALUES ('c17033100023', 'p17032700048');

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
  `subtitle` varchar(200) DEFAULT NULL,
  `content` varchar(3000) DEFAULT NULL,
  `imagepath` varchar(500) DEFAULT NULL COMMENT '对应图片的存储路径',
  `uid` varchar(10) DEFAULT NULL COMMENT '发布用户的ID',
  `status` varchar(1) DEFAULT NULL COMMENT '新闻状态。1:已上架，0:未上架。',
  `indexsort` varchar(2) DEFAULT NULL COMMENT '首页排序顺序。0代表按时间排序。1-99代表按手动指定的顺序排列。',
  `indexplay` varchar(1) DEFAULT NULL COMMENT '是否进行首页轮播。1:首页轮播，0:不进行首页轮播。',
  `isdel` varchar(1) DEFAULT '0' COMMENT '是否是删除状态。1:已删除，0:正常状态。',
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='职场新闻内容表。';

-- ----------------------------
-- Records of news
-- ----------------------------

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
  `cid` varchar(12) DEFAULT NULL COMMENT '下单的前台客户id',
  `uid` varchar(10) DEFAULT NULL COMMENT '此字段只在后台添加订单时，有用。正常前台客户下订单，此字段为null。后台添加订单，记录添加订单的用户id。',
  `isdel` varchar(1) DEFAULT '0' COMMENT '当前订单是否为已删除状态。1:已删除，0:正常状态',
  PRIMARY KEY (`orid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单表。';

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `pid` varchar(12) NOT NULL COMMENT '主键。产品ID，生成规则：p+年+月+日+5位数字。例如：p17031200001',
  `pname` varchar(100) DEFAULT NULL COMMENT '产品名称',
  `type` varchar(1) DEFAULT NULL COMMENT '产品类型。1:技能包，2:经验包。',
  `price` decimal(10,2) unsigned DEFAULT NULL COMMENT '产品价格',
  `derateProportion` decimal(4,2) unsigned DEFAULT NULL,
  `introduction` varchar(3000) DEFAULT NULL COMMENT '产品文本介绍',
  `listimage` varchar(500) DEFAULT NULL COMMENT '列表图片地址',
  `indexplay` varchar(1) DEFAULT NULL COMMENT '首页轮播状态。1:首页轮播，0:非首页轮播。',
  `indexsort` varchar(2) DEFAULT '99' COMMENT '首页排名。99代表按上架时间排序，1-98代表手动排序的顺序',
  `uid` varchar(12) DEFAULT NULL COMMENT '负责此产品的掌门的ID',
  `status` varchar(1) DEFAULT '3' COMMENT '产品状态。1:上架，2:预告，3:下架。默认是，下架状态',
  `createdatetime` datetime DEFAULT NULL COMMENT '产品创建时间',
  `isdel` varchar(1) DEFAULT '0' COMMENT '产品是否为删除状态。1:已删除，0:正常状态。',
  `updatedatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `buycount` int(6) DEFAULT NULL COMMENT '购买人数',
  `istry` varchar(1) DEFAULT NULL COMMENT '是否可以试学。产品是否可以试学，取决于产品下是否存在试学课程',
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品表。';

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('p17032000015', '你好', '1', '11.00', '30.00', '220', 'upload/product/p17032000015/p17032000015_listimg.png', '0', '99', 'u170318002', '3', '2017-03-20 16:42:51', '1', '2017-03-24 14:50:27', '0', '0');
INSERT INTO `product` VALUES ('p17032200016', '测试', '1', '22.00', '10.00', '', 'upload/product/p17032200016/p17032200016_listimg.png', '1', '3', 'u170318002', '1', '2017-03-22 21:50:12', '0', '2017-03-24 14:50:27', '0', '0');
INSERT INTO `product` VALUES ('p17032200017', '测试1', '1', '22.00', '33.00', '', 'upload/product/p17032200017/p17032200017_listimg.png', '1', '99', 'u170318002', '3', '2017-03-22 21:52:23', '0', '2017-03-24 14:50:27', '0', '0');
INSERT INTO `product` VALUES ('p17032200018', '嘎嘎嘎', '2', '22.00', '1.00', '', 'upload/product/p17032200018/p17032200018_listimg.png', '1', '2', 'u170318002', '1', '2017-03-22 21:57:00', '0', '2017-03-24 14:50:27', '0', '0');
INSERT INTO `product` VALUES ('p17032300019', '方法', '1', '222.00', '1.00', '', 'upload/product/p17032300019/p17032300019_listimg.png', '1', '99', 'u170318002', '3', '2017-03-23 10:05:32', '0', '2017-03-24 14:50:27', '0', '0');
INSERT INTO `product` VALUES ('p17032300020', '方法', '1', '222.00', '1.00', '', 'upload/product/p17032300020/p17032300020_listimg.png', '1', '99', 'u170318002', '3', '2017-03-23 10:05:40', '0', '2017-03-24 14:50:27', '0', '0');
INSERT INTO `product` VALUES ('p17032300021', '测试222', '1', '22.00', '2.00', '', 'upload/product/p17032300021/p17032300021_listimg.png', '1', '1', 'u170318002', '1', '2017-03-23 10:07:29', '0', '2017-03-24 14:50:27', '0', '0');
INSERT INTO `product` VALUES ('p17032300034', '1037', '2', '666.00', '66.00', '', 'upload/product/p17032300034/p17032300034_listimg.png', '0', '99', 'u170318002', '2', '2017-03-23 10:39:50', '0', '2017-03-24 14:50:27', '0', '0');
INSERT INTO `product` VALUES ('p17032300035', '1432', '1', '25.00', '20.00', '', 'upload/product/p17032300035/p17032300035_listimg.png', '0', '99', 'u170318002', '3', '2017-03-23 14:24:06', '0', '2017-03-24 14:50:27', '0', '0');
INSERT INTO `product` VALUES ('p17032300036', '1424', '1', '25.00', '20.00', '', 'upload/product/p17032300036/p17032300036_listimg.png', '0', '99', 'u170318002', '3', '2017-03-23 14:24:57', '0', '2017-03-24 14:50:27', '0', '0');
INSERT INTO `product` VALUES ('p17032300042', '测试2张主图', '1', '555.00', '6.00', '', 'upload/product/p17032300042/p17032300042_listimg.png', '0', '99', 'u170318002', '3', '2017-03-23 21:07:02', '0', '2017-03-24 14:50:27', '0', '0');
INSERT INTO `product` VALUES ('p17032400045', 'ff', '1', '2.00', '2.00', '', 'upload/product/p17032400045/p17032400045_listimg.tgz', '0', '0', 'u170318002', '3', '2017-03-24 20:44:58', '1', '2017-03-24 20:44:58', '0', '0');
INSERT INTO `product` VALUES ('p17032400046', 'aaa', '1', '22.00', '2.00', '', 'upload/product/p17032400046/p17032400046_listimg.jpg', '0', '0', 'u170318002', '1', '2017-03-24 21:08:45', '1', '2017-03-24 21:08:45', '0', '0');
INSERT INTO `product` VALUES ('p17032600047', '测试课程1', '2', '22.00', '12.00', '', 'upload/product/p17032600047/p17032600047_listimg.png', '1', '1', 'u170324004', '1', '2017-03-26 09:50:28', '0', '2017-03-26 09:50:28', '0', '0');
INSERT INTO `product` VALUES ('p17032700048', '测试上班1', '1', '33.00', '3.00', '产品介绍测试', 'upload/product/p17032700048/p17032700048_listimg.jpg', '0', '99', 'u170324003', '1', '2017-03-27 22:25:52', '0', '2017-03-27 22:25:52', null, null);
INSERT INTO `product` VALUES ('p17032700049', '测试商品222', '1', '222.00', '2.00', '', 'upload/product/p17032700049/p17032700049_listimg.jpg', '0', '99', 'u170324003', '3', '2017-03-27 22:28:38', '0', '2017-03-27 22:28:38', null, null);
INSERT INTO `product` VALUES ('p17032700050', '测试1121', '1', '22.00', '22.00', '', 'upload/product/p17032700050/p17032700050_listimg.jpg', '0', '99', 'u170324003', '1', '2017-03-27 22:30:21', '0', '2017-03-27 22:30:21', null, null);
INSERT INTO `product` VALUES ('p17032800051', '测试IE1', '1', '22.00', '2.00', '', 'upload/product/p17032800051/p17032800051_listimg.jpg', '0', '99', 'u170324003', '1', '2017-03-28 12:17:58', '0', '2017-03-28 12:17:58', null, null);
INSERT INTO `product` VALUES ('p17032900057', '测试MyBatis1', '2', '222.00', '2.00', '发发发', 'upload/product/p17032900057/p17032900057_listimg.jpg', '1', '99', 'u170324004', '1', '2017-03-29 15:09:26', '0', '2017-03-29 15:09:26', null, null);
INSERT INTO `product` VALUES ('p17032900058', '测试MyBatis2', '2', '33.00', '3.00', '方法', 'upload/product/p17032900058/p17032900058_listimg.jpg', '1', '4', 'u170324003', '1', '2017-03-29 15:16:34', '0', '2017-03-29 15:16:34', null, null);
INSERT INTO `product` VALUES ('p17033100059', '啊啊', '1', '11.00', '11.00', '方法', 'upload/product/p17033100059/p17033100059_listimg.jpg', '0', '1', 'u170318002', '1', '2017-03-31 16:21:32', '0', '2017-03-31 16:21:32', null, null);

-- ----------------------------
-- Table structure for product_image
-- ----------------------------
DROP TABLE IF EXISTS `product_image`;
CREATE TABLE `product_image` (
  `imageid` varchar(15) NOT NULL COMMENT '主键。产品主图id。生成规则：所属产品ID+‘_2位数字’。例如p17031200001_01',
  `path` varchar(500) DEFAULT NULL COMMENT '对应的图片存储路径',
  `pid` varchar(12) DEFAULT NULL COMMENT '所属的产品id',
  PRIMARY KEY (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品对应的图片表。';

-- ----------------------------
-- Records of product_image
-- ----------------------------
INSERT INTO `product_image` VALUES ('p17032200016_1', 'upload/product/p17032200016/p17032200016_mainimg_1.png', 'p17032200016');
INSERT INTO `product_image` VALUES ('p17032200016_2', 'upload/product/p17032200016/p17032200016_mainimg_2.png', 'p17032200016');
INSERT INTO `product_image` VALUES ('p17032200016_3', 'upload/product/p17032200016/p17032200016_mainimg_3.png', 'p17032200016');
INSERT INTO `product_image` VALUES ('p17032200017_1', 'upload/product/p17032200017/p17032200017_mainimg_1.png', 'p17032200017');
INSERT INTO `product_image` VALUES ('p17032200017_2', 'upload/product/p17032200017/p17032200017_mainimg_2.png', 'p17032200017');
INSERT INTO `product_image` VALUES ('p17032200017_3', 'upload/product/p17032200017/p17032200017_mainimg_3.png', 'p17032200017');
INSERT INTO `product_image` VALUES ('p17032200018_1', 'upload/product/p17032200018/p17032200018_mainimg_1.png', 'p17032200018');
INSERT INTO `product_image` VALUES ('p17032200018_2', 'upload/product/p17032200018/p17032200018_mainimg_2.png', 'p17032200018');
INSERT INTO `product_image` VALUES ('p17032200018_3', 'upload/product/p17032200018/p17032200018_mainimg_3.png', 'p17032200018');
INSERT INTO `product_image` VALUES ('p17032300019_1', 'upload/product/p17032300019/p17032300019_mainimg_1.png', 'p17032300019');
INSERT INTO `product_image` VALUES ('p17032300019_2', 'upload/product/p17032300019/p17032300019_mainimg_2.png', 'p17032300019');
INSERT INTO `product_image` VALUES ('p17032300019_3', 'upload/product/p17032300019/p17032300019_mainimg_3.png', 'p17032300019');
INSERT INTO `product_image` VALUES ('p17032300020_1', 'upload/product/p17032300020/p17032300020_mainimg_1.png', 'p17032300020');
INSERT INTO `product_image` VALUES ('p17032300020_2', 'upload/product/p17032300020/p17032300020_mainimg_2.png', 'p17032300020');
INSERT INTO `product_image` VALUES ('p17032300020_3', 'upload/product/p17032300020/p17032300020_mainimg_3.png', 'p17032300020');
INSERT INTO `product_image` VALUES ('p17032300021_1', 'upload/product/p17032300021/p17032300021_mainimg_1.png', 'p17032300021');
INSERT INTO `product_image` VALUES ('p17032300021_2', 'upload/product/p17032300021/p17032300021_mainimg_2.png', 'p17032300021');
INSERT INTO `product_image` VALUES ('p17032300021_3', 'upload/product/p17032300021/p17032300021_mainimg_3.png', 'p17032300021');
INSERT INTO `product_image` VALUES ('p17032300034_1', 'upload/product/p17032300034/p17032300034_mainimg_1.png', 'p17032300034');
INSERT INTO `product_image` VALUES ('p17032300034_2', 'upload/product/p17032300034/p17032300034_mainimg_2.png', 'p17032300034');
INSERT INTO `product_image` VALUES ('p17032300034_3', 'upload/product/p17032300034/p17032300034_mainimg_3.png', 'p17032300034');
INSERT INTO `product_image` VALUES ('p17032300035_1', 'upload/product/p17032300035/p17032300035_mainimg_1.png', 'p17032300035');
INSERT INTO `product_image` VALUES ('p17032300035_2', 'upload/product/p17032300035/p17032300035_mainimg_2.png', 'p17032300035');
INSERT INTO `product_image` VALUES ('p17032300035_3', 'upload/product/p17032300035/p17032300035_mainimg_3.png', 'p17032300035');
INSERT INTO `product_image` VALUES ('p17032300036_1', 'upload/product/p17032300036/p17032300036_mainimg_1.png', 'p17032300036');
INSERT INTO `product_image` VALUES ('p17032300036_2', 'upload/product/p17032300036/p17032300036_mainimg_2.png', 'p17032300036');
INSERT INTO `product_image` VALUES ('p17032300036_3', 'upload/product/p17032300036/p17032300036_mainimg_3.png', 'p17032300036');
INSERT INTO `product_image` VALUES ('p17032300042_1', 'upload/product/p17032300042/p17032300042_mainimg_1.png', 'p17032300042');
INSERT INTO `product_image` VALUES ('p17032300042_2', 'upload/product/p17032300042/p17032300042_mainimg_2.png', 'p17032300042');
INSERT INTO `product_image` VALUES ('p17032600047_1', 'upload/product/p17032600047/p17032600047_mainimg_1.png', 'p17032600047');
INSERT INTO `product_image` VALUES ('p17032600047_2', 'upload/product/p17032600047/p17032600047_mainimg_2.png', 'p17032600047');
INSERT INTO `product_image` VALUES ('p17032600047_3', 'upload/product/p17032600047/p17032600047_mainimg_3.png', 'p17032600047');
INSERT INTO `product_image` VALUES ('p17032700048_1', 'upload/product/p17032700048/p17032700048_mainimg_1.jpg', 'p17032700048');
INSERT INTO `product_image` VALUES ('p17032700048_2', 'upload/product/p17032700048/p17032700048_mainimg_2.jpg', 'p17032700048');
INSERT INTO `product_image` VALUES ('p17032700048_3', 'upload/product/p17032700048/p17032700048_mainimg_3.jpg', 'p17032700048');
INSERT INTO `product_image` VALUES ('p17032700049_1', 'upload/product/p17032700049/p17032700049_mainimg_1.jpg', 'p17032700049');
INSERT INTO `product_image` VALUES ('p17032700049_2', 'upload/product/p17032700049/p17032700049_mainimg_2.jpg', 'p17032700049');
INSERT INTO `product_image` VALUES ('p17032700049_3', 'upload/product/p17032700049/p17032700049_mainimg_3.jpg', 'p17032700049');
INSERT INTO `product_image` VALUES ('p17032700050_1', 'upload/product/p17032700050/p17032700050_mainimg_1.jpg', 'p17032700050');
INSERT INTO `product_image` VALUES ('p17032700050_2', 'upload/product/p17032700050/p17032700050_mainimg_2.jpg', 'p17032700050');
INSERT INTO `product_image` VALUES ('p17032700050_3', 'upload/product/p17032700050/p17032700050_mainimg_3.jpg', 'p17032700050');
INSERT INTO `product_image` VALUES ('p17032800051_1', 'upload/product/p17032800051/p17032800051_mainimg_1.jpg', 'p17032800051');
INSERT INTO `product_image` VALUES ('p17032800051_2', 'upload/product/p17032800051/p17032800051_mainimg_2.jpg', 'p17032800051');
INSERT INTO `product_image` VALUES ('p17032800051_3', 'upload/product/p17032800051/p17032800051_mainimg_3.jpg', 'p17032800051');
INSERT INTO `product_image` VALUES ('p17032900057_1', 'upload/product/p17032900057/p17032900057_mainimg_1.jpg', 'p17032900057');
INSERT INTO `product_image` VALUES ('p17032900057_2', 'upload/product/p17032900057/p17032900057_mainimg_2.jpg', 'p17032900057');
INSERT INTO `product_image` VALUES ('p17032900057_3', 'upload/product/p17032900057/p17032900057_mainimg_3.jpg', 'p17032900057');
INSERT INTO `product_image` VALUES ('p17032900058_1', 'upload/product/p17032900058/p17032900058_mainimg_1.jpg', 'p17032900058');
INSERT INTO `product_image` VALUES ('p17032900058_2', 'upload/product/p17032900058/p17032900058_mainimg_2.jpg', 'p17032900058');
INSERT INTO `product_image` VALUES ('p17032900058_3', 'upload/product/p17032900058/p17032900058_mainimg_3.jpg', 'p17032900058');
INSERT INTO `product_image` VALUES ('p17033100059_1', 'upload/product/p17033100059/p17033100059_mainimg_1.jpg', 'p17033100059');
INSERT INTO `product_image` VALUES ('p17033100059_2', 'upload/product/p17033100059/p17033100059_mainimg_2.jpg', 'p17033100059');
INSERT INTO `product_image` VALUES ('p17033100059_3', 'upload/product/p17033100059/p17033100059_mainimg_3.jpg', 'p17033100059');

-- ----------------------------
-- Table structure for recharge
-- ----------------------------
DROP TABLE IF EXISTS `recharge`;
CREATE TABLE `recharge` (
  `recid` varchar(12) NOT NULL COMMENT '主键。充值id，规则为，r+年+月+日+5位数字，例如r17031100001',
  `recamount` decimal(6,2) NOT NULL COMMENT '充值金额',
  `cid` varchar(12) NOT NULL COMMENT '充值客户的id',
  `issucc` varchar(1) DEFAULT '0' COMMENT '知否是否成功',
  `transaction_id` varchar(32) DEFAULT NULL COMMENT '微信支付订单id',
  `recdatetime` datetime NOT NULL COMMENT '充值时间',
  `isdel` varchar(1) DEFAULT '0' COMMENT '当前充值是否为已删除状态。1:已删除，0:正常。',
  PRIMARY KEY (`recid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值信息表。';

-- ----------------------------
-- Records of recharge
-- ----------------------------
INSERT INTO `recharge` VALUES ('r17040400003', '0.01', 'c17033100021', '0', null, '2017-04-04 21:59:41', '0');
INSERT INTO `recharge` VALUES ('r17040400004', '0.01', 'c17033100021', '0', null, '2017-04-04 22:33:31', '0');
INSERT INTO `recharge` VALUES ('r17040400005', '0.01', 'c17033100021', '0', null, '2017-04-04 22:47:10', '0');
INSERT INTO `recharge` VALUES ('r17040400006', '0.01', 'c17033100021', '0', null, '2017-04-04 22:47:14', '0');
INSERT INTO `recharge` VALUES ('r17040400007', '0.01', 'c17033100021', '0', null, '2017-04-04 22:47:16', '0');
INSERT INTO `recharge` VALUES ('r17040400008', '0.01', 'c17033100021', '0', null, '2017-04-04 22:47:18', '0');
INSERT INTO `recharge` VALUES ('r17040400009', '0.01', 'c17033100021', '0', null, '2017-04-04 22:47:20', '0');
INSERT INTO `recharge` VALUES ('r17040400010', '0.01', 'c17033100021', '0', null, '2017-04-04 22:47:21', '0');
INSERT INTO `recharge` VALUES ('r17040400011', '0.01', 'c17033100021', '0', null, '2017-04-04 22:47:21', '0');
INSERT INTO `recharge` VALUES ('r17040400012', '0.01', 'c17033100021', '0', null, '2017-04-04 22:47:22', '0');
INSERT INTO `recharge` VALUES ('r17040400013', '0.01', 'c17033100021', '0', null, '2017-04-04 22:47:23', '0');
INSERT INTO `recharge` VALUES ('r17040400014', '0.01', 'c17033100021', '0', null, '2017-04-04 22:47:24', '0');
INSERT INTO `recharge` VALUES ('r17040400015', '0.01', 'c17033100021', '0', null, '2017-04-04 22:47:24', '0');
INSERT INTO `recharge` VALUES ('r17040400016', '0.01', 'c17033100021', '0', null, '2017-04-04 22:47:25', '0');
INSERT INTO `recharge` VALUES ('r17040400017', '0.01', 'c17033100021', '0', null, '2017-04-04 22:47:26', '0');
INSERT INTO `recharge` VALUES ('r17040400018', '0.01', 'c17033100021', '0', null, '2017-04-04 22:47:27', '0');
INSERT INTO `recharge` VALUES ('r17040400019', '0.01', 'c17033100021', '0', null, '2017-04-04 22:47:27', '0');
INSERT INTO `recharge` VALUES ('r17040400020', '0.01', 'c17033100021', '0', null, '2017-04-04 22:47:28', '0');
INSERT INTO `recharge` VALUES ('r17040400021', '0.01', 'c17033100021', '0', null, '2017-04-04 22:47:34', '0');

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
INSERT INTO `sequence` VALUES ('course_seq', '24', '1', '100000');
INSERT INTO `sequence` VALUES ('customer_seq', '24', '1', '100000');
INSERT INTO `sequence` VALUES ('product_seq', '59', '1', '100000');
INSERT INTO `sequence` VALUES ('recharge_seq', '21', '1', '100000');
INSERT INTO `sequence` VALUES ('user_seq', '40', '1', '1000');

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
INSERT INTO `test` VALUES ('111', '哈哈');
INSERT INTO `test` VALUES ('444', '哈哈');

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
INSERT INTO `user` VALUES ('u170318002', '小明', null, 'c493fe01749b3add91214af329c98761', '1', '1', null, '', '1', '2017-03-18 10:04:06', null, null, null, '99');
INSERT INTO `user` VALUES ('u170324003', '管理员', null, '8880443972f045283ee4e0729e668fa6', '1', '1', null, '', '1', '2017-03-24 21:50:39', null, null, null, '99');
INSERT INTO `user` VALUES ('u170324004', '小军', null, 'fce369dc41110b892caab8d222c08e29', '1', '1', null, '', '1', '2017-03-24 21:51:08', null, null, null, '99');
INSERT INTO `user` VALUES ('u170328006', 'sss', '11111111111', '7c5122595e3e248ca8472797fdb0bcec', '1', '1', '', 'fff', '1', '2017-03-28 20:25:30', null, null, null, '99');
INSERT INTO `user` VALUES ('u170329010', '测试1', '18764678231', 'c071bd38e4c31ed73ec02faa32b52e4a', '1', '1', '', '', '1', '2017-03-29 11:00:41', null, null, null, '99');
INSERT INTO `user` VALUES ('u170329011', 'xxx', '18697613456', 'dad3a37aa9d50688b5157698acfd7aee', '1', '1', '', '', '1', '2017-03-29 19:00:50', null, null, null, '99');
INSERT INTO `user` VALUES ('u170330012', 'test', '13232323232', '05a671c66aefea124cc08b76ea6d30bb', '1', '1', '', 'ff', '1', '2017-03-30 14:53:50', null, null, null, '99');
INSERT INTO `user` VALUES ('u170330013', '管理员1', '12341234567', 'abcbbfaea4e618fa7f88cb6b47c6969c', '1', '2', 'admin1', '', '0', '2017-03-30 16:42:56', null, null, null, '99');
INSERT INTO `user` VALUES ('u170330017', 'admin1', '13829121111', '2ad674cee8744e94ae37d7b20e442e0a', '1', '2', 'admin12', '', '0', '2017-03-30 19:45:24', null, null, null, '99');
INSERT INTO `user` VALUES ('u170330018', 'admin2', '12312312312', 'af8eb328301d219cfd1d50e6c6a48f58', '1', '2', 'admin2', '', '0', '2017-03-30 19:45:47', null, null, null, '99');
INSERT INTO `user` VALUES ('u170330019', 'admin3', '12312312312', '7169390683d2b222ba778ca6374b59d3', '1', '2', null, '发发发1', '1', '2017-03-30 19:46:05', null, null, null, '99');
INSERT INTO `user` VALUES ('u170330020', 'aaa1', '11111111112', '3dbe00a167653a1aaee01d93e77e730e', '2', '1', null, 'q', '1', '2017-03-30 20:06:30', null, null, null, '99');
INSERT INTO `user` VALUES ('u170331021', '测试掌门1', null, '42b72f913c3201fc62660d512f5ac746', '2', '1', null, null, '1', '2017-03-31 15:23:14', '职业经理人', '测试\r\n回车\r\n还是', 'upload/master/u170331021/u170331021.jpg', '99');
INSERT INTO `user` VALUES ('u170331022', '管理员3', '12345678910', '7169390683d2b222ba778ca6374b59d3', '2', '2', null, '', '1', '2017-03-31 19:25:52', null, null, null, '99');
INSERT INTO `user` VALUES ('u170331023', '小军', '18769796123', 'fce369dc41110b892caab8d222c08e29', '1', '1', 'xj', null, '0', '2017-03-31 19:56:04', '经理', '资深经理', 'upload/master/u170331023/u170331023.jpg', '99');
INSERT INTO `user` VALUES ('u170331024', '大职门掌门人', '18769785246', '8880443972f045283ee4e0729e668fa6', '1', '1', 'dzm', null, '0', '2017-03-31 19:56:32', '掌门人', '', 'upload/master/u170331024/u170331024.jpg', '99');
INSERT INTO `user` VALUES ('u170401025', '小米', '18769796456', 'c493fe01749b3add91214af329c98761', '1', '1', 'xm', null, '0', '2017-04-01 15:04:52', '经理', '', 'upload/master/u170401025/u170401025.jpg', '99');
INSERT INTO `user` VALUES ('u170404027', '测试修改seq掌门', '12345678901', '42b72f913c3201fc62660d512f5ac746', '1', '1', 'test1', null, '0', '2017-04-04 16:18:59', '测试修改seq掌门', '', 'upload/master/u170404027/u170404027.jpg', '99');

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
