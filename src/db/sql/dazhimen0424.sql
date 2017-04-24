/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : dazhimen

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2017-04-24 18:44:20
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
  `sort` varchar(3) DEFAULT '99' COMMENT '排序标志。999代表按时间排序。1-99代表按手动指定的序号排序。',
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
INSERT INTO `course` VALUES ('cou17032700007', '课程1', null, '99', 'upload/product/p17032700050/course/cou17032700007.mp3', '2017-03-27 22:32:47', '2017-03-27 22:32:47', '9', 'p17032700050');
INSERT INTO `course` VALUES ('cou17032700008', '课程2', '1', '99', 'upload/product/p17032700050/course/cou17032700008.mp3', '2017-03-27 22:33:06', '2017-03-27 22:33:06', '29', 'p17032700050');
INSERT INTO `course` VALUES ('cou17032700009', '课程1', null, '99', 'upload/product/p17032700050/course/cou17032700009.mp3', '2017-03-27 22:33:19', '2017-03-27 22:33:19', '1', 'p17032700050');
INSERT INTO `course` VALUES ('cou17032700010', '课程1', null, '99', 'upload/product/p17032700050/course/cou17032700010.mp3', '2017-03-27 22:33:49', '2017-03-27 22:33:49', '2', 'p17032700050');
INSERT INTO `course` VALUES ('cou17032800011', '课程1', '1', '99', 'upload/product/p17032700049/course/cou17032800011.mp3', '2017-03-28 11:49:15', '2017-03-28 11:49:15', '40', 'p17032700049');
INSERT INTO `course` VALUES ('cou17032800012', '大音频课程', null, '99', 'upload/product/p17032700049/course/cou17032800012.mp3', '2017-03-28 16:30:52', '2017-03-28 16:30:52', '5', 'p17032700049');
INSERT INTO `course` VALUES ('cou17041800014', 'sunxy', '1', '99', 'upload/product//course/cou17041800014.mp3', '2017-04-18 12:23:28', '2017-04-18 12:23:28', '0', '');
INSERT INTO `course` VALUES ('cou17041800015', ' 音频测试', '1', '99', 'upload/product/p17041800076/course/cou17041800015.mp3', '2017-04-18 12:25:38', '2017-04-19 14:05:05', '47', 'p17041800076');
INSERT INTO `course` VALUES ('cou17042400016', 'jkhkhkhkh', '1', '99', 'upload/product/p17042400078/course/cou17042400016.mp3', '2017-04-24 11:03:13', '2017-04-24 11:03:13', '0', 'p17042400078');
INSERT INTO `course` VALUES ('cou17042400017', 'oljklkklklk', '0', '99', 'upload/product/p17042400078/course/cou17042400017.mp3', '2017-04-24 11:04:00', '2017-04-24 11:04:00', '0', 'p17042400078');
INSERT INTO `course` VALUES ('cou17042400018', 'oljklkklklk', '0', '99', 'upload/product/p17042400078/course/cou17042400018.mp3', '2017-04-24 11:04:30', '2017-04-24 11:04:30', '0', 'p17042400078');
INSERT INTO `course` VALUES ('cou17042400019', '发的说法', '0', '2', 'upload/product/p17042400079/course/cou17042400019.mp3', '2017-04-24 11:19:38', '2017-04-24 16:09:22', '0', 'p17042400079');
INSERT INTO `course` VALUES ('cou17042400020', '阿凡达是', '0', '99', 'upload/product/p17042400079/course/cou17042400020.mp3', '2017-04-24 11:20:23', '2017-04-24 11:20:23', '0', 'p17042400079');
INSERT INTO `course` VALUES ('cou17042400021', '发的说法', '0', '99', 'upload/product/p17042400079/course/cou17042400021.mp3', '2017-04-24 11:21:11', '2017-04-24 11:21:11', '0', 'p17042400079');
INSERT INTO `course` VALUES ('cou17042400022', 'fdsf', '0', '99', 'upload/product/p17042400079/course/cou17042400022.mp3', '2017-04-24 11:23:29', '2017-04-24 11:23:29', '0', 'p17042400079');
INSERT INTO `course` VALUES ('cou17042400023', 'fdasf', '0', '1', 'upload/product/p17042400080/course/cou17042400023.mp3', '2017-04-24 11:28:05', '2017-04-24 12:49:09', '0', 'p17042400080');
INSERT INTO `course` VALUES ('cou17042400024', 'fdasf', '0', '2', 'upload/product/p17042400080/course/cou17042400024.mp3', '2017-04-24 11:41:42', '2017-04-24 16:12:54', '0', 'p17042400080');
INSERT INTO `course` VALUES ('cou17042400025', 'fadsf', '0', '5', 'upload/product/p17042400080/course/cou17042400025.mp3', '2017-04-24 12:11:53', '2017-04-24 12:51:10', '0', 'p17042400080');
INSERT INTO `course` VALUES ('cou17042400026', 'fagadsg', '0', '3', 'upload/product/p17042400080/course/cou17042400026.mp3', '2017-04-24 12:50:40', '2017-04-24 16:32:26', '0', 'p17042400080');
INSERT INTO `course` VALUES ('cou17042400027', 'fadsfasf', '0', '4', 'upload/product/p17042400080/course/cou17042400027.mp3', '2017-04-24 12:51:23', '2017-04-24 12:51:23', '0', 'p17042400080');
INSERT INTO `course` VALUES ('cou17042400028', 'fads', '0', '99', 'upload/product/p17042400080/course/cou17042400028.mp3', '2017-04-24 12:51:32', '2017-04-24 12:51:32', '0', 'p17042400080');
INSERT INTO `course` VALUES ('cou17042400029', 'fdsafas', '1', '99', 'upload/product/p17042400080/course/cou17042400029.mp3', '2017-04-24 14:10:53', '2017-04-24 16:32:20', '0', 'p17042400080');
INSERT INTO `course` VALUES ('cou17042400030', 'fdsaf', '1', '99', 'upload/product/p17042400080/course/cou17042400030.mp3', '2017-04-24 16:16:12', '2017-04-24 16:16:12', '0', 'p17042400080');
INSERT INTO `course` VALUES ('cou17042400031', 'fdsafaf', '0', '2', 'upload/product/p17041800076/course/cou17042400031.mp3', '2017-04-24 16:16:33', '2017-04-24 16:16:33', '0', 'p17041800076');

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
INSERT INTO `customer` VALUES ('c17033100040', '啦啦啦啦啦啦啦啦图因为我哦兔', '13520197512', '无名', '177688028@qq.com', '1', 'upload/customer/c17033100040/c17033100040_header.jpg', '女', null, '0', null, null, null, 'oMQfAwXcAKPXmWzOVOlsuEd5TcPI', '2.14', '2017-03-31 14:30:48', null);
INSERT INTO `customer` VALUES ('c17033100041', '大职门', '18203659178', '', '', '0', 'upload/customer/c17033100041/c17033100041_header.jpg', '男', null, '0', null, 'F02412E525995D97B2D870458D239D5B', null, null, '1.84', '2017-03-31 14:34:38', null);
INSERT INTO `customer` VALUES ('c17040700042', null, '18765826282', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-07 14:03:53', null);
INSERT INTO `customer` VALUES ('c17040700043', null, '18203659804', null, null, null, 'upload/customer/c17040700043/c17040700043_header.jpg', null, null, '0', null, null, null, null, '0.01', '2017-04-07 21:26:54', null);
INSERT INTO `customer` VALUES ('c17040700044', null, '13960850472', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-07 21:56:30', null);
INSERT INTO `customer` VALUES ('c17040800045', null, '15203659178', null, null, null, null, null, null, '0', null, null, null, null, '0.02', '2017-04-08 02:28:40', null);
INSERT INTO `customer` VALUES ('c17040900056', '电子邮', '18765806282', null, '2222s', '4', null, '男', null, '0', null, null, null, null, '0.00', '2017-04-09 10:16:38', null);
INSERT INTO `customer` VALUES ('c17040900071', '齐路军', '15688731300', '齐路军', '', '0', null, '男', null, '0', null, null, null, null, '0.00', '2017-04-09 22:07:45', null);
INSERT INTO `customer` VALUES ('c17040900074', '就看看空间看了哈哈哈哈图看看就看见了看了看看了哈哈哈哈哈哈哈', '18765806281', '哈喽', 't123456@qq.com', '4', 'upload/customer/c17040900074/c17040900074_header.png', '女', null, '0', null, null, null, 'oMQfAwSdglfEertT0X_TQKVrw-bk', '0.10', '2017-04-09 23:32:39', null);
INSERT INTO `customer` VALUES ('c17040900075', '声动科技', null, null, null, null, 'http://wx.qlogo.cn/mmopen/LYtgjZVNSVWast5VGBHd2NcLiaZopmicjaW6j8PajhQFDALu5ed4ZgOEBbhCPIh9cCgibIz4a63PI1RCs22WwkhibR01bEEfbK7m/0', '0', null, '0', null, null, null, 'oMQfAwbDWWjmukOi5QgbnODyHBEo', '0.01', '2017-04-09 23:39:08', null);
INSERT INTO `customer` VALUES ('c17041300076', null, '13380574089', null, null, null, 'upload/customer/c17041300076/c17041300076_header.jpg', null, null, '0', null, null, null, null, '0.00', '2017-04-13 09:04:12', null);
INSERT INTO `customer` VALUES ('c17041400077', '哈喽', '13965087452', '哈喽', '', '0', 'upload/customer/c17041400077/c17041400077_header.jpg', '男', null, '0', null, null, null, null, '0.01', '2017-04-14 07:39:58', null);
INSERT INTO `customer` VALUES ('c17041400078', null, '13717718808', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-14 09:41:50', null);
INSERT INTO `customer` VALUES ('c17041500079', null, '13960874098', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-15 21:33:35', null);
INSERT INTO `customer` VALUES ('c17041600080', null, '13470841208', null, null, null, null, null, null, '0', null, null, null, null, '0.01', '2017-04-16 09:35:19', null);
INSERT INTO `customer` VALUES ('c17041600081', null, '13080963850', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-16 13:46:35', null);
INSERT INTO `customer` VALUES ('c17041600082', null, '13908740520', null, null, null, null, null, null, '0', null, null, null, null, '0.01', '2017-04-16 15:21:40', null);
INSERT INTO `customer` VALUES ('c17041600083', null, '13370840896', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-16 15:51:39', null);
INSERT INTO `customer` VALUES ('c17041600084', null, '13408965074', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-16 16:00:01', null);
INSERT INTO `customer` VALUES ('c17041600085', null, '13470896305', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-16 16:01:31', null);
INSERT INTO `customer` VALUES ('c17041600086', null, '13980740856', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-16 16:06:04', null);
INSERT INTO `customer` VALUES ('c17041600087', null, '13740896084', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-16 16:06:57', null);
INSERT INTO `customer` VALUES ('c17041600088', null, '13748096350', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-16 16:13:09', null);
INSERT INTO `customer` VALUES ('c17041600089', null, '13740708508', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-16 16:13:59', null);
INSERT INTO `customer` VALUES ('c17041600090', null, '13520497512', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-16 16:22:13', null);
INSERT INTO `customer` VALUES ('c17041600091', null, '13809630874', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-16 17:10:33', null);
INSERT INTO `customer` VALUES ('c17041600092', null, '13508960874', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-16 17:11:29', null);
INSERT INTO `customer` VALUES ('c17041600093', null, '13520197510', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-16 17:20:05', null);
INSERT INTO `customer` VALUES ('c17041600094', null, '13520197518', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-16 23:25:51', null);
INSERT INTO `customer` VALUES ('c17041600095', null, '13717710890', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-16 23:34:04', null);
INSERT INTO `customer` VALUES ('c17041700096', null, '13309871209', null, null, null, 'upload/customer/c17041700096/c17041700096_header.jpg', null, null, '0', null, null, null, null, '0.00', '2017-04-17 14:22:52', null);
INSERT INTO `customer` VALUES ('c17041800097', '小米测试', null, null, null, null, 'upload/customer/c17041800097/c17041800097_header.png', '0', null, '0', null, null, null, 'oMQfAwaaHGqfarp9GW5jsd3c3Nwg', '0.00', '2017-04-18 10:29:00', null);
INSERT INTO `customer` VALUES ('c17041800098', '啊PK赛别呵呵割肉诺特色色婆婆热了头多咯咯娄看评论投鼠忌器计算机三级京', '13810045952', 'vdhhdhdbhdjdhhsjs5米就听你牛股明明哦你明明明明民工\n饿了就\n', '123@F.com', '2', 'upload/customer/c17041800098/c17041800098_header.png', '男', null, '0', null, 'CCB4839E668FAEB99C3F0E96BC4E0921', null, null, '0.00', '2017-04-18 10:55:24', null);
INSERT INTO `customer` VALUES ('c17041800099', 'iPhone 5s', null, null, null, null, 'https://wx.qlogo.cn/mmopen/Fo30ZKtBBm1fUnTI174m6fyB072Y2LjQ8WkSW7bCq2JtmWM68VjqMj0oo0IZmd8TcKoiaKIC8NibuI8UEtXcvfia7ZGSh2RBJVib/0', '女', null, '0', null, null, null, 'oMQfAwa_G57dKuyGjSqmNo7xURjQ', '0.00', '2017-04-18 10:56:18', null);
INSERT INTO `customer` VALUES ('c17041800100', '回到家的精神世', '18612448479', '图解了', '123@123.com', '2', 'upload/customer/c17041800100/c17041800100_header.jpg', '男', null, '0', null, null, null, null, '0.10', '2017-04-18 10:57:17', null);
INSERT INTO `customer` VALUES ('c17041800101', null, '13520986084', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-18 11:01:40', null);
INSERT INTO `customer` VALUES ('c17041800102', null, '13520987659', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-18 11:07:18', null);
INSERT INTO `customer` VALUES ('c17041800103', null, '13580963580', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-18 12:27:40', null);
INSERT INTO `customer` VALUES ('c17041900104', null, '13374089608', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-19 12:30:24', null);
INSERT INTO `customer` VALUES ('c17041900105', null, '13508963580', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-19 13:50:42', null);
INSERT INTO `customer` VALUES ('c17041900106', null, '13963896370', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-19 15:00:01', null);
INSERT INTO `customer` VALUES ('c17041900107', null, '13520197542', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-19 15:03:15', null);
INSERT INTO `customer` VALUES ('c17041900108', null, '13596807408', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-19 15:25:44', null);
INSERT INTO `customer` VALUES ('c17041900109', null, '13520980740', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-19 15:26:07', null);
INSERT INTO `customer` VALUES ('c17041900110', null, '13520741085', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-19 16:56:32', null);
INSERT INTO `customer` VALUES ('c17041900111', null, '13650896307', null, null, null, null, null, null, '0', null, null, null, null, '0.01', '2017-04-19 21:25:31', null);
INSERT INTO `customer` VALUES ('c17042000112', '', '13264069734', '', '475558885888@1.com', '0', 'upload/customer/c17042000112/c17042000112_header.jpg', '男', null, '0', null, null, null, null, '0.00', '2017-04-20 11:06:50', null);
INSERT INTO `customer` VALUES ('c17042000113', null, '15700000000', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-20 11:10:48', null);
INSERT INTO `customer` VALUES ('c17042000114', '兔兔', '18010041751', '图书', '', '0', 'upload/customer/c17042000114/c17042000114_header.jpg', '男', null, '0', null, null, null, null, '0.02', '2017-04-20 11:15:15', null);
INSERT INTO `customer` VALUES ('c17042000115', '吕布不不不不不不不不不不不不不不不不不可乐了哭了可口可乐路了', '18911961659', '啦啦啦啦啦啦啦啦啦啦啦', '', '0', 'upload/customer/c17042000115/c17042000115_header.jpg', '男', null, '0', null, null, null, null, '0.01', '2017-04-20 11:21:33', null);
INSERT INTO `customer` VALUES ('c17042000116', 'meizuvvv   ', '15712345678', '    ', '  ', '5', 'upload/customer/c17042000116/c17042000116_header.png', '女', null, '0', null, null, null, 'oMQfAwRvwU3jmkqLpbjpiFDOVhAw', '0.00', '2017-04-20 11:38:20', null);
INSERT INTO `customer` VALUES ('c17042000117', 'iPhone6测试', '15700000021', '', '', '0', 'upload/customer/c17042000117/c17042000117_header.jpg', '男', null, '0', null, null, null, 'oMQfAwcaX3NIyeCdGJqNh11DG_Q4', '0.00', '2017-04-20 11:38:20', null);
INSERT INTO `customer` VALUES ('c17042000118', null, '13340987657', null, null, null, 'upload/customer/c17042000118/c17042000118_header.jpg', null, null, '0', null, null, null, null, '0.00', '2017-04-20 17:04:54', null);
INSERT INTO `customer` VALUES ('c17042000119', null, '13580740851', null, null, null, 'upload/customer/c17042000119/c17042000119_header.jpg', null, null, '0', null, null, null, null, '0.00', '2017-04-20 17:38:28', null);
INSERT INTO `customer` VALUES ('c17042000120', null, '13290876890', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-20 17:57:33', null);
INSERT INTO `customer` VALUES ('c17042100121', null, '13698074512', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-21 10:10:40', null);
INSERT INTO `customer` VALUES ('c17042100122', null, '13470895084', null, null, null, 'upload/customer/c17042100122/c17042100122_header.jpg', null, null, '0', null, null, null, null, '0.01', '2017-04-21 11:07:07', null);
INSERT INTO `customer` VALUES ('c17042100123', '', '13240987657', '', '', '2', null, '女', null, '0', null, null, null, null, '0.00', '2017-04-21 11:27:22', null);
INSERT INTO `customer` VALUES ('c17042100124', '信步', null, null, null, null, 'upload/customer/c17042100124/c17042100124_header.jpg', '男', null, '0', null, null, null, 'oMQfAwUAuTKcW05eXOShf0bji6vs', '0.00', '2017-04-21 13:06:02', null);
INSERT INTO `customer` VALUES ('c17042100125', null, '13670294111', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-21 13:10:48', null);
INSERT INTO `customer` VALUES ('c17042100126', null, '13658096374', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-21 14:49:27', null);
INSERT INTO `customer` VALUES ('c17042100127', '小月', '18883865945', '新款', '', '0', 'https://wx.qlogo.cn/mmopen/icFtiaZv653nUYDyOGONykG4s1cRs2XkaOV1OBibshzbQMQwr8rIC9tuwZ7zEYJK6icxE2PhqnPhhyIaZ8niaqxWic9huHh09dQARJ/0', '男', null, '0', null, null, null, 'oMQfAwSSTAsUQ28qyK052wEwO_7s', '0.00', '2017-04-21 16:53:31', null);
INSERT INTO `customer` VALUES ('c17042100128', null, '13696807408', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-21 17:43:45', null);
INSERT INTO `customer` VALUES ('c17042100129', null, '13520197515', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-21 23:24:47', null);
INSERT INTO `customer` VALUES ('c17042100130', null, '13696807456', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-21 23:37:59', null);
INSERT INTO `customer` VALUES ('c17042200131', null, '13560985087', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-22 10:13:24', null);
INSERT INTO `customer` VALUES ('c17042300132', null, '13590685235', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-23 10:21:59', null);
INSERT INTO `customer` VALUES ('c17042300133', '慢慢修', '18769796133', '海杰', 'ffff1@qq.com', '3', null, '女', null, '0', null, null, null, null, '99.99', '2017-04-23 11:21:58', null);
INSERT INTO `customer` VALUES ('c17042300134', null, '13240986540', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-23 12:36:35', null);
INSERT INTO `customer` VALUES ('c17042300135', null, '13540986098', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-23 12:40:07', null);
INSERT INTO `customer` VALUES ('c17042300136', null, '13520984712', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-23 12:45:33', null);
INSERT INTO `customer` VALUES ('c17042300137', null, '13963085407', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-23 19:40:25', null);
INSERT INTO `customer` VALUES ('c17042400138', null, '13508963507', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-04-24 09:34:22', null);

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
INSERT INTO `ir_customer_news` VALUES ('c17033100040', 'n170421017');
INSERT INTO `ir_customer_news` VALUES ('c17033100040', 'n170421019');
INSERT INTO `ir_customer_news` VALUES ('c17042100128', 'n170421018');
INSERT INTO `ir_customer_news` VALUES ('c17042300137', 'n170421019');
INSERT INTO `ir_customer_news` VALUES ('c17042400138', 'n170421019');

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
INSERT INTO `ir_customer_product` VALUES ('c17033100040', 'p17040700052');
INSERT INTO `ir_customer_product` VALUES ('c17033100040', 'p17040700053');
INSERT INTO `ir_customer_product` VALUES ('c17033100040', 'p17040700055');
INSERT INTO `ir_customer_product` VALUES ('c17033100040', 'p17040700056');
INSERT INTO `ir_customer_product` VALUES ('c17033100040', 'p17040700057');
INSERT INTO `ir_customer_product` VALUES ('c17033100040', 'p17041100058');
INSERT INTO `ir_customer_product` VALUES ('c17033100040', 'p17041400060');
INSERT INTO `ir_customer_product` VALUES ('c17033100040', 'p17041800075');
INSERT INTO `ir_customer_product` VALUES ('c17033100040', 'p17041800076');
INSERT INTO `ir_customer_product` VALUES ('c17033100041', 'p17032700049');
INSERT INTO `ir_customer_product` VALUES ('c17033100041', 'p17032700050');
INSERT INTO `ir_customer_product` VALUES ('c17033100041', 'p17033000051');
INSERT INTO `ir_customer_product` VALUES ('c17033100041', 'p17040700054');
INSERT INTO `ir_customer_product` VALUES ('c17033100041', 'p17040700056');
INSERT INTO `ir_customer_product` VALUES ('c17033100041', 'p17041700072');
INSERT INTO `ir_customer_product` VALUES ('c17040700043', 'p17032700050');
INSERT INTO `ir_customer_product` VALUES ('c17040700044', 'p17032700049');
INSERT INTO `ir_customer_product` VALUES ('c17040800045', 'p17032700049');
INSERT INTO `ir_customer_product` VALUES ('c17040800045', 'p17040700056');
INSERT INTO `ir_customer_product` VALUES ('c17040800045', 'p17040700057');
INSERT INTO `ir_customer_product` VALUES ('c17040900071', 'p17040700053');
INSERT INTO `ir_customer_product` VALUES ('c17040900071', 'p17040700054');
INSERT INTO `ir_customer_product` VALUES ('c17041400077', 'p17032700049');
INSERT INTO `ir_customer_product` VALUES ('c17041500079', 'p17032700050');
INSERT INTO `ir_customer_product` VALUES ('c17041600082', 'p17032700049');
INSERT INTO `ir_customer_product` VALUES ('c17041600089', 'p17032700049');
INSERT INTO `ir_customer_product` VALUES ('c17041600089', 'p17033000051');
INSERT INTO `ir_customer_product` VALUES ('c17041600090', 'p17040700053');
INSERT INTO `ir_customer_product` VALUES ('c17041600093', 'p17032700050');
INSERT INTO `ir_customer_product` VALUES ('c17041600095', 'p17033000051');
INSERT INTO `ir_customer_product` VALUES ('c17041600095', 'p17040700056');
INSERT INTO `ir_customer_product` VALUES ('c17041800098', 'p17041700063');
INSERT INTO `ir_customer_product` VALUES ('c17041800100', 'p17041700063');
INSERT INTO `ir_customer_product` VALUES ('c17041800101', 'p17040700057');
INSERT INTO `ir_customer_product` VALUES ('c17042000113', 'p17040700057');
INSERT INTO `ir_customer_product` VALUES ('c17042000113', 'p17041800075');
INSERT INTO `ir_customer_product` VALUES ('c17042000113', 'p17041800076');
INSERT INTO `ir_customer_product` VALUES ('c17042000115', 'p17040700056');
INSERT INTO `ir_customer_product` VALUES ('c17042000115', 'p17041700063');
INSERT INTO `ir_customer_product` VALUES ('c17042000115', 'p17041800076');
INSERT INTO `ir_customer_product` VALUES ('c17042000116', 'p17041800075');
INSERT INTO `ir_customer_product` VALUES ('c17042000117', 'p17040700057');
INSERT INTO `ir_customer_product` VALUES ('c17042100122', 'p17041800075');
INSERT INTO `ir_customer_product` VALUES ('c17042100123', 'p17041800076');
INSERT INTO `ir_customer_product` VALUES ('c17042300137', 'p17040700057');

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
INSERT INTO `ir_customer_view_course` VALUES ('c17033100040', 'cou17032700007');
INSERT INTO `ir_customer_view_course` VALUES ('c17033100040', 'cou17032700008');
INSERT INTO `ir_customer_view_course` VALUES ('c17033100040', 'cou17032700009');
INSERT INTO `ir_customer_view_course` VALUES ('c17033100040', 'cou17032700010');
INSERT INTO `ir_customer_view_course` VALUES ('c17033100040', 'cou17032800011');
INSERT INTO `ir_customer_view_course` VALUES ('c17033100040', 'cou17032800012');
INSERT INTO `ir_customer_view_course` VALUES ('c17033100040', 'cou17041800015');
INSERT INTO `ir_customer_view_course` VALUES ('c17033100041', 'cou17032700007');
INSERT INTO `ir_customer_view_course` VALUES ('c17033100041', 'cou17032700008');
INSERT INTO `ir_customer_view_course` VALUES ('c17033100041', 'cou17032800011');
INSERT INTO `ir_customer_view_course` VALUES ('c17033100041', 'cou17032800012');
INSERT INTO `ir_customer_view_course` VALUES ('c17040900056', 'cou17032700008');
INSERT INTO `ir_customer_view_course` VALUES ('c17040900074', 'cou17032700008');
INSERT INTO `ir_customer_view_course` VALUES ('c17040900074', 'cou17032700010');
INSERT INTO `ir_customer_view_course` VALUES ('c17040900074', 'cou17032800011');
INSERT INTO `ir_customer_view_course` VALUES ('c17040900074', 'cou17041800015');
INSERT INTO `ir_customer_view_course` VALUES ('c17040900075', 'cou17032700008');
INSERT INTO `ir_customer_view_course` VALUES ('c17041400077', 'cou17032700008');
INSERT INTO `ir_customer_view_course` VALUES ('c17041600080', 'cou17032800011');
INSERT INTO `ir_customer_view_course` VALUES ('c17041600089', 'cou17032800011');
INSERT INTO `ir_customer_view_course` VALUES ('c17041600093', 'cou17032700008');
INSERT INTO `ir_customer_view_course` VALUES ('c17041600094', 'cou17032800011');
INSERT INTO `ir_customer_view_course` VALUES ('c17041600095', 'cou17032800011');
INSERT INTO `ir_customer_view_course` VALUES ('c17041700096', 'cou17032800011');
INSERT INTO `ir_customer_view_course` VALUES ('c17041800098', 'cou17041800015');
INSERT INTO `ir_customer_view_course` VALUES ('c17041800100', 'cou17041800015');
INSERT INTO `ir_customer_view_course` VALUES ('c17041900105', 'cou17041800015');
INSERT INTO `ir_customer_view_course` VALUES ('c17041900109', 'cou17032700008');
INSERT INTO `ir_customer_view_course` VALUES ('c17041900109', 'cou17032800011');
INSERT INTO `ir_customer_view_course` VALUES ('c17041900109', 'cou17041800015');
INSERT INTO `ir_customer_view_course` VALUES ('c17042000113', 'cou17041800015');
INSERT INTO `ir_customer_view_course` VALUES ('c17042000115', 'cou17041800015');
INSERT INTO `ir_customer_view_course` VALUES ('c17042000119', 'cou17032800011');
INSERT INTO `ir_customer_view_course` VALUES ('c17042100122', 'cou17032800011');
INSERT INTO `ir_customer_view_course` VALUES ('c17042100123', 'cou17041800015');
INSERT INTO `ir_customer_view_course` VALUES ('c17042400138', 'cou17032800011');

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
INSERT INTO `ir_order_product` VALUES ('or17041401049', 'p17041400060');
INSERT INTO `ir_order_product` VALUES ('or17041401050', 'p17041400060');
INSERT INTO `ir_order_product` VALUES ('or17041401051', 'p17041400060');
INSERT INTO `ir_order_product` VALUES ('or17041401052', 'p17040700052');
INSERT INTO `ir_order_product` VALUES ('or17041601057', 'p17033000051');
INSERT INTO `ir_order_product` VALUES ('or17041601058', 'p17032700049');
INSERT INTO `ir_order_product` VALUES ('or17041601059', 'p17032700049');
INSERT INTO `ir_order_product` VALUES ('or17041601060', 'p17041600061');
INSERT INTO `ir_order_product` VALUES ('or17041601061', 'p17041600061');
INSERT INTO `ir_order_product` VALUES ('or17041601063', 'p17032700049');
INSERT INTO `ir_order_product` VALUES ('or17041601064', 'p17033000051');
INSERT INTO `ir_order_product` VALUES ('or17041601065', 'p17032700049');
INSERT INTO `ir_order_product` VALUES ('or17041601066', 'p17032700049');
INSERT INTO `ir_order_product` VALUES ('or17041601067', 'p17032700049');
INSERT INTO `ir_order_product` VALUES ('or17041601068', 'p17032700049');
INSERT INTO `ir_order_product` VALUES ('or17041601069', 'p17033000051');
INSERT INTO `ir_order_product` VALUES ('or17041601070', 'p17032700049');
INSERT INTO `ir_order_product` VALUES ('or17041601071', 'p17033000051');
INSERT INTO `ir_order_product` VALUES ('or17041601072', 'p17040700057');
INSERT INTO `ir_order_product` VALUES ('or17041701073', 'p17040700057');
INSERT INTO `ir_order_product` VALUES ('or17041701074', 'p17041700072');
INSERT INTO `ir_order_product` VALUES ('or17041701075', 'p17041700063');
INSERT INTO `ir_order_product` VALUES ('or17041701076', 'p17041400060');
INSERT INTO `ir_order_product` VALUES ('or17041701077', 'p17041600061');
INSERT INTO `ir_order_product` VALUES ('or17041801078', 'p17041800076');
INSERT INTO `ir_order_product` VALUES ('or17041901079', 'p17041800075');
INSERT INTO `ir_order_product` VALUES ('or17041901080', 'p17040700052');
INSERT INTO `ir_order_product` VALUES ('or17042001084', 'p17040700057');
INSERT INTO `ir_order_product` VALUES ('or17042001085', 'p17041800075');
INSERT INTO `ir_order_product` VALUES ('or17042001086', 'p17041800075');
INSERT INTO `ir_order_product` VALUES ('or17042001087', 'p17041800075');
INSERT INTO `ir_order_product` VALUES ('or17042101088', 'p17040700057');
INSERT INTO `ir_order_product` VALUES ('or17042101089', 'p17041800076');
INSERT INTO `ir_order_product` VALUES ('or17042101090', 'p17041800076');
INSERT INTO `ir_order_product` VALUES ('or17042101091', 'p17041700063');
INSERT INTO `ir_order_product` VALUES ('or17042301092', 'p17032700049');

-- ----------------------------
-- Table structure for ir_role_module
-- ----------------------------
DROP TABLE IF EXISTS `ir_role_module`;
CREATE TABLE `ir_role_module` (
  `rid` varchar(10) NOT NULL,
  `mid` varchar(20) NOT NULL,
  PRIMARY KEY (`rid`,`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ir_role_module
-- ----------------------------
INSERT INTO `ir_role_module` VALUES ('r170421002', 'admin_manage');
INSERT INTO `ir_role_module` VALUES ('r170421002', 'customer_query');
INSERT INTO `ir_role_module` VALUES ('r170421002', 'indexplay_manage');
INSERT INTO `ir_role_module` VALUES ('r170421002', 'indexsort_manange');
INSERT INTO `ir_role_module` VALUES ('r170421002', 'master_manage');
INSERT INTO `ir_role_module` VALUES ('r170421002', 'news_manage');
INSERT INTO `ir_role_module` VALUES ('r170421002', 'order_query');
INSERT INTO `ir_role_module` VALUES ('r170421002', 'permission_manage');
INSERT INTO `ir_role_module` VALUES ('r170421002', 'product_manage');
INSERT INTO `ir_role_module` VALUES ('r170421002', 'recharge_query');
INSERT INTO `ir_role_module` VALUES ('r170424003', 'admin_manage');
INSERT INTO `ir_role_module` VALUES ('r170424003', 'customer_query');
INSERT INTO `ir_role_module` VALUES ('r170424003', 'indexplay_manage');
INSERT INTO `ir_role_module` VALUES ('r170424003', 'indexsort_manange');
INSERT INTO `ir_role_module` VALUES ('r170424003', 'master_manage');
INSERT INTO `ir_role_module` VALUES ('r170424003', 'news_manage');
INSERT INTO `ir_role_module` VALUES ('r170424003', 'order_query');
INSERT INTO `ir_role_module` VALUES ('r170424003', 'permission_manage');
INSERT INTO `ir_role_module` VALUES ('r170424003', 'product_manage');
INSERT INTO `ir_role_module` VALUES ('r170424003', 'recharge_query');

-- ----------------------------
-- Table structure for ir_user_role
-- ----------------------------
DROP TABLE IF EXISTS `ir_user_role`;
CREATE TABLE `ir_user_role` (
  `uid` varchar(10) NOT NULL COMMENT '用户ID',
  `rid` varchar(10) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`uid`,`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户分配的角色信息表。';

-- ----------------------------
-- Records of ir_user_role
-- ----------------------------
INSERT INTO `ir_user_role` VALUES ('u170324003', 'r170421002');
INSERT INTO `ir_user_role` VALUES ('u170324004', 'r170421002');
INSERT INTO `ir_user_role` VALUES ('u170411007', 'r170421002');
INSERT INTO `ir_user_role` VALUES ('u170411008', 'r170421002');
INSERT INTO `ir_user_role` VALUES ('u170411009', 'r170421002');
INSERT INTO `ir_user_role` VALUES ('u170411010', 'r170421002');
INSERT INTO `ir_user_role` VALUES ('u170411011', 'r170421002');
INSERT INTO `ir_user_role` VALUES ('u170411012', 'r170421002');
INSERT INTO `ir_user_role` VALUES ('u170411013', 'r170421002');
INSERT INTO `ir_user_role` VALUES ('u170411014', 'r170421002');
INSERT INTO `ir_user_role` VALUES ('u170411015', 'r170421002');
INSERT INTO `ir_user_role` VALUES ('u170414031', 'r170421002');
INSERT INTO `ir_user_role` VALUES ('u170418032', 'r170421002');
INSERT INTO `ir_user_role` VALUES ('u170418033', 'r170421002');
INSERT INTO `ir_user_role` VALUES ('u170420034', 'r170421002');
INSERT INTO `ir_user_role` VALUES ('u170420034', 'r170424003');
INSERT INTO `ir_user_role` VALUES ('u170421036', 'r170421002');
INSERT INTO `ir_user_role` VALUES ('u170421036', 'r170424003');
INSERT INTO `ir_user_role` VALUES ('u170421037', 'r170421002');
INSERT INTO `ir_user_role` VALUES ('u170421038', 'r170421002');

-- ----------------------------
-- Table structure for module
-- ----------------------------
DROP TABLE IF EXISTS `module`;
CREATE TABLE `module` (
  `mid` varchar(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL COMMENT '模块名称',
  `remarks` varchar(500) DEFAULT NULL COMMENT '模块备注',
  `sort` int(2) DEFAULT NULL COMMENT '当前模块，在菜单中的位置，用于展示时的排序',
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统中的模块信息表。';

-- ----------------------------
-- Records of module
-- ----------------------------
INSERT INTO `module` VALUES ('admin_manage', '管理员管理', null, '9');
INSERT INTO `module` VALUES ('customer_query', '会员查询', null, '3');
INSERT INTO `module` VALUES ('indexplay_manage', '首页轮播', null, '6');
INSERT INTO `module` VALUES ('indexsort_manange', '首页排序', null, '7');
INSERT INTO `module` VALUES ('master_manage', '掌门管理', null, '8');
INSERT INTO `module` VALUES ('news_manage', '新闻管理', null, '2');
INSERT INTO `module` VALUES ('order_query', '订单查询', null, '5');
INSERT INTO `module` VALUES ('permission_manage', '权限管理', null, '10');
INSERT INTO `module` VALUES ('product_manage', '产品管理', null, '1');
INSERT INTO `module` VALUES ('recharge_query', '充值查询', null, '4');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `nid` varchar(10) NOT NULL COMMENT '主键。内容ID。生成规则：n+年+月+日+3位数字。例如：n170313001',
  `title` varchar(100) DEFAULT NULL,
  `mainimgurl` varchar(500) DEFAULT NULL COMMENT '对应新闻主图的存储路径',
  `listimgurl` varchar(500) DEFAULT NULL COMMENT '对应新闻列表图片的存储路径',
  `htmlfileurl` varchar(500) DEFAULT NULL COMMENT '新闻生成的对应html文件的url路径',
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
INSERT INTO `news` VALUES ('n170421017', '测试新版新闻1', 'upload/news/n170421017/n170421017_mainimg.jpg', 'upload/news/n170421017/n170421017_listimg.jpg', 'upload/news/n170421017/n170421017_newscontent.html', null, '1', '2017-04-21 20:16:38', '2017-04-21', '99', '1', '0');
INSERT INTO `news` VALUES ('n170421018', '测速新版新闻2', 'upload/news/n170421018/n170421018_mainimg.png', 'upload/news/n170421018/n170421018_listimg.png', 'upload/news/n170421018/n170421018_newscontent.html', null, '1', '2017-04-21 20:19:54', '2017-04-21', '99', '1', '0');
INSERT INTO `news` VALUES ('n170421019', '十九大前夕，总书记基层听民声，问计于民', 'upload/news/n170421019/n170421019_mainimg.png', 'upload/news/n170421019/n170421019_listimg.png', 'upload/news/n170421019/n170421019_newscontent.html', null, '1', '2017-04-21 21:53:33', '2017-04-21', '99', '0', '0');
INSERT INTO `news` VALUES ('n170423020', '大职门App', 'upload/news/n170423020/n170423020_mainimg.jpg', 'upload/news/n170423020/n170423020_listimg.jpg', 'upload/news/n170423020/n170423020_newscontent.html', null, '0', '2017-04-23 21:06:18', '2017-04-23', '99', '0', '0');
INSERT INTO `news` VALUES ('n170423033', '测试新版新闻3', 'upload/news/n170423033/n170423033_mainimg.jpg', 'upload/news/n170423033/n170423033_listimg.jpg', 'upload/news/n170423033/n170423033_newscontent.html', null, '0', '2017-04-23 23:21:30', '2017-04-23', '99', '0', '0');
INSERT INTO `news` VALUES ('n170423034', '测试新版新闻4', 'upload/news/n170423034/n170423034_mainimg.jpg', 'upload/news/n170423034/n170423034_listimg.jpg', 'upload/news/n170423034/n170423034_newscontent.html', null, '0', '2017-04-23 23:26:25', '2017-04-23', '99', '0', '0');

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
INSERT INTO `news_content` VALUES ('nc17042100057', '2', 'upload/news/n170421017/nc17042100057_contentimg.jpg', '5', 'n170421017');
INSERT INTO `news_content` VALUES ('nc17042100058', '1', 'Windows黑科技工具推荐', '1', 'n170421017');
INSERT INTO `news_content` VALUES ('nc17042100059', '2', 'upload/news/n170421017/nc17042100059_contentimg.png', '2', 'n170421017');
INSERT INTO `news_content` VALUES ('nc17042100060', '3', '今天小编把几年积累的Windows 上的黑科技分享给大家，虽然我已不用Windows 了，但是这些工具真的让你还怀念，如果你时候用Windows，这些工具绝对不该错过，它可以然你的效率大大提升', '3', 'n170421017');
INSERT INTO `news_content` VALUES ('nc17042100061', '3', 'Everything 是Windows 上一款文件搜索软件。\r\n\r\n只需要你第一次打开，它就会建立索引，之后的使用，不管你是成千上万个软件，还是几百G 的硬盘，Everything 只需几秒就可以检索出你要的文件。\r\n\r\n可以你会想：它功能这么强大，一定会很大而且很占内存吧，我只想告诉你，它的一个安装文件不到1M，而且占用内存不到10M，简直是业界良心。\r\n\r\n而且它还支持中文。', '4', 'n170421017');
INSERT INTO `news_content` VALUES ('nc17042100062', '3', 'Total Commander 是一个非常强大的Windows 文件资源管理器。强大到无法用语言来形容。\r\n\r\n而且它有各种黑科技，对于老司机们可以随意捣鼓。它在一个窗口有两个并列的窗口，你可以执行任意的操作。它有很强大的搜索功能，你可以使用通配符来搜索。它还有快速预览缩略图，它还有批量重命名工具。\r\n\r\n你还可以使用它来访问FTP 服务器。它有强大的同步功能，还可以比较不同的内容同步，\r\n\r\nMac 用户觉得自带的Finder 不好用，可以尝试体验Commander One，和Total Commander类似。', '5', 'n170421018');
INSERT INTO `news_content` VALUES ('nc17042100063', '2', 'upload/news/n170421018/nc17042100063_contentimg.jpg', '6', 'n170421018');
INSERT INTO `news_content` VALUES ('nc17042100064', '1', 'Fences', '1', 'n170421018');
INSERT INTO `news_content` VALUES ('nc17042100065', '2', 'upload/news/n170421018/nc17042100065_contentimg.jpg', '2', 'n170421018');
INSERT INTO `news_content` VALUES ('nc17042100066', '3', 'Fences 是一个Windows 桌面管理软件。\r\n\r\n它可以在桌面上建立文件夹，将不同的软件整理在一个文件夹内。\r\n\r\n而且它还有一个特别棒的功能，双击隐藏桌面的所有图标，这对于有癖好的人随时一个福利。\r\n\r\n它还支持虚拟桌面，当你拖拽桌面两侧，它就会进入一个干净的桌面，你可以所以使用。\r\n\r\nAutoHotKey\r\n\r\nAutoHotKey 是一个自动化软件工具，它可以让你快速制动执行重复性的任务。\r\n\r\n听起来好高端的样子，这种事情不是只有程序员干的么？\r\n\r\n现在AutoHotKey 也让你有这种能力，你只需要建立自己的脚本。\r\n\r\n它会有一些符号代表某些按键，而且你还可以快速打开软件，一下打开好多网页。\r\n\r\n当然其他更多黑科技，还需要你去读文档了。', '3', 'n170421018');
INSERT INTO `news_content` VALUES ('nc17042100067', '1', 'Total Commander', '4', 'n170421018');
INSERT INTO `news_content` VALUES ('nc17042100068', '3', '　【习近平：付出生态代价的发展没有意义】20日下午，习近平总书记考察了南宁市那考河生态综合整治项目。总书记问住在附近的居民，这里环境变化大不大?住在这里感觉怎么样?听到大家给予肯定的回答，总书记说，到这里就是要看看生态综合治理的实际效果，大家满意是一个标志。习近平说，生态文明建设是党的十八大明确提出的“五位一体”建设的重要一项，不仅秉承了天人合一、顺应自然的中华优秀传统文化理念，也是国家现代化建设的需要。付出生态代价的发展没有意义。保护生态，和谐发展，是现在我们建设方方面面都要体现的理念。', '5', 'n170421019');
INSERT INTO `news_content` VALUES ('nc17042100069', '1', '【习近平：技术交流合作要让适合的种子在适宜的环境中开花结果】', '6', 'n170421019');
INSERT INTO `news_content` VALUES ('nc17042100070', '3', '【习近平：技术交流合作要让适合的种子在适宜的环境中开花结果】20日下午，习近平总书记来到南宁·中关村创新示范基地考察，观看了基地入驻企业在智能制造、信息技术、创新之星、国际合作等方面的成果展示，了解基地推动外地企业同本土企业协同创新发展情况。总书记说，技术需要交流合作，相互取长补短。只有互利共赢、彼此受益才可能交流合作起来。要让适合的种子在适宜的环境中开花结果。【习近平：技术交流合作要让适合的种子在适宜的环境中开花结果】20日下午，习近平总书记来到南宁·中关村创新示范基地考察，观看了基地入驻企业在智能制造、信息技术、创新之星、国际合作等方面的成果展示，了解基地推动外地企业同本土企业协同创新发展情况。总书记说，技术需要交流合作，相互取长补短。只有互利共赢、彼此受益才可能交流合作起来。要让适合的种子在适宜的环境中开花结果。【习近平：技术交流合作要让适合的种子在适宜的环境中开花结果】20日下午，习近平总书记来到南宁·中关村创新示范基地考察，观看了基地入驻企业在智能制造、信息技术、创新之星、国际合作等方面的成果展示，了解基地推动外地企业同本土企业协同创新发展情况。总书记说，技术需要交流合作，相互取长补短。只有互利共赢、彼此受益才可能交流合作起来。要让适合的种子在适宜的环境中开花结果。【习近平：技术交流合作要让适合的种子在适宜的环境中开花结果】20日下午，习近平总书记来到南宁·中关村创新示范基地考察，观看了基地入驻企业在智能制造、信息技术、创新之星、国际合作等方面的成果展示，了解基地推动外地企业同本土企业协同创新发展情况。总书记说，技术需要交流合作，相互取长补短。只有互利共赢、彼此受益才可能交流合作起来。要让适合的种子在适宜的环境中开花结果。【习近平：技术交流合作要让适合的种子在适宜的环境中开花结果】20日下午，习近平总书记来到南宁·中关村创新示范基地考察，观看了基地入驻企业在智能制造、信息技术、创新之星、国际合作等方面的成果展示，了解基地推动外地企业同本土企业协同创新发展情况。总书记说，技术需要交流合作，相互取长补短。只有互利共赢、彼此受益才可能交流合作起来。要让适合的种子在适宜的环境中开花结果。【习近平：技术交流合作要让适合的种子在适宜的环境中开花结果】20日下午，习近平总书记来到南宁·中关村创新示范基地考察，观看了基地入驻企业在智能制造、信息技术、创新之星、国际合作等方面的成果展示，了解基地推动外地企业同本土企业协同创新发展情况。总书记说，技术需要交流合作，相互取长补短。只有互利共赢、彼此受益才可能交流合作起来。要让适合的种子在适宜的环境中开花结果。【习近平：技术交流合作要让适合的种子在适宜的环境中开花结果】20日下午，习近平总书记来到南宁·中关村创新示范基地考察，观看了基地入驻企业在智能制造、信息技术、创新之星、国际合作等方面的成果展示，了解基地推动外地企业同本土企业协同创新发展情况。总书记说，技术需要交流合作，相互取长补短。只有互利共赢、彼此受益才可能交流合作起来。要让适合的种子在适宜的环境中开花结果。【习近平：技术交流合作要让适合的种子在适宜的环境中开花结果】20日下午，习近平总书记来到南宁·中关村创新示范基地考察，观看了基地入驻企业在智能制造、信息技术、创新之星、国际合作等方面的成果展示，了解基地推动外地企业同本土企业协同创新发展情况。总书记说，技术需要交流合作，相互取长补短。只有互利共赢、彼此受益才可能交流合作起来。要让适合的种子在适宜的环境中开花结果。【习近平：技术交流合作要让适合的种子在适宜的环境中开花结果】20日下午，习近平总书记来到南宁·中关村创新示范基地考察，观看了基地入驻企业在智能制造、信息技术、创新之星、国际合作等方面的成果展示，了解基地推动外地企业同本土企业协同创新发展情况。总书记说，技术需要交流合作，相互取长补短。只有互利共赢、彼此受益才可能交流合作起来。要让适合的种子在适宜的环境中开花结果。【习近平：技术交流合作要让适合的种子在适宜的环境中开花结果】20日下午，习近平总书记来到南宁·中关村创新示范基地考察，观看了基地入驻企业在智能制造、信息技术、创新之星、国际合作等方面的成果展示，了解基地推动外地企业同本土企业协同创新发展情况。总书记说，技术需要交流合作，相互取长补短。只有互利共赢、彼此受益才可能交流合作起来。要让适合的种子在适宜的环境中开花结果。【习近平：技术交流合作要让适合的种子在适宜的环境中开花结果】20日下午，习近平总书记来到南宁·中关村创新示范基地考察，观看了基地入驻企业在智能制造、信息技术、创新之星、国际合作等方面的成果展示，了解基地推动外地企业同本土企业协同创新发展情况。总书记说，技术需要交流合作，相互取长补短。只有互利共赢、彼此受益才可能交流合作起来。要让适合的种子在适宜的环境中开花结果。', '7', 'n170421019');
INSERT INTO `news_content` VALUES ('nc17042100071', '1', '　【十九大前夕，总书记基层听民声，问计于民】4月20日下午，习近平总书记在广西主持召开座谈会。来自科技、教育、党建、纪检、劳模、英模、少数民族、大学生、新社会阶层人士等各方面的14位基层干部群众代表，同总书记面对面交流，谈情况、说体会、提建议，畅谈对党的十九大的期盼。总书记同大家进行了深入交流。他说，听了发言，感受到大家对党和国家、对中国特色社会主义事业的信心，对党中央的信任。我们要把大家提出的意见和建议带回去认真研究。习近平强调，筹备党的十九大，要充分发扬民主，广泛汲取全党全社会的智慧，让广大党员干部群众都参与进来，把各方面积极性激发出来。 　　【习近平：积极推动民企党建探索工作】在基层代表座谈会上，来自广西华蓝集团的雷翔作为新社会阶层人士代表谈到了党建工作对非公有制经济发展的推动作用。习近平强调，党要管党，党建要全覆盖。根据经济社会发展和结构变化，党的组织形式、工作方法也要与之适应。要积极推动民企党建工作探索，因地制宜抓好党建、促进企业健康发展。 　　【习近平：鼓励教师到农村任教】座谈会上，南宁二中党委书记徐华建议进一步采取措施，加强教师队伍建设，补齐民族地区、边疆地区、贫困地区基础教育的短板。总书记说，对农村教师队伍建设要有更加有力的措施。要从总体上研究解决这个问题。', '1', 'n170421019');
INSERT INTO `news_content` VALUES ('nc17042100072', '2', 'upload/news/n170421019/nc17042100072_contentimg.png', '2', 'n170421019');
INSERT INTO `news_content` VALUES ('nc17042100073', '3', '【习近平七年之后再到南南铝：“鸟枪换炮了!”】4月20日上午，正在广西考察的习近平总书记来到广西南南铝加工有限公司，实地了解企业进行传统产业优化升级，发展航空航天、轨道交通、船舶海洋等领域高性能铝材产业情况。2010年5月，时任国家副主席的习近平曾到南南铝业股份有限公司考察。总书记说，上一次是看传统产品，今天看了新产品、高端产品，鸟枪换炮了。六七年的时间，企业与国家发展同步，取得可喜成绩，向大家表示祝贺。\r\n　　【习近平：做强实体经济，抓好制造业】习近平总书记对企业职工说，一个国家一定要有正确的战略选择。我们的战略选择就是要继续抓好制造业。中国是个大国，必须要做强实体经济，不能“脱实向虚”。要虚实结合，以实为基础。制造业是实体经济的重要组成部分。要以创新驱动，实现新旧动能转换。同时，做好知识和人才的积累。\r\n　　习近平强调，国有企业是主力军、生力军。攻坚克难、打硬仗还要靠主力军。国有企业在中国的地位只能加强。同时，国有企业也要自强不息，自我改革完善，不能固步自封，通过改革补齐短板。要抓好党建工作，忽视了先锋队作用，什么事也干不好。', '3', 'n170421019');
INSERT INTO `news_content` VALUES ('nc17042100074', '2', 'upload/news/n170421019/nc17042100074_contentimg.png', '4', 'n170421019');
INSERT INTO `news_content` VALUES ('nc17042300075', '3', '大职门APP，职场经验与技能分享平台，智慧人口红利下的分享经济模式。\r\n\r\n在职场某一领域具有丰富积累的人都算智慧人口，在大职门，我们将智慧人口统称为职场掌门，他们的经验和技能可以帮助很多人。\r\n\r\n大职门是职场掌门分享经验与技能的平台，通过释放智慧人口红利，帮助掌门获得额外的变现机会。\r\n\r\n大职门也是学习者快速提升自己，获取职场突破的渠道。出于对劳动者尊重，学习者需要向职场掌门支付小额费用。\r\n\r\n大职门希望每位职场掌门的经验都能惠及更多人，帮助更多人成长，从而实现自己的职业理想。', '1', 'n170423020');
INSERT INTO `news_content` VALUES ('nc17042300112', '1', '份饭', '1', 'n170423033');
INSERT INTO `news_content` VALUES ('nc17042300113', '2', 'upload/news/n170423033/nc17042300113_contentimg.png', '2', 'n170423033');
INSERT INTO `news_content` VALUES ('nc17042300114', '3', '发顺丰', '3', 'n170423033');
INSERT INTO `news_content` VALUES ('nc17042300115', '1', '防守打法', '1', 'n170423034');
INSERT INTO `news_content` VALUES ('nc17042300116', '2', 'upload/news/n170423034/nc17042300116_contentimg.jpg', '2', 'n170423034');
INSERT INTO `news_content` VALUES ('nc17042300117', '3', '法萨芬', '3', 'n170423034');

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
INSERT INTO `orders` VALUES ('or17041401049', '2017-04-14 21:56:37', '0.01', '3', '2017041421001004800296786865', 'c17033100041', '0');
INSERT INTO `orders` VALUES ('or17041401050', '2017-04-14 21:58:36', '0.01', '3', '2017041421001004800296787052', 'c17033100040', '0');
INSERT INTO `orders` VALUES ('or17041401051', '2017-04-14 21:59:38', '0.01', '3', '2017041421001004800296795348', 'c17041400078', '0');
INSERT INTO `orders` VALUES ('or17041401052', '2017-04-14 22:00:40', '0.01', '3', '2017041421001004800296787228', 'c17041400078', '0');
INSERT INTO `orders` VALUES ('or17041601057', '2017-04-16 00:02:04', '0.01', '3', '2017041621001004120299616543', 'c17040900074', '0');
INSERT INTO `orders` VALUES ('or17041601058', '2017-04-16 13:46:56', '0.01', '2', '4007892001201704167208464450', 'c17041600081', '0');
INSERT INTO `orders` VALUES ('or17041601059', '2017-04-16 15:21:59', '0.01', '3', '2017041621001004800299413905', 'c17041600082', '0');
INSERT INTO `orders` VALUES ('or17041601060', '2017-04-16 15:47:49', '0.01', '1', null, 'c17033100040', '0');
INSERT INTO `orders` VALUES ('or17041601061', '2017-04-16 15:49:36', '0.01', '2', '4007892001201704167219724055', 'c17041400078', '0');
INSERT INTO `orders` VALUES ('or17041601063', '2017-04-16 15:56:49', '0.01', '3', '2017041621001004800299482294', 'c17041600083', '0');
INSERT INTO `orders` VALUES ('or17041601064', '2017-04-16 15:59:32', '0.01', '3', '2017041621001004800299464634', 'c17041600083', '0');
INSERT INTO `orders` VALUES ('or17041601065', '2017-04-16 16:00:11', '0.01', '3', '2017041621001004800299487326', 'c17041600084', '0');
INSERT INTO `orders` VALUES ('or17041601066', '2017-04-16 16:01:43', '0.01', '3', '2017041621001004800299480917', 'c17041600085', '0');
INSERT INTO `orders` VALUES ('or17041601067', '2017-04-16 16:06:19', '0.01', '3', '2017041621001004800299481208', 'c17041600086', '0');
INSERT INTO `orders` VALUES ('or17041601068', '2017-04-16 16:07:12', '0.01', '3', '2017041621001004800299468199', 'c17041600087', '0');
INSERT INTO `orders` VALUES ('or17041601069', '2017-04-16 16:13:28', '0.01', '3', '2017041621001004800299512741', 'c17041600088', '0');
INSERT INTO `orders` VALUES ('or17041601070', '2017-04-16 16:14:11', '0.01', '3', '2017041621001004800299511250', 'c17041600089', '0');
INSERT INTO `orders` VALUES ('or17041601071', '2017-04-16 18:46:19', '0.01', '2', '4007892001201704167245184323', 'c17041600093', '0');
INSERT INTO `orders` VALUES ('or17041601072', '2017-04-16 23:26:07', '0.01', '2', '4007892001201704167275444492', 'c17041600094', '0');
INSERT INTO `orders` VALUES ('or17041701073', '2017-04-17 15:12:24', '0.01', '1', null, 'c17040900074', '0');
INSERT INTO `orders` VALUES ('or17041701074', '2017-04-17 15:14:11', '0.01', '1', null, 'c17040900074', '0');
INSERT INTO `orders` VALUES ('or17041701075', '2017-04-17 15:20:29', '0.01', '1', null, 'c17040900074', '0');
INSERT INTO `orders` VALUES ('or17041701076', '2017-04-17 15:24:57', '0.01', '1', null, 'c17040900074', '0');
INSERT INTO `orders` VALUES ('or17041701077', '2017-04-17 15:26:08', '0.01', '2', '4001382001201704177335539996', 'c17040900074', '0');
INSERT INTO `orders` VALUES ('or17041801078', '2017-04-18 14:30:11', '0.10', '3', '2017041821001004350260236729', 'c17041800100', '0');
INSERT INTO `orders` VALUES ('or17041901079', '2017-04-19 17:14:34', '0.00', '1', null, 'c17040900074', '0');
INSERT INTO `orders` VALUES ('or17041901080', '2017-04-19 17:20:58', '0.01', '1', null, 'c17040900074', '0');
INSERT INTO `orders` VALUES ('or17042001084', '2017-04-20 14:21:18', '0.01', '1', null, 'c17042000117', '0');
INSERT INTO `orders` VALUES ('or17042001085', '2017-04-20 14:24:46', '0.00', '1', null, 'c17042000113', '0');
INSERT INTO `orders` VALUES ('or17042001086', '2017-04-20 14:25:43', '0.00', '1', null, 'c17042000116', '0');
INSERT INTO `orders` VALUES ('or17042001087', '2017-04-20 18:07:35', '0.00', '1', null, 'c17033100040', '0');
INSERT INTO `orders` VALUES ('or17042101088', '2017-04-21 16:33:44', '0.01', '1', null, 'c17042000115', '0');
INSERT INTO `orders` VALUES ('or17042101089', '2017-04-21 17:43:00', '0.10', '1', null, 'c17033100040', '0');
INSERT INTO `orders` VALUES ('or17042101090', '2017-04-21 18:03:55', '0.10', '1', null, 'c17033100041', '0');
INSERT INTO `orders` VALUES ('or17042101091', '2017-04-21 23:26:00', '0.01', '1', null, 'c17033100040', '0');
INSERT INTO `orders` VALUES ('or17042301092', '2017-04-23 11:25:36', '0.01', '1', null, 'c17042300133', '0');

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
INSERT INTO `product` VALUES ('p17032700049', '测试产品1', '2', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17032700049/p17032700049_listimg.jpg', '0', '99', 'u170324003', '1', '2017-03-27 22:30:59', '0', '2017-03-27 22:30:59', '13', null);
INSERT INTO `product` VALUES ('p17032700050', '测试商品2', '1', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17032700050/p17032700050_listimg.jpg', '0', '99', 'u170324003', '1', '2017-03-27 22:32:18', '0', '2017-03-27 22:32:18', '6', null);
INSERT INTO `product` VALUES ('p17033000051', '测试112', '2', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17033000051/p17033000051_listimg.png', '0', '99', 'u170324004', '1', '2017-03-30 22:12:38', '0', '2017-03-30 22:12:38', '6', null);
INSERT INTO `product` VALUES ('p17040700052', '技能包1', '1', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17040700052/p17040700052_listimg.jpg', '0', '99', 'u170324003', '1', '2017-04-07 11:11:38', '0', '2017-04-07 11:11:38', '6', null);
INSERT INTO `product` VALUES ('p17040700053', '技能包2', '1', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17040700053/p17040700053_listimg.jpg', '0', '99', 'u170324003', '1', '2017-04-07 11:12:21', '0', '2017-04-07 11:12:21', '5', null);
INSERT INTO `product` VALUES ('p17040700054', '技能包3', '1', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17040700054/p17040700054_listimg.jpg', '0', '99', 'u170324003', '2', '2017-04-07 11:12:43', '0', '2017-04-07 11:12:43', '2', null);
INSERT INTO `product` VALUES ('p17040700055', '经验包1', '2', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17040700055/p17040700055_listimg.jpg', '0', '99', 'u170324003', '1', '2017-04-07 11:13:08', '0', '2017-04-07 11:13:08', '3', null);
INSERT INTO `product` VALUES ('p17040700056', '经验包2', '2', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17040700056/p17040700056_listimg.jpg', '0', '1', 'u170324003', '2', '2017-04-07 11:13:36', '0', '2017-04-07 11:13:36', '2', null);
INSERT INTO `product` VALUES ('p17040700057', '经验包3', '2', '0.01', '0', '产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试，产品介绍信息测试产品介绍信息测试。', 'upload/product/p17040700057/p17040700057_listimg.jpg', '0', '2', 'u170324003', '1', '2017-04-07 11:15:23', '0', '2017-04-07 11:15:23', '6', null);
INSERT INTO `product` VALUES ('p17041100058', '大学生职业恋爱观', '1', '22.00', '2', '大学生恋爱只能报', 'upload/product/p17041100058/p17041100058_listimg.png', '1', '99', 'u170324003', '1', '2017-04-11 14:12:53', '0', '2017-04-11 14:12:53', '0', null);
INSERT INTO `product` VALUES ('p17041400060', '测试商品', '1', '0.01', '11', '主要原料  本公司产品以甘蔗渣、甘蔗尾稍、玉米秸秆、象草等生 物质秸秆为原料，用生物发酵方法并添加营养物质和生物菌种经科学配制而成。生物发酵甘蔗渣复合饲料产品的实施能够带动生物技术在农牧业产业的应用发展，将农业废弃物通过生物技术变废为宝，以引领农业向科技、生态、环保方向循环发展。对改变传统农业发展模式有很好的促进作用。用发酵甘蔗渣代替青贮玉米杆喂养牛羊食料可以全面替代传统粮食饲料，用于饲养牛、羊可提高粗饲料的采用食量，促进消化吸收，消化系统疾病减少，提高免疫力，肉牛可提高肉比，提高羊肉优质，提早出栏，降低饲养成本。   主要产品  本产品利用甘蔗渣发酵制备得到的牛羊饲料营养全面、有糖蜜香甜味、能够提高了牛羊的食欲，牛羊爱吃，生长快。在发酵过程中添加了发酵剂，制备得到的饲料中所含有益微生物能够加强牛羊对营养物质的消化利用，促进牛羊生长，改善胃肠机能，增进其食欲，有效抑制畜禽肠道中病原菌的繁殖，增强免疫力，提高抵抗疾病的能力，减少疾病发生。我们在广西国营金光肉牛场进行中试结果表明：用发酵甘蔗渣能够将粗纤维和粗蛋白转化，用其代替青贮玉米杆饲喂牛羊是可行有效的，从160公斤饲养到500公斤出栏，喂本公\r\n tob_id_4526\r\n司产品的可提前70天出栏，每头牛取得纯利润3000元以上的效益。不仅可以达到牛羊理想的日增重效果，保证肉牛羊的健康生长和肉的优质，而且可节约饲料投喂量和节省储存饲料仓库占用，降低饲料成本，缩短饲养时间，取得了显著的经济效益。近几年，随着养牛羊养殖业的迅速发展，各种牛羊饲料也随之迅速发展，现阶段市场的各种牛羊饲料品种繁多，作用各异，其中牛羊在不同的生长、生理时期对营养的要求不相同，其喂养的饲料也不能一样，能量饲料添加需要特别配制。如何合理利用秸秆资源、科学配制加工牛羊饲料，对大力发展集约化、规模化、标准化的牛羊舍养圈养的养殖模式起着决定性的作用。', 'upload/product/p17041400060/p17041400060_listimg.png', '0', '99', 'u170324004', '1', '2017-04-14 15:44:47', '0', '2017-04-14 15:44:47', '4', null);
INSERT INTO `product` VALUES ('p17041600061', '测试商品', '1', '0.01', '11', '产品测试', 'upload/product/p17041600061/p17041600061_listimg.png', '0', '99', 'u170411007', '1', '2017-04-16 15:46:41', '0', '2017-04-16 15:46:41', '3', null);
INSERT INTO `product` VALUES ('p17041700063', '经验包测试', '1', '0.01', '1', '“乐天陷入四面楚歌”，韩国《每日经济》16日称，乐天遭受的损失如滚雪球一样越滚越大，会长辛东彬也因卷入“总统亲信干政门”面临起诉。根据乐天集团16日公布的数据，3月因中国反制“萨德”措施，集团总体损失高达2500亿韩元(约合17亿人民币)。乐天方面表示，中国的萨德反制措施毫无放松的迹象，如果此种趋势持续下去，从今年3月至6月，乐天集团损失额将超过1万亿韩元。　　韩国《中央日报》16日分析称，在“萨德”入韩“实际上部署完毕”的情况下，白宫官员的上述表态“并不是说不部署萨德”，而是一旦韩国新总统要求撤出“萨德”，韩美两国可就此展开磋商。韩国外交部相关人士表示，已经通过多种途径向美方证实，确认美国在“萨德”问题上的立场“没有变化”。美国副总统彭斯的发言人16日表示：“美国关于部署萨德的政策没有改变”。　《中央日报》评论称，韩美当局都就白宫官员的一句话出面澄清，这非常罕见。韩国外交人士分析认为，做出之前发言的白宫官员可能并不非常清楚“萨德”部署和当前半岛局势，因此“仅是从技术层面进行了解读”。但有分析认为，不排除中美两国“背着韩国”就“萨德”进行某种交易的可能。韩国外交消息人士表示，美国可能以暂缓部署“萨德”换取中国在对朝施压上采取更有力措施，如果中方施压无效，美国或将重启部署进程。', 'upload/product/p17041700063/p17041700063_listimg.png', '0', '99', 'u170324004', '1', '2017-04-17 10:54:22', '0', '2017-04-17 10:54:22', '2', null);
INSERT INTO `product` VALUES ('p17041700072', '测试产品', '2', '0.01', '1', '测试经验包', 'upload/product/p17041700072/p17041700072_listimg.png', '0', '99', 'u170324003', '1', '2017-04-17 13:20:38', '0', '2017-04-17 13:20:38', '1', null);
INSERT INTO `product` VALUES ('p17041800073', 'yxb名称', '1', '9.00', '0', '介绍信息123介绍信息123介绍信息123介绍信息123介绍信息123介绍信息123介绍信息123介绍信息123介绍信息123介绍信息123', 'upload/product/p17041800073/p17041800073_listimg.jpg', '0', '99', 'u170324003', '1', '2017-04-18 11:05:10', '0', '2017-04-18 11:05:10', '0', null);
INSERT INTO `product` VALUES ('p17041800075', 'yxb经验包', '2', '0.00', '0', '介绍123', 'upload/product/p17041800075/p17041800075_listimg.png', '1', '99', 'u170324003', '1', '2017-04-18 11:50:32', '0', '2017-04-18 11:50:32', '4', null);
INSERT INTO `product` VALUES ('p17041800076', 'sunxy', '1', '0.10', '0', '的萨达萨达', 'upload/product/p17041800076/p17041800076_listimg.jpg', '0', '99', 'u170324003', '1', '2017-04-18 12:19:15', '0', '2017-04-18 12:19:15', '3', '1');
INSERT INTO `product` VALUES ('p17042300077', '新闻测试', '1', '0.01', '1', '测试已经成型', 'upload/product/p17042300077/p17042300077_listimg.png', '0', '99', 'u170324004', '1', '2017-04-23 22:30:44', '0', '2017-04-23 22:30:44', '0', null);
INSERT INTO `product` VALUES ('p17042400078', 'jljljkljkljlj', '1', '999.00', '0', 'dljflsjkljflkjlklk', 'upload/product/p17042400078/p17042400078_listimg.jpg', '0', '99', 'u170324004', '3', '2017-04-24 10:51:28', '0', '2017-04-24 10:51:28', '0', '1');
INSERT INTO `product` VALUES ('p17042400079', 'fff', '1', '3.00', '1', '', 'upload/product/p17042400079/p17042400079_listimg.jpg', '0', '99', 'u170411008', '3', '2017-04-24 11:17:56', '0', '2017-04-24 11:17:56', '0', '0');
INSERT INTO `product` VALUES ('p17042400080', 'fdasf', '2', '1.00', '1', '', 'upload/product/p17042400080/p17042400080_listimg.jpg', '0', '99', 'u170411009', '1', '2017-04-24 11:27:50', '0', '2017-04-24 11:27:50', '0', '1');
INSERT INTO `product` VALUES ('p17042400081', 'fdsaf', '1', '1.00', '1', '', 'upload/product/p17042400081/p17042400081_listimg.jpg', '0', '99', 'u170324003', '3', '2017-04-24 17:31:18', '0', '2017-04-24 17:31:18', '0', null);
INSERT INTO `product` VALUES ('p17042400082', 'ewe', '1', '1.00', '0', '', 'upload/product/p17042400082/p17042400082_listimg.jpg', '0', '99', 'u170324003', '3', '2017-04-24 17:47:37', '0', '2017-04-24 17:47:37', '0', null);

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
INSERT INTO `product_image` VALUES ('p17041400060_1', 'upload/product/p17041400060/p17041400060_mainimg_1.png', 'p17041400060');
INSERT INTO `product_image` VALUES ('p17041600061_1', 'upload/product/p17041600061/p17041600061_mainimg_1.png', 'p17041600061');
INSERT INTO `product_image` VALUES ('p17041700063_1', 'upload/product/p17041700063/p17041700063_mainimg_1.png', 'p17041700063');
INSERT INTO `product_image` VALUES ('p17041700072_1', 'upload/product/p17041700072/p17041700072_mainimg_1.png', 'p17041700072');
INSERT INTO `product_image` VALUES ('p17041800073_1', 'upload/product/p17041800073/p17041800073_mainimg_1.png', 'p17041800073');
INSERT INTO `product_image` VALUES ('p17041800075_1', 'upload/product/p17041800075/p17041800075_mainimg_1.jpg', 'p17041800075');
INSERT INTO `product_image` VALUES ('p17041800076_1', 'upload/product/p17041800076/p17041800076_mainimg_1.jpg', 'p17041800076');
INSERT INTO `product_image` VALUES ('p17042300077_1', 'upload/product/p17042300077/p17042300077_mainimg_1.png', 'p17042300077');
INSERT INTO `product_image` VALUES ('p17042400078_1', 'upload/product/p17042400078/p17042400078_mainimg_1.jpg', 'p17042400078');
INSERT INTO `product_image` VALUES ('p17042400079_1', 'upload/product/p17042400079/p17042400079_mainimg_1.jpg', 'p17042400079');
INSERT INTO `product_image` VALUES ('p17042400080_1', 'upload/product/p17042400080/p17042400080_mainimg_1.jpg', 'p17042400080');
INSERT INTO `product_image` VALUES ('p17042400081_1', 'upload/product/p17042400081/p17042400081_mainimg_1.jpg', 'p17042400081');
INSERT INTO `product_image` VALUES ('p17042400082_1', 'upload/product/p17042400082/p17042400082_mainimg_1.jpg', 'p17042400082');

-- ----------------------------
-- Table structure for recharge
-- ----------------------------
DROP TABLE IF EXISTS `recharge`;
CREATE TABLE `recharge` (
  `recid` varchar(12) NOT NULL COMMENT '主键。充值id，规则为，r+年+月+日+5位数字，例如r17031100001',
  `recamount` decimal(10,2) NOT NULL COMMENT '充值金额',
  `cid` varchar(12) NOT NULL COMMENT '充值客户的id',
  `paymenttype` varchar(1) DEFAULT NULL COMMENT '充值支付方式：2:微信支付，3:支付宝支付',
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
INSERT INTO `recharge` VALUES ('r17041200118', '0.01', 'c17033100040', '2', '4007892001201704126768127705', '2017-04-12 19:31:26', '0');
INSERT INTO `recharge` VALUES ('r17041200119', '0.01', 'c17033100040', '2', '4007892001201704126780330446', '2017-04-12 20:05:20', '0');
INSERT INTO `recharge` VALUES ('r17041300120', '0.01', 'c17033100040', '2', '4007892001201704136802809602', '2017-04-13 01:25:12', '0');
INSERT INTO `recharge` VALUES ('r17041400121', '0.01', 'c17041400077', '2', '4007892001201704146919242265', '2017-04-14 07:45:44', '0');
INSERT INTO `recharge` VALUES ('r17041401233', '0.01', 'c17033100041', '3', '2017041421001004800296772361', '2017-04-14 21:45:27', '0');
INSERT INTO `recharge` VALUES ('r17041401234', '0.01', 'c17033100041', '3', '2017041421001004800296782424', '2017-04-14 21:46:53', '0');
INSERT INTO `recharge` VALUES ('r17041501235', '0.01', 'c17033100040', '3', '2017041521001004800297425017', '2017-04-15 12:05:49', '0');
INSERT INTO `recharge` VALUES ('r17041501236', '0.01', 'c17040900074', '3', '2017041521001004120299588961', '2017-04-15 23:17:36', '0');
INSERT INTO `recharge` VALUES ('r17041501237', '0.01', 'c17040900074', '3', '2017041521001004120299566846', '2017-04-15 23:20:19', '0');
INSERT INTO `recharge` VALUES ('r17041501238', '0.01', 'c17040900074', '3', '2017041521001004120299569936', '2017-04-15 23:26:03', '0');
INSERT INTO `recharge` VALUES ('r17041501239', '0.01', 'c17040900074', '3', '2017041521001004120299576647', '2017-04-15 23:27:36', '0');
INSERT INTO `recharge` VALUES ('r17041501240', '0.01', 'c17040900074', '3', '2017041521001004120299591130', '2017-04-15 23:28:20', '0');
INSERT INTO `recharge` VALUES ('r17041501241', '0.01', 'c17040900074', '3', '2017041521001004120299570137', '2017-04-15 23:33:11', '0');
INSERT INTO `recharge` VALUES ('r17041501242', '0.01', 'c17040900074', '3', '2017041521001004120299591366', '2017-04-15 23:36:14', '0');
INSERT INTO `recharge` VALUES ('r17041501245', '0.01', 'c17040900074', '2', '4001382001201704157155042236', '2017-04-15 23:37:18', '0');
INSERT INTO `recharge` VALUES ('r17041501246', '0.01', 'c17040900074', '3', '2017041521001004120299614237', '2017-04-15 23:38:48', '0');
INSERT INTO `recharge` VALUES ('r17041601249', '0.01', 'c17041600080', '3', '2017041621001004800298823548', '2017-04-16 09:36:25', '0');
INSERT INTO `recharge` VALUES ('r17041601252', '0.01', 'c17041600082', '2', '4007892001201704167221173348', '2017-04-16 15:40:22', '0');
INSERT INTO `recharge` VALUES ('r17041601253', '0.01', 'c17033100040', '3', '2017041621001004800299995120', '2017-04-16 21:02:59', '0');
INSERT INTO `recharge` VALUES ('r17041701254', '0.01', 'c17033100040', '3', '2017041721001004800200232973', '2017-04-17 00:20:36', '0');
INSERT INTO `recharge` VALUES ('r17041701255', '0.01', 'c17033100040', '2', '4007892001201704177295456062', '2017-04-17 09:20:54', '0');
INSERT INTO `recharge` VALUES ('r17041701256', '0.01', 'c17033100040', '2', '4007892001201704177295441319', '2017-04-17 09:21:22', '0');
INSERT INTO `recharge` VALUES ('r17041701257', '0.01', 'c17033100040', '2', '4007892001201704177321867430', '2017-04-17 13:09:11', '0');
INSERT INTO `recharge` VALUES ('r17041701259', '0.01', 'c17040900074', '2', '4001382001201704177323981467', '2017-04-17 13:31:25', '0');
INSERT INTO `recharge` VALUES ('r17041701260', '0.01', 'c17040900074', '2', '4001382001201704177325666236', '2017-04-17 13:35:06', '0');
INSERT INTO `recharge` VALUES ('r17041701263', '0.01', 'c17033100040', '2', '4007892001201704177336336732', '2017-04-17 14:41:55', '0');
INSERT INTO `recharge` VALUES ('r17041801280', '0.10', 'c17041800100', '3', '2017041821001004350259905714', '2017-04-18 11:32:45', '0');
INSERT INTO `recharge` VALUES ('r17041901292', '0.01', 'c17040900075', '2', '4002472001201704197567906810', '2017-04-19 15:07:31', '0');
INSERT INTO `recharge` VALUES ('r17041901296', '0.01', 'c17041900111', '2', '4007892001201704197615363528', '2017-04-19 21:26:43', '0');
INSERT INTO `recharge` VALUES ('r17042001297', '0.01', 'c17033100040', '3', '2017042021001004800318315176', '2017-04-20 08:04:15', '0');
INSERT INTO `recharge` VALUES ('r17042001298', '0.01', 'c17042000114', '3', '2017042021001004350263257145', '2017-04-20 11:19:36', '0');
INSERT INTO `recharge` VALUES ('r17042001299', '0.01', 'c17042000114', '3', '2017042021001004350263247120', '2017-04-20 11:20:24', '0');
INSERT INTO `recharge` VALUES ('r17042001301', '0.01', 'c17042000115', '3', '2017042021001004350263391348', '2017-04-20 12:31:24', '0');
INSERT INTO `recharge` VALUES ('r17042001312', '0.01', 'c17042000117', '2', '4004142001201704207672402270', '2017-04-20 12:31:58', '0');
INSERT INTO `recharge` VALUES ('r17042001321', '0.01', 'c17033100040', '3', '2017042021001004800318937561', '2017-04-20 14:36:27', '0');
INSERT INTO `recharge` VALUES ('r17042001322', '0.01', 'c17033100040', '3', '2017042021001004800318931522', '2017-04-20 14:48:37', '0');
INSERT INTO `recharge` VALUES ('r17042101323', '0.01', 'c17033100040', '3', '2017042121001004800202690220', '2017-04-21 01:20:42', '0');
INSERT INTO `recharge` VALUES ('r17042101324', '0.01', 'c17033100040', '2', '4007892001201704217761483669', '2017-04-21 08:33:43', '0');
INSERT INTO `recharge` VALUES ('r17042101333', '0.01', 'c17042100122', '3', '2017042121001004800203444632', '2017-04-21 11:59:33', '0');
INSERT INTO `recharge` VALUES ('r17042101344', '0.01', 'c17042000115', '3', '2017042121001004350265577124', '2017-04-21 17:25:41', '0');
INSERT INTO `recharge` VALUES ('r17042101382', '0.01', 'c17033100040', '2', '4007892001201704217840896128', '2017-04-21 19:07:09', '0');
INSERT INTO `recharge` VALUES ('r17042201383', '0.01', 'c17033100040', '2', '4007892001201704227899834077', '2017-04-22 10:32:35', '0');
INSERT INTO `recharge` VALUES ('r17042201384', '0.01', 'c17033100040', '3', '2017042221001004800205256198', '2017-04-22 12:25:05', '0');
INSERT INTO `recharge` VALUES ('r17042201385', '0.01', 'c17033100040', '3', '2017042221001004800205593169', '2017-04-22 14:37:11', '0');
INSERT INTO `recharge` VALUES ('r17042301405', '0.01', 'c17033100040', '2', '4007892001201704238119217841', '2017-04-23 22:53:22', '0');
INSERT INTO `recharge` VALUES ('r17042401406', '0.01', 'c17040900074', '3', '2017042421001004120213395739', '2017-04-24 09:48:46', '0');
INSERT INTO `recharge` VALUES ('r17042401407', '0.01', 'c17040900074', '3', '2017042421001004120213409177', '2017-04-24 09:55:46', '0');
INSERT INTO `recharge` VALUES ('r17042401408', '0.01', 'c17040900074', '2', '4001382001201704248148516745', '2017-04-24 09:56:08', '0');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `rid` varchar(10) NOT NULL COMMENT '主键。角色ID。生成规则：r+年+月+日+3位数字。例如：r170312001',
  `name` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `introduction` varchar(500) DEFAULT NULL COMMENT '角色介绍',
  `ismastercanown` varchar(1) DEFAULT NULL COMMENT '是否允许分配给掌门。1:允许。0:不允许。',
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色信息表。有一个需要注意的属性：是否允许分配给掌门';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('r170421002', '角色-拥有所有权限', '', '1');
INSERT INTO `role` VALUES ('r170424003', 'sxy', '啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦', '1');

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
INSERT INTO `sequence` VALUES ('course_seq', '31', '1', '100000');
INSERT INTO `sequence` VALUES ('customer_seq', '138', '1', '100000');
INSERT INTO `sequence` VALUES ('news_content_seq', '117', '1', '100000');
INSERT INTO `sequence` VALUES ('news_seq', '34', '1', '1000');
INSERT INTO `sequence` VALUES ('order_seq', '1092', '1', '100000');
INSERT INTO `sequence` VALUES ('product_seq', '82', '1', '100000');
INSERT INTO `sequence` VALUES ('recharge_seq', '1408', '1', '100000');
INSERT INTO `sequence` VALUES ('role_seq', '3', '1', '1000');
INSERT INTO `sequence` VALUES ('user_seq', '38', '1', '1000');
INSERT INTO `sequence` VALUES ('verifycode_seq', '14', '1', '100000');

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
INSERT INTO `user` VALUES ('u170411010', '管家', '13520987512', 'ac7486b6daa849beaebf6b7f3de65185', '1', '1', '管家', null, '0', '2017-04-11 11:47:27', '管家', '介绍', 'upload/master/u170411010/u170411010.png', '99');
INSERT INTO `user` VALUES ('u170411011', '大职门', '13210987654', '8d8178ddd3d5d040bd3696d5b98ed655', '1', '1', '大职门', null, '0', '2017-04-11 11:48:11', '总裁', '总裁介绍', 'upload/master/u170411011/u170411011.png', '99');
INSERT INTO `user` VALUES ('u170411012', '秘书', '13210231452', '19c4d17876fa0d3b1fa1c34c7ea5b0ad', '1', '1', '大职门秘书', null, '0', '2017-04-11 11:48:48', '秘书', '秘书简介', 'upload/master/u170411012/u170411012.png', '99');
INSERT INTO `user` VALUES ('u170411013', '前台', '13520198764', '462472361fb60b154a581985d87e43b5', '1', '1', '前台', null, '0', '2017-04-11 11:49:27', '前台', '前台简介', 'upload/master/u170411013/u170411013.png', '99');
INSERT INTO `user` VALUES ('u170411014', '后段', '13209876540', '186b04046b5cf1a2526f8073a7575fe9', '1', '1', '后端', null, '0', '2017-04-11 11:50:11', '后段', '后段介绍', 'upload/master/u170411014/u170411014.png', '99');
INSERT INTO `user` VALUES ('u170411015', '武当', '13320987650', '5fe5e03f97c781210776b9bb381f3bb9', '1', '1', '武当', null, '0', '2017-04-11 11:50:50', '武当', '武当介绍', 'upload/master/u170411015/u170411015.png', '99');
INSERT INTO `user` VALUES ('u170414031', '小莫', '13520191100', '5dafcff5519b2e952710194bc18f0688', '1', '1', '小莫', null, '0', '2017-04-14 15:59:57', '声动科技执行总裁', '百度（纳斯达克：BIDU），全球最大的中文搜索引擎、最大的中文网站。1999年底,身在美国硅谷的李彦宏看到了中国互联网及中文搜索引擎服务的巨大发展潜力，抱着技术改变世界的梦想，他毅然辞掉硅谷的高薪工作，携搜索引擎专利技术，于 2000年1月1日在中关村创建了百度公司。\r\n“百度”二字,来自于八百年前南宋词人辛弃疾的一句词：众里寻他千百度。这句话描述了词人对理想的执着追求。\r\n百度拥有数万名研发工程师，这是中国乃至全球最为优秀的技术团队。这支队伍掌握着世界上最为先进的搜索引擎技术，使百度成为中国掌握世界尖端科学核心技术的中国高科技企业，也使中国成为美国、俄罗斯、和韩国之外，全球仅有的4个拥有搜索引擎核心技术的国家之一。阿里巴巴网络技术有限公司（简称：阿里巴巴集团）是以曾担任英语教师的马云为首的18人于1999年在杭州创立，他们相信互联网能够创造公平的竞争环境，让小企业通过创新与科技扩展业务，并在参与国内或全球市场竞争时处于更有利的位置。[1] \r\n阿里巴巴集团经营多项业务，另外也从关联公司的业务和服务中取得经营商业生态系统上的支援。业务和关联公司的业务包括：淘宝网、天猫、聚划算、全球速卖通、阿里巴巴国际交易市场、1688、阿里妈妈、阿里云、蚂蚁金服、菜鸟网络等。[2]  2014年9月19日，阿里巴巴集团在纽约证券交易所正式挂牌上市，股票代码“BABA”，创始人和董事局主席为马云。2015年全年，阿里巴巴总营收943.84亿元人民币，净利润688.44亿元人民币。\r\n2016年4月6日，阿里巴巴正式宣布已经成为全球最大的零售交易平台。\r\n2016年7月5日，第三方应用商店“豌豆荚”宣布，其应用分发业务并入阿里巴巴移动事业群，双方已正式签订并购协议。[3] \r\n2016年8月，阿里巴巴集团在\"2016中国企业500强\"中排名第148位。[4]  2017年1月19日晚间，国际奥林匹克委员会与阿里巴巴集团在瑞士达沃斯联合宣布，双方达成期限直至2028年的长期合作。阿里巴巴将加入奥林匹克全球合作伙伴（The Olympic Partner、“TOP”）赞助计划，成为“云服务”及“电子商务平台服务”的官方合作伙伴，以及奥林匹克频道的创始合作伙伴。[5]  2017年2月，阿里巴巴成立澳大利亚、新西兰总部。深圳市腾讯计算机系统有限公司成立于1998年11月[1]  ，由马化腾、张志东、许晨晔、陈一丹、曾李青五位创始人共同创立。[1]  是中国最大的互联网综合服务提供商之一，也是中国服务用户最多的互联网企业之一。[2] \r\n腾讯多元化的服务包括：社交和通信服务QQ及微信/WeChat、社交网络平台QQ空间、腾讯游戏旗下QQ游戏平台、门户网站腾讯网、腾讯新闻客户端和网络视频服务腾讯视频等。[3] \r\n2004年6月16日，腾讯公司在香港联交所主板公开上市（股票代号00700），是香港恒生指数成分股之一，董事会主席兼首席执行官是马化腾。\r\n2015年，腾讯公司实现总收入1028.63亿元，同比增长30%；腾讯权益持有人应占盈利288.06亿元，同比增长21%。\r\n2016年6月22日在北京世界品牌实验室(World Brand Lab)主办的“世界品牌大会”发布了2016年(第十三届)《中国500最具价值品牌》分析报告，腾讯名列三甲。[4] \r\n2016年上半年，腾讯营收为人民币676.86亿元（102.07亿美元 ），比去年同期增长48%。权益持有人应占盈利为人民币199.20亿元（30.04亿美元），比去年同期增长40%。[5]  2016年8月，腾讯控股有限公司在\"2016中国企业500强\"中排名第140位。[6]  2016年9月5日，腾讯股价开盘后继续大涨，腾讯股价达209.40港元，市值目前已达1.982万亿港元，不仅领先于阿里巴巴集团，也首度超过中国移动，力压工商银行、中国石油等老牌国字头公司，成为亚洲市值最高的公司。', 'upload/master/u170414031/u170414031.png', '1');
INSERT INTO `user` VALUES ('u170418032', 'yxb', '15701206171', 'c39889cde3e746767222a878a80744fa', '2', '2', 'yxb', 'wu ', '0', '2017-04-18 11:34:58', null, null, null, '99');
INSERT INTO `user` VALUES ('u170418033', 'yxb1', '15700000001', '947ce0899e8057734585ddb7aa93ba47', '2', '1', 'yxbzm', null, '0', '2017-04-18 14:11:35', 'zm1', 'zhangmenjieshao123zhangmenjieshao123zhangmenjieshao123zhangmenjieshao123zhangmenjieshao123456', 'upload/master/u170418033/u170418033.png', '2');
INSERT INTO `user` VALUES ('u170420034', 's--/-/----+ +++-9-*-//-*/-*-/*/unxy', '12345678901', 'd2ef55a07cbbc658c5a682256efe828f', '1', '1', ' sunv此 xy，', null, '0', '2017-04-20 15:34:10', '卡从粉红色的v黄小姐开会说的4564654654@@@@76213737', '很少见挥洒喊度华东师大', 'upload/master/u170420034/u170420034.jpg', '99');
INSERT INTO `user` VALUES ('u170420035', 'sxy', null, '328d0af3b648ea710faed01e15463cda', '1', '2', null, '合适的话撒娇看得见看见', '1', '2017-04-20 15:51:13', null, null, null, '99');
INSERT INTO `user` VALUES ('u170421036', '孙逍原', '18911961659', 'ea89880265b134eef25a084d35967aad', '1', '2', 'sxy', '倪倪倪倪倪倪妮妮倪倪倪倪倪倪逆囜你你你你你你你你', '0', '2017-04-21 10:11:55', null, null, null, '99');
INSERT INTO `user` VALUES ('u170421037', '测试权限', '18736971254', '8d5395e2cbc25ff2c26fb95f5257e1a2', '1', '2', 'test1', '', '0', '2017-04-21 20:11:02', null, null, null, '99');
INSERT INTO `user` VALUES ('u170421038', '测试权限掌门', '18769796233', '15f9819b3512b47a1cbc9138b05a99a9', '1', '1', 'test2', null, '0', '2017-04-21 20:11:32', '防守打法', '', 'upload/master/u170421038/u170421038.jpg', '99');

-- ----------------------------
-- Table structure for verifycode
-- ----------------------------
DROP TABLE IF EXISTS `verifycode`;
CREATE TABLE `verifycode` (
  `vid` varchar(12) NOT NULL COMMENT '验证码ID，生成规则=v+年+月+日+5位数字，例如v17032500001',
  `mphone` varchar(15) DEFAULT NULL COMMENT '要获取验证码的手机号',
  `code` varchar(10) DEFAULT NULL COMMENT '验证码',
  `expiredatetime` varchar(100) DEFAULT NULL COMMENT '验证码超时时间，用于计算的 str 时间戳类型',
  `createdatetime` datetime DEFAULT NULL COMMENT '验证码生成时间',
  PRIMARY KEY (`vid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of verifycode
-- ----------------------------
INSERT INTO `verifycode` VALUES ('v17042300002', '18769796133', '261282', '1492918044303', '2017-04-23 11:22:24');
INSERT INTO `verifycode` VALUES ('v17042300003', '13590685235', '331105', '1492918809942', '2017-04-23 11:35:09');
INSERT INTO `verifycode` VALUES ('v17042300004', '13520197512', '629115', '1492918825442', '2017-04-23 11:35:25');
INSERT INTO `verifycode` VALUES ('v17042300005', '13520197512', '400786', '1492919013222', '2017-04-23 11:38:33');
INSERT INTO `verifycode` VALUES ('v17042300006', '13520197512', '446846', '1492921987937', '2017-04-23 12:28:07');
INSERT INTO `verifycode` VALUES ('v17042300007', '13520197512', '502797', '1492922005890', '2017-04-23 12:28:25');
INSERT INTO `verifycode` VALUES ('v17042300008', '13520197512', '899368', '1492922107874', '2017-04-23 12:30:07');
INSERT INTO `verifycode` VALUES ('v17042300009', '13240986540', '624220', '1492922540215', '2017-04-23 12:37:20');
INSERT INTO `verifycode` VALUES ('v17042300010', '13520197512', '173606', '1492924351875', '2017-04-23 13:07:31');
INSERT INTO `verifycode` VALUES ('v17042400011', '18911961659', '108494', '1493000651073', '2017-04-24 10:19:11');
INSERT INTO `verifycode` VALUES ('v17042400012', '18911961659', '394575', '1493000651620', '2017-04-24 10:19:11');
INSERT INTO `verifycode` VALUES ('v17042400013', '18911961659', '873668', '1493000653198', '2017-04-24 10:19:13');
INSERT INTO `verifycode` VALUES ('v17042400014', '13520197512', '006285', '1493001010495', '2017-04-24 10:25:10');

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
