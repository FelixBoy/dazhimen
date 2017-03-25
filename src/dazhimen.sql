/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : dazhimen

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2017-03-24 21:47:34
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
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `courseid` varchar(14) NOT NULL COMMENT '主键。课程id。生成规则：cou+年+月+日+5位数字。例如：cou17031300002',
  `name` varchar(100) DEFAULT NULL COMMENT '课程名称',
  `istry` varchar(1) DEFAULT NULL COMMENT '是否试学。1:试学，0:非试学。',
  `sort` varchar(2) DEFAULT NULL COMMENT '排序标志。0代表按时间排序。1-99代表按手动指定的序号排序。',
  `audiopath` varchar(500) DEFAULT NULL COMMENT '音频存储地址',
  `pid` varchar(12) DEFAULT NULL COMMENT '所属产品ID',
  PRIMARY KEY (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程信息表。';

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
  `createdate` datetime DEFAULT NULL COMMENT '客户账号生成时间',
  `age` int(3) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='前台客户信息表。';

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
-- Table structure for ir_order_product
-- ----------------------------
DROP TABLE IF EXISTS `ir_order_product`;
CREATE TABLE `ir_order_product` (
  `orid` varchar(13) NOT NULL COMMENT '订单ID',
  `pid` varchar(12) NOT NULL COMMENT '订单中的产品ID',
  PRIMARY KEY (`orid`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单与产品的关联关系表。';

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
-- Table structure for ir_user_role
-- ----------------------------
DROP TABLE IF EXISTS `ir_user_role`;
CREATE TABLE `ir_user_role` (
  `uid` varchar(10) NOT NULL COMMENT '用户ID',
  `rid` varchar(4) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`uid`,`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户分配的角色信息表。';

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
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
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
  `indexsort` varchar(3) DEFAULT '999' COMMENT '首页排名。999代表按上架时间排序，1-998代表手动排序的顺序',
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
-- Table structure for recharge
-- ----------------------------
DROP TABLE IF EXISTS `recharge`;
CREATE TABLE `recharge` (
  `recid` varchar(12) NOT NULL COMMENT '主键。充值id，规则为，r+年+月+日+5位数字，例如r17031100001',
  `recamount` decimal(6,2) NOT NULL COMMENT '充值金额',
  `cid` varchar(12) NOT NULL COMMENT '充值客户的id',
  `uid` varchar(10) DEFAULT NULL COMMENT '此字段只在后台添加充值时，有用。正常前台客户充值，此字段为null。后台添加充值，记录添加充值的用户id。',
  `recdatetime` datetime NOT NULL COMMENT '充值时间',
  `isdel` varchar(1) DEFAULT '0' COMMENT '当前充值是否为已删除状态。1:已删除，0:正常。',
  PRIMARY KEY (`recid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值信息表。';

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
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `id` varchar(10) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台用户信息表。注意，type字段用于区分 当前用户是掌门还是管理员。';

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


-- ----------------------------
-- Records of codemap
-- ----------------------------
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
-- Records of sequence
-- ----------------------------
INSERT INTO `sequence` VALUES ('customer_seq', '1', '1', '100000');
INSERT INTO `sequence` VALUES ('product_seq', '1', '1', '100000');
INSERT INTO `sequence` VALUES ('user_seq', '1', '1', '1000');


-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('u170318002', '小明', '13569721354', 'c493fe01749b3add91214af329c98761', '1', '1', 'xm', '', '0', '2017-03-18 10:04:06', null, null, null);
INSERT INTO `user` VALUES ('u170324003', '管理员', '18764678231', '8880443972f045283ee4e0729e668fa6', '1', '1', 'dzm', '', '0', '2017-03-24 21:50:39', null, null, null);
INSERT INTO `user` VALUES ('u170324004', '小军', '18697613456', 'fce369dc41110b892caab8d222c08e29', '1', '1', 'xj', '', '0', '2017-03-24 21:51:08', null, null, null);

