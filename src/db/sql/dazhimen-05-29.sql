/*
Navicat MySQL Data Transfer

Source Server         : 生产
Source Server Version : 50528
Source Host           : 47.93.48.9:3306
Source Database       : dazhimen

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2017-05-25 20:34:56
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
  `audiofilename` varchar(500) DEFAULT NULL COMMENT '音频文件名称',
  `audiofilesize` decimal(15,2) DEFAULT NULL COMMENT '音频文件大小',
  `createdate` datetime DEFAULT NULL COMMENT '新增日期',
  `updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `viewcount` varchar(10) DEFAULT '0' COMMENT '播放次数，默认是0',
  `pid` varchar(12) DEFAULT NULL COMMENT '所属产品ID',
  PRIMARY KEY (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程信息表。';

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('cou17051000001', '第一课', '0', '99', 'upload/product/p17051000001/course/cou17051000001.mp3', 'PPT第一课.mp3', '6.11', '2017-05-10 20:49:12', '2017-05-19 12:13:51', '3', 'p17051000001');
INSERT INTO `course` VALUES ('cou17051100002', '一MBA报考条件及如何选择学校', '1', '99', 'upload/product/p17051100002/course/cou17051100002.mp3', 'MBA第一课.mp3', '12.93', '2017-05-11 10:58:47', '2017-05-25 16:21:49', '62', 'p17051100002');
INSERT INTO `course` VALUES ('cou17051300006', '1、P2P是什么？', '1', '99', 'upload/product/p17051200004/course/cou17051300006.mp3', 'P2P是什么？.mp3', '8.23', '2017-05-13 08:00:59', '2017-05-25 16:21:21', '3', 'p17051200004');
INSERT INTO `course` VALUES ('cou17051400008', '第一节', '0', '99', 'upload/product/p17051400007/course/cou17051400008.mp3', 'xiaochengxu.mp3', '7.57', '2017-05-14 13:53:00', '2017-05-19 12:22:47', '3', 'p17051400007');
INSERT INTO `course` VALUES ('cou17051700009', '第一课', '0', '99', 'upload/product/p17051400008/course/cou17051700009.mp3', '淘宝开店入门秘籍.mp3', '7.07', '2017-05-17 19:31:30', '2017-05-21 16:07:42', '0', 'p17051400008');
INSERT INTO `course` VALUES ('cou17051700010', '跟对人和选对公司，哪个更重要？', '0', '99', 'upload/product/p17051300005/course/cou17051700010.mp3', '跟对人和选对公司，哪个更重要.mp3', '4.87', '2017-05-17 19:32:01', '2017-05-19 16:48:46', '0', 'p17051300005');
INSERT INTO `course` VALUES ('cou17051700011', '为润资本合伙人姚鑫谈要不要创业', '0', '99', 'upload/product/p17051700009/course/cou17051700011.mp3', '创业一期.mp3', '7.39', '2017-05-17 21:07:15', '2017-05-19 13:00:01', '0', 'p17051700009');
INSERT INTO `course` VALUES ('cou17052100012', '为润资本创始合伙人姚鑫这样说', '0', '99', 'upload/product/p17052100011/course/cou17052100012.mp3', '8点14.mp3', '7.37', '2017-05-21 11:10:25', '2017-05-21 11:10:25', '1', 'p17052100011');
INSERT INTO `course` VALUES ('cou17052100013', '下属经常抱怨，管理者该怎么应对', '0', '99', 'upload/product/p17051300005/course/cou17052100013.mp3', '下属经常抱怨、发牢骚，管理者应该怎么应对？.mp3', '4.27', '2017-05-21 16:42:12', '2017-05-21 16:42:12', '0', 'p17051300005');
INSERT INTO `course` VALUES ('cou17052100014', '当领导也应适当“装傻”与示弱', '0', '99', 'upload/product/p17051300005/course/cou17052100014.mp3', '当领导也应适当“装傻”与“示弱”.mp3', '5.98', '2017-05-21 16:45:47', '2017-05-21 16:45:47', '1', 'p17051300005');
INSERT INTO `course` VALUES ('cou17052100015', '领导推崇以公司为家，这观点对吗', '0', '99', 'upload/product/p17051300005/course/cou17052100015.mp3', '领导推崇以公司为家，这种观点对吗？.mp3', '3.67', '2017-05-21 16:47:22', '2017-05-21 16:47:22', '1', 'p17051300005');
INSERT INTO `course` VALUES ('cou17052200016', '申请MBA是一种什么样的体验？', '1', '99', 'upload/product/p17051100002/course/cou17052200016.mp3', '申请MBA是一种什么样的体验？.mp3', '2.57', '2017-05-22 22:40:46', '2017-05-25 16:21:55', '2', 'p17051100002');
INSERT INTO `course` VALUES ('cou17052200017', 'MBA的市场格局及如何申请？', '0', '99', 'upload/product/p17051100002/course/cou17052200017.mp3', 'MBA的市场格局及如何申请？.mp3', '6.44', '2017-05-22 22:42:16', '2017-05-22 22:42:16', '1', 'p17051100002');
INSERT INTO `course` VALUES ('cou17052200018', '2017届MBA录取情况', '0', '99', 'upload/product/p17051100002/course/cou17052200018.mp3', '2017届MBA录取情况.mp3', '7.51', '2017-05-22 22:45:43', '2017-05-22 22:45:43', '0', 'p17051100002');
INSERT INTO `course` VALUES ('cou17052200019', '案例告诉你什么人容易申请成功', '0', '99', 'upload/product/p17051100002/course/cou17052200019.mp3', '案例分析告诉你什么人容易申请成功.mp3', '7.75', '2017-05-22 22:48:34', '2017-05-22 22:48:34', '0', 'p17051100002');
INSERT INTO `course` VALUES ('cou17052200020', '申请材料的重要性', '0', '99', 'upload/product/p17051100002/course/cou17052200020.mp3', '申请材料的重要性.mp3', '3.20', '2017-05-22 22:49:14', '2017-05-22 22:49:14', '0', 'p17051100002');
INSERT INTO `course` VALUES ('cou17052200021', '清华、北大、人大的招生风格', '0', '99', 'upload/product/p17051100002/course/cou17052200021.mp3', '清华、北大、人大的招生风格.mp3', '5.49', '2017-05-22 22:52:47', '2017-05-22 22:52:47', '0', 'p17051100002');
INSERT INTO `course` VALUES ('cou17052300022', '对MBA申请的难度要有正确认知', '0', '99', 'upload/product/p17051100002/course/cou17052300022.mp3', '对MBA申请的难度要有正确认知.mp3', '4.55', '2017-05-23 00:47:47', '2017-05-23 00:47:47', '0', 'p17051100002');
INSERT INTO `course` VALUES ('cou17052300023', '你最适合报哪个学校？', '0', '99', 'upload/product/p17051100002/course/cou17052300023.mp3', '你最适合报哪个学校？.mp3', '3.05', '2017-05-23 00:48:59', '2017-05-23 00:48:59', '0', 'p17051100002');
INSERT INTO `course` VALUES ('cou17052300024', 'MBA申请重要时间节点和批次', '0', '99', 'upload/product/p17051100002/course/cou17052300024.mp3', 'MBA申请重要时间节点和批次.mp3', '3.57', '2017-05-23 00:50:05', '2017-05-23 00:50:05', '0', 'p17051100002');
INSERT INTO `course` VALUES ('cou17052300025', '申请结果是待定时，怎么办？', '0', '99', 'upload/product/p17051100002/course/cou17052300025.mp3', '申请结果是待定时，怎么办？.mp3', '7.00', '2017-05-23 00:52:17', '2017-05-23 00:52:17', '0', 'p17051100002');
INSERT INTO `course` VALUES ('cou17052300026', '名校MBA面试形式与选人风格', '0', '99', 'upload/product/p17051100002/course/cou17052300026.mp3', '名校MBA面试形式与选人风格.mp3', '4.25', '2017-05-23 00:53:02', '2017-05-23 00:53:02', '1', 'p17051100002');
INSERT INTO `course` VALUES ('cou17052300027', '申请材料填写的注意事项', '0', '99', 'upload/product/p17051100002/course/cou17052300027.mp3', '申请材料填写的注意事项.mp3', '8.23', '2017-05-23 00:54:53', '2017-05-23 00:54:53', '0', 'p17051100002');
INSERT INTO `course` VALUES ('cou17052300028', '进入名校，你还需要这些软素质', '0', '99', 'upload/product/p17051100002/course/cou17052300028.mp3', '进入名校，你还需要这些软素质.mp3', '13.47', '2017-05-23 00:56:19', '2017-05-23 00:56:19', '1', 'p17051100002');
INSERT INTO `course` VALUES ('cou17052300029', '逻辑思维水平，笔试和面试都重要', '0', '99', 'upload/product/p17051100002/course/cou17052300029.mp3', '逻辑思维水平，笔试和面试都重要.mp3', '6.22', '2017-05-23 00:57:19', '2017-05-23 00:57:19', '1', 'p17051100002');
INSERT INTO `course` VALUES ('cou17052300030', '情商与人脉在面试中的重要性', '0', '99', 'upload/product/p17051100002/course/cou17052300030.mp3', '情商与人脉在面试中的重要性.mp3', '2.75', '2017-05-23 00:58:37', '2017-05-23 00:58:37', '1', 'p17051100002');
INSERT INTO `course` VALUES ('cou17052300031', '作为空降兵，如何在新公司站稳脚', '0', '99', 'upload/product/p17051300005/course/cou17052300031.mp3', '空降兵如何生存.mp3', '5.92', '2017-05-23 21:48:13', '2017-05-23 21:48:13', '0', 'p17051300005');
INSERT INTO `course` VALUES ('cou17052300032', '想赢得老板喜欢？要学会管理老板', '0', '99', 'upload/product/p17051300005/course/cou17052300032.mp3', '如何管理老板.mp3', '5.51', '2017-05-23 21:58:34', '2017-05-23 21:58:34', '0', 'p17051300005');
INSERT INTO `course` VALUES ('cou17052300033', '2、网贷的业务逻辑和典型模式', '1', '99', 'upload/product/p17051200004/course/cou17052300033.mp3', '网络借贷的业务逻辑及典型模式.mp3', '14.14', '2017-05-23 22:09:41', '2017-05-25 16:21:24', '1', 'p17051200004');
INSERT INTO `course` VALUES ('cou17052400034', '怎样做职业选择才能事半功倍？', '0', '99', 'upload/product/p17052400012/course/cou17052400034.mp3', '怎样做职业选择才能事半功倍？.mp3', '6.45', '2017-05-24 08:28:56', '2017-05-24 08:28:56', '1', 'p17052400012');
INSERT INTO `course` VALUES ('cou17052400035', '3、平台电子合同怎么签才有效？', '0', '99', 'upload/product/p17051200004/course/cou17052400035.mp3', '3、网贷平台电子合同怎么签才有法律效力？.mp3', '10.74', '2017-05-24 21:56:54', '2017-05-24 22:06:09', '1', 'p17051200004');
INSERT INTO `course` VALUES ('cou17052400036', '4、逾期处理中容易被忽视的问题', '0', '99', 'upload/product/p17051200004/course/cou17052400036.mp3', '4、逾期处理中容易被忽视的问题.mp3', '8.25', '2017-05-24 21:59:54', '2017-05-24 21:59:54', '1', 'p17051200004');
INSERT INTO `course` VALUES ('cou17052400037', '供应链融资那些事儿', '0', '99', 'upload/product/p17052400013/course/cou17052400037.mp3', '供应链融资那些事儿.mp3', '30.28', '2017-05-24 23:09:17', '2017-05-24 23:09:17', '1', 'p17052400013');

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
INSERT INTO `customer` VALUES ('c17051000001', 'Target', null, null, null, null, 'upload/customer/c17051000001/c17051000001_header.jpg', '男', null, '0', null, null, null, 'oMQfAwXcAKPXmWzOVOlsuEd5TcPI', '0.03', '2017-05-10 21:22:52', null);
INSERT INTO `customer` VALUES ('c17051100002', null, '13520197512', null, null, null, 'upload/customer/c17051100002/c17051100002_header.png', null, null, '0', null, null, null, null, '0.03', '2017-05-11 10:29:32', null);
INSERT INTO `customer` VALUES ('c17051100003', null, '13520197515', null, null, null, 'upload/customer/c17051100003/c17051100003_header.png', null, null, '0', null, null, null, null, '0.00', '2017-05-11 10:46:37', null);
INSERT INTO `customer` VALUES ('c17051100004', '小8', null, null, null, null, 'upload/customer/c17051100004/c17051100004_header.png', '男', null, '0', null, null, null, 'oMQfAwSdglfEertT0X_TQKVrw-bk', '0.00', '2017-05-11 11:20:31', null);
INSERT INTO `customer` VALUES ('c17051100005', '李皮', '18811045102', null, null, '5', 'http://wx.qlogo.cn/mmopen/icFtiaZv653nUYDyOGONykG6MVGVrc8vqKDibxkYKYVwe0giblP48FKB1FxALnMpXbHvZFK9AXoeeSZXPH0CrOtDRC5tQ2vibZVWia/0', '男', null, '0', null, null, null, 'oMQfAwVz_pfNJhrVloBMELH55rnY', '19.31', '2017-05-11 15:34:18', null);
INSERT INTO `customer` VALUES ('c17051300006', '张三木', '15510152940', null, null, '0', 'http://wx.qlogo.cn/mmopen/EJOlbD3jCria5kroGLYFMnzCpRIQmQXeyc1ruTmEicBmhVQw61FbhM7MafedoJWJkHVzZ1eC2YwIIN32oF2Kbcf0HUXzLjLHiaT/0', '男', null, '0', null, null, null, 'oMQfAwZQYAPfph0VyvxMHM8IJf8k', '1.00', '2017-05-13 16:08:29', null);
INSERT INTO `customer` VALUES ('c17051300007', '646@北京', null, null, null, null, 'https://wx.qlogo.cn/mmopen/icFtiaZv653nUYDyOGONykG0xpkibsSRPzt6PIC2KrkCyS4pnJia2HB5OvbGibziatIoz9qFCkzhichZzTUwsmrubxoxB78UtYRMVbO/0', '男', null, '0', null, null, null, 'oMQfAwd2z2nUsVeksbTmDZICQFsw', '0.10', '2017-05-13 17:04:07', null);
INSERT INTO `customer` VALUES ('c17051500008', null, '18733259535', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-05-15 06:33:43', null);
INSERT INTO `customer` VALUES ('c17051500009', '专业填坑人', null, null, null, null, 'http://q.qlogo.cn/qqapp/1106037492/AB46620A0F4E02023B12AB3183B7038F/100', '男', null, '0', null, 'AB46620A0F4E02023B12AB3183B7038F', null, null, '0.00', '2017-05-15 11:13:33', null);
INSERT INTO `customer` VALUES ('c17051600010', null, '18722420589', null, null, null, null, null, null, '0', null, null, null, null, '9.99', '2017-05-16 16:14:56', null);
INSERT INTO `customer` VALUES ('c17051700011', '李国誌', null, null, null, null, 'http://wx.qlogo.cn/mmopen/IXun3rdMcib04dAicule4hiarL7k9tumtTPaVT0hS40E459gJia8vn9vEZODPQrTAg7QlicW4QYQazziaAHX12q4ND0uVg0quaVoUa/0', '男', null, '0', null, null, null, 'oMQfAwdSzy63hnaZgGMnvTHFr2XQ', '0.00', '2017-05-17 17:42:24', null);
INSERT INTO `customer` VALUES ('c17051700012', '读你', null, null, null, null, 'http://wx.qlogo.cn/mmopen/PqR8xtG9fr0hzVhY4aibq6JoQZY2apSLNWYVtIowEP3fI1vLUt7r2Pb3pE9tlfEB0OYRLpzgGZk4euSialTQK1yIp8PTGZxKM0/0', '男', null, '0', null, null, null, 'oMQfAwVbJJHLizum0mIQr7wnWtnQ', '0.00', '2017-05-17 18:27:03', null);
INSERT INTO `customer` VALUES ('c17051700013', 'lll', null, null, null, null, '', '0', null, '0', null, null, null, 'oMQfAwWqxWyWtYvh2W-CtHaB4L1U', '0.00', '2017-05-17 19:23:31', null);
INSERT INTO `customer` VALUES ('c17051700014', null, '13614147789', null, null, null, null, null, null, '0', null, null, null, null, '0.00', '2017-05-17 21:17:49', null);
INSERT INTO `customer` VALUES ('c17051800015', '钟子明', null, null, null, null, 'http://wx.qlogo.cn/mmopen/icFtiaZv653nUYDyOGONykGwZVMNJ9tzI6E9bVJFeC9j1xP0LoHA4pE2KAbpuicv8Q6FbEAMeWlSBqGkceWpOerVXeNEC1h4SPx/0', '0', null, '0', null, null, null, 'oMQfAwXOBTcZLFcblnC1pKpOyF10', '0.00', '2017-05-18 09:31:00', null);
INSERT INTO `customer` VALUES ('c17051900016', '阿莎', null, null, null, null, 'http://wx.qlogo.cn/mmopen/icFtiaZv653nUYDyOGONykGic63EBYl5Jze5ic0drd1FGkzS4W2MN2ibPvlfbuZcgwkOWaG0arwFkERFRPzu3KMPu4HhWBOEnVCr9/0', '女', null, '0', null, null, null, 'oMQfAwWLVUtLeZXTmaLPN1npHARo', '0.00', '2017-05-19 12:56:30', null);
INSERT INTO `customer` VALUES ('c17052200017', '南风|创新领导力讲师', null, null, null, null, 'http://wx.qlogo.cn/mmopen/EJOlbD3jCria5kroGLYFMn49Pka6pibWoZ1jCvbTziatpIy6AF4ibRagYNOMCrsAuic2XV3icPOOzKibQ9euGywmGJ6JEqM0ZSu2Yhd/0', '男', null, '0', null, null, null, 'oMQfAwfG8OQz1_ZtGjOZJUqh7pzY', '0.00', '2017-05-22 09:54:38', null);
INSERT INTO `customer` VALUES ('c17052200018', '袁涛จุ๊บ', '18833332045', '太', '', '0', 'https://wx.qlogo.cn/mmopen/PqR8xtG9fr0hzVhY4aibq6BAG2rIMHGJs2WPCYeAEPwLhwy0oNaUd3xiciaMy4tKWDqiaOHhalS0LzozUj0JQvtkRe2sKmsbRh9n/0', '男', null, '0', null, null, null, 'oMQfAwTDhmvwpllPRqUTvMyGV-MQ', '0.00', '2017-05-22 12:29:51', null);
INSERT INTO `customer` VALUES ('c17052400019', 'wuair', '18131166128', '吴秋鹏', 'wuair@163.com', '5', 'upload/customer/c17052400019/c17052400019_header.png', '男', null, '0', null, null, null, 'oMQfAwQ78P82N7zUiullxNEYggo8', '0.00', '2017-05-24 07:30:57', null);

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
INSERT INTO `ir_customer_news` VALUES ('c17051100002', 'n170523030');
INSERT INTO `ir_customer_news` VALUES ('c17051300006', 'n170520027');

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
INSERT INTO `ir_customer_product` VALUES ('c17051000001', 'p17051100002');
INSERT INTO `ir_customer_product` VALUES ('c17051000001', 'p17051300005');
INSERT INTO `ir_customer_product` VALUES ('c17051100002', 'p17051100002');
INSERT INTO `ir_customer_product` VALUES ('c17051100002', 'p17051200004');
INSERT INTO `ir_customer_product` VALUES ('c17051100002', 'p17051700009');
INSERT INTO `ir_customer_product` VALUES ('c17051100002', 'p17052100011');
INSERT INTO `ir_customer_product` VALUES ('c17051100004', 'p17051100002');
INSERT INTO `ir_customer_product` VALUES ('c17051100005', 'p17051400008');
INSERT INTO `ir_customer_product` VALUES ('c17051300006', 'p17051000001');
INSERT INTO `ir_customer_product` VALUES ('c17051300006', 'p17051400007');
INSERT INTO `ir_customer_product` VALUES ('c17051300006', 'p17052100011');

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
INSERT INTO `ir_customer_view_course` VALUES ('c17051000001', 'cou17051000001');
INSERT INTO `ir_customer_view_course` VALUES ('c17051000001', 'cou17051100002');
INSERT INTO `ir_customer_view_course` VALUES ('c17051000001', 'cou17051100003');
INSERT INTO `ir_customer_view_course` VALUES ('c17051000001', 'cou17051200004');
INSERT INTO `ir_customer_view_course` VALUES ('c17051000001', 'cou17051300007');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100002', 'cou17051100002');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100002', 'cou17051200004');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100002', 'cou17051200005');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100002', 'cou17051300006');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100002', 'cou17051300007');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100002', 'cou17051400008');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100002', 'cou17052200016');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100002', 'cou17052200017');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100002', 'cou17052300026');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100002', 'cou17052300028');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100002', 'cou17052300029');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100002', 'cou17052300030');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100004', 'cou17051100002');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100004', 'cou17051200004');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100004', 'cou17051300007');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100005', 'cou17051300006');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100005', 'cou17051300007');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100005', 'cou17052100012');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100005', 'cou17052100014');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100005', 'cou17052100015');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100005', 'cou17052200016');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100005', 'cou17052300033');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100005', 'cou17052400034');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100005', 'cou17052400035');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100005', 'cou17052400036');
INSERT INTO `ir_customer_view_course` VALUES ('c17051100005', 'cou17052400037');
INSERT INTO `ir_customer_view_course` VALUES ('c17051300006', 'cou17051000001');
INSERT INTO `ir_customer_view_course` VALUES ('c17051300006', 'cou17051100002');
INSERT INTO `ir_customer_view_course` VALUES ('c17051300006', 'cou17051300006');
INSERT INTO `ir_customer_view_course` VALUES ('c17051300006', 'cou17051300007');
INSERT INTO `ir_customer_view_course` VALUES ('c17051300007', 'cou17051300007');
INSERT INTO `ir_customer_view_course` VALUES ('c17051300007', 'cou17051400008');
INSERT INTO `ir_customer_view_course` VALUES ('c17051500009', 'cou17051200004');
INSERT INTO `ir_customer_view_course` VALUES ('c17051500009', 'cou17051300007');
INSERT INTO `ir_customer_view_course` VALUES ('c17051600010', 'cou17051400008');
INSERT INTO `ir_customer_view_course` VALUES ('c17051900016', 'cou17051000001');

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
INSERT INTO `ir_order_product` VALUES ('or17051000001', 'p17051000001');
INSERT INTO `ir_order_product` VALUES ('or17051300003', 'p17051000001');
INSERT INTO `ir_order_product` VALUES ('or17051300004', 'p17051200004');
INSERT INTO `ir_order_product` VALUES ('or17051400006', 'p17051100002');
INSERT INTO `ir_order_product` VALUES ('or17051400007', 'p17051400007');
INSERT INTO `ir_order_product` VALUES ('or17051600105', 'p17051400007');
INSERT INTO `ir_order_product` VALUES ('or17051600106', 'p17051400007');
INSERT INTO `ir_order_product` VALUES ('or17051900337', 'p17051000001');
INSERT INTO `ir_order_product` VALUES ('or17052100338', 'p17052100011');
INSERT INTO `ir_order_product` VALUES ('or17052100339', 'p17051300005');
INSERT INTO `ir_order_product` VALUES ('or17052200349', 'p17051400008');
INSERT INTO `ir_order_product` VALUES ('or17052400384', 'p17052400012');
INSERT INTO `ir_order_product` VALUES ('or17052400386', 'p17051200004');
INSERT INTO `ir_order_product` VALUES ('or17052500387', 'p17052400013');

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
INSERT INTO `ir_role_module` VALUES ('r170510001', 'product_manage');
INSERT INTO `ir_role_module` VALUES ('r170511002', 'master_manage');
INSERT INTO `ir_role_module` VALUES ('r170511002', 'news_manage');
INSERT INTO `ir_role_module` VALUES ('r170511002', 'product_manage');

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
INSERT INTO `ir_user_role` VALUES ('u170510001', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510001', 'r170511002');
INSERT INTO `ir_user_role` VALUES ('u170510003', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510004', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510005', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510006', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510007', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510008', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510009', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510010', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510011', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510012', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510013', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510014', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510015', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510016', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510017', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510018', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510019', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510020', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510021', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510022', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510023', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170510024', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170511025', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170511026', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170513027', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170514028', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170514029', 'r170510001');
INSERT INTO `ir_user_role` VALUES ('u170517030', 'r170510001');

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
INSERT INTO `news` VALUES ('n170428047', '大职门App', 'upload/news/n170428047/n170428047_mainimg.jpg', 'upload/news/n170428047/n170428047_listimg.jpg', 'upload/news/n170428047/n170428047_newscontent.html', null, '0', '2017-04-28 16:49:56', '2017-04-28', '99', '0', '0');
INSERT INTO `news` VALUES ('n170512007', '欢乐颂走红背后的“职场人设”逻辑是什么？', 'upload/news/n170512007/n170512007_mainimg.jpg', 'upload/news/n170512007/n170512007_listimg.jpg', 'upload/news/n170512007/n170512007_newscontent.html', null, '1', '2017-05-12 17:49:45', '2017-05-12', '99', '0', '0');
INSERT INTO `news` VALUES ('n170512008', '英诺天使合伙人：科技类创业热点方向及如何选择好项目？', 'upload/news/n170512008/n170512008_mainimg.png', 'upload/news/n170512008/n170512008_listimg.png', 'upload/news/n170512008/n170512008_newscontent.html', null, '1', '2017-05-12 17:58:45', '2017-05-12', '99', '0', '0');
INSERT INTO `news` VALUES ('n170512009', '跟对老板，对职场前途到底有多重要？', 'upload/news/n170512009/n170512009_mainimg.jpg', 'upload/news/n170512009/n170512009_listimg.jpg', 'upload/news/n170512009/n170512009_newscontent.html', null, '1', '2017-05-12 21:14:50', '2017-05-12', '99', '0', '0');
INSERT INTO `news` VALUES ('n170512010', '七麦科技徐欢：三年挂牌新三板，创业需要专注、拒绝诱惑', 'upload/news/n170512010/n170512010_mainimg.jpg', 'upload/news/n170512010/n170512010_listimg.jpg', 'upload/news/n170512010/n170512010_newscontent.html', null, '1', '2017-05-12 21:19:25', '2017-05-12', '99', '0', '0');
INSERT INTO `news` VALUES ('n170512011', '清华教授朱岩：互联网 × 传统产业 = 重资产的轻工业化', 'upload/news/n170512011/n170512011_mainimg.jpg', 'upload/news/n170512011/n170512011_listimg.jpg', 'upload/news/n170512011/n170512011_newscontent.html', null, '1', '2017-05-12 21:22:28', '2017-05-12', '99', '0', '0');
INSERT INTO `news` VALUES ('n170512012', '世纪明德董事长王学辉（一）：泛素质教育领域创业的特点和方向', 'upload/news/n170512012/n170512012_mainimg.jpg', 'upload/news/n170512012/n170512012_listimg.jpg', 'upload/news/n170512012/n170512012_newscontent.html', null, '1', '2017-05-12 21:26:11', '2017-05-12', '99', '0', '0');
INSERT INTO `news` VALUES ('n170512013', '世纪明德董事长王学辉（二）：如何走上创业之路？', 'upload/news/n170512013/n170512013_mainimg.jpg', 'upload/news/n170512013/n170512013_listimg.jpg', 'upload/news/n170512013/n170512013_newscontent.html', null, '1', '2017-05-12 21:32:36', '2017-05-12', '99', '0', '0');
INSERT INTO `news` VALUES ('n170512014', '天使投资人王刚70万投资滴滴打车的幕后故事（一）', 'upload/news/n170512014/n170512014_mainimg.jpg', 'upload/news/n170512014/n170512014_listimg.jpg', 'upload/news/n170512014/n170512014_newscontent.html', null, '1', '2017-05-12 21:40:36', '2017-05-12', '99', '0', '0');
INSERT INTO `news` VALUES ('n170512015', '天使投资人王刚70万投资滴滴打车的幕后故事（二）', 'upload/news/n170512015/n170512015_mainimg.jpg', 'upload/news/n170512015/n170512015_listimg.jpg', 'upload/news/n170512015/n170512015_newscontent.html', null, '1', '2017-05-12 21:44:12', '2017-05-12', '99', '0', '0');
INSERT INTO `news` VALUES ('n170512016', '见闻 | 为未来的新职业做好准备', 'upload/news/n170512016/n170512016_mainimg.jpg', 'upload/news/n170512016/n170512016_listimg.jpg', 'upload/news/n170512016/n170512016_newscontent.html', null, '1', '2017-05-12 21:51:48', '2017-05-12', '99', '0', '0');
INSERT INTO `news` VALUES ('n170512017', '星瀚资本杨歌：产业系统升级与深度技术革命', 'upload/news/n170512017/n170512017_mainimg.jpg', 'upload/news/n170512017/n170512017_listimg.jpg', 'upload/news/n170512017/n170512017_newscontent.html', null, '1', '2017-05-12 22:08:49', '2017-05-12', '99', '0', '0');
INSERT INTO `news` VALUES ('n170512018', '异构智能CEO吴仞博士：AI研究的终极目标及创业', 'upload/news/n170512018/n170512018_mainimg.jpg', 'upload/news/n170512018/n170512018_listimg.jpg', 'upload/news/n170512018/n170512018_newscontent.html', null, '1', '2017-05-12 22:19:05', '2017-05-12', '99', '0', '0');
INSERT INTO `news` VALUES ('n170512019', '英诺天使李竹：创新趋势分析&搭建同花顺团队', 'upload/news/n170512019/n170512019_mainimg.jpg', 'upload/news/n170512019/n170512019_listimg.jpg', 'upload/news/n170512019/n170512019_newscontent.html', null, '1', '2017-05-12 22:23:55', '2017-05-12', '99', '0', '0');
INSERT INTO `news` VALUES ('n170512020', '源政投资董事长杨向阳：硬技术与消费升级的创业', 'upload/news/n170512020/n170512020_mainimg.jpg', 'upload/news/n170512020/n170512020_listimg.jpg', 'upload/news/n170512020/n170512020_newscontent.html', null, '1', '2017-05-12 22:27:52', '2017-05-12', '99', '0', '0');
INSERT INTO `news` VALUES ('n170512021', '致CEO：你花70%的时间磨合团队，不如先花50%的时间找对人', 'upload/news/n170512021/n170512021_mainimg.jpg', 'upload/news/n170512021/n170512021_listimg.jpg', 'upload/news/n170512021/n170512021_newscontent.html', null, '1', '2017-05-12 22:31:17', '2017-05-12', '99', '0', '0');
INSERT INTO `news` VALUES ('n170512022', '大职门正式上线啦！有职场困惑？想职场进阶？这里都有答案！', 'upload/news/n170512022/n170512022_mainimg.jpg', 'upload/news/n170512022/n170512022_listimg.jpg', 'upload/news/n170512022/n170512022_newscontent.html', null, '1', '2017-05-12 22:36:01', '2017-05-12', '1', '1', '0');
INSERT INTO `news` VALUES ('n170518023', '职场“任性”与“韧性”', 'upload/news/n170518023/n170518023_mainimg.jpg', 'upload/news/n170518023/n170518023_listimg.jpg', 'upload/news/n170518023/n170518023_newscontent.html', null, '1', '2017-05-18 09:21:59', '2017-05-18', '99', '0', '0');
INSERT INTO `news` VALUES ('n170518024', '从“北漂”到上市公司CEO，傅盛总结了人与人之间最根本的差别…', 'upload/news/n170518024/n170518024_mainimg.jpg', 'upload/news/n170518024/n170518024_listimg.jpg', 'upload/news/n170518024/n170518024_newscontent.html', null, '1', '2017-05-18 09:36:48', '2017-05-18', '99', '0', '0');
INSERT INTO `news` VALUES ('n170518025', '大职门APP：推动职业经验共享，释放智慧人口红利', 'upload/news/n170518025/n170518025_mainimg.png', 'upload/news/n170518025/n170518025_listimg.png', 'upload/news/n170518025/n170518025_newscontent.html', null, '1', '2017-05-18 17:20:59', '2017-05-18', '99', '0', '0');
INSERT INTO `news` VALUES ('n170519026', '创业是追逐机会还是创造价值，了解创业者是技术也是艺术', 'upload/news/n170519026/n170519026_mainimg.jpg', 'upload/news/n170519026/n170519026_listimg.jpg', 'upload/news/n170519026/n170519026_newscontent.html', null, '1', '2017-05-19 11:01:56', '2017-05-19', '99', '0', '0');
INSERT INTO `news` VALUES ('n170520027', '2017年职场女性压力报告', 'upload/news/n170520027/n170520027_mainimg.jpg', 'upload/news/n170520027/n170520027_listimg.jpg', 'upload/news/n170520027/n170520027_newscontent.html', null, '1', '2017-05-20 20:59:28', '2017-05-20', '99', '0', '0');
INSERT INTO `news` VALUES ('n170523028', '赵晨分享：如何撰写BP、路演技巧和创业生态体系', 'upload/news/n170523028/n170523028_mainimg.jpg', 'upload/news/n170523028/n170523028_listimg.jpg', 'upload/news/n170523028/n170523028_newscontent.html', null, '1', '2017-05-23 10:34:45', '2017-05-23', '99', '0', '0');
INSERT INTO `news` VALUES ('n170523029', '盛希泰：我们面临的五大机遇和创业者必备六大特征', 'upload/news/n170523029/n170523029_mainimg.jpg', 'upload/news/n170523029/n170523029_listimg.jpg', 'upload/news/n170523029/n170523029_newscontent.html', null, '1', '2017-05-23 10:40:47', '2017-05-23', '99', '0', '0');
INSERT INTO `news` VALUES ('n170523030', '理性创业需要足够的职业积累、商业理解和学习能力', 'upload/news/n170523030/n170523030_mainimg.jpg', 'upload/news/n170523030/n170523030_listimg.jpg', 'upload/news/n170523030/n170523030_newscontent.html', null, '1', '2017-05-23 10:46:54', '2017-05-23', '99', '0', '0');

-- ----------------------------
-- Table structure for news_content
-- ----------------------------
DROP TABLE IF EXISTS `news_content`;
CREATE TABLE `news_content` (
  `contentid` varchar(13) NOT NULL COMMENT '新闻内容id，生成规则是:nc+年月日+5数字',
  `contenttype` varchar(1) DEFAULT NULL COMMENT '内容类型，1:副标题，2:图片文件，3:文本信息',
  `contentvalue` varchar(5000) DEFAULT NULL,
  `contentsort` int(2) DEFAULT NULL COMMENT '内容在页面中的排序',
  `nid` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`contentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of news_content
-- ----------------------------
INSERT INTO `news_content` VALUES ('nc17051200021', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170512007');
INSERT INTO `news_content` VALUES ('nc17051200022', '2', 'upload/news/n170512007/nc17051200022_contentimg.jpg', '2', 'n170512007');
INSERT INTO `news_content` VALUES ('nc17051200023', '3', '　　《欢乐颂2》已强势上档，携去年热播之势，无论职场金字塔顶端的安迪、富二代创业的曲筱绡、职业转型期的樊胜美，还是职场新鲜人关关与小邱，在演绎活色生香人生故事的同时，也充分映射出当下中国职场人的消费趋势。近日，全球最大的职场社交平台Linkedin(领英)发布了“2017中国职场人消费行为洞察”，旨在为品牌及营销人揭示中国职场精英的消费特点，探寻当代“新中产”的消费升级路径。调研显示，中国庞大的1.5亿职场人正展示出惊人的消费意愿和实力，被调查者中超过六成人渴望通过努力工作享受高水平的物质生活。这些正处于消费升级过程中、职场阶段不同且性格各异的年轻人，也在欢乐颂五美的人设中有生动展现。\r\n\r\n\r\n◆ 白领“剁手”实力惊人，个性化消费趋势明显\r\n\r\n　　《欢乐颂》的粉丝们对片中主要人物、职场领导者安迪的爱马仕Kelly包，以及职场中坚力量的代表樊胜美近3000元一盒的纪梵希“面膜”仍然记忆犹新。那现实中的白领“剁手”实力如何呢？根据领英调研显示，在其3200万中国会员中，有38%的人属于公认的“新富裕阶层”，即个人可投资资产在30万元以上的群体；有超过60%的会员有意愿进行奢侈品消费，超过1/3的受访者家庭月收入超过5.5万元。这些职场精英展现出了非常强的消费意愿和消费能力。\r\n\r\n　　职场精英们不但消费实力惊人，而且个性化需求明显。例如，有别于曲筱绡外放张扬的品牌偏好，安迪选择的是品质极致的意大利高端服饰，以彰显其优雅、低调的个人品味。在忙碌工作之余，安迪会用一场“说走就走”的旅行来释放压力、充实自我，曲筱绡则喜欢呼朋唤友、派对享乐。而现实中在职场中的重要时刻，例如升职、加薪、换工作等，职场人会希望通过价值更高、更多元化的消费方式来庆祝。数据显示，购买理财产品，投资教育以及购入奢侈品等均是职场人的重要消费决策；其中希望通过购买旅行产品来加冕自己职场巅峰时刻的人最多，比例高达62%；\r\n\r\n　　除了一次性消费，职场人也非常重视对未来的投资和规划。高达77%的职场人希望在未来一年内开展理财和投资计划，65%的人则希望开展学习或教育计划。这说明，理性的中国职场精英非常关注资产的增值和自身实力的提升。\r\n\r\n\r\n◆ 七成白领每年一件“奢侈品”，男性消费更“冲动”\r\n\r\n　　为了更深入了解职场人的消费动机和心态，领英专门以奢侈品为例开展进一步调查。结果发现，职场人对奢侈品的接受度很高，他们巨大的消费潜力正在持续释放。超过六成职场人接受合理的奢侈品消费，超过70%的受访者表示每年都会购入一件奢侈品，超过30%的人奢侈品年均消费额超过10,000元人民币。 有趣的是，职场男性和女性对奢侈品的品类诉求不同。男性偏好腕表、服饰和箱包，而职场女性更青睐箱包和珠宝。数据显示，职场男性的购买周期整体更短，在有购买意愿后会迅速行动，近半数的男性会在一个月内完成购买。这意味着，品牌需要为职场男性打造更加快捷的信息获取与消费通道。确实，正如剧中角色王柏川一样，想要消解樊胜美的小脾气、赢得女人心，直截了当地购买一条爱马仕丝巾！\r\n\r\n\r\n◆ 消费升级时代，职场人用品牌定义独特自我\r\n\r\n　　《欢乐颂》中，安迪的品牌认同是卡地亚腕表、爱马仕钱包、香奈儿丝巾、椰子鞋，曲筱绡钟爱个性张扬的LV小箱包、Valentino铆丁鞋，樊胜美虽然收入不及前者，但仍喜欢佩戴宝格丽耳环、纪梵希蕾丝面膜，哪怕是职场新鲜人关关、邱莹莹，也有能力穿上Joshua Sanders俏皮活泼的笑脸鞋。现实中亦如此，职场精英们在消费升级中渴望表达自我，并希望借助品牌来定义、彰显自己的个性。 领英数据显示，近四成的职场人喜欢能够表达自我、表达个性的奢侈品品牌。同时，白领们对自身所处的职场群体有着高度认同，他们的消费行为会影响同事、客户、合作伙伴的购买决定。例如，高达58%的受访者表示，其汽车购买决策会受到职场人脉的影响，他们60%-70%的教育消费会受到同事的影响，而职场“朋友圈”对其在商务或休闲差旅方面的影响力也超过50%。\r\n\r\n　　“中国的安迪、樊胜美们的品牌消费动力，是对品质生活的追求，对自我的褒奖，以及对品牌的文化和历史的认同。”领英中国企业市场及市场运营总监陈婷认为，“如何在消费者品牌忠诚度愈发提高的现状中保持消费吸引力，让有追求的人追求自身品牌，成为品牌和营销人面临的严峻挑战。”\r\n\r\n　　例如线上高端线上旅游服务平台“赞那度”就曾选择在领英推广“工作-生活平衡(Work-life Balance)”的营销活动，通过在领英发放个性化测试问卷来精准触达领英平台上的商务精英。陈婷表示：“作为全球规模最大的商业决策者、意见领袖及职场影响力人士聚集的平台，领英时刻密切关注职场人这一群体。在中国职业人消费快速升级的当下，我们致力于提供基于领英职场大数据的消费者洞察，以及针对高净值目标人群的精准社交营销方案，帮助客户拓展商机、实现价值。”\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '3', 'n170512007');
INSERT INTO `news_content` VALUES ('nc17051200024', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170512008');
INSERT INTO `news_content` VALUES ('nc17051200025', '2', 'upload/news/n170512008/nc17051200025_contentimg.png', '2', 'n170512008');
INSERT INTO `news_content` VALUES ('nc17051200026', '3', '　　清华邀请到臻云创投合伙人、英诺天使基金合伙人——祝晓成先生，为大家讲述科技类创业和投资的实践。\r\n\r\n　　科技发展使得人类生活更强大更自由，未来穿戴上外骨骼，可能随便出去越野跑10公里很轻松，体力劳动有可能慢慢被很多机器所替代；有更多的传感器甚至生物芯片的出现，有可能跟人体结合，人们获取信息更方便交流更通畅。但是不是会出现别的问题呢？我们会有这样的思考，比如环保的需求、能源的开发等等。有新的东西出来，就会有新的问题出来；新的问题出来，就需要去解决。创业要满足需求，解决问题也是一样，也是需求的一种。\r\n\r\n\r\n一、当前科技类创业热点：\r\n\r\n1、工业机器人，是持续的热点，如汽车装配方面的工业机器人。工业机器人关键技术基本掌握在国外四大家族手里，这是智能制造领域大家不可回避的事实，涉及到一些关键的技术，中国一直在努力突破。生产线上的分拣机器人、装配机器人、喷涂机器人、AGV等等，现在应用已经非常普遍。服务机器人热了几年，除了扫地机器人外，目前还没有形成很好的市场。但随着人机交互技术的不断成熟，未来几年有望进入快速发展期。\r\n\r\n2、VR/AR，热了几年了，虽然还没有形成成熟市场，依然是投资热点。\r\n\r\n3、外骨骼，大家了解么？知道能做些什么？我讲一下自己实际体验过的东西，我戴了一个腰托后，搬几十公斤都感觉不费力，这是外骨骼的一种。康复训练，现在市场上比较知名的，一个是以色列ReWalk，还有日本Cyberdyne公司的HAL系列。因为还有一些如柔性和运动幅度限制的因素，当时还没有特别好的商业化。但是，未来它一定是典型的能够帮助人的设备，不管医疗角度，还是劳动助力的角度，一定有非常大作用。明年中国就有比较成熟的产品推出，大家可以期待。\r\n\r\n4、无人驾驶，这一定会改变人的生活，不仅仅是改变人的驾驶，为什么？未来无人驾驶的车辆，通过全新的交通法规和全新的路径规划，你不需要亲自控制汽车，而可以在途中做任何事情。像我们这样上班通勤的人，每天在北京路上半小时、一小时甚至一个半小时，花的时间可以用来工作、娱乐，甚至休息，无人驾驶会改变人的生活状态。\r\n\r\n5、金融领域的科技，如智能投顾，是人工智能在金融领域的应用；\r\n\r\n6、智慧医疗，如影像辅助诊断，是除了传统的设备以外，用到人工智能，可以大大提高医疗效率（缩短标注时间，提升漏诊率指标）。\r\n\r\n\r\n二、什么是好的科技类创业项目？\r\n\r\n1、满足刚需？制造需求？\r\n　　什么是好项目？不是它的技术强就是好的，而是要满足需求。还有什么可能呢？创造一种需求。创业创业，业是什么？商业，商业的本质一定是供需，没有满足需求不是好项目，没有创造需求不是好项目。接下来再去看项目有多好，属于哪一类，是创新型的、升级型的、还是革命性的。的确，我们天天接触科技类创业项目，评估项目本身强在什么地方、技术有多好等等，但是，第一位的东西一定是要满足需求——满足刚需，制造需求。\r\n一般来讲，好的项目要考虑差异化，也就是你跟别人不一样，尤其是科技类项目，要考虑差异化这个问题。\r\n\r\n2、领先性？革命性？\r\n　　你是领先？还是革命？革命肯定是很厉害的，但是革命一定是最少那部分，你有足够的领先或者领先一部分也是可以的。\r\n\r\n3、时机\r\n　　我们之前都有过很多教训，其中有一条叫时机。即使有高大上的科技，但如果干早了，因为一些条件还不满足商业的闭环，所以创业失败了。2000年左右的时候，我们有一个创业项目，做的跟Skype基本是一样的事情，这个东西往上延伸，就像现在伟大的微信。当时，我们增加了很多功能性模块，如将语音转成文字，通过email传送替代费用高昂的国际传真，为to B行业如外贸企业提供服务。但是当年没有这么好的带宽，只能靠一些低码流的业务支撑起一个商业模式，方便性、易用性及效率的提升都不显著。所以，简单来讲就是做早了，那个时候的带宽太低，同时也没有延伸出一个有更大商业空间的模式。时机很重要，科技类创业这么多年，一直有新的东西发生、发展，但是所有的链条当中大家都能找到先烈。先烈唯一的好处就是给后来者提供了少踩坑的机会，提供了宝贵的经验。\r\n\r\n\r\n三、科技类创业的特点\r\n\r\n1、综合跨学科\r\n　　科技类项目的特点也是它的难点，就是往往跨学科度非常大，比如硬件方面有声、光、电的结合，还要结合软件开发，所以，这类项目有周期长的特点。科技类项目的创业者，自己要先调整心态，不要想着今天干这个事，明天革命就成功了，后天还翻个多少倍，要踏踏实实做好每一步。\r\n\r\n2、需要行业背景\r\n　　在科技类创业当中，我们经常看到年龄偏大的创业者，他们有非常深厚的行业背景，经历过行业的一些周期，从底层到应用层都熟悉，也能对趋势有所把握，水平甚至是世界顶级的，像之前给大家做过分享的做人工智能的吴韧博士。光见过猪跑不行，还要吃过猪肉。不是说创业团队里每个人都要这样资深，起码团队里应该有这样的人。\r\n\r\n3、需要工程背景\r\n　　工程背景什么意思？指干一个活，能干成什么样，工程能力和背景很重要。这里面又包含很多方面，如对材料的把握、对生产工艺的把握、制造流程的经验和项目管理的能力等等。很多创业者的想法非常好，因为团队没有类似经验，去做了，发现走了很多弯路，交了很多学费，有时候对创业就是生和死的区别了。\r\n\r\n4、需要对接产业资源\r\n　　需要对接产业资源，这个特别特别重要。在高校和科研院所里其实有大量的好东西，可以转化出来，我们叫科技成果转化。其实转化好特别难，以前有政策原因，现在政策打开了，效果还有很大的提升空间，这是个有意思的课题，不展开讲。现在说的是创业方向的事，就是说你思考或寻找的一个需求，有可能在一些大的产业课题里或者大的企业里边他们已经发现了，他们已经在想能不能做？或者我们做不了，有没有人能做？这是现在很多企业到高校共建实验室的原因之一。创业者有机会要多接触大企业，看看他们想什么、他们需要什么，往往这些需求你可以去做，而且做起来后可以和他们的业务嫁接起来，或者就在他们的平台上开发，很容易和他们业务的上下游协同。快速地对接产业资源，创业项目未来也可以接受产业投资，实现项目的健康持续发展。\r\n\r\n\r\n四、科技类创业的难点\r\n\r\n　　作为投资人，尤其在早期投资这件事上，我们的实践就是，从创业者的角度来看问题，看创业的难点，看其中的机会。再归总一下我们建议大家关注的点有哪些：\r\n\r\n1、寻找什么方向的应用\r\n　　首先还是看需求，想一想创什么业？智能制造、物联网有机会，金融、汽车、医疗有机会，娱乐、文创也是大机会。今天主要讲科技，那你怎么寻找方向？首先我觉得要放到足够大的尺度去看这件事。假设大家创业，建议不要只盯着自己的一亩三分地，而要去看市场可能多大，创业能满足多大的需求，或者能创造多大的需求，实现上有哪些关键点，尽量系统化地思考，这么想了以后再收敛和求证怎么做。如果一开始想的就是太窄的点或者不够系统化，往往因为市场太局限或者有更好的方案，最后证明做不大或者根本行不通。\r\n\r\n2、产品是否符合市场需求\r\n　　同样，如何识别和判断伪需求是非常重要的。伪需求并不是说需求不存在，而是指创业的模式是否可以持续和发展。我们看项目的时候，不管通过和创业团队聊还是通过时间去考察，都要放到足够大的尺度，要论证你的产品满足需求的同时，是不是不经济，是不是窗口期很短，是不是只能靠补贴而不能自我造血等等。这些事弄清楚才能启动，后面才是团队的问题、估值的问题等等。\r\n\r\n3、技术壁垒\r\n　　技术壁垒方面，除了不断迭代，要注意专利保护。以前盗版这事使得中国在世界范围内的名声不好，现在有很大改观了。如果你是科技类创业，专利怎么写很有学问，建议大家要做好功课，一定要注意专利保护、建立技术壁垒尤为重要。', '3', 'n170512008');
INSERT INTO `news_content` VALUES ('nc17051200029', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170512010');
INSERT INTO `news_content` VALUES ('nc17051200030', '2', 'upload/news/n170512010/nc17051200030_contentimg.jpg', '2', 'n170512010');
INSERT INTO `news_content` VALUES ('nc17051200031', '3', '七麦科技徐欢女士，为大家讲述她如何在互联网风潮中发现缝隙市场，创立七麦科技，并成功在新三板上市。\r\n\r\n\r\n◆ 开始北漂创业的生活\r\n\r\n2010年大学毕业后加入广州一家央企，生活跟工作的状态都很美好，谁都没有想到我会做出辞职的决定。我知道美好并非我所追求的，于是我2011年辞职，怀揣着不多的积蓄与满满的斗志，坐了22多个小时的硬座来到北京。下火车后当天我就到创新工场去报道，打开电梯门的一霎那，我觉得我来对了——一群年轻人穿着T恤板鞋，顶着重重的黑眼圈，却激情饱满地在讨论着。就是这样一群年轻人，在创造着属于中国的最早一批移动互联网产品——豌豆荚、点心、知乎、应用汇、布丁优惠券、行云等。我跟在座的各位一样，作为北漂一员，住过天通苑、回龙观，地铁转三趟外加公交坐半个小时。我永远记得那段时间，几乎每天10点后下班，站在工场楼下等出租车，没有滴滴的年代，车老是半路被不远处的新浪或腾讯截杀，我有时候需要等上1个小时。\r\n\r\n我不清楚每个人为什么选择来北京，又为什么选择留在北京，但我知道我以及我代表的创业者选择北京的原因，这个城市可以包容我们的理想，可以成就我们的梦想，但也可以击碎它们。\r\n\r\n\r\n◆ 新变量出现，才有可能有新机会\r\n\r\n大家如果想开启创业时候，可以采用坐标轴分析的方式。比如说你目前的创业想法，现在市场上有没有？市场上是否饱和？还是空白领域的。另外一边是你手上有的资产，比如现在团队的技术实力，或是你们现在的资金实力。根据这样的团队实力可以划分出哪块其实是可以做的。我们分析后得出，对于七麦来说，最佳的板块应该是在企业服务领域。\r\n\r\n接下来我们需要看领域是否有新变量，如果没有变量的话，说明有玩家在占据市场。而如果有新的变量，我们应该快速利用这个新的变量，就有可能突破。七麦的新变量发生在2012年底，智能手机与App开始被越来越多大众了解了，到2013年，用户通过搜索关键词下载App的已达到80%，从而带来新的需求就叫做应用市场上的关键词搜索优化。\r\n\r\n\r\n◆ 找准方向就要专注、拒绝诱惑\r\n\r\n创业者需要聚焦专注于擅长的领域。在创业路上，你会遇到各种各样的诱惑，而我们要做的就是聚焦。实际上这三年过程当中，如果让我自己复盘的话，我依然觉得我们不够聚焦，中间走了很多弯路。我们在公司里做了内部创新，把人流进行分散，也做了一些新的项目，势必会错过一些机会，但是没有关系，关注在你自己擅长和应该做的领域才有可能突破。\r\n\r\n80%创业项目的失败，不是因为钱烧完了或者他们的产品没有人用，而是因为创业者自己放弃了。这些创业者往往非常优秀，但优秀的人有太多选择了——可以进入BAT、独角兽公司等等。我确实有很多同学在BAT，我的工资跟他们比起来没有优势，他们不用担心公司垮掉，不用背负很大责任。在这种前提下，他们或许不会选择创业， 或者在做不下去的时候，就不做了。所以，如果你真的想要创业，请想清楚这件事情是你真的要All-in，还是你只是想尝试一下这种感觉。\r\n\r\n\r\n◆ 打造小麦型人才\r\n\r\n七麦名字的来源是初创团队有七个人，之所以取名麦字，是因为也许每一个人单拎出来非常普通，跟麦田里的小麦子一样，但这样七个人凑在一起就能够成就一些事情，这就是为什么叫七麦的原因。\r\n\r\n七麦人才，我形容成小麦型人才，首先必须执行力强。执行力跟自身的资本有关系，通常越优秀的人，越容易不接地气。面试的时候，我会把情况说的很糟，我说我们真的会加班，强度很大，即使你是实习生，我们也会像正常员工对待，有时甚至故意把工作描述得有一些难度，是希望最终真正吸引来的是那些执行力非常强的人。这些人不是因为舒服、不是因为好玩、不是因为觉得福利好、不是因为这个团队颜值高而加入七麦，而是因为他们想要锻炼，想要在这里边拼，想跟有拼劲的团队一起成长。\r\n\r\n创业不是为了好玩，它的背后实际上是商业，非常残酷。任何商业的本质就是要盈利，你不赚钱，你的创业情怀就是在自我YY，这样一个现象直到今年才逐渐被大家看到，为什么？因为2016年资本寒冬，原来大批量只讲情怀的公司倒下了，创业者才警醒，说不行，大家应该落地了，不能再讲情怀了，因为情怀会饿死人，因为情怀当不了饭吃。\r\n\r\n\r\n◆ 七麦文化是什么？\r\n\r\n我一直在强调努力，在七麦，非常非常尊重“努力”两个字，现在的反鸡汤看的多了，大家或许记得有些十万＋《身体上的勤奋不过是为了弥补战术上的懒惰》之类的。但是，努力带来的是一个正向的价值观。在七麦里，我们绩效和管理方式实际上分为两种方式：第一，通过绩效奖金的方式鼓励和奖励努力的人，通过加薪升职的方式奖励那些聪明的人。努力应该得到表彰，即使产出不大，也应该得到表彰。\r\n\r\n在一个创业公司，在一个小团队，这样一个态度太重要了，当你团队大于1/2的人是非常努力、非常勤奋的，他能够影响剩下1/2的人也会变的努力。我们需要寻找的人才是认同“chuang”的精神，认同“创业”文化，也认同“闯”这样一个价值观，这是我们希望打造的人。\r\n\r\n\r\n◆ 创业者需具备智商＋情商\r\n\r\n我们从7个人成长到20人，再成长到50人，管理风格在不断的调整优化。原来快速奔跑的方式并不适合了，团队信息传递也会不通顺。因此在管理上，现在做到了：第一，我们会构建一个充分的沟通的通道，不要小看沟通通道这四个字，在公司里边，如果沟通不充分，很多消极的消息会蔓延、会滋生。在这点上我们建立了三大通道，第一个通道，首先上级要主动的向下沟通，我会考核每一个领导者；第二，我要建立员工可以直接跟HR沟通的绿色通道；甚至每个月会建立CEO和员工沟通方式，希望通过这三个通道让每个人觉得如果你有情绪、烦恼是可以进行沟通化解的。\r\n\r\n另外节点人员要具备智商和情商这两点。什么叫节点人员？部门间的工作会产生交集，汇报流程会产生交集，你发现一个人的交集点越多，说明这个人越重要，他有可能是运营某一个功能板块的负责人，或者他实际上是某个部门的负责人。而这样节点的人，我觉得一定要具备这两点，即使他没有，你也应该告诉他他应该有。我觉得情商有很多种解释，我解释为同理心，作为管理者，最重要的情商不是多么懂得圆滑的说话，这个不是情商，情商是你要懂得换位思考，不要把自己装在领导者的框架里，你想一想你的员工想要什么，我如果不换位思考，我永远不会知道为什么员工要跟我一起拼？\r\n\r\n\r\n◆ 创业最大的成本是决策成本\r\n\r\n创业三年多，我自己觉得最大的成本是什么？算起来，我觉得最大成本不是人的成本，也不是房租的价格。因为这些成本其实都不算什么，创业三年多，我觉得最大成本是决策成本，决策失误有可能搭进去一个完整的团队。\r\n\r\n很多创业者说“我一天到晚忙死了，从早到晚开会，写文档”，那你们花多少时间想呢？做这件事情对了吗？下一个新的增长点在哪儿？…你不去想，你希望谁去想？员工？程序员？还是投资人？没有人帮你想。而决策成本的唯一规避的方式只能靠核心管理层花更多的时间去思考。你如果觉得人贵，而把自己的时间都搭进去了，那有可能所有事情都不成立。这个时候我往往会跟公司的CEO说把自己的时间空出来，你现在做的事情如果能够招人做，花多少钱都值，因为这个公司的性命在我们管理层身上，我们不想谁想。而下面员工能帮你做的事，是把你想清楚的方向细化，加上血，加上肉。\r\n\r\n如果你真的选择创业，请想清楚这件事情你是真的要All-in，还是只是想尝试一下这种感觉。如果只是想尝试一下创业感觉，请加入我们，我们会给你这种感觉，没有必要去烧投资人的钱。', '3', 'n170512010');
INSERT INTO `news_content` VALUES ('nc17051200032', '3', '◆ 未来的创业机会\r\n\r\nASO100作为国内专业互联网数据分析平台，你会看得到整个中国移动互联网的起伏跌荡和风向的改变，去年是直播，今年是共享单车。目前线上超过30到50款单车APP，他们下载量差异非常大。ASO100大数据研究院3月发布了《2017年共享单车领域数据分析报告》，其中mobike排第一，ofo排第二。对于下半场，ASO100监测到怎样的机会？大家如果想创业，或许可以参考。\r\n\r\n\r\n◆ 首先，全球化。\r\n\r\n全球化这个概念，最近重新被大家提起来，作为早期出海的很多公司已经享受到了红利，比如猎豹。全球化为什么又重新被提起来？其中有几个原因：第一，文化差异比以前小太多了，早期出海的很多产品，你们会发现大多数是工具，比如猎豹的病毒清理助手，浏览器等。第二，有几个大的平台在逐渐变的越来越成熟，而且开放程度越来越大，如果你要做全球的产品，不得不关注的一定是Facebook、谷歌、Apple、Twitter。这些平台都可以利用，但是需要有钱，需要有预算。第三，国内红海一片，你能想到的领域基本红海一片了。海外开发者开发能力实际上不如中国开发者。中国开发者不管是编程能力还是想法创新，都很强的，进军海外的时候，竞争优势非常大的。ASO100上有全球155个国家/地区的APP排行榜，里面会有些很有趣的东西。\r\n\r\n\r\n◆ 其次，内容互联网。\r\n\r\n现在好多大公司都在做平台，比如微信公众平台，内容实际上就是机会，用户需求转向对内容的需求，造成创业的风口。第三，“互联网+”一定要深入到各个行业里。互联网要深入各个行业里去，还得求助和请教各个行业里深根扎根的人。我们要做的是把互联网工具和这些行业结合起来，创造新的产能和新的价值。比如e袋洗是很典型的用互联网思维改变洗护行业。\r\n\r\n\r\n◆ 人工智能时代，我们发布AI实验室\r\n\r\n最近人工智能这个话题比较火，包括开复老师在各个场合都有提及。人工智能跟互联网一样，它是一个技术工具，要结合实际的使用场景才会创造价值。我认可人工智能是接下来的风口，但是应该还远远没有到To C的阶段，目前应该仅仅停留在对企业的应用场景，To B的领域。用通俗的话来说，人工智能就是让计算机强大的运算能力达到模拟人脑思考的技术。比如我希望计算机可以自动识别出来猫，我会先给计算机1万张不同的猫的照片培养它。最后当你给它任何一张照片，它都可以自动识别出来是不是猫。你们知道，微博是有审核员的，理论上这个工作是可以由机器代劳的，通过人工智能的技术，微博的内容审核员和百度图片审核员等将可以不用存在了。\r\n\r\n我相信人工智能的时代即将会到来，它能用人脑不能比拟的速度快速高效地运转，自动解决问题，而且最重要的是它不用吃饭，24小时工作，还不用交社保、五险一金，成本非常低。\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '4', 'n170512010');
INSERT INTO `news_content` VALUES ('nc17051200035', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170512012');
INSERT INTO `news_content` VALUES ('nc17051200036', '2', 'upload/news/n170512012/nc17051200036_contentimg.jpg', '2', 'n170512012');
INSERT INTO `news_content` VALUES ('nc17051200037', '3', '世纪明德董事长、青青部落创始人——王学辉先生，为大家讲述泛素质教育领域创业的特点和方向。\r\n\r\n\r\n◆ 什么是泛素质教育\r\n\r\n到底怎样定义素质教育领域？我们平常经常说素质教育领域、应试教育领域，真正做定义时候，真的挺难的。我想很久，做了这么个定义——非同步辅导非提分就都可以叫泛素质教育领域。它包含哪些范畴呢？我想至少可以包含这些：比如艺术相关的培训、体育相关的培训或者活动，户外拓展、营地教育、社会实践、志愿服务、STEM创客、国际学校，包括我们自己做的游学研学旅行等等，这些都属于泛素质教育的领域。\r\n\r\n\r\n◆ 以游学行业为例说明素质教育领域特点\r\n\r\n下面，我就以游学行业为例说明素质教育领域的一些特点，很多都是相通的。游学行业我从四个维度进行划分：\r\n \r\n◆ 销售渠道\r\n\r\n我认为几乎所有人创业都会面临这样的渠道，一个是B2B渠道，一个是B2C渠道，这两个渠道真的非常不一样，甚至可以说天壤之别。比如我们这个领域做B2B，就是要跟学校打交道，要跟校长、局长打交道，为什么呢？一个校长同意、组织一下，三五百学生就来了。\r\n\r\n但大家知道，夏令营行业最大问题其实是安全问题。我跟校长聊，他拒绝我的最大原因是什么？安全问题。游学夏令营就是这样，对于学生的好处开阔视野、增长见识、读万卷书、行万里路，好处显而易见，他比你更明白。但是，他最后不组织的原因就是安全，安全是红线，维稳是红线，万一出现安全问题，他的乌纱帽可能没了。这就是我们这个行业toB最大难点。\r\n\r\nB2C，我们做了青青部落。在to B领域，尤其2014年遇到那样复杂的外部环境的时候，真的很难很难。你让他办A事情，你必须帮他先办B事情，A、B交换，很痛苦的过程，这也是我想做C端，在2015年青青部落拆分出来的原因之一。C端绝对的产品为王，口碑至上。主要靠滚雪球把这个群体越做越大。\r\n\r\n去年12月19号时候终于盼到教育部联合11部委发的文件，叫《关于推进中小学生研学旅行的意见》，真的是行业的春风，我相信大家也是一样，任何一个行业都会这样，一开始进入时候没什么政策支持，本来光明正大的事情，搞成鬼鬼祟祟，很不爽。但是，如果认准这个大方向，迟早国家会承认。去年的文件真的这样，教育部在多个省市试点了以后，终于全面推开，这个事件对我们游学、研学夏令营行业的影响就跟十一届三中全会对中国的影响一样，是划时代和里程碑式的。\r\n \r\n\r\n◆ 目的地\r\n\r\n跟其他素质教育行业可能不太一样，这是我们这个行业特有的，国内营和国际营真的不一样，有时候把港台营也放国际营里，就是因为有办签证的过程，有订国际机票的过程，跟国内高铁、火车票真不一样。国内营，内部能操控以后，其实相对简单的，无非是辅导员怎么把吃喝拉撒、景点、讲座、报告各种活动执行好就可以了，相应的毛利、相应的成本是可控的。但是，国际营有非常不可控的一点，国际机票，为啥呢？去美国国际游学三万多的话，机票就要占一万多，如果敢在一年前把机票钱扣在手里，机票上能省三千到五千块钱，比活动中赚的所有利润都高。但如果没有拿下来的话，临时拿，在机票上就亏三千到五千块，整个团队利润就没有了，或者提前扣了机票，最后没销售出去，又没出手，整个机票订金就全砸了。\r\n \r\n\r\n◆ 活动形式\r\n\r\n活动形式，我分为游学式跟营地式，在美国，游学和营地是两个行业，老死不相往来，但是，在国内其实就是一个行业。一开始定义这个行业的时候，我的观点是把游学式和营地式放一起，为什么呢？一开始要把自己所处的行业搞的大大的，跟搞政治一样，把朋友搞的多多的，把敌人搞的少少的，内容也差不多，目的也差不多，游学是动态式的让学生开拓眼界、增长见识，营地是静态式的，把活动放固定的营地里，是不同形态的。但都是一种载体，都是寓教于乐的形式，一开始在行业里有分歧感，你是搞游学的，我们是搞营地的，咱们分开弄，最后一看就二三十人的小圈子，我觉得不好。所以，一开始要尽量把相关行业划分的大一点，把很多人圈进来，这样大家才有机会产生化学反应。\r\n \r\n\r\n◆ 实施时间\r\n\r\n实施时间，这也是非常不一样的，大家做教育，一定会碰到这个问题，这是面向学生的行业所特有的。在学期中，还是在寒暑假？这是完全不一样的，我们以前只能做做寒暑假。但是，这次发的文件中要求在学期中完成这个事，当成社会综合实践，要计入学分课，要求你停课参加研学旅行。如果只在寒暑假两个月、三个月赚钱，平常会有大量闲置的师资、教室、营地，这个时候算下来运营管理成本非常非常高，收入覆盖不掉全年运营成本，从商业模式上讲是非常吃亏的。但是，教育部文件一发，说可以在学期中做，太好了，假如有一个营地运营的话，每周排的特别满，在学期中的时候就可以接待学校的研学旅行。\r\n\r\n\r\n◆ 世纪明德所在纬度\r\n\r\n综上，我把游学行业按照四个维度、十六个领域区分，世纪明德现在虽然是行业里的小龙头，但是，我们其实只做到销售渠道to B、目的地是国内、活动形式是游学、实施时间是寒暑假，我们只是1/16，今年做到4亿左右的销售额，这个行业还很分散。比如青青部落，现在定位B2C，国内为主的、营地为主、寒暑假为主的。我们明德现在正在跟地方政府谈希望自己建一个营地，如果建好一个营地的话，就是B2B、国内的、营地式的、学期中的。所以，对于明德来讲，要做的就是十六个细分领域都能有所布局，这样的话，我才能做到让整个集团风险更小。\r\n\r\n\r\n◆ 行业特点\r\n\r\n下面我来说说游学行业的一些特点，这跟很多素质教育领域也是想通的：\r\n\r\n低频、高价、非标准、难评价、季度性强、决策者和使用者分离这些因素是我总结的行业特点。\r\n\r\n◆ 低频\r\n\r\n低频，互联网有个规则，高频打低频，王兴创办的美团是高频的，很多互联网平台型产品都是高频的，用罗辑思维的话来讲就是争夺国民的有效时间。低频是咱们行业很大的问题，跟辅导行业不一样，要同步辅导，每天下课都辅导，新东方、学而思为什么那么好，他们的入口直达高一，试验完以后，80%、90%都会接着报，很高频的东西，黏度极高。你跟老师熟了，你明年一般不会换另外一个老师，他们只在高一、初一打打价格战，70%、80%的续约率，游学行业很难，所有素质教育行业都很难。', '3', 'n170512012');
INSERT INTO `news_content` VALUES ('nc17051200038', '3', '◆ 高价\r\n\r\n高价，相对来讲的，对夏令营来讲，国内B端两千元，C端五千元，欧美国际游学的三四万左右，相对来讲是高价的行为，这是比较难的。国际游学一次，有时候不是父母说了算，有时候得父母、姥姥、姥爷、爷爷、奶奶坐下来开个家庭会议。一般的中产阶级家庭还是有些预算的限制，比如只有五千块钱或者一万块钱预算情况下，他可能更倾向于刚需的补课，之后就没有游学的钱了。\r\n\r\n◆ 非标准、难评价\r\n\r\n我相信非标准、难评价是素质教育领域创业两个通用的特点，非标准是什么？比如说好未来、新东方，都有一套教学大纲，而咱们的夏令营，产品是很难标准化的，而且价值观多元化，主题丰富多彩，有成千上万种产品展示形态。难评价，我觉得难评价是非常非常大的问题，你参加一个托福培训班，进去80分，出来100分，好；数学，进去60分，出来90分。夏令营产品，或者素质教育产品，比如艺术培训或者户外体验、拓展，非常难评价。参加完活动后，家长主观感觉好多小孩更听话了，更独立了，甚至懂得帮家长洗衣服了，等等，但这种主观感受都是很难标准的话，导致行业内各家都说自己好，老王卖瓜自卖自夸，很难有个统一的衡量标准。\r\n \r\n\r\n◆ 季节性强\r\n\r\n季节性强，寒暑假是个优势，但上学期间呢？教育部已经发文了，把学期中的时间解放了，我们目前找到了解决方案，你们能不能找到解决方案？\r\n \r\n\r\n◆ 决策者和使用者分离\r\n\r\n决策者和使用者分离，这点也非常纠结。两个小年轻途牛上买张去马尔代夫的机票就去旅行了，夏令营不是这样，有时候家长要去，小孩不同意；有时候小孩想去，家长不愿意让去，有时候家长附带条件的，在班里考第几名让你去。这些特点决定了这个行业最后就是小而美众多的行业，非常的分散。\r\n\r\n下面这是好未来张邦鑫的观点，好未来做的非常好，主要以同步辅导为主，他说要想取得行业规模、市场规模，这三个条件是必须的，第一，最好跟高考挂钩；第二，不跟高考挂钩也行，最好有个输赢的概念，还是刚才讲的评价问题，有输赢算解决了评价指标问题才容易上规模；第三，没输赢也行，有个等级概念也行，比如钢琴，钢琴跟美术相比，其实钢琴的市场比美术大很多，都是艺术类的，为什么呢？钢琴有考级，美术没有，很难界定标准。导致这个行业是分散的特点。\r\n\r\n\r\n◆ 未来游学行业是典型纺锤型结构\r\n\r\n我预测这个行业将来发展到相对比较成熟的话，会成为纺锤型的，从同步辅导行业来看，其实现在就是这样，新东方和好未来加上大家能数上名的十来家，加起来占5%都不到，极其分散。小而美作坊式的，各地小龙头，每个县、每个区都有同步辅导机构，一开始都是知名老师，学校里的特级教师出来做兼职。补课行业就是纺锤型的，一方面是几个巨头，以上市公司为代表，另外一方面就是一堆小而美的小巨头、地头蛇，包括作坊式的，比如北京四中一个特级教师，他身边永远围绕着四五十个学生，新东方、好未来做的再大，也拽不走这四五十个学生，只要在这个老师的精力范围内，不需要规范，不需要办公场地，也会做的很不错的。特大的几家巨型机构，天时地利人和，形成了规模效应，又形成了资本优势，一定会越做越好。\r\n\r\n大家将来创业，如果做成你那个行业的小龙头时候，“四聚”原则是需要的，人才聚集，品牌聚焦，业务聚合，行业剧变。最后要实现行业整合，一定要做到这几步。\r\n\r\n\r\n◆ 未来规划\r\n\r\n明德目前是中国最大的游学集团，通过三五年发展，做到各个细分领域的数一数二，再过三五年，市值到50、60亿时候，收购欧美最大的营地游学集团，他们估值二三十亿人民币。问题是他们持续盈利，盈利还不错，但是没有增长，而且创始人团队已经基本退出，都是职业经理人团队在运营，股权都在基金手里，卖来卖去，欧美很多都是这样的。把欧美最大的游学公司收过来，一方面增大我们的利润，同时增进彼此之间的业务协同，他每年没增长，或者仅仅增长3%、5%，中国这么大市场，我们可以把学生送过去，他也可以把学生送过来，业务协同前景非常广阔。\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '4', 'n170512012');
INSERT INTO `news_content` VALUES ('nc17051200041', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170512014');
INSERT INTO `news_content` VALUES ('nc17051200042', '2', 'upload/news/n170512014/nc17051200042_contentimg.jpg', '2', 'n170512014');
INSERT INTO `news_content` VALUES ('nc17051200043', '3', '滴滴打车已经是传奇，天使投资人王刚的眼光更是让人钦佩，以下是王刚自述（第一部分）\r\n\r\n滴滴创始人程维和我在阿里巴巴B2B、支付宝商户事业部期间一起共事多年。2012年我们先后离开阿里，准备创业。最开始我们很天真，曾想一起做一个集团公司。 \r\n \r\n滴滴属于我们孵化的第一个项目，做一个打车软件的想法也是我和程维一起碰撞并决定的。\r\n \r\n原因有三，在中国打车难，这是大众主流的刚性需求；国外有类似的模式，英国打车应用Hailo刚刚拿到了融资，方向貌似可行，但不能完全拷贝；移动互联网的到来，手机定位距离的属性变得越来越重要。\r\n \r\n最终决定创业后我出资七十万，程维出资十万，他从杭州回到北京，在2012年5月开始创业。我们都没有创业经验，仅仅做出了一个演示和勉强上线的产品，我和他就一起去融资，要融500万美金。\r\n \r\n主流VC都找遍了，但都没有结果。这不能怪投资人没眼光，主要是我们融资经验不足，要的价格跟公司阶段不匹配。\r\n \r\n之后，尽管程维绞尽脑汁压缩成本，还是花完了我们当时的出资。我记得他给我打过一个电话，请求资金上的帮助，我的回应也很坚定：“这是我们孵化的第一个项目，宁可后面不投其他公司，也会扛下去。”后来我就又借了公司几十万。\r\n \r\n直到几个月后，此前我们并不认识的金沙江创投合伙人朱啸虎通过微信找上门来，一拍即合，几乎答应了我们所有条件，滴滴这才完成A轮融资。\r\n\r\n这应该是朱啸虎投资史上最有价值的项目，从那以后，朱啸虎也像合伙人一样一路给滴滴不少有价值的提醒和建议。如果是犀利的意见，他也会通过我，侧面提醒程维。他的确是程维和我见过的最棒的VC合伙人之一。\r\n \r\n滴滴起步时并不顺利。最初的产品是花8万块钱外包开发的，但总达不到上线标准，推出时间一拖再拖。\r\n  \r\n在产品上曾走了弯路，也与早期选择技术合伙人不够慎重有关。因为我和程维都不懂技术，所以拉了一个技术就创业了。\r\n \r\n四个月后，程维果断地让这个技术合伙人离开了公司，在公司账上并没有多少现金的情况下，我们付出了数百万人民币的代价。\r\n \r\n当然，到今天我还是很感激这名合伙人，如果没有他的加盟我们就不会启动这个项目，他对滴滴是有历史价值的。\r\n \r\n团队没有懂技术的人，我们痛苦了很长一段时间，直到2012年年底，程维请来了百度的研发经理张博，才彻底补齐了技术的短板。\r\n\r\n技术合伙人到位后，第一场硬仗就是要拿下北京市场。在这里我们不是起步最早的，当时有一家直接的竞争对手摇摇招车。\r\n \r\n我们没有简单复制他们，而是独立思考我们的业务模式。滴滴有着阿里的基因，如何做一个平台我们是有些经验的。针对对手，在早期我们坚持了四不做：\r\n \r\n一、不做黑车。毫无疑问，我们不能做政策风险太大的事情。\r\n \r\n二、不做加价。因为不想让产品变得太复杂，所以让对手先做，试水了市场接受度后，我们才考虑是否跟进。\r\n \r\n三、不做账户。对于乘客，付钱难不是痛点，打车难是痛点，绑卡很复杂，在早期如果我们给司机带来的收入不够多，他们不会有意愿配合，所以为了不影响扩张速度，我们暂时没有做账户。\r\n \r\n四、不做硬件。当时还有创业公司给司机送iPad，我的看法是平台公司不能用硬件做壁垒，规模是平台的唯一的壁垒。\r\n \r\n能否给司机带来优质订单是核心，硬件不是核心——如果没有订单，司机会在你的设备上安装别人的app抢单；有订单，司机就会买最好的设备来装你的app抢单。\r\n \r\n滴滴第一天就选择在北京创业，也是歪打正着，尽管城市越大，匹配难度就越大，但是先占领了这个战略要地对我们有非同小可的价值。当然首先要面对的就是要和摇摇招车的正面竞争。\r\n \r\n这家公司产品推出比我们早，融资比我们顺利。它和我们的早期目标一样，是要让更多的出租车司机安装上自己的软件，因此地推团队都摆个桌子，在火车站、机场等出租车聚集点推广产品。\r\n \r\n起步后，我们迅速占领了除首都机场T3航站楼以外的所有重要据点，摇摇则跟一家机场第三方公司签了协议，把控了三号航站楼。\r\n \r\nT3这个地点很特殊，每天的出租车吞吐量超过两万，相当于北京其他聚集点车辆数量加一起的总量。这是一个至关重要的阵地，没有占领这里是最让程维睡不着觉的。\r\n \r\n我们商量再三，没有采用跟摇摇一样的方式去找第三方合作，因为担心这种合作有不确定性风险。后来，机场管理部门接到了投诉，摇摇的这个推广点被取消了。当它再去疯狂地寻找其他入口时，我们守住了自己的阵地。\r\n \r\n之后在北京的数据，我们逐渐超过了摇摇。利用了逆袭摇摇的这次机会，我们开始了B轮融资，并做出了我们最纠结的融资决定——接受腾讯的投资。\r\n \r\n此时滴滴受到了很多VC的追捧，当然也包括腾讯。因为我们不想在B轮的时候就站队，所以我们一开始没有想过拿腾讯的钱。\r\n \r\n在腾讯副总裁、腾讯产业共赢基金董事总经理彭志坚的努力和撮合之下，程维和我有了一次跟马化腾面谈的机会。进门之前我们达成默契，就是不给腾讯领投的机会。\r\n \r\n在现场我们分析了移动出行的各种可能发展情况、滴滴对于腾讯的价值，另外就是我们对公司控制权的在乎。马化腾大气地基本答应了我们的所有条件，包括不干涉公司业务的独立发展和不谋求控制权，只有一条，他希望能占有更多的股份。\r\n \r\n通过几次和腾讯的人打交道，他们给程维和我留下了正直、简单和友好的印象，所以我们并不排斥和他们合作。但是对于我们从阿里离开的人来讲，是要过心里这道坎的。\r\n \r\n如果不拿腾讯的钱，我们最大的担心是，快的已经拿了阿里的投资，如果腾讯等不及，转身去投资了摇摇，滴滴将会非常被动。\r\n \r\n此外我们的优势在线下，如果如日中天的微信的强大入口不为我们所用，滴滴就失去了一个最好的战略资源；同时公司也需要一个强大的伙伴去一起面对政策的不确定性，活下去是最重要的。\r\n \r\n程维和我在一个足浴店里进行了最后的讨论，我倾向腾讯跟投，他倾向腾讯领投。结果是我妥协了。\r\n \r\n因为他是CEO，我是投资人，我必须站在他的角度支持他，才能赢。但是我也告诉了他，我们的这个决定是要付代价的，只能扛了。\r\n \r\n刚刚做完了融资决定，第二天是周日，程维就率领他的核心骨干奔赴了上海，因为快的已经进入上海两周了。我则从北京回到了杭州，心情是忐忑的。\r\n \r\n将融资决定反馈给阿里后，几经周折，得到了默认，我也就释然了。但是两家公司的业务，也只能市场上见了。', '3', 'n170512014');
INSERT INTO `news_content` VALUES ('nc17051200044', '3', '快的总部在杭州，几乎和滴滴同期创立，是长三角当时最大的打车公司。快的进入上海后，我们判断，如果上海和杭州形成联动，滴滴将会很被动，所以对这个战略要地，我们必须不惜代价的拿下。程维及团队的目标很简单：交易量不追上快的，就不回北京。\r\n \r\n在上海，滴滴和快的开始了正面交锋。当团队综合运用多种方法，在上海追平了快的之后，我们又迅速进入了快的大本营杭州。\r\n \r\n因为资源倾斜向杭州，让杭州的数据好看了，但上海的团队和资源也随之被削弱，这时候，2013年上半年，上海市场异军突起了除滴滴和快的之外的第三家公司——大黄蜂。\r\n \r\n这家公司我们很关注，他们以一百人的团队，专攻上海一个城市，我们以一百多人的队伍，同时进军五到六个核心城市。大黄蜂单点突破的方式，收效很大。\r\n \r\n我有一次去上海，司机说：“你看，这不是滴滴的联络点吗？”我仔细一看，大黄蜂的联络点就跟滴滴并排在一起，但对方的人员比我的团队更敬业和认真。\r\n \r\n在现场我拍了一张照片发给程维，跟他说：“上海你可能要丢掉了，这座城市一旦丢掉，你就给了对手一个很好的融资的理由，他们会告诉投资人：只要给我钱，我就可以逆袭滴滴。这将后患无穷。”程维回答说：“你给我一周时间，我会马上再来上海。”\r\n \r\n大黄蜂的打法让滴滴伤透脑筋，因为我们打的是一条线，而它只打一个点，比我们要容易。另一方面，快的在拼命拉长战线，大举进军二线城市。\r\n \r\n面对夹攻，我们的战略非常清楚：要把核心城市要地牢牢抓在手里；核心城市一个不能丢，必须把大黄蜂按住。资源都是有限的，由于我们的资金储备比对方多，滴滴采取了一块魔术布的策略，即大黄蜂打哪里我就哪里强，它不打的地方我不打。\r\n \r\n为了把大黄蜂剿灭，公司为上海市场单独做了预算，比如北京市场放五十万美金，上海市场可能加码到三百万美金。什么是战略？\r\n \r\n这就是战略，不平均用力，重点突出，单个矛盾，单个解决。重新把力量集结到上海后，我们逐渐追平了大黄蜂，这时候滴滴、快的、大黄蜂三家公司占有率相差不大。\r\n \r\n恰在这时，我们听闻大黄蜂在找百度融资。在当时，快的已经拿到了阿里的投资，如果百度再入主大黄蜂，打车软件市场将变成BAT三家各投一家，这将是程维和我最不愿看到的局面。\r\n \r\n我们主动约见了百度战略投资部的负责人，程维问他：“你是要投第三名去搏命，还是要投第一？我们的天使可以卖老股争取你们进来。”\r\n \r\n滴滴的目标很清楚：只要争取一个月的谈判时间。只要我们在一个月的时间里，把大黄蜂在上海的数据砸下去，百度就不会投它。\r\n \r\n这时候滴滴的处境是很尴尬的：C轮融资因为VC的恐慌，并非想象的那么顺利；Uber已经准备进入中国市场；传统出租车公司对打车软件充满敌意；区域性政策风险仍不可小觑。\r\n \r\n大黄蜂则利用两边的竞争态势，拼命提高收购条件。这严重的触动了我们的神经。一次在谈判桌上，我突然想起了八个字，“鹬蚌相争，渔翁得利”。\r\n \r\n眼看收购价格越来越高，我提出，与其第一或第二名去争抢第三名，不如一二合并，重新奠定新的市场格局。经过跟程维和滴滴的其他董事商量，我主动找到了阿里。\r\n \r\n尽管信任的重塑是需要时间的，但因为情感基础和理性的战略利益都还在，所以双方都启动了谈判。金沙江的代表、腾讯的代表，阿里的代表，滴滴和快的的代表都出面了。\r\n \r\n当时还在高盛的柳青就是在这时候了解了滴滴，了解了程维。在谈判时，她因为跟两边的高层都能对上话，所以扮演了中间人的角色。经过几轮的反复沟通，虽然双方都是有意愿的，但因为在股份比例和管理权等问题上有分歧，一直无法达成共识。\r\n \r\n最终在2013年下半年，快的并购了大黄蜂。滴滴的C轮融资也获得了突破，得到了中信产业基金的支持，使得滴滴再次拥有了独立发展的机会，和快的的谈判也就暂时搁置了。\r\n \r\n和快的的这次合并谈判，一定程度上修复了我们和阿里的关系。但谈判搁置后，随后就和它开始补贴大战则有一定的偶然性。\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '4', 'n170512014');
INSERT INTO `news_content` VALUES ('nc17051200045', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170512015');
INSERT INTO `news_content` VALUES ('nc17051200046', '2', 'upload/news/n170512015/nc17051200046_contentimg.jpg', '2', 'n170512015');
INSERT INTO `news_content` VALUES ('nc17051200047', '3', '滴滴打车已经是传奇，天使投资人王刚的眼光更是让人钦佩，以下是王刚自述（第二部分）\r\n\r\n在2014年年初接入微信支付后，程维想做一次促销推广，他最初找腾讯要几百万的预算，腾讯回复说：你们的预算太少。最终给了滴滴几千万。结果补贴让滴滴的成交量暴涨，一个礼拜里补贴已经过亿。\r\n \r\n数据的暴涨给了对方不小的压力，在我们即将停止补贴的前一天，快的和支付宝也加入战局，开始对乘客和司机进行补贴。同时因为我们的补贴取消，形势迅速逆转，滴滴的交易数据开始大幅下滑。\r\n \r\n对方的补贴跟进后，一天，程维在董事会上告诉我们：“两周以后，快的的数据可能开始超越我们。”这是我们第一次听到滴滴将被对方超越。此时我人在国外休假，听到这消息，所有的董事都惊呆了。\r\n \r\n我们再次面临一个重大的抉择：是否马上跟进补贴。所有投资人包括我，本能的反应都是极不愿意烧钱的，没有人希望看到我刚投资你，很快钱就被烧光的局面。\r\n \r\n这时候，程维正在开发“红包”产品，更成熟、性价比更高，他的想法是在一个月之后再进行新型的红包补贴。\r\n \r\n在董事的电话会议中，我和朱啸虎提出，尽管是我们发动的补贴大战，但是务必立即有力反击，如果等一个月后再反击，市场份额可能变成7:3，主动权将拱手让予对方，滴滴有可能在市场上消失。\r\n \r\n我们做了一个推演：我们发起补贴时，如果快的不是六天而是一个月后才反应过来，市场数据对比将是7:3甚至8:2。\r\n \r\n一旦这种局面出现，网络效应会产生，乘客觉得呼叫没有司机应答，司机觉得平台里没有乘客使用，将会产生强者愈强，弱者愈弱的结果。这时候对手再用十倍的代价，也未必能追上我们，它的结局是很难拿到融资并最终出局。反之亦然。\r\n \r\n很快大家就达成了一致，一定要让腾讯继续参与补贴。此前的补贴全是腾讯买单，我们后来达成的方案是腾讯和滴滴各拿50%。腾讯高层很爽快地表态：不论是一个月后补贴还是下周一补贴，CEO做决定。程维则当机立断：下周一开始补贴！\r\n \r\n接下来的局面大家都很熟悉了：对方补贴十块，我们十一；我们补贴十一，对方十二的局面。当补贴提高到十二元时，马化腾以多年运营游戏的经验，出了另一个主意：每单补贴随机，十块到二十块不等。这样对方就完全无法跟进了。\r\n \r\n程维采纳了这个方案。之后价格战越打越凶，根本停不下来。直到2014年2月底，马云在来往写了文章，说打车软件让家人打不到车。滴滴立即把握时机做出了积极的回应，使得补贴大战暂时告一段落。\r\n \r\n我要强调的是，滴滴有一个强大的CEO程维，同时有一个非常团结的董事会，滴滴的很多重要决策都是集体作出的。程维不但把他的几个VP激发得不错，董事会成员的热情他也调动得也很好。\r\n \r\n不夸张的说，滴滴的团队没有一天是平静的，滴滴的董事会没有超过一个礼拜是平静的——不是竞争出状况，政策有风险，就是开打价格战，两三年来没消停过。用我们的话形容是“来不及喘气，天天都是高潮”。\r\n \r\n滴滴成立后我们只开过一次正式的董事会，但其实天天都在碰头，随时都可能开会。移动互联网的创业如履薄冰，要求的反应速度比我想象的还要快。\r\n  \r\n补贴对于引导和教育市场是绝对有价值的，但在市场教育完之后，还继续进行巨额补贴，这是不理性的，很多时候是由于囚徒困境导致很难停下来。\r\n \r\n补贴大战进行的同时，有一天，程维打电话告诉我，他想要挖柳青过来。我当时狠狠的吃了一惊。\r\n \r\n这两三年来，我对我投资或者孵化的CEO们讲的最多的一段话就是：“一定要持续的找更牛的人,最初你们都是带一帮一线人员打仗，很快你带的将是经理、总监、副总裁。看你的领导力水平最核心的是看你能领导谁，谁愿意跟你混。”\r\n \r\n虽然我也觉得程维是个没有给自己设限的CEO，但敢挖柳青，还是超出我的预料，程维太敢想了。\r\n \r\n他们密切接触了十来天，如同热恋一般，不夸张的说每天超过16个小时在交流，柳青和程维的家人、同事聊天，把滴滴翻了个底朝天。\r\n \r\n程维告诉我，柳青赌的不是钱，是把整个人赌进来了，她做的背景调查绝对超过所有的投资机构。\r\n \r\n柳青的这个决定肯定让所有人都大跌眼镜，我所知道的是，她的家人对于她加入滴滴心情矛盾，出于理性和尊重的支持与出于情感的心疼都兼而有之。\r\n \r\n柳青决定加盟之前给我打过一个电话，聊了一次，我说：“你那么多年的投行经历，好比一个空心萝卜，因为你没有实操经验；如果加盟滴滴，空心萝卜会变成实心萝卜。”\r\n \r\n在我看来，她和程维商量站在一起的时候，肯定是要打造一个数百亿美金的公司，否则对不起他们的代价。\r\n \r\n要我评价，柳青和程维在业务上就是一对绝配。什么是绝配？\r\n \r\n价值观相同、能力互补，就是绝配，就像马云和蔡崇信是绝配、马化腾和刘炽平也是绝配一样。程维、柳青两个人都极为聪明，有正气，做事都拼命。\r\n \r\n程维草根出身，从底层的销售一步步成长，他对市场的敏锐度、深入一线的执行能力是柳青所需要的；柳青出身名门，有大家风范，她的人脉资源、国际视野、在资本市场里呼风唤雨的能力，又是程维需要的，因此他们这个组合很快见到了化学反应和叠加效应。\r\n \r\n柳青为滴滴付出很多，我讲一个例子：她的孩子以前是读寄宿学校，周末回家。但公司周末要开会，见不到孩子，她就把孩子从寄宿学校转学到公立学校，每天晚上可以回家看到孩子。\r\n \r\n但没想到，滴滴每天晚上开会也开到很晚，经常到十一二点。滴滴团队后来竟想出来这样一个“变态”的方案：每天晚上先让柳青晚上九点下班，回去哄孩子睡觉，十一点再在她家楼下开会。\r\n \r\n这就是滴滴团队拼的程度，这就是滴滴能赢的原因。不仅是她，整个团队都很拼命。\r\n \r\n比如补贴大战的时候，因为服务器宕机，技术团队曾经五天五夜不下楼，大家形容当时CTO张博的状态“整个人都是恍惚的”，还有一名工程师家里老婆生小孩了都没有来得及去医院陪护。\r\n \r\n柳青加盟后，给公司带来了直接的变化。\r\n \r\n记得去年我们D轮融资拿到DST一亿美金之后，DST联合创始人兼总裁尤里·米尔纳(Yuri Milner)曾经来到滴滴，说了三句话：“第一、Uber要灭了你们；第二、如果要活命，只有一个办法，和快的合并；第三、合并后我可以再给你们十亿美金。”\r\n \r\n在现场，我感觉这个家伙是个有大智慧的人，但同时我们也传递了顾虑，因为此前两家公司曾试图合并，但失败了，这时候公司上下没人相信合并是可行的。我们担心他低估了合并的难度，因此做好了继续打大仗的准备，计划融一大笔钱。\r\n \r\n柳青的优势通过这次融资充分发挥出来了。她在和程维的配合下主导了滴滴F轮的近7亿美元的融资，这也是中国移动互联网史上最大一笔融资之一。快的也不示弱，去年年底融了跟我们相同数量的钱。\r\n \r\n融资后，形势起了些微妙的变化。是继续火拼，还是握手言和，共同面对其他的竞争者，双方开始认真进行更有诚意的沟通。\r\n \r\n阿里和腾讯的态度也都变得更加开放，尽管战略诉求不同，但是开放的姿态和心态使得合并有可能发生。双方的管理团队有了更加默契的分工，财务投资人当然都乐见其成。\r\n \r\n大家不约而同地选择了中国互联网界最棒的“红娘”、华兴资本创始人包凡做中间人，开始了不间断的正式谈判。\r\n \r\n在一个基本框架下，战略股东的协调难度肯定是最大的，中间有过几次反复，柳青承担了很重要的斡旋角色，两个CEO也一起喝了不少酒。\r\n \r\n可想而知，几乎所有人都做出了让步，才有了今天的谈判结果。至于董事席位，因为财务投资的股份也占非常大的比重，财务投资人的董事席位没有谁是仅仅代表自己，应该是代表了所有财务股东。\r\n \r\n滴滴和快的合并后的公司，是个更加独立发展的公司，所有的股东，包括战略股东也都对新公司寄予很高的期望和祝福。\r\n \r\n市场竞争远远没有结束，我们因为共同的敌人走到了一起，Uber、易到仍是活跃的竞争者，新的传统租车巨头也会挤进这个领域，移动出行是个非常广泛的领域，“美好出行”的征途才刚刚起步。\r\n \r\n至于滴滴和程维能有今天，我觉得最根本的还是得益于他学习能力强，进步速度快。你的想法告诉他，下一次他能说得比你更好、更透。\r\n \r\n高瓴资本的管理合伙人张磊曾经这样侧面评价过程维：“每一个季度见他，他的进步都非常之大，这样的人，你说不投还能怎么办，必须得投啊。”\r\n \r\n我和程维一起相处有8年，除了学习能力强，他的特点还有聪明、执行力一流、口才出众。他对团队的领导和掌控能力也很强，A轮融资前，因为资金紧张，公司招聘员工的时候不管之前工资是一万还是两万，当时加入，工资只能给五千块。\r\n \r\n如果你是冲着高薪水来，不相信移动改变出行的梦想，那就不要加入。即使是这样的条件，他还是能稳得住军心，这是很考验卖梦想的能力的。', '3', 'n170512015');
INSERT INTO `news_content` VALUES ('nc17051200048', '3', '滴滴在经历几轮补贴大战以后，尽管补贴出去了大把的钱，但是用于团队和公司本身，比如采购桌椅这样的事情，还是能省则省。滴滴今天的手笔比以前大，队伍扩张也更快，对于内部可能的腐败，他仍保持着高度的警惕。\r\n \r\n三年的时间，程维已经迅速地从一个BD经理成长为眼光独到，能纳贤用人，能应对复杂局面的年轻CEO。\r\n \r\n不但能驱动庞大的团队，还能协调各大股东的关系，把董事团结在他的周围，让大家都愿意为公司出力。走到今天，他仍能保持冷静独立思考，还时不时的自我调侃：“我们是被催熟的，样子有点胖，可能是水肿。”\r\n \r\n随着公司的壮大，我们的角色分工有了少许的变化。如果滴滴是一辆车，我以前和其他执行董事是坐在副驾驶的位置上，现在把位置交给柳青，但我们仍在后座。\r\n \r\n公司持续的有新的董事加入进来，给予程维帮助，越来越多的牛人包括极有名望的人加入董事会，对滴滴是最大的好事。\r\n \r\n早期，金沙江的朱啸虎、腾讯产业基金的彭志坚以及中信产业基金的吴敬阳对公司有很大的贡献，直到今天也一如既往地出谋划策。\r\n\r\n此后柳青来了，程维的副驾驶多了一个可以实时在现场对话的人，效率更高。今天的董事会里除了Dexter(快的CEO吕传伟)和David Su（经纬管理合伙人徐传陞），又出现了彭蕾和刘炽平这样的人物，无疑会有助于把公司的业务和管理提升到前所未有的高度。\r\n \r\n但这辆车的驾驶员始终是程维和Dexter，最后的方向仍由他们掌握。我们自始至终能做的就是提醒，碰到了危险，嗓门会大一点。\r\n  \r\n要我形容和滴滴一路走来的这个过程就是互相依托，相互成全。4年前局外人会评价，程维遇到我是他的运气；但在今天我必须得承认，能遇到他，是我的福气。\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '4', 'n170512015');
INSERT INTO `news_content` VALUES ('nc17051200049', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170512016');
INSERT INTO `news_content` VALUES ('nc17051200050', '2', 'upload/news/n170512016/nc17051200050_contentimg.jpg', '2', 'n170512016');
INSERT INTO `news_content` VALUES ('nc17051200051', '3', '新职业层出不穷：无论是近年才有的互联网营销顾问，或是已经有些时日的足球运动员。站在今时今日，我们应该如何为未来的职业做好准备？本文给出了有益的指导。\r\n\r\n未来会出现什么样的新职业，没人知道，怎么为未来的职业做准备？\r\n \r\n\r\n◆ 为未来的职业做准备\r\n\r\n看看纽约时报，现在上面的招聘广告正在招社交媒体运营经理和搜索引擎评估员，管理社交媒体帐号、评估搜索结果相关度，相信对于从事这些职业的人，他们的父母在决定他们在学校学什么的时候不会想到存在这种工作。\r\n\r\n那么我们怎么为还不存在的未来职业做准备？答案就是一位传奇曲棍球球手所说的：要成功就不要看球在哪儿，而要看球将要滑向哪儿。从未来的发展趋势可以让我们找到该关注的地方。\r\n \r\n\r\n◆ 新职业层出不穷\r\n\r\n工作似乎变得越来越虚拟化。我们花越来越多的时间在虚拟的网络世界中，同时我们也看到越来越多的新职业出现。\r\n\r\n整个互联网的生态系统已经出现。 在Google做广告曾经是一个小企业主就可以做的事情，但是现在已变得如此复杂和专业化，数以百计的广告顾问正通过管理在线广告服务来谋生。同时，Facebook的流行又带来了社交媒体咨询的职业。电子游戏的发展产生了“游戏代练”的职业，还有不断增长的电子竞技运动产业。甚至有学生帮别人拿着智能手机四处走动玩精灵宝可梦（Pokemon Go）游戏，通过俘获小精灵来赚取房租。\r\n\r\n如果你觉得这些都不是正经工作，那么试问一下，在19世纪长大的人会相信2016年世界上年薪最高的人会是一些跟着足球跑来跑去的人（足球运动员）吗？他们会想到心理学家、私人教练或者品牌顾问这些职业的存在吗？\r\n \r\n\r\n◆ 利用人对机器的优势\r\n\r\n没有人真的知道今后哪些工作将会由机器自动完成。但有一件事情是清楚的：随着机器变得越来越普遍，调教它们的人也会越来越多。正如我们在航空领域中已经看到的那样，自动驾驶并没有使飞行员失业，相反，它预示着人与机器之间在复杂任务上越来越多的合作。\r\n\r\n自动化在不断发展，但人类具有提升个人技能的潜力，这一点是机器无法匹配或做到的。汽车行业出了件不同寻常的事情， 汽车巨头丰田正在从其工厂中移除机器人，因为机器无法像人类那样提出改进的想法。\r\n\r\n机器似乎不适合于创新，它们在某些方面也不够灵活。看看巴黎的餐厅服务员的表现，试问下需要多长时间才能让机器人来替代这份工作。\r\n\r\n如果要我告诉年轻人他们所需要的技能，那么同情心、创造力、领导力、直觉和人际交往能力，这些都将列在清单上，另外还要加上一点：注意机器是如何运作和思考的。\r\n\r\n“学习你的敌人的语言”，如果机器要来取代我们，我们就需要了解它们。\r\n \r\n\r\n◆ 历史教训\r\n\r\n工作在不断的发展变化之中，但这并不意味工作机会的大量减少。\r\n\r\n几年前，我在和一家4万人公司的CEO谈话的时候，请他列出他认为在数字、数据驱动的未来所需要的技能。他提到了程序员、设计师和网络营销专家。然后，我请他列出公司当前开出工资人员的技能，两者差异是很明显的。\r\n\r\n因为当前人员接受的是过时技能的培训，而组织机构要在短时间内获取全新技能的人员，这种转变并不容易。正如作家阿文·托夫勒（Alvin Toffler）曾经预言的那样：未来属于那些可以忘掉所学的并重新学习的人。\r\n\r\n历史告诉我们，技术创造了更多的机会和工作。世界的状况看上去会令人困惑和担忧，但其实并不是这样。无论是虚拟的或者是实际的工作，无论是自动化的或者是人工的工作，工作虽然在许多方面正在发生变化，但基本原则仍然存在：获取人们需要的技能，做人们需要的工作。\r\n\r\n滑到球将要去的位置其实很容易，只要你坚持几个基本的原则：保持好奇心、开放的心态、敢于尝试新事物、顺应世界潮流发展的方向。\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '3', 'n170512016');
INSERT INTO `news_content` VALUES ('nc17051200056', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170512018');
INSERT INTO `news_content` VALUES ('nc17051200057', '2', 'upload/news/n170512018/nc17051200057_contentimg.jpg', '2', 'n170512018');
INSERT INTO `news_content` VALUES ('nc17051200058', '3', '国际知名人工智能专家、高性能计算专家、异构计算专家和计算机博弈专家，异构智能创始人兼CEO——吴韧博士，讲解了人工智能的技术背景和他在此领域的研究和见解，从技术的角度深入阐述了他对于人工智能未来的看法。\r\n\r\n\r\n◆ 想好了再创业\r\n\r\n创业是一个很艰苦的过程，很多年以前，我喜欢摄影，大家开玩笑是说“如果你想陷害你的朋友，想让他破产的话，就劝他去学摄影。”学摄影有什么好处？摄影是一门艺术，是“用光”的艺术，劝你朋友把什么都“用光”，包括钱。创业也一样，创业有巨大的回报，但是也有非常高的风险。如果你的男朋友或者女朋友让你不高兴，你劝他创业，因为一年以后他肯定涨30磅了，像我一样。\r\n\r\n创业艰辛，如果大家没有准备好，还不如找一个靠谱的工作，比如给我们投简历。没想清楚之前，先选一个靠谱公司，比如说异构智能公司，到一个非常高的起点上，然后创业，这样成功率会增加很多。\r\n\r\n\r\n◆ 战略&战术\r\n\r\n“I have no time to see a saleman, I\'ve got a battle to fight.\"图中例子是讲一个将军带着士兵冲锋战斗，忙着把城堡打下来，却没时间见一个销售员。但实际上销售员手上的抢远远比将军手上的箭更为先进。” 但如果他停下来几分钟仔细思考一下，拿到这个武器后，他的战斗会变的无比容易。\r\n\r\n如果你忽略了对长期趋势的判断，而只专注于眼前斗争的时候，你可能会输得很惨，如果对方采用跟你不一样的更适应将来发展趋势的策略，即使战术上胜了，但是战略上也会输掉。\r\n\r\n更深层的意思，这幅图也告诉我们，不管将军的武功多好、他的算法多厉害，如果有新的武器出来以后，个人的能力或者用上一代武器练出来的绝世功夫在新武器面前一文不值。大家用弓箭和长矛战斗时候，要想我做什么事情可以彻底改变竞争格局，在武器上、在思维上、还是在更高的维度上领先对手。不管创业，还是工作，还是以后管理非常巨大的公司，一定要记住战术上要胜利，战略上也不能输掉，一定要胜利。这才是真正智者的行为。\r\n\r\n\r\n◆ 人类的直觉才是智能的关键\r\n\r\n国际象棋程序击败世界冠军是1997年。而在2006年的时候围棋程序连初学者都比不过，2015年时我们的顶尖的棋手让九个子，还可以把围棋程序打得一败涂地，这也是为什么去年初AlphaGo跟李世石比赛的时候网上给出的判断一边倒，说人类一定会完胜围棋程序，为什么这样讲？因为国际象棋运用的是左脑思维的做法，在国际象棋上非常成功，可惜的是在围棋上完全不灵，围棋上用到了我们人类另外一个非常重要的能力，什么能力？\r\n\r\n爱因斯坦很早就告诉过我们，真正有价值的是我们的直觉，人类的进化告诉我们人类的直觉才是真正的关键元素。我们的围棋程序为什么几年前做的不好？就是因为我们没有技术真正做出围棋的棋感或者直觉，在业内人来说，如果对这个问题有深层认识的话，你可能会知道，我们近几年深度学习的进度或者深度神经网的能力正好给我们提供了另外一种载体，可以让我们几乎重现动物的本能或者人类的直觉。\r\n\r\n\r\n◆ AI研究的终极目标在于进入并改善生活\r\n\r\n若想通过AI赚钱，就必须通过AI技术解决具体问题。解决具体问题的方法在于把AI从云端、从设计上放到各种各样的小东西里，从无所不能到无处不在，这就是我想给大家讲的，至少是方向所在。我们应该把AI做得更好，但是更重要的是要把AI应用起来，它要进入到我们的生活，并且改善我们的生活，这是做AI研究的终极目标。如果大家对创业有兴趣的话，一定要想清楚你创业的目的是什么，用AI来创业，一定要找到AI可以进入我们生活并且改善我们生活的地方，做到这一步以后你就准备好了。\r\n\r\n\r\n◆ 智能物联网\r\n\r\n我的判断是物联网永远不会发生，世界上不会有物联网，唯一有的一定智能物联网，我们每一个小物体感知到数据以后，它必须就地处理这些数据，就地消化掉这些数据，跟后端或者跟其它东西进行交付的时候，一定是更高层面的通讯。为什么？物理上限制了我们的能力，有很多具体的限制问题，比如带宽，再比如自动驾驶，如果前面出来一头牛的时候，车要回到云端问一下牛能不能撞，拿到结果的时候，你已经没法看这个结果了，因为延时是致命的，必须本地作出马上的反应。\r\n\r\n物理已经告诉我们，如果本地做计算消耗的能力跟你从手机上把计算送到云端某一个服务器做出计算以后再把结果返回来对比，之间的能量差是6个数量级，是100万的区别，如此巨大的区别。从物理上来讲，从节约能量角度来说，我们都要做本地智能。能量是生物或者地球上物种存在的一个重要的判定指标，设计这个系统的时候，必须得遵照地球上最基本的规则。\r\n\r\n\r\n◆ 创业需要想清楚的事情\r\n\r\n你要找创业机会的话，就要思考在哪一个方面能够比你的对手或者比所有的竞争者都做得更好，我们讲到数据，这是一个方向。有了数据方向以后，你需要在算法上，不同的人工智能模型、不同培训算法上做得比别人好。创业的时候，你得想清楚，为什么只有你可以做而别人做不了？你下载一个开源软件，就觉得能够创业成功，那还是低估了创业的难度。用别人做出来的工具，你走的路已经很受限制了。\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '3', 'n170512018');
INSERT INTO `news_content` VALUES ('nc17051200067', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170512022');
INSERT INTO `news_content` VALUES ('nc17051200068', '2', 'upload/news/n170512022/nc17051200068_contentimg.jpg', '2', 'n170512022');
INSERT INTO `news_content` VALUES ('nc17051200069', '3', '大职门APP，职场经验与技能分享平台，智慧人口红利下的共享经济模式。\r\n\r\n在职场某一领域具有丰富积累的人都算智慧人口，在大职门，我们将智慧人口统称为职场掌门，他们的经验和技能可以帮助很多人。\r\n\r\n大职门是职场掌门分享经验与技能的平台，通过释放智慧人口红利，帮助掌门获得额外的变现机会。大职门也是学习者快速提升自己，获取职场突破的渠道。\r\n\r\n大职门希望每位职场掌门的经验都能惠及更多人，帮助更多人成长，帮他们实现自己的职业理想。\r\n\r\n有些人不知道怎么选择职业，大职门可以提供帮助：\r\n \r\n◆ 首先，帮你了解行业。\r\n大职门会持续发布由业内资深人士提供的热门行业研究分析和趋势追踪，包括互联网、房地产、人工智能、教育、金融科技、智慧医疗、投资等等。\r\n \r\n◆ 其次，为你解读不同行业中企业的运转机制与岗位体系设置，分享具体岗位的实战经验与技能。\r\n帮助你认识企业这种组织，理解岗位体系和组织的关系，明白不同岗位分别需要哪些经验技能，看到不同岗位的日常工作内容，进而对照自己的条件和喜好，做出合适的选择。\r\n \r\n◆ 当然，大职门也提供职业规划服务，一众职场大咖现身说法，根据自己的亲身经历，加之深刻总结，帮你分析自己的特点，找到最适合自己的职业方向。\r\n \r\n即便你选择对了，想取得职场成功，依然有很长的路要走。\r\n \r\n你需要不断丰富自己的技能，完善自己的知识体系，提高胜任力；你也需要直面职场江湖中的各种争斗和险恶，学会蹚平职场中的坑；还要能预判自己的职业发展前景，适时作出转型。所有这些，大职门都能为你提供。\r\n \r\n如果你想去创业，大职门也能为你指点迷津。这里不缺少创业精英，他们的领悟也能帮助你走向光明。如何发现创业机会？组建核心团队的要诀？商业模式梳理？计划书撰写指南？股权设计方案？融资渠道？创业需经历的，他们都可以分享给你。\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '3', 'n170512022');
INSERT INTO `news_content` VALUES ('nc17051300070', '1', '——专业的职场经验与技能分享平台。', '1', 'n170428047');
INSERT INTO `news_content` VALUES ('nc17051300071', '2', 'upload/news/n170428047/nc17051300071_contentimg.jpg', '2', 'n170428047');
INSERT INTO `news_content` VALUES ('nc17051400073', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170512021');
INSERT INTO `news_content` VALUES ('nc17051400075', '2', 'upload/news/n170512021/nc17051400075_contentimg.jpg', '2', 'n170512021');
INSERT INTO `news_content` VALUES ('nc17051400076', '3', '对创业公司而言，造血能力与产品发展方向等都非常重要。所有的这些具体工作有赖于落实到具体的个人身上，所以招聘到核心团队就显得尤为重要。带出一支凶悍的队伍，你需要在最合适的岗位上找到最合适的人，并想到方法让他们保持激情、施展才能。\r\n\r\n同一赛道，旗鼓相当的两家成长期创业公司，拥有充足弹药的极有可能赢家通吃，率先在细分领域拔得头筹。为保证业务快速增长，战略级人才招聘是 CEO 不惜一切代价也要落地、必须亲力亲为的事情。\r\n\r\n在此前的经纬创享汇中，瓜子二手车的 CEO 杨浩涌说：“招人是每个创始人除了投资定战略以外最重要的事情。招人没有诀窍，你投入多少时间就会有多少结果。在前期多下功夫，好的人才值得花时间去挖掘和沟通。如果创始人 70% 的时间都在做具体事情上，那只能说明你的团队还不够强。”\r\n\r\nCEO 应该打造一支顶尖团队，把自己从具体事务中解放，将注意力转移到更重要的地方。有些时候，阅人无数不如思考如何锁定并拿下目标人才，巩固团队并培育中流砥柱。\r\n\r\n\r\n◆ 为什么有些人，就算“倾家荡产”也得拿下？\r\n\r\n“不让我投，我就给你打工吧。”2014 年 6 月，当时代表高盛投资、却再三遭拒的柳青对程维说。\r\n\r\n两天后，程维约她正式谈加盟，落脚谈到薪水。当时与快的补贴大战中，滴滴最高记录是每天烧钱 3000 万美元。柳青在高盛年薪千万，资金紧张的程维又该如何付至少 200 万美元的薪水呢？\r\n\r\n程维一脸镇定，维持着笑眯眯的表情，心里却唱起忐忑。那时滴滴薪水最高的人年薪也不过 25 万。\r\n\r\n回到公司，程维做了两个决定：\r\n\r\n一、继续跟柳青谈判，用股权的方式来调整她的薪水；\r\n\r\n二、找来公司财务总监，只说了一句话，不管你用裁员还是其他方式缩减流水，不惜一切代价也要挖来柳青。\r\n\r\n结果我们都知道，2014 年底，入职不到半年的柳青主导了滴滴 F 轮 7 亿美元融资。\r\n\r\n\r\n◆ 我再举个例子：\r\n\r\n当年谷歌打算进中国时，中国区总裁人选很难确定。海德思哲和谷歌分析的结论是，如果要进入中国，最大的障碍是缺少本土技术人才。因此，这个候选人必须具有一个很核心的能力——感召力，才能把技术人才提前锁定。他们与 200 多个华人职业经理人沟通过后，发现当时的微博大 V 李开复最为合适。\r\n\r\n李开复入职第一年，在全国各地各大高校进行巡回演讲，那一年谷歌中国在中国招了 2000 多名知名高校毕业生。\r\n\r\n这故事在猎头界广为传颂，我想用它说明的是：战略级人才挖角，是 CEO 不惜一切代价也要落地、必须亲力亲为的事情。\r\n\r\n而如果没有站在公司战略的高度去思考，CEO 们有的时候真的会把自己坑死。\r\n\r\n\r\n◆ 我再给各位举个反例：\r\n\r\n有个做直播的创业者打算转行做电商，找到我。他说自己公司做电商的优势在于流量大，用户黏性好。\r\n\r\n我当时额头就冒出黑线——这些数据对于做电商其实帮助很小，目测创始人对于业务想得不是很清晰。我只好问：“你打算用什么样的代价，去完成这个目标呢？”\r\n\r\n“我就想用 15000 左右的月薪，招个运营。如果可以的话就继续开展这个业务，如果不行就再换个方向。”\r\n\r\n我顿时眼前一黑：15000 招个运营专员工资确实很高，可关键一个运营专员根本搞不定这摊事啊？凭着不坚定的决心和这么低的投入，如果继续这样，做这个项目基本没戏。\r\n\r\n这个例子我想说明的是，市场上的人才都是“优质优价”，想花小钱办大事，基本没可能，或者不长久。\r\n\r\n所以啊，老板们，敲黑板，该出手时就出手，该高薪就不要吝啬，犹豫就等于永远错失良机。\r\n\r\n\r\n◆ 什么时候高薪挖人是大杀器？\r\n\r\n如果你正遇上这两种情况，我建议你果断用高薪砸晕对方：\r\n\r\n一是，当新引进人才可以加速融资速度时，必须要舍得花钱。\r\n\r\n二是，两家业务相近的公司竞争白热化时，要率先冲出来。\r\n\r\n同一赛道创业，两个公司不相上下，先融到下一轮的公司极有可能赢家通吃，率先在这个细分领域冲出来。这种时候，高薪挖人只是打击竞争对手的一种手段。\r\n\r\n不过，敢于高薪挖人的 CEO 通常是这两类：一类是能迅速把事物本质点出，他会很清楚地知道公司的问题是什么，也知道自己要什么样的人才去解决这个问题；另一类则是不多见的明星创始人。\r\n\r\n\r\n◆ 招人留人的三种正确姿势\r\n\r\n当然，为避免空降高管把组织搞得鸡飞狗跳，高薪挖人成为公司走向不归路的开始，强烈推荐各位老板这样三步走：\r\n\r\n\r\nStep1：实行 BOSS 团制度\r\n\r\n公司引进核心高管时，最好让其他所有高管都参与面试。一面时可以由创始人单独进行，二面、三面时要与未来共事的同事进行接触。\r\n\r\n这样一个人是否入职就是大家一起拍板、共同决策的结果。这样做的好处是公司不容易出现山头政治，由于是集体的决定，所以大家更愿意配合新同事开展工作，不会当他是外来人而另外抱团；当这个人最后表现不如人意时，大家也可以理智评估去留，减少团队因此冲突的可能性。\r\n\r\n在面试时，还可以动用一切人脉，邀请相关领域的专家加入面试，对面试者的专业素养和过往经历进行核实。\r\n\r\n\r\nStep2：给招人留出充足空间\r\n\r\n对创始人来说，招聘是为了战略目标服务，但由于战略可能经常变，所以招人的弹性要大，此时要把候选人的潜力列为考察重点。\r\n\r\n打个比方来说，某 CEO 要招一个做社交的产品经理，社交形态丰富，包括社区、APP、直播等等，如果只招一个有做直播经验的人，就并不是最优解。\r\n\r\n在创始人发现方向需要调整时，比如不得不去做社交短视频，那此时就需要一个有学习能力并且能适应业务微调的产品经理。\r\n\r\n当 CEO 允许招聘空间有弹性时，有潜力的员工能够适应创业公司天生的这种变化，这样可以节约成本、提高效率。\r\n\r\n\r\nStep3：支付薪水的正确姿势\r\n\r\n话分两头，尽管做好了高薪准备，但在谈薪水的时候，你也要说清高薪、低薪 + 期权方式的优劣：\r\n\r\n拿较低的薪水通常对应聘者更有利，因为团队容错率更高；而高薪相当于提前变现，这意味着容错率特别低。\r\n\r\n如果对方选择高薪，作为创业公司 CEO 的你可以大胆给钱，但给钱的方式一定要严格，甚至要比上市公司还要严。你可以开出两个人的薪水，要求该人去做三个人的工作。\r\n\r\n阿里巴巴的做法是，公司表现最一般的员工每年发 15 个月的薪水，最好的员工可以给到 27 个月。其实这种保持饥饿感的方式最适合创业公司，薪水数目由应聘者定，支付方式由公司定：如果可以完成 KPI，除高薪还有额外奖励；如果做不到，可能几个月就被开掉。\r\n\r\n你也可以选择延缓发放高薪，比如承诺下一轮融资到账以后工资翻 1.5 倍或者 2 倍。很多创业公司已经开始这么做了，这是用来吸引核心人才的一种手段。当然如果入职后做得不好，也要尽快清理出团队。\r\n\r\n\r\n◆ 尖兵留不住，公司不进步\r\n\r\n我们把企业里的员工分为三类：\r\n\r\n第一类，普通的员工，主要负责日常执行，换谁一样干。\r\n\r\n第二类，有潜力的人才，在执行中实现创新，并且能够适应公司的微调。\r\n\r\n第三类，是我们说不可或缺的负责人，公司没有办法不用。这样的人可能是从明星公司挖来，也可能有特别多的资源，这样的人离开后公司就无法正常运转。\r\n\r\n\r\n◆ 不同的人对待的方式就不一样，激励机制也不同。\r\n\r\n1、普通员工，只要保证能拿到工资，保证正常上下班，不要让这些员工心生怨恨就足够。\r\n\r\n2、明星员工加入之后，能迅速做起公司的某块业务，不过这样的人通常会觉得创业成功希望渺茫，变现更为实际。如果你不开高薪，这种人就会迅速被其他公司抢走。\r\n\r\n而第二种人能担事、有创业精神，是创业尖兵，这样的人一定要牢牢盯住。这种人有很强的学习能力和可塑性，要为他们的渴望创造成长的环境。\r\n\r\n公司里面最拔尖的那 10% 人才，是未来整个公司持续发展的核心动力源泉。这种人才数量不够公司就会死气沉沉，只能按照上级的要求执行。这些尖兵一定要全部留住，少一个人，公司发展就可能慢好几年。\r\n\r\n\r\n◆ 老板要把自己从具体事务中解放\r\n\r\nCEO 要多花时间在人和战略上面，要占 50% 的精力，而不是主要陷入事情本身。这是杨浩涌在第二次创业的经验，我也把这句话送给各位创业者。\r\n\r\n打造团队这件事不能假手于人。如果用一两周时间把人找来，后面要花几个月去改造，不断地跟在他后面，看他做的怎么样，不断提改进意见，那招聘其实就是失败的。\r\n\r\n应该在前期找人上多下功夫，好的人才值得花非常多的时间去发现和沟通。如果 CEO 70% 的时间都在做具体事情上，那只能说明你的团队还不够强。\r\n\r\nCEO 应该打造一支优良团队，把自己从具体事务中解放，将注意力放到更重要的地方。\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '3', 'n170512021');
INSERT INTO `news_content` VALUES ('nc17051400077', '3', '日前，清华创业与引导课堂邀请到源政投资董事长——杨向阳先生，为大家讲述硬技术与消费升级的创业。以下是主要内容：\r\n\r\n今天回清华跟大家交流，我想还是先讲一讲最早创业的清华校友，是谁呢？我愿意也希望每一个清华人都应该记住“熊大缜”这个名字，理学院院长叶企孙最钟爱的一个学生。熊大缜是个富家子弟，他长得很帅，在家排行老五，所以叫熊五爷。他1931年进入清华，也是清华足球队的。他很喜欢照相，喜欢摄影，在叶师的指导下，在大二还是大三时候做出了中国第一台红外照相机，可以在清华气象站拍到西山的夜景，后来又在西山拍了北京市的夜景，这个照片在清华校史馆可以找到。\r\n\r\n上世纪30年代的时候，红外技术还是很先进的技术，那时候印照片都是蛮强的技术。他创了什么业呢？他做了清华照相馆，在什么位置呢？如果没记错，就是二校门旁边的小楼，所有冲印的药水都是他们自己研发的，那个年代是高科技了。后来这个照相馆很赚钱，因为在那个年代，大家背井离乡，没有火车也没有飞机，坐着马车、背着包袱就来上学了，能够拍一张照片，给家里寄回去，是很重要的一件事。清华照相馆很赚钱，赚的钱买了很多教学教具和设备。\r\n\r\n后来他干了一件更大的事，抗日时候，他帮共军做炸药。我们小时候看的电影中讲的地雷、炸药都是农民兄弟造出来的，其实不是，都是熊大缜造的。但他后来被当作国民党特务处死了，他死的时候年仅26岁，在1986年的时候被平反昭雪了。这是我们清华的骄傲，也是每个清华人应该尊重的，这也是迄今为止清华创业的第一人。\r\n\r\n\r\n◆ 回归商业的本质\r\n\r\n我对创业的基本主张是回归到商业本质，商业本质是什么？我们组建公司也好，做个产品也好，提供服务也好，是为了干什么？其实是真的要满足一个需求，找到一帮客户，也就是说你要找到一个市场。找到市场以后，用你的技术也好，用你的产品也好，用你的服务也好，来满足这个市场，你得赚到钱，一个不赚钱的企业，那就是瞎扯。今天不赚钱没关系，但是，未来一定赚钱，回归到商业本质就是这样。当然，不光是赚钱，还要能够持续赚钱，这就是我对创业的基本主张。\r\n\r\n\r\n◆ 互联网与人工智能不是创业的全部\r\n\r\n我还是要跟大家强调一下，互联网与人工智能不是创业的全部。比如说我们做出了一个药品，能够治疗癌症，它跟互联网有什么关系？一定要用互联网吗？如果说现在全世界有一种药，可以让我们的生命延长十年，用互联网吗？其实不用。在这个时代，互联网成为主要的商业趋势，它占据了流量，占据了很多眼球，很多人就提出这么一种主张，好像互联网是一切。\r\n\r\n其实我觉得互联网不是全部，我今天讲的创业可能跟互联网没有太大关系，但是也不代表我们不可能有一番成就，人工智能也是一样。我们在清华，在各个系，有很多好的想法其实都可以创业，不一定非要挂着互联网或AI才能成为创业者，这也是我的一个基本观点。\r\n\r\n\r\n◆ 做一批“中国创造”类的企业\r\n\r\n经过一段时间思考，我想我们以前穷、以前弱，落后、挨打。现在我们好象富了、强了，但是似乎并没有受到世界的尊重，为什么？一个人、一个社会、一个国家怎么能够受到别人尊重？后来我得出一个结论：一个人不能只索取，一个社会、一个国家也是一样，你要有所贡献。你对这个社会、对整个世界要有所贡献，你才能得到别人的尊重。\r\n\r\n我们想一想，电话、电报跟我们有关系吗？照相机、摄像机跟我们有关系吗？火车、轮船、飞机跟我们有关系吗？现在我们吃的、穿的、用的中最先进的东西没有什么是我们发明创造的。所以，我想中国应该到了这么一个阶段，我们今天可以从中国制造向中国创造转变。\r\n\r\n\r\n◆ 硬技术创业的特点与坑\r\n\r\n从技术到产品，再从产品到市场是很麻烦的事情。比如清华的师兄，光峰光电的李屹，真的是聪明不得了，非常好的科学家。但他在做终端产品的过程中出现了很多问题，走了很多弯路。一个搞技术的要做成一个品牌，尤其是to  C的品牌很难。像这种企业怎么定位？就守住核心技术，开发出产品DEMO，然后找有生产能力的人去做，这种方式就比较自由。所以我想告诉大家有技术是可以创业的，找到适合自己的方式，也是可以做出很不错企业的，比如光峰光电。\r\n \r\n清华可能有很多技术不太好商业化，但在清华学技术只是一种能力，不一定依靠这个技术去创业，比如现在搞计算机的可能好创业，别的院系相对没那么容易，但只要受过这种训练和教育，有了这种能力做什么都行。\r\n\r\n\r\n◆ 消费升级要有品、有态度、有价值主张\r\n\r\n我对于消费升级的理解是我们要从单纯的有用要走到有品、有态度、有价值主张。你的态度是什么？你有什么样的价值主张？消费升级真正的内涵在这里。一个酒店本来是破破烂烂的居民楼，里边改改装修一下，价格就可以贵一点。以前卖一个烧鸡30元，说是无公害的，可以卖60元。为什么贵呢？卖的是什么？这就是一种态度，你有你的价值主张，比如你卖的是有机的，你卖的是生活情调。从单纯的有用要走到有品、有态度、有价值主张，我觉得这就是消费升级核心的问题。\r\n\r\n其实当时我准备退休的时候，想做两个企业，一个是跟科技相关的，叫小藻科技。同时，我想做另外一个企业，这个企业最好跟文艺相关。我们做了定制领域里边的富士康——“一件起定”，用一整套柔性生产路线来支持个性化定制。比如我今天穿了一件T恤，上面就是我自己设计的图案。点一下你喜欢的图案、文字或者你设计的图形，你拍的照片都可以，就可以一件起定。后来我起名叫“态度”，我们要做一个有态度的定制。\r\n\r\n从生产线、墨水到所有东西都是我们自己研发的，设备都是我们自己做的，我要按工业4.0的思路来做这个事情。我们做个性化定制，做一件、做十件、做一百件成本大概差5-10%。我们当时的战略比较简单，to 大B、to 小B、to C。一件起定，未来一定是个性化的时代，年轻人喜欢个性化的东西。\r\n\r\n\r\n◆ 清华人最基本&最高要求\r\n\r\n清华人最基本的要求是“三通”，文理通、中西通、古今通。我建议大家不要太偏科，要扩大自己的知识面。\r\n\r\n清华人最高的要求是什么？独立精神、自由思想。你们将来要创业，这个事情非常重要。你们做很多决定时候，其实都是很孤独的，面对未知时候，如果不能有独立精神和自由思想，只是人云亦云是不行的。考61分和90分都没关系，但如果问你诗词歌赋，你什么都不懂，那还谈什么消费升级呢？你自己都没消费过，没有品位，还怎么升级呢？所以最高要求是有独立精神、自由思想。\r\n\r\n\r\n◆ 对现在学生想创业的几点建议\r\n\r\n我们要自己训练自己，要怎么训练呢？我有几个建议：\r\n\r\n第一，我们要管理好自己的信息库与人脉库。每个人都有手机、电脑，都有自己的朋友圈，这时你就可以建一个自己的信息库，把相关的有价值的内容收集起来，长期积累下来就形成了自己的知识库。要善于管理自己的人脉库。比如我在我的朋友圈里只要看到某个人发了我要抵制日本人，抵制韩货，我立马拉黑，这种人就是没脑子。不要惹这种人，把他们清了。所以，要管理好自己的人脉关系，你交什么样的人？跟什么样的人走动？你也会慢慢变成这样的人，这些其实是我们年轻人要注意的。\r\n\r\n第二，清华工科比较多，就要多关注一些人文，科技如果不插上人文的翅膀，是飞不高的。比如说两个人都用同样的技术设计出一个产品，一个人可能卖的很好，另一个人可能卖不掉。为什么？他说我卖的是诗和远方，很多人觉得有格调就买了。另外一个人说结实、便宜，但现在消费升级了，没有人要。有时间可以听两首歌、读两首诗、读点好的书籍，这个很重要。\r\n\r\n第三，努力养成独立思考与决策的能力，如果永远问别人对不对，最后没办法做事。一个好的创业者，一定是一个好的Leader，什么叫好的Leader？就是你在茫茫大海上，只有一束微光的时候，你能够决定往那里走，最后还没沉船，还没撞，就算撞了你也要走。\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '3', 'n170512020');
INSERT INTO `news_content` VALUES ('nc17051400078', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170512020');
INSERT INTO `news_content` VALUES ('nc17051400079', '2', 'upload/news/n170512020/nc17051400079_contentimg.jpg', '2', 'n170512020');
INSERT INTO `news_content` VALUES ('nc17051400080', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170512019');
INSERT INTO `news_content` VALUES ('nc17051400081', '2', 'upload/news/n170512019/nc17051400081_contentimg.jpg', '2', 'n170512019');
INSERT INTO `news_content` VALUES ('nc17051400082', '3', '◆ 如何准备创业\r\n\r\n第一：找到强需求\r\n\r\n什么叫强需求，就是真实存在的并且市场足够大的需求。很多事情都可以创业，其中有些也解决了身边的小问题，但我们寻找的是有资本价值并能够解决足够大问题的创业项目。\r\n\r\n\r\n第二：找到合伙人\r\n\r\n当你知道要干的事情是什么以后，一定要找人一起干。只投两个以上创始人的团队，基本上是所有天使投资人的要求，为什么？因为一个创始人很容易退却、很容易放弃，可能看到其他更挣钱、更好玩，就做别的事情了。再有，如果只有一个合伙人，碰到困难，你一个人解决不了，整个公司就解决不了。有合伙人以后，碰到问题可以一块商量，创业有时候是非常苦的事，但是，有搭档就不会感到那么苦。\r\n\r\n\r\n第三：找到天使投资\r\n\r\n找天使投资，不仅仅是找钱，还要找能够帮助你优化商业模式的，能够帮助你对接资源的人。在中国，做一个创始人太不容易了，要懂得产品，要了解市场，要知道怎么管人，甚至还要跟政府打交道。这些事情学都学不过来，就需要有人帮你，天使投资人也许就是能够帮助你的人。\r\n\r\n\r\n◆ 好项目怎么进行求证\r\n\r\n1、谁是用户？刚性需求？\r\n\r\n很多创业者在设定自己创业目标的时候，往往容易犯一个错误，就是路径依赖，首先想我有什么本事、我有什么资源，然后我做什么样的创业，但是，往往忽略了你服务于谁。\r\n\r\n先把用户搞清楚，比如在微信上做公众号，首先针对的是什么群体？找到用户群以后，最好做一下调查，问一下他们，我想做一个这样的事，你们觉得是不是需要？如果他们说我肯定用，这就是刚性需求。如果你问了十个人，有五个人说我可能用，那这事就别干了。\r\n\r\n\r\n2、独特发现？细分领域第一？\r\n\r\n这件事情是不是你独特的发现？还是很多人都想到了？如果你发现这件事情时候已经有很多人做了，你一定要看看你和他们的差异化在哪儿，你比他们好多少。创业者看到有些公司融资了，觉得我也能做，就马上做一个，这个情况是极其危险的。我要告诉大家，你跟别人做同样的事情，如果你晚半年，你的估值大概只有别人1/3。这就是互联网创业的规律。\r\n\r\n还有一个问题，我做了这个领域，我有没有可能做到第一？在你启动一件你认为有价值去创业的事情时，你必须认为在这个细分领域你能做到第一。\r\n\r\n\r\n3、与其更好，不如不同\r\n\r\n《从0到1》这本书最关键的结论之一是如果看到别人做什么，做的不错，随大溜，绝对会失败。我们经常看到一些创业者是什么东西热做什么，原来是移动互联网App比较热，他觉得不错，就做了，没做多久发现O2O起来了，就转过来做O2O，往往以失败告终。创业一定要有创新的精神，不能老是抄别人的。\r\n\r\n\r\n4、创新趋势分析\r\n\r\n举两个例子，一是去年春节时候电影《美人鱼》票房过30亿。从1998年第一部贺岁片《甲方乙方》到2008年，每年春节票房都是三四千万，最高不超过五千万，但是，2008年以后逐渐增长，到了30亿。二是去年有个AlphaGo，出来的时候，大家突然发现人工智能变成一个现实的事情，机器人下围棋能战胜人类。\r\n\r\n如果我们注意观察生活，我们会发现一些趋势，沿着这个趋势走，就会有一些有意思的创业方向。\r\n\r\n\r\n5、文化创意\r\n\r\n需要个人创造的东西都属于文化创意，包括影视、动漫、游戏、出版、演出，甚至体育项目。文化创意实际上在一个国家的爆发往往是从人均GDP4000美元开始的。前年，我国人均GDP达到7500美元，文化类消费会快速的上升，这点可以从日本的动漫和韩国的综艺中看到。\r\n\r\nIP产生最便宜的方式就是文学和漫画，产生之后去做发行，你就能成为IP的发行渠道。IP的变现有几个方式，一个是游戏，一个是电影、电视剧，还有就是直播，这几个能收大钱，其它都是收小钱。也许在IP形成过程中赚不了多少钱，比如一部漫画卖版权卖不了多少钱，但是当你为游戏或电影这样的衍生品授权，可能就有几千万。\r\n\r\n\r\n6、人工智能\r\n\r\n我们要上升到一个非常高的高度来看，它不仅仅是一个技术，它是人类社会的转折期，会极大的改变我们的生活。移动互联网已经改变我们生活了，它让我们的生活更简单、更方便、更便宜。未来30年的智能时代，会让人类变得更强大。\r\n\r\n戴上AR眼镜，就可以了解很多事情。戴上可穿戴设备，一个残疾人可以跑完马拉松。甚至还有一些芯片可以植入到人类的大脑，扩展人类的记忆，这都是完全可能的，很快就要发生的事情。无人驾驶，它的失误率比人要小的多，可能要小8倍、10倍，人有时候可能会疲倦，造成一些交通事故，但是机器不会。\r\n\r\n排在最后的是智能App，做对于个人用户人工智能的应用要谨慎一点，因为跟个人有关的数据都集在“BAT”巨头的手上，他们要做，很容易超越你，你没有他那么多数据，他有，很快就能做出服务于用户的东西来。\r\n\r\n人工智能创业方面，我觉得To  B比较靠谱。比如针对智能车市场，像新能源车，如果能给车提供前装配件，比如激光雷达、一个电控系统或者一个无人驾驶控制系统，任何一个东西，只要能跟一个车厂合作，一年都是五六亿的销售收入。\r\n\r\n专利和行业标准，这个非常重要，如果有人工智能技术，想办法把自己变成某个行业标准，找到落地应用，公司就有价值。\r\n\r\n人工智能知道每个人的需求是什么。那些需要人反复做的事，需要人积累不断学习才学会的事都会由机器替代，这就是未来。这是从模式创新到技术创新的时代，我认为下一个BAT一定在人工智能这个领域里。', '3', 'n170512019');
INSERT INTO `news_content` VALUES ('nc17051400083', '2', 'upload/news/n170512019/nc17051400083_contentimg.jpg', '4', 'n170512019');
INSERT INTO `news_content` VALUES ('nc17051400084', '3', '◆ 搭建同花顺团队\r\n\r\n1、创始人：我是那张A吗？\r\n\r\n创业者我非常看重3点，一是格局，二是学习能力，三是找人能力。\r\n\r\n格局包含两点：契约精神和分享精神。创始人的契约精神，就是要说到做到，从创始时的分配股权就是一个契约，到雇佣员工签劳动合同，和合作伙伴签合作协议等等。分享精神也非常重要，我们看到有的创业公司，创始人占95%，其他人占5%，看到这种公司我们一般不会投。你不愿意分享，没有人愿意和你干，没有能干的人愿意和你干。\r\n\r\n找人的能力我认为是创始人的核心竞争力。在初创的时候，创始人会花一半的时间来找人。会沟通，积累人脉和资源，结识有能力的人，拉上他们一起干，许多你自己解决不了的问题，他们可以帮你解决。\r\n\r\n自省能力同样特别重要，敢于承认错误并及时改正。有些CEO在公司，大家都必恭必敬的，只有他是对的，我们不会投这样的公司，反而公司CEO敢于说我错了，这个时候他没有包袱，公司也没有包袱，有时候为了证明自己不是错的，公司背上太多包袱，最后烧掉很多钱。\r\n\r\n\r\n2、K&Q：志同道合的联合创始人\r\n\r\n联合创始人，我们一定要找互补的，一个是能力互补，二是圈子互补。能力互补，大家很容易理解，我是搞产品的，我肯定找一个搞推广搭配。但是，圈子特别重要。大家资源不同，当你碰到一个问题，老大解决不了，老二就能解决。\r\n\r\n评价联合创始人的时候，要从这几个角度来评价，巴菲特的评价方法，首先，正直，第二，智慧，第三，活力。为什么把正直排第一位，因为联合创始人代表了一个公司的文化，大家做事情的价值观必须完全一样，小财靠拼，中财靠智，大财靠德。\r\n\r\n找人的捷径，最好找熟人，找同事，找朋友。如果找联合创始人，两个人的认识时间至少一年以上，一年之内的人，基本最后都不能持久。\r\n\r\n\r\n3、J：核心员工\r\n\r\n核心员工，就是我们说的同花顺里边的J，J极其重要，直接决定公司的堡垒，决定公司的基础。应该怎么找这些人呢？宁缺毋滥，有的公司融到A轮以后，也就才十个人、八个人，但是这些人都很精干，一个人能干两个人的活，这是最好的。拿到A轮之前，原则上公司人数不要太多，最好不要超过20人，因为会增加沟通成本和人力成本。\r\n\r\n\r\n4、10:补短板的天使投资人\r\n\r\n10是最小的，天使投资人在里边是最不重要的，但是是必要的。大家知道融资不光是融钱，还要融智、融资源，最好找到懂你的，能够帮你优化模式的天使投资人。他其实不是告诉你怎么做，而是告诉你不能做什么，会把失败原因告诉你们，让你们减少一些试错成本。\r\n\r\n\r\n◆ 股权分配\r\n\r\n1、有大股东，减少争议。\r\n\r\n原则上第一大股东股权应该在40-70%之间，这都是合理的，为什么呢？初创公司会碰到很多岔路口，大家意见不一样，但最后一定要有人拍板，不是大家心目中说张三是老大他拍板就行了，最后有可能用股权说话。\r\n\r\n\r\n2、有先来后到，风险与回报对称\r\n\r\n什么叫有先来后到？初创公司风险是极大的，先进来的人冒着更大风险，先来的人股份就应该多。A轮以后进来的人，即使是副总裁，可能都没有一个做总监的创始人股份高，因为他在风险最大的时候进入公司。一般来说，A轮以后，一个副总裁级别的人进来，大概也就是两个点的股份，但是，如果最早来公司的员工，可能有5%。\r\n\r\n\r\n3、有预留，引入生力军\r\n\r\n分配股权的时候，往往还要有预留，用来引入生力军，团队开始往往都是不完善的，如果没有这点的话，有可能后面需要的人进不来，所以，要预留一些股份和期权，一般是10-15%。\r\n\r\n\r\n4、分期行权，全时投入\r\n\r\n很重要一点是要分期行权，股份一般是分四年行权，在公司干满四年，所有股份才会给到你，干一年，可能就给1/4。我们看到有些公司没有设定这条，成立一个公司时，你20%，他30%，还有一个人50%，最后20%股份的走了，再引入新人来，没有股份了。这条其实为了保护创业者的，万一发现有人走错了，能把股份空出来，然后再给后面的人。\r\n\r\n同时创业者必须要全时投入，股份超过5%的人，原则上必须在公司全职工作。我们看到有一个公司股权结构里有一个人的股份20%，但他根本不在公司工作，只是顾问，说明公司缺一些重要资源。从股份上能看出很多问题，大家不要小看股份分配。\r\n\r\n\r\n◆ 团队激励方式\r\n\r\n1、股权\r\n\r\n股权实际上是最宝贵的，只有在公司刚成立的时候加入的三四个人有股权。股权是一种长期激励或者叫长期的绑定，大家都承诺把自己全部精力花在公司上，一起把公司做大做强。有股权的人有归属感，相当于公司创始人或联合创始人。\r\n\r\n\r\n2、期权\r\n\r\n期权，通常是预留的一部分股份。A轮之前进来的核心人员，可以发些股权，但是，A轮之后，股权一般转换成期权。期权是有价格的，不同时间公司会有不同估值，打折之后，按照这个价格发给高管或者中层以上的人，切忌全员持股。\r\n\r\n发期权的时候，要按岗位来，这个人是副总裁，他的期权就多。如果这个人不称职，把他开掉，期权还可以收回。\r\n\r\n\r\n3、奖金\r\n\r\n奖金和绩效奖励的时效性要比较强，一般必须按月兑现，初创公司搞季度奖也没有意义，一定要时效性特别强。\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '5', 'n170512019');
INSERT INTO `news_content` VALUES ('nc17051400085', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170512017');
INSERT INTO `news_content` VALUES ('nc17051400086', '2', 'upload/news/n170512017/nc17051400086_contentimg.jpg', '2', 'n170512017');
INSERT INTO `news_content` VALUES ('nc17051400087', '3', '◆ 互联网三段论\r\n\r\n\r\n第一阶段：社区门户、即时通信、移动互联网和电商\r\n\r\n传统的互联网，依靠于简单的代码，依靠页面级的东西，造就很多公司，比如新浪、网易、搜狐，社区类的人人、开心、微博，这里面胜出几家公司，叫做“BAT”。\r\n\r\n传统互联网有一个启示，叫做羊毛出在猪身上，有什么特点？早期根本挣不着钱，就是赔本赚吆喝，收集有关数据，下载用户、注册用户、使用用户、活跃用户，到这一步都挣不着钱，直到有购买用户和复购用户之后这个平台才真正有现金。大部分互联网公司早期都波荡在这个地方，没办法赚钱，公司估值不断变大，直到有一天转型成功，找到了猪，然后开始挣钱。\r\n\r\n为什么？360在争取带宽，但凡用360产品，用他的平台、用他的桌面、用他的浏览器，进入这些里面的游戏和电商的，他就可以进行收成，这个就叫做导流。把你作为流量导到这里边去，让你在这里面非常高兴的剁手，360用这种方法实现了羊毛出在猪身上。\r\n\r\n但在前期没有收入的时候该怎么办？要融资，要不断把自己的估值引上去，这个估值是不断升高的，和真实的数据之间并行成长，但和真实的现金流不并行，该怎么办？于是就出现了Gap，Gap就是风险，所以为什么叫风险投资？我们就是填坑的，往Gap里填钱，填到公司转型成功为止，这就是传统互联网给我们的启示。\r\n\r\n\r\n第二阶段：“互联网+”\r\n\r\n我们大搞两三年时间，迅速迭代成功。我们把“互联网+”分成两部分，一个叫“互联网轻加”，一个叫“互联网重加”。“轻加”加的少，把“互联网+”当一种工具加载在产业里，叫做产业升级。“重加”，把线下东西搬到线上，叫O2O。“互联网+”也是有非常多的公司，我们发现“互联网+”只适用于刚性需求的行业，非刚性需求、低频使用的行业不太适合使用“互联网+”。比如“互联网+”盛行的时候很多人出来做美容美装、环保回收、宠物“互联网+”，都不是非常成功，为什么？低频、小众，很难推广。\r\n\r\n“互联网+”特点是什么？比较重，会实际发生，所以，一旦实际发生成本太大，这个事情就没人做，比如洗车，洗车“互联网+”这件事情，中国和美国从2015年年中开始很多公司同时做，到2016年全倒逼掉，原因是没有算过账，这种行业是没办法做互联网+的。我们最终发现高频使用、客单价比较高的、衣食住行等刚性需求的行业是适合做“互联网+”的，而其他的不适合。这就是“互联网+”2015年迭代之后给我们的启示。\r\n\r\n走过了O2O，我们认为到今天基本“互联网+”已经走到比较红海状态，再想重新做“互联网+”公司也比较困难。“互联网+”这块剩下的是什么？是大量海量的蓝海，这就是产业升级，互联网TMT思路，技术、媒体、通信，这种思路加载在传统行业里，这种行业会迅速得到成长。\r\n\r\n\r\n第三阶段：智能化\r\n\r\n所有智能化公司都渴求模仿传统互联网公司，想象我也可以做一个手表，卖到一千万件，收集大家数据，变成粉丝模式，通过粉丝模式融资，然后再把公司做大，很不幸，这些公司没能做成。比如关于智能硬件，我非常喜欢智能硬件，一个公司没有投。为什么？我调查非常多的公司，基本当年智能硬件70%以上公司的CEO我都聊过，有很多公司我特别喜欢，谈到出货量，我说真正出货量有两三万吗？他们说没有，只有五千，整个商业模式无法实现快速增长。很多公司力求于转型，也非常非常困难。\r\n\r\n所以，我看到最好的智能硬件一个鼠标能卖一百万件，顶部一些项目只能卖到20万件，大部分企业，比如空气净化器、空气检测仪、车载记录仪等等只能卖几千件。\r\n\r\n这些公司后来都怎么办了呢？存活下来的公司都转型to  B了，就是把自己卖给了大公司，所有产品、品牌、营销都不做了，只做技术和研发，做完之后，把这个卖给大公司。比如很多车载智能硬件，车载行车记录仪、车载空气净化器，都卖给前端厂家，借助大公司营销能力，这样的公司可以生存下去。所以，转型去做to  B是前两年智能硬件企业的出路。\r\n\r\n为什么是这种现象？还有很多人问我VR是不是一定能成功？答案一定是否定，至少到现在为止。首先，VR绝对不是在脑袋上扣一个盒子叫VR，一定是随处可见，天上、地上随处可见的所有东西都有芯片。', '3', 'n170512017');
INSERT INTO `news_content` VALUES ('nc17051400088', '3', '◆ 互联网智能化——深度科技应用\r\n\r\n\r\n智能化三段论\r\n\r\n第一阶段：互联网基础。互联网基础如前面讲到的，已经成熟了，所有搭建的网络环境、商业模式都已经成熟了。\r\n\r\n第二阶段：大数据的积累。大数据的积累，处于半成熟阶段，表层数据都有了。谷歌现在正在挖掘黑数据，什么叫黑数据，谷歌认为大部分数据都是处于冰山底下的大数据，水面上的都是小数据，大数据积累还在过程中。\r\n\r\n第三阶段：算法的应用，算法其实很成熟了，在互联网时代，基础都很成熟了。但是，它的商业化应用不成熟，搞工程的每个人都有一摞算法，关键是怎么应用。我们现在走到了哪步呢？把大量已经收集来的数据做成标准化、结构化的数据集，这是无论从学校还是到产业都是在做的事情。\r\n\r\n\r\n◆ 什么是大数据？\r\n\r\n大数据是非常简单的拓扑结构，分为入口端、大数据端和商业化端。大数据端中间是数据挖掘、分析、整理、定义的过程。所有数据都要经历这个过程，可以是智能硬件，可以是网络，可以是交易平台，最重要是有黏性。\r\n\r\n\r\n◆ 人工智能\r\n\r\n人工智能层级分成四个阶段：\r\n\r\n第一，明确交给计算机的东西，我们已经定义好，无论是自然、物理、社会，我们交给计算机的东西，这个叫弱智能。\r\n\r\n第二，我们教计算机如何学习的过程？就是使用人工智能方法迭代，在这个过程中，我们知道目标是什么，我们知道我们有什么，但是，计算过程中逻辑是什么，我们并不知道，美国叫做可视化逻辑，这是今年特别火的，要求在计算机计算过程中每一个逻辑点能够让人看懂。\r\n\r\n第三，计算机学习过程中产生一些我们没有想到的东西，比如说在字迹识别过程中，计算机识别完之后反馈回来，不光是什么人写的字它都认识，还可以告诉我一个结果，90%多人喜欢在白纸上写字，有一部分人喜欢在黄纸上写字，很少一部分人喜欢在黑纸上写字，这是完备性算法，会把所有规律用有限阶函数表达出来，综合告诉你一个结果。\r\n\r\n第四，我们不知道学会了什么，这个东西超智能，这点很可怕，但是，超智能最重要的是要汇集所有数据，耦合所有数据，我认为离这件事情还有很远距离，很远不会太远，可能50年100年。\r\n\r\n\r\n◆ 生物医药\r\n\r\n生命科学的治疗划分，第一类医疗技术指物理类手术，第二类指化学类疗法，第三类指生物精准类疗法。物理类疗法非常原始，化学类疗法会好一点，但是仍然比较原始，生物类疗法是非常前沿的。在精准化治疗里，我们主要关注三个板块：第一，基因的治疗；第二，细胞的治疗，细胞其实是基因的整体体现；第三，脑神经治疗。这里主要说基因的治疗，跟人工智能非常贴切，非常相关。\r\n\r\n在北京亦庄有一个项目，一个博士从斯坦福回来，他在干吗呢？他有一个动物园，全是自己造的动物。开始上面有一个母鼠，母鼠盒子里存是的健康老鼠。然后，他做基因消除，底下所有格子是各种各样病的老鼠，有先天性心脏病、先天性癌症、先天性糖尿病的，为什么做这件事情呢？大家知道，我们所有吃的药都需要做活体试验，原来这些医药公司上动物园买动物，买老弱病残动物，来试这个药。但是，最后不知道动物是药死的，还是老死的。他做基因消除来更好的进行活体试验，这个公司现在已经市值超过10个亿了。', '4', 'n170512017');
INSERT INTO `news_content` VALUES ('nc17051400089', '3', '◆ 当下国际市场动向\r\n\r\n\r\n1、中国——消费购买力驱动的自给自足的完整市场\r\n\r\n以上讲的这些，美国很多机构都在研发，而中国并没有，中国是消费力驱动市场，我们关注的是如何得到更多的市场，得到更多的客户，迎合我们的客户，屌丝经济。乔布斯那句话，我不需要我的客户知道他们需要什么，我告诉他们需要什么，但中国到现在为止企业家不敢说这话，有几个原因：第一，中国客户群众太多了，第二，中国企业家并没有非常强的技术意识，所以，中国大多数企业都是由消费购买力驱动的，我们在不断的迎合中层消费者，所以，我们势必没有很强的技术能力。中国值得尊敬的公司是华为，花大量成本做研发，一个常青企业要既懂得客户，又懂得技术和产品，这才是好企业。\r\n\r\n\r\n2、美国——前沿技术需求驱动的自给自足的完整市场\r\n\r\n美国技术为导向，以上讲的很多东西，要不然美国带回来的，要不然在美国成长起来的企业。美国硅谷，在干什么呢？我每次去硅谷和波士顿，基本都会谈几大行业：宇航、生物医药、材料、能源、人工智能、量子、农业技术，一般都会提这七大行业。但是，中国不一样，中国是什么呢？农业、工业、物流仓储、消费服务、金融业。\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '5', 'n170512017');
INSERT INTO `news_content` VALUES ('nc17051400090', '3', '◆ 从商、从政、科研这三条路，更愿意选择哪条？\r\n\r\n对我个人来讲，本科时候一直考虑这些问题，大家知道，一般家乡父老都这么认为，清华毕业一定要当官，我个人也认为从政很好，真有政治情怀的话，你能最大程度发挥个人的能量。但是，我觉得从政真得有政治情怀，不能揣着明白装糊涂，不能随波逐流，大家看《人民的名义》，从政出问题有时候不是能力问题，不是勤奋问题，从政是个“高危”职业。我认为科研非常好，我们班30个同学，估计也只有两三个人真正从内心愿意静心做学术，科研真的需要淡薄名利，宁静致远。真正有这种情怀的都是比较少的，但很多人只是把他当成一个谋生的饭碗，这就不一样了。我个人认为，这两个至少不适合我，自己还没达到那个层次。\r\n\r\n最后选择从商，主要是感觉自由，当然，从商主要讲的是创业领域，大家也可以去国企、外企，但选择创业，就是因为自由，我今天晚上做好计划书，明天就可以实现，后天觉得不行，大后天可以修改，完全可以自我掌控，我很喜欢这种感觉，所以，我会选择创业这条路。本科时候，大家每半年会改变一次人生比较大的发展方向，研究生时候基本想清楚了，这是我自己的选择。\r\n\r\n \r\n◆ 创业是种生活方式，你准备好了吗？\r\n\r\n选择创业以后，大家一定要真的认可创业这种生活方式，作为主要的创始人和联合创始人，创业以后，不要想在你的工作和生活分开，从此以后是完全融为一体的，我们内部经常讲5+2、白+黑，除了同事没朋友、除了工作没生活，你一定要真正从内心享受这样的生活，大家一定要想清楚，你选择创业，你愿意享受这样的生活方式，绝对不是为了简单的赚钱。\r\n\r\n \r\n◆ 你是否会选择素质教育领域创业？\r\n\r\n大家要想清楚了，包括清华的学生也一样，现在去工作，很多还是去金融领域、去投行，为什么？工资高，但是大家要想一下，整个金融行业其实是平均数较高，但是，你见过金融行业里有几个特别有钱的？很少，包括美国也是，就巴菲特。金融行业中位数好、平均数好，但要想上福布斯排行榜，我觉得你还是要走创业这条路，虽然概率是小的，创业整体可能会有5-10%的成功率，而上福布斯排行榜在创业者中可能只有万分之一的机会或者更少。\r\n\r\n素质教育领域可以让大家实现小小的财务自由，而且实现的成功率比5-10%要高，可能有30-50%，实现财务自由是没问题的，这个行业最好也就能做到像老俞他们一样，再往大，想做到王健林、马云、马化腾那样没戏，最后要做一个现实的选择。大家觉得什么样是财务自由？\r\n\r\n学生：在北京的话，几千万都自由不了。\r\n\r\n学生：不用为了自己的收入发愁，而且有比较多的时间可以做自己喜欢的事情，像王健林那样或者王石那样。\r\n\r\n咱们分析一下，在北京有车、有房可能先得需要1500万，剩下的存款买个理财，稳定的收益能够覆盖保证你一年中产阶级的生活费就OK了，这就是我对财务自由的定义。除了买房、买车以后，先赚到1000万，大概你有1000万存款，每年理财收益50万也够花了，如果50万不够，那就存2000万，每年有100万理财收益，够你平常生活了。所以在我的定义中，买房、买车以后，有1500——2000万就可以叫财务自由了，就能够更好的按照你的兴趣去做了。\r\n\r\n我认为教育领域、素质教育领域都能帮你达到这个目标。团购网站，分类信息网站，共享单车等互联网类的创业，一开始都很热闹，但最后胜出的可能就一两个，最后的一两个也经常合并，那是赢者通吃的市场，在一个显赫的成功案例背后，绝大多数人是要做分母的，整体成功率非常非常低。但在素质教育领域，我相信在座各位50%能成功，坚持十年达到那个状态，前提是必须十年，千万别想三五年，我经常跟资本机构讲，如果用一年、半年的眼光来看企业，我说算了，我不跟你谈了，赶紧找其他特别好的行业，有些风口企业一年能涨10倍，但是，如果放五年到十年范畴内看，教育这个行业绝对不会让你失望，为什么呢？因为你当年看好的行业可能百分之五六十已经没了，但教育这个行业还是常青、常新的。所以，你要不要选择这个行业？\r\n\r\n \r\n◆ 做B端还是做C端？\r\n\r\n大家想好真的做B端，还是做C端，如果做教育，这么大的公立市场，不进不可以的，要进的话，你自己要想清楚，吃饭、喝酒、公关是不是你擅长和喜欢的？有的人一上酒桌，如同战场上的将军一样，整个局势就在他的把控中，想办什么事都能办成，但是，有的人完全不是。如果选择C端的话，前期的投入，可能有一段时间不盈利，能不能有自有资金支持？会不会有后面的VC、PE支持你？to C对产品打磨都有一些投入期，过程比较长，我觉得至少三年是必须的， B端C端都可能做成，但大家一定要想好哪些是适合自己的。\r\n\r\n \r\n◆ 民主还是专制的管理方式好？ \r\n\r\n在创业团队中，大家认为民主一点，还是专制一点的风格比较好？通常一般人肯定会说比较民主的方式，民主是好，但是，民主的最大问题是效率低。最早期的时候需要专注一点突破的时候，有可能专制更好一点，因为效率高，咱们社会主义国家，中国、朝鲜搞导弹、搞原子弹都可以搞成，集中力量办大事，这是优势。但是，专制最怕遇到昏君，发展发展，最后创始人的认识边界成了企业的边界，这个情况下怎么办？这就是专制体制下要解决的问题，有时候能打95分，但有时候也会打30分不及格。民主和专制各有优势，民主好，大方向不会错，但是效率低。专制效率高，但问题是一把手和核心团队几个人出现一些问题的时候，有可能企业就死掉了。\r\n\r\n怎么能把这两个结合起来？我认为民主集中制很重要。不过最早从0到1的过程中，一般企业还是集中制，专制占主导，创业早期就是这样，不允许有太多讨论，你也就这次机会，全力以赴做好这点，做成了，模式打通了，肯定盈利了，或者VC、PE来了，打不通，一拍两散了。一开始，创业企业还是要有核心骨干，他要有权威，当然，最好做决策时候能够听取大多数人的意见，孙陶然讲创业36条军规，很好，大家值得买了看一下，虽然他做的企业不是最大的，但是，总结的理论是最接地气的，大家一定要搞清楚，你能做成首富，跟高考考状元一样，真的有运气在里面，但是，高考前100名都有实力。听大多数人意见，跟少数人商量，最后一个人拍板。\r\n\r\n \r\n◆ 创业团队股份如何分配比较科学？\r\n\r\n创业团队的股份，一开始的时候，如何分配？大家见过最差最差的股份划分就是各分一半，还有各三分之一、各四分之一的，这是最差的划分。\r\n\r\n总之，均分的一般都会出问题，创业初期时候要有绝对的权威，不然谁都不服谁，一定是一拍两散。\r\n\r\n具体的股份设计上，一把手跟二把手之间，我认为要有3：1的比例。创业企业面临着很多痛苦的决策过程，最后一定要有一个人拍板。当然，赌这个人，他既听取大家意见，又是领袖，民主决策，铁血执行，这个企业可能成功了。假如这个人很昏庸，又没找对点，就失败了，大家再去做新项目。\r\n \r\n最后用几句话作为结语， Stay Hungry，Stay Foolish。追求理想，顺便赚钱。乔布斯说的这句英文，大家觉得这句话怎么翻译呢？上次看了咱们学长一个神翻译，其实“Stay Hungry，Stay Foolish”最好的翻译就是清华校训“自强不息，厚德载物”。\r\n\r\n素质教育行业比较适合学生创业，相对来讲门槛比较低，成功率较高，可小富，难大贵，但是，这个行业幸福感比较强，你会认为你做的是很有社会意义的事情，真的是与孩子一起成长，少年强则国强！\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '3', 'n170512013');
INSERT INTO `news_content` VALUES ('nc17051400091', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170512013');
INSERT INTO `news_content` VALUES ('nc17051400092', '2', 'upload/news/n170512013/nc17051400092_contentimg.jpg', '2', 'n170512013');
INSERT INTO `news_content` VALUES ('nc17051400093', '3', '        日前，在“2017中国国际电子商务博览会”上，中国信息化百人会成员、清华大学经济管理学院党委副书记、清华大学互联网产业研究院院长朱岩教授发表了主题演讲，主要内容总结如下：\r\n\r\n\r\n一、连接是一种资源\r\n\r\n        2017年政府工作报告为变革指明方向：以创新来引领实体经济的转型升级，推动实体经济结构化调整，不断的释放我们的新的需求。\r\n\r\n        为什么会提出呢？因为我们原有的资源优势尽失。曾记何时，我们以自然资源，政府资源为骄傲，但是我们突然发现，高昂的成本变得让人难以接受，似乎一无所有，那么我们有什么呢？\r\n\r\n        扎克伯格说，连接是我们的优势，也是我们的资源。扎克伯格认为自己对世界最大的贡献就是连接，不仅是人和人之间的连接，也包括所有事务之间的连接，因为这会带来我们的商业模式上的一种根本的转变。\r\n\r\n        在传统情况下，企业连接的关系非常简单，就是将商品卖出，与客户建立单向的联络。但是互联网时代不同，没有关系的客户也会连接在一起，这意味着企业打开更多通道。商业模式也就必然发生改变。这意味着什么？我们完全放弃原来的“买卖”关系，以增值的方式获得价值。或许企业原来只考虑竞争就够了，但是在企业建立起来各种各样的连接关系中，电商企业会发现自己越来越向金融靠近，是不是所有的电商都一定要连接金融呢？未必如此。因为，这取决于客户在哪里，你如何通过关联，获得新的盈利的方式。\r\n\r\n        这样，多边市场的效应在重新定义新电商环境。企业要想办法让你所有的产品具备可连接性。哪怕你做的是袜子，哪怕你做的是吸管，哪怕你做的是一个杯子......\r\n\r\n        如果杯上加了一个温度传感器，或者蓝牙模块，就有了黏性，这个杯子告诉你里边的水多少度，如果能跟手机连在一起，当你离开这个杯，超过30米，手机报警了，这家杯子企业要发生革命性的变化，如果我们在杯子的平面变成屏幕，游戏屏，LED屏。也许，生产一千万杯子企业的时候，这个时候这家公司就成为媒体公司，我们可以尽情设想在这些杯体上承载的各种信息。在物联时代，一旦具备了连接性，运营方式就很不一样了。\r\n\r\n\r\n二、新电商时代的到来\r\n\r\n        新电商表现为三个基本特征，移动性，参与性，智能性。\r\n\r\n        移动性并不仅限于App，而是在信息广泛存在情况下的协同性，产品、服务，与相关方广泛协同，这才是叫做移动性。参与性，就是共享经济。无论是政府还是企业管理，以开放心态，以互联网思维，发挥人民的力量经济生产主体。要用互联网方式来执政，用互联网方式管理企业，一切变得更加智能。\r\n\r\n\r\n三、新技术助长新生态，新电商创造新规则\r\n\r\n        在经济不景气时，传统模式往往以鼓励商家到实体店购物的方式刺激消费，但是随着互联网+、大数据、云计算等因素普及和应用，这种刺激消费的方式正在发生改变。你完全可以将线上游戏与线下购物场景有机结合，甚至商场可以在线红包的方式激励消费，商家完全可能通过这种促销模式诞生新的“爆品”。我们面临的不是没有需求，而是在新技术条件下，需求方式的变化。\r\n\r\n        这样，新技术改变了传统的经营模式，也完全可能在迭代中创造出独一无二的商业生态，并演化出与之匹配的新规则。例如：区块链技术是比特币诞生的基础，8年时间里面比特币上升150万倍。这种去中心化的计算影响的不只是金融行业，而是推动金融体系的重塑，甚至整体行业的转变。\r\n\r\n        如果说在传统国际贸易、国际金融领域，中国还难以成为领先者，在新商业生态演化出新商业规则的时刻，我们有了机会，国际结算银行正向中国转移。我们应该加大对新规则的研究。这是一个新商业、新技术带动新规则大量涌现的历史阶段，我们有足够的理由在世界经济舞台上面参与、书写这些新规则。\r\n\r\n        在通讯技术领域，华为正成为规则的主导者。在电商领域，完全可以借鉴区块链去中心化的思想和实践思路，开创新电商规则。\r\n\r\n\r\n四、共享经济的春天\r\n\r\n        共享经济在北美市场的规模已经相当巨大。这是所有人能够参与，所有物品都能参与这样的一种经济模式。在美国，没有什么不可以拿来共享。这给我们很大的启示。中国是一个人口众多，资源相对不足的国家。我们有责任维持可持续发展，让子孙后代依然能够享受到这片土地上留给他们的一些自然资源。这就非常有必要去发展各种各样的共享经济。\r\n\r\n        幸运的是，在中国，分享经济正如火如荼发展。分享经济渗透到住、行、金融、教育等不同领域。\r\n\r\n        在住房领域，已经有了若干个途家、小猪，这种分享住房的模式完全可以与Airbnb媲美。在出行方面，滴滴之后，共享单车进入市场。在技能方面，有猪八戒网；在金融领域，有P2P平台，还教育分享等等，各种场景的分享模式均可能出现。\r\n\r\n         那么互联网创新价值到底如何？你会看到互联网带动传统产业所爆发出的能量，正帮企业带来指数级的价值突破。我把它总结为一个公式叫做“互联网×传统产业=重资产的轻工业化！”\r\n\r\n        我们在原有的重资产之上引入多边市场，引入各种各样的新经营模式。重资产模式进入门槛高，我们以全新的方式发挥我们重资产的价值，同时考虑到轻资产能够给我们带来价值的提升。这是我们在新经济时代里面要遵循的发展道路。唯有此，才能开创中国电商的新的篇章。\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '3', 'n170512011');
INSERT INTO `news_content` VALUES ('nc17051400094', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170512011');
INSERT INTO `news_content` VALUES ('nc17051400095', '2', 'upload/news/n170512011/nc17051400095_contentimg.jpg', '2', 'n170512011');
INSERT INTO `news_content` VALUES ('nc17051400096', '3', '导读：有多少员工是因公司而加入，却都是因直属领导而离开。职场上，遇到一位对的老板，是一件极其幸运的事。跟对一位好的老板，到底对职场前途有多重要？\r\n\r\n人在职场，不管职位大小，在一定的发展阶段，都有自己的老板。跟了对的老板，就像选对了一个好导师、好的伯乐，他会身体力行地教会你处理业务、接人待物的道理和玄机，既磨练你，又提拔你，让你的职场生涯充满机会和希望，甚至彻底改变你的人生轨迹。\r\n \r\n在千万个和你打交道的职场角色中，老板至关重要。他可以成就你，也可以“毁灭”你，所以很多人提起老板，不是爱得心心念念，就是恨得咬牙切齿。 \r\n \r\n\r\n1、不合拍的上司是员工离职的导火线\r\n\r\n员工因公司而加入，却因直属领导而离开的状况层出不穷。有人曾做过一次实验，调查员工离职的真实原因，得到的反馈是：“老板，我现在可以告诉你，当初我离开公司的真正原因不是那个辞职报告上写的什么家庭原因、个人原因，都是借口，真实原因是和我的直接上司不合拍。\r\n \r\n这种辞职理由，老板知道了会怎样想？\r\n \r\n为何有的人，宁愿将战线拉长一些，也要寻求一个合拍的上司？我们来算一笔账，工作至少占据了我们一天三分之一的时间，除去独处的时间（如厕、做梦、吃饭），每天跟领导相处的机会比家人还多，遇到宽容、大度、有担当的上司自然给工作心情加分。相反，如果遇到“猪”一样的领导，工作中处处感到压抑，即使再高的薪水，也难买你的一笑。好多时候，员工放弃的不是公司，而是领导。\r\n\r\n\r\n2、跟对人等于成功了一半\r\n\r\n人往高处走，大多数人跳槽后涨薪，然而，找工作并非企业名气大、钱赚得多就适合自己。名气和钱财固然重要，它们给你带来的好处也许只是暂时的、阶段性的，而一个优秀的上级则可能影响你的一生。\r\n \r\n对的老板，就是你职场人生的灯塔，照亮你的前程。\r\n \r\nBill Belichick是美国国家橄榄球联盟收入最高的教练之一，他执教的爱国者队曾斩获13个分区冠军，连续13个赛季赢得两位数胜利。在他的带领下，一些能力不错但绝非最好的球员也能表现出全球一流水平，甚至有许多球员不惜降薪加入他的队伍。\r\n \r\n例如：Corey Dillon为了加入Bill Belichick的爱国者队，自愿将385万美元的薪酬期望值降至360万美元，之后在Bill Belichick的指导下，Corey Dillon创下了职业生涯新高，年收入也大幅度增长，达到500万美元。\r\n \r\n降薪跳槽只为跟随好领导，是亏还是赚？哈佛商学院工商管理教授研究发现，无论是在体育界还是商业界，只要遇到一位好领导，即使拿的钱少了，也只是暂时现象，你的个人价值在他的帮助下，必将得到迅速提升。\r\n \r\n\r\n3、在职场上怎样为自己选老板？\r\n\r\n1）“四蛋”老板，打死也不能跟\r\n \r\n猎聘老六曾在自己的一篇文章中提到：“在职场上，我们可以肯定的是，‘糊涂蛋老板’‘软蛋老板’‘混蛋老板’以及‘坏蛋老板’坚决不跟。”\r\n \r\n遇到任性的领导，你得有情绪崩溃的准备。\r\n \r\n职场上，我们会遇到各种类型的领导，有咆哮型、打鸡血型、空口承诺型。只要我们在职一天，不是自己做老板，就无法躲过“老板”这个梗。所幸我们有相对的选择权。\r\n \r\n针对那些业务能力差、瞎指挥的“糊涂蛋”，毫无主张、不敢担当的“软蛋”，不讲道理的“混蛋”，还有人品有问题的“坏蛋”老板，打死也不跟，这无关性格、脾气，而是我们的职场底线——这样的老板很难具有正向积极、坦诚健康的价值观，不会指给员工一条光明的路。\r\n \r\n\r\n2）谦逊的老板，更易建立信任\r\n \r\n提到领导，我们脑海中经常会浮现出一个“傲娇、自大、独断”的经典形象。其实，谦逊随和的老板更容易拉近和员工之间的距离。同样的，下属每天跟这样的上司处事，不仅愉悦放松、还能最大限度的激发工作斗志。\r\n \r\nIDEO系统设计师，设计总监Deirdre Cerninaro 曾有这样一次面试经历：当年我到波士顿接受CEO Tim面试，结束后，他问我知不知道怎么回家，我说坐地铁。结果Tim没给我指路，而是对我说“我陪你走过去吧！”在我婉拒之前，他已经按下电梯按钮。\r\n \r\n那天我在他办公室仅待了三个小时，但从他身上学到了很多。仅仅是他陪我走到地铁的那几分钟，我看到了他对待同事的方式，也看到了他会是一个良师益友。\r\n \r\n谦逊的领导，欣赏员工的长处，让员工有更多的认同感、尊重感和成就感，员工更愿意与谦逊的领导建立长久的信任。相反，高傲自满、独断专行的老板让人噤若寒蝉，生怕一不小心就被老板责罚、打击甚至丢掉饭碗。\r\n \r\n\r\n3）以身作则的老板，是你的榜样\r\n \r\n工作中常常遇到要求员工“以老板心态打工”的领导，努力工作无可厚非，但作为团队的领头羊，应以身作则，做表率，而不是夸夸其谈，空喊口号，企业需要的是一个能带兵打仗的将军，而不是一个处处压榨下属的“吸血鬼”。\r\n \r\n真正负责任的老板，工作上从来不马虎，表现得比一般员工还要敬业。\r\n \r\n苹果CEO Tim Cook每天早上3点45分起床，一直工作到深夜。每天第一个到达办公室，最后一个离开。\r\n \r\n雅虎CEO Marissa Mayer曾被媒体称为“机器人”，任职谷歌时，她每周工作时间多达130小时。在她看来，没有什么是不可能的，“只要你能忍受在桌子底下睡觉然后在洗澡的时候争分夺秒，这就不成问题。”\r\n \r\n他们位高权重，尚且如此勤勉不倦，你还有什么理由怠工呢？遇到这些身先士卒的老板，就是遇到你职场最好的老师，千万不要错过。\r\n \r\n授人以鱼不如授人以渔，一个出色的领导，能分享所想、所悟，并带领团队一起成长、一起战斗，他不但成就自己，而且成就别人。 \r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '3', 'n170512009');
INSERT INTO `news_content` VALUES ('nc17051400097', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170512009');
INSERT INTO `news_content` VALUES ('nc17051400098', '2', 'upload/news/n170512009/nc17051400098_contentimg.jpg', '2', 'n170512009');
INSERT INTO `news_content` VALUES ('nc17051400099', '3', '五、如何对接资源\r\n\r\n　　如何对接产业资源，政府的资源在哪里，怎么用？尤其是当政府重视、资金和政策往技术创新倾斜的时候，有可能赋予整个行业几十倍、几百倍的能量，创业需要合理地对接这些资源。我们投资的项目中，有很多符合这个规律，对接之后，原来觉得很难的事情，或者需要通过两三年走的路，一下子就好办了或者加速了，眼观六路耳听八方，创业者要敏锐要培养这些综合的能力。\r\n\r\n\r\n六、如何组建优秀团队\r\n\r\n　　大多数创业大会、投资大会讨论环节问嘉宾的问题中会有这个，就是如果说用一句话讲投资，你最看重什么？其实就是看人，主帅特别重要，然后就是看他组建优秀团队的能力，包括他的合伙人。如何提升团队战斗力，扩大团队的能力圈，都需要合伙人们去解决，所以合伙人特别重要。之前李竹师兄有个搭建同花顺团队的课大家可以学习下。\r\n\r\n\r\n七、如何应对人才匮乏和人才培养\r\n\r\n　　科技创业领域，人才特别贵，近期是涉及到人工智能这块的创业，都在说人力成本太高。我的建议是创业者要把自己身边的校友、同学牢牢的抓在手里，既有相互的信任和了解，也能帮你省很多钱。我们投的法律项目，创始人把他高中的好几个同学都拉到另外一个城市一起创业，找人的能力很强。第二，人才的培养很重要，包括自身的进步和团队整体的培养；这句话放哪都适用，我们做投资也是一样，我跟我的团队、合伙人之间互相学习，向创业者学习。要注重营造一个学习和进化的氛围，人才就能培养起来，优胜劣汰，能者来归。\r\n\r\n　　最后，总结一下。我们的投资理念叫“和优秀者同行，成人达己”。从投资实践来说，我们关注大企业的需求，关注高校和科研院所的科技成果，你们自己就在高校里，看看高校里边、科研院所里在做什么，很多东西跟市场结合的很好了。我们关注国际化，不光是人家的东西要引进来，我们的东西能不能走出去？可以，你们做公司要有国际化思维。我们投资有学习能力的TOP创业者，现在年轻人视野更广，心态更开放，同时竞争也更激烈，创业者要有超强的学习能力、足够的找人能力和自我进化的能力，这些是决定一个创业团队成功的主要要素。我们投资这些团队，形成一个小生态，促进他们的协同，帮助他们成长，真正做到和优秀者同行。\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '4', 'n170512008');
INSERT INTO `news_content` VALUES ('nc17051700100', '2', 'upload/news/n170428047/nc17051700100_contentimg.png', '3', 'n170428047');
INSERT INTO `news_content` VALUES ('nc17051800101', '3', '朋友A最近情绪很低落，并且已经持续了好一阵子了。原来在春节前，小A辞职了。这还是在春节之后，大家各自要回到工作岗位的时候，小A的踌躇让我们几个很疑惑。追问之后才知道，原来在去年学期工作接近尾声、马上要放寒假的时候，小A工作上犯了一个错误。当然了，犯了错，除了尽力弥补和挽回损失，还要想着吸取教训，下不为例。这个时候，领导批评了小A几句，可能有些话相对就说的重了一点。我们问小A，那领导都说了啥，竟然让你就辞职了呢？小A吱吱唔唔地解释，还不是说我不该犯这种错误，最后搞的所有人的辛苦都白费了，都要重新再来，要是换了别人，早一头钻到地下去了。在领导的“批评”之下，小A觉得领导是在暗示她离开，于是就傲气潇洒的提出了辞呈，表现足了自己为这次错误买单的姿态。领导错愕了一下也没挽留，大笔一挥，批了。\r\n\r\n于是小A失业了。接着就是春节，天然的喜庆氛围冲淡了小A失业的忧伤。到了大家各归其位的时候，小A才发现自己又要像当年那样，步入求职者的队伍。', '4', 'n170518023');
INSERT INTO `news_content` VALUES ('nc17051800102', '2', 'upload/news/n170518023/nc17051800102_contentimg.jpg', '5', 'n170518023');
INSERT INTO `news_content` VALUES ('nc17051800103', '3', '小A按照之前那份工作的各项条件去投简历，结果效果微乎其微。小A这才惊觉，原来自己那份工作，已经相当不错。身在其中的时候，小A也没有觉得多珍贵，该抱怨的抱怨，该提升自己能力的时候，没有积极主动去提升，不该裸辞的时候却裸辞了。\r\n\r\n后来，因为各自工作忙，断断续续地了解到，小A进了另一个与之前工作单位齐名的单位。原本以为，这一事故有了完美的结局。但是小A却开始闷闷不乐，因为在这边，工作氛围远不如以前的和谐温暖，同样的岗位薪资待遇却大不如以前，事情却更繁杂。\r\n\r\n小A的经历，让我们唏嘘不已，只能鼓励她不断提升工作能力，显示自己的工作价值，让自己有涨薪的机会。', '6', 'n170518023');
INSERT INTO `news_content` VALUES ('nc17051800104', '2', 'upload/news/n170518023/nc17051800104_contentimg.jpg', '7', 'n170518023');
INSERT INTO `news_content` VALUES ('nc17051800105', '1', '大职门——专业的职场经验与技能分享平台', '1', 'n170518023');
INSERT INTO `news_content` VALUES ('nc17051800106', '3', '在日常生活和工作中，经常会听到关于某个人因为受不了上司的批评、和同事起了误会和冲突等等原因，“潇洒”的辞职，并且不少人以此作为自己“自主、自由”性格的的标榜。\r\n\r\n不错，每个人都有选择的自由，你也有对自己的事情有决定的自由。但是在职场，很多事情就会变得有些“身不由己”，那些“潇洒”的朋友们，也许也没有他们表现出来的那么潇洒。', '2', 'n170518023');
INSERT INTO `news_content` VALUES ('nc17051800107', '2', 'upload/news/n170518023/nc17051800107_contentimg.jpg', '3', 'n170518023');
INSERT INTO `news_content` VALUES ('nc17051800108', '3', '想想小A的首先，在已经做了两年的工作岗位上，还在常规的工作上犯了重大错误，这说明工作能力不足。其次，在犯了重大失误的时候，领导批评几句，不是很正常的事情么？因为你的失误，整个团队的工作都要重来。这个时候，不是应该尽自己全力采取补救措施，并且向团队的每一个成员道歉么。但结果是，小A对于这些本该有的批评却承受不住，内心敏感的察觉到了那么一丝被嫌弃的气息，自己干脆就“引咎辞职”了。领导估计也没有想到，小A最后财采取的是这种解决问题的方法，既然你任性地留下一个潇洒离去的背影，领导为何不成全？\r\n\r\n很多人可能会觉得是小A自己在“作”。但现实生活中，还不乏有小A这样经历的人存在。有了一份工作，不够珍惜。工作中犯了错误，承受不住犯了错误之后代价，不考虑后果就辞职不干，够“任性”，但缺乏了一些“韧性”。', '8', 'n170518023');
INSERT INTO `news_content` VALUES ('nc17051800109', '2', 'upload/news/n170518023/nc17051800109_contentimg.jpg', '9', 'n170518023');
INSERT INTO `news_content` VALUES ('nc17051800110', '3', '希望现实的职场中的我们，多一些有韧性，能警惕职场舒适的诱惑，能够“好好学习，天天向上”来提升自己的能力，能够承受住住工作压力，能够扛住犯错后的心理压力，别人给的“白眼”和批评，能够有能力去挽回因犯错误而丢失的印象分，能够即使想离开，也是因为自己有了更好的能力需要更好的平台或自己的职业生涯发展需要。\r\n\r\n相信我，每一个职场人，都冒出干不下去了想辞职的念头，但很少人一有这个念头就这么去做了，更多的人会检查自己的装备，选择让自己更强大。\r\n\r\n来源：微信公众号 职业规划  作者：轩雨浪\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '10', 'n170518023');
INSERT INTO `news_content` VALUES ('nc17051800111', '3', '这是一个人认知的四种状态——“不知道自己不知道”，“知道自己不知道”，“知道自己知道”和“不知道自己知道”，也是人的四种境界。我将其简单翻译为：\r\n\r\n不知道自己不知道——以为自己什么都知道，自以为是的认知状态。\r\n\r\n知道自己不知道——有敬畏之心，开始空杯心态，准备丰富自己的认知。\r\n\r\n知道自己知道——抓住了事情的规律，提升了自己的认知。\r\n\r\n不知道自己知道——永远保持空杯心态，认知的最高境界。\r\n\r\n\r\n现在我终于意识到，人和人根本的区别就在于这四种状态。更可怕的是，95%的人都处在第一个状态，甚至更多。这也就是为什么碌碌无为的人是大多数。视而不见，只会失去升级的可能性。只有自我否定，保持空杯心态，一个人才有可能真正成长，实现跨越。\r\n\r\n今天，我们处在一个大拐弯的时代，每一个行业的认知都在迅速叠加，跨界越来越普遍。如果不保持这种“自我否定”的认知状态，很难完成对快速变化的行业的认知。\r\n\r\n\r\n◆ -2- 人和人最大的差别是认知\r\n\r\n认知，几乎是人和人之间唯一的本质差别。技能的差别是可量化的，技能再多累加，也就是熟练工种。而认知的差别是本质的，是不可量化的。\r\n\r\n记得在香港约过一次马云喝茶，他几乎不用电子邮件，当时我就琢磨，他为什么能去指挥那么大一个帝国？后来发现，他在不断观察行业变化，从变化里找关键切入点，找资源和人配合。\r\n\r\n人和人比拼的，是对一件事情的理解和对行业的洞察。执行很重要，但执行本质是为了实践认知。\r\n\r\n有时候，我也会鉴古通今地去琢磨，为什么鸦片战争时期，大清帝国输那么惨？简单说，一群怀揣现代物理学认知的人，打败了另一群信奉四书五经认知的人。其实就是两种不同认知的较量。\r\n\r\n\r\n◆ -3- 认知升级的两个误区\r\n\r\n真正的认知需要通过行动展现，行动一旦缺失，认知容易陷入误区。我总结了两个可能遇到的误区，未必全面，抛砖引玉：\r\n\r\n○ 误区一：以为自己知道，远远不如以为自己不知道\r\n\r\n自以为是，是自我认知升级的死敌。回想奇虎当年搜索没干过百度，老周一度总结为不小心把公司卖了，百度没卖。他没想到，当时李彦宏对搜索的认知远高于他。老周不愿打硬仗，不愿打重型战役，不愿搞大研发，不相信算法。那时候卖，本质上是打不下去了。可他不这么认为。\r\n\r\n自我否定，就是假设自己无知，是自我认知升级的唯一路径。不做痛苦的自我否定，认知上不了一个新台阶。即使正确信息摆在面前，你也会视而不见。这基本是区别英雄和凡人唯一的机会了。\r\n\r\n○ 误区二：以为自己认为重要和真的认为重要，往往不是一回事\r\n\r\n有一个词叫自我迷惑。自认为觉得很重要，但根本没把它转化成真正的行动。\r\n\r\n我最大的反思就是对头条的理解。两年多前，我说头条就是移动端的搜索。我的反思是什么？我当时认为挺重要的，一直到15年四季度，我才开始召集人马，着手海外头条的业务。\r\n\r\n这是认知里经常出现的一个误区：以为自己认为很重要和真的认为很重要，往往不是一回事。\r\n\r\n不行动的认知，就是伪认知。炫耀自己知道，有什么用？一个浪潮打过来，认知就没了，如同没有。真正的认知，必须知行结合。\r\n\r\n\r\n◆ -4- 认知升级的三剂解药\r\n\r\n把一件事情转化成行动，难度之大。认知到行动，中间有巨大损耗。我给认知升级开了三剂解药：\r\n\r\n○ 解药一：坚信大趋势\r\n\r\n想法要立刻转为行动。坚信大趋势，坚信这家公司的各种认知决定。不要简单的批判，你一定要相信那些行业领头人。他们拿到的信息肯定比你多，处理信息的能力比你强，他们的认知不是现阶段的你所能赶得上的。不理解，就执行，在执行中理解。\r\n\r\n盲目坚信，立即行动，在行动中形成认知。不要怕死，早死早超生。去年，我想出做机器人的决定，几乎没人认为可行。我就想，先去找人，坚信趋势，立即行动。那种情况，不做，更没有机会，只能是大量时间的损耗。\r\n\r\n不行动，是最糟糕的。行动，才有可能证伪。坐而论道，没有意义。\r\n\r\n○ 解药二：对外求教，不做井底之蛙\r\n\r\n有一个对外求教的心态，非常重要。对外求教，是为了扩展你的视野。要找到带路党，吃过猪肉不一样。他们比你强不是他们聪明，而是有着你不知道的认知。\r\n\r\n当年我和徐鸣做可牛影像，我们的口号是我们来了。我们的技术水平，做过的客户端体验，见啥灭啥。我们来这个行业了，谁还活得下去？结果，美图秀秀把我们打得内心都快崩溃了。\r\n\r\n这是我们特别容易陷入的一种状态：以自我为中心，不向外看。面对新事物，很多人甚至连尝试和对外沟通的欲望都没有。完全不知道外面发生什么。\r\n\r\n强调一点：认知理解与聪明度无关。只有从认知角度，而不从聪明角度，去理解这个世界，理解所在行业，你才会有更多不一样的认知，才能看到更多别人看不到以及顽固不愿去理解的机会。\r\n\r\n越是处在绝路的团队，越是往外看得多。\r\n\r\n○ 解药三：活在当下，面向未来\r\n\r\n活在当下，恐惧时，想想错了又如何？多错才有机会对。这是我给自己的一个思维训练。当你面对一些事情，想想最坏的结果是什么？想完你会发现，最坏结果与你内心的恐惧，根本不在一个量级。\r\n\r\n恐惧就是恐惧本身。不肯尝试的本质是不敢面对所谓失败。但，这个失败的后果是什么？很少有人认真思考过。其实绝大部分失败是没有后果的。\r\n\r\n再就是面向未来，纠结时，想想五年后会怎样？会不会被淘汰掉？如果五年后，你跟这个时代已形同陌路，这才是最可怕的。行业变化之快，超出我们想象。\r\n\r\n◆ -5- 所谓成长就是认知升级\r\n\r\n所谓成长，并不来自于所谓的位高权重，不来自于所谓的财富积累，也不来自于你掌握的某一个单项技能。\r\n\r\n行业里有很多这样的人。比如史玉柱。最惨时，欠了一屁股债，什么都没有。靠一个脑白金，重新崛起。因为他在整个营销上的认知水平，领先了一个时代。即便失去所有财富，甚至所有队伍，就凭他对营销的理解，也是那个时代无人可望其项背的。只要他活着，随时可翻身。\r\n\r\n绝境当中，他真正拥有的核心武器，根本不是资源，而是认知。\r\n\r\n想想腾讯这些年的发展。3Q大战前，腾讯讲花瓣策略——我的花朵上长出很多花瓣，每个花瓣都能干掉你。这种态势，使得腾讯在每个领域都不得不与当时各个领域最先进的认知打，非常困难；3Q大战后，腾讯的策略改为生态链。第一个投资的就是猎豹，接着又投了一批公司。\r\n\r\n结果如何呢？腾讯市值从300亿美金涨到了今天的2000多亿美金。《福布斯》杂志曾经做了一个年龄在四十岁以下的四十位中国商业精英年度排行榜“40 Under 40”，第一位是刘强东，其次是王小川、我、姚劲波。马化腾当时留言说，前五个当中，四个都跟我有关系，很荣幸。\r\n\r\n此后，我一直思考，其实马化腾通过投资形成的生态系，帮助他建立了足够的行业认知。因为，当他投资了这些公司之后，他就不是在跟一个普通的产品经理聊了，而是跟刘强东聊电商，跟王小川聊搜索，跟猎豹聊国际化。\r\n\r\n所以，腾讯用这样一种开放的生态策略，本质拿到的不是投资挣来的钱，而是投资挣来的认知。它和大家建立友好的关系，怎么会不知道出行市场的规模、方向和目标呢？怎么会不知道国际化有哪些机会呢？核心就在于行业认知。\r\n\r\n回顾360崛起给我带来了什么？简单说，就是让我拿到行业最一手的认知——一种对于安全行业，对于客户端软件，对于互联网怎么颠覆一个行业的认知。\r\n\r\n离开360时，我的前东家只给了我1块钱，但朋友安慰说，没关系，你积累的认知，别人都拿不走，将来所有东西都会还给你。我就带着一个认知，走上了茫茫创业人海。\r\n\r\n○ 就因为这么一个小小的认知。\r\n\r\n我才能那么坚决做Clean Master。没人知道APP全球化怎么做，好多单词也不认识，没做过商业。当时几乎对所谓国际化，对美国市场一无所知的情况下，做了All in Clean Master的决定。就因为有那样的认知。\r\n\r\n因为我就信一点——360单点撬动一个行业的事情，在我面前真真切切发生过，而我就是亲历者。', '5', 'n170518024');
INSERT INTO `news_content` VALUES ('nc17051800112', '3', '○ 所谓成长，就来自于认知。\r\n\r\n有时候，想起这个时代，我脑海常浮现一个历史典故——煮酒论英雄。两人坐在那，一个指点群雄，一个一味谦恭。问天下英雄是谁？曹操说唯使君与操耳，刘备吓得筷子都掉了。纵然天下各种人物拥有千军万马，但曹操真正顾忌的却是这个正在种菜的刘备。虽然刘备寄人篱下，内心却是匡扶汉室的认知。\r\n\r\n后面的历史走向也正如以上的认知讨论一样。天下大势，何其复杂；即便如此，也能简化到最关键的点，即关键人的关键认知。\r\n\r\n而认知的本质就是做决定。人和人一旦产生认知差别，就会做出完全不一样的决定。而这些决定，就是你和这些人最大的区别。你拥有的资源、兵力，都不重要，核心是你脑海里的大图和你认知的能力。\r\n\r\n单点也好，势能也好，猎豹能有一点成绩，本质是在移动互联网巨大红利增长之下，做了一个未必那么关键但很正确的决定。那个时候，我们开了先河。但这个认知，不足以支撑我们变成一家卓越而伟大的公司。我们依然需要认知升级。而猎豹和我在过去一年获得的最大财富，就是开始了认知升级。\r\n\r\n我开始思考一句话：一个人卓越，造就不了一家卓越的公司；一群人卓越，才能造就一家卓越的公司。而卓越的核心是一家公司和一群人的认知升级，否则不可能真的上新台阶。\r\n\r\n只会陷入死循环：认知不统一，事情推不动。推不动的本质是大家没有建立对这件事重要性的认知。看不见也罢，顽固拒绝也罢，都不可怕。最可怕的是，我们不知道“我们不知道”。\r\n\r\n如果一个人，不断想学习，想了解，去反思；空杯心态，放下恐惧，不拒绝改变。认知升级，其实也就是捅破那层窗户纸。\r\n\r\n成长如是。\r\n\r\n-- 来源：盛盛GO（ID：fstalk） 作者：傅盛\r\n-- 转自：创业邦杂志\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '6', 'n170518024');
INSERT INTO `news_content` VALUES ('nc17051800113', '1', ' 大职门APP——专业的职场经验与技能分享平台', '1', 'n170518024');
INSERT INTO `news_content` VALUES ('nc17051800114', '2', 'upload/news/n170518024/nc17051800114_contentimg.jpg', '2', 'n170518024');
INSERT INTO `news_content` VALUES ('nc17051800115', '3', '当初来北京，傅盛不是为了梦想，也不是要改变世界，就是想考研究生或者MBA，能够找好工作。他住地下室，每天花几小时上班，从没想过自己有机会去创办公司，甚至做到美股上市。\r\n\r\n后来做猎豹，雷军是董事长，腾讯是股东，跟他们交流过程中，傅盛就在想人和人为什么有这么大的差别。最终想明白了：技能的差别是可量化的。而认识是根据复杂信息综合判断，然后做出决定的一种能力。这种能力是人和人之间的巨大差别，具备认知能力就可以超越很多现实困难和资源困境。\r\n\r\n乔布斯有一句名言：“Stay foolish.Stay hungry”。傅盛认为，Stay Foolish，是一个人成长最重要的事情。你要认为自己像个傻瓜，因为只有把自己看的很低，才能从新的现象中了解事物。\r\n\r\n近些日子，傅盛的关于认知的文章传播很广泛。他说：认知，一个是自我反思，一个是从社会环境中去产生思考。\r\n\r\n邦哥从傅盛认知三部曲中节选了传播最广泛、认可度最高的第一部《所谓成长就是认知升级》，和你分享：一个人认知的四种状态和认知升级的本质，捅破那层窗户纸。\r\n\r\n我一直在思索，怎么才能让一家公司更快地成长？一个人怎么才能从一群人的竞争当中脱颖而出？\r\n\r\n\r\n◆ -1- 人的四种认知状态\r\n\r\n最近我看了一幅图，我在其上加了一个数字注脚。', '3', 'n170518024');
INSERT INTO `news_content` VALUES ('nc17051800116', '2', 'upload/news/n170518024/nc17051800116_contentimg.jpg', '4', 'n170518024');
INSERT INTO `news_content` VALUES ('nc17051800117', '3', '扫描上方二维码，下载并安装大职门APP。即刻学他人所长，并分享你的经验吧。\r\n\r\n大职门APP，职场经验与技能分享平台，智慧人口红利下的分享经济模式。\r\n\r\n在职场某一领域具有丰富积累的人都算智慧人口，在大职门，我们将智慧人口统称为职场掌门，他们的经验和技能可以帮助很多人。\r\n\r\n大职门是职场掌门分享经验与技能的平台，通过释放智慧人口红利，帮助掌门获得额外的变现机会。\r\n\r\n大职门也是学习者快速提升自己，获取职场突破的渠道。出于对劳动者尊重，学习者需要向职场掌门支付小额费用。\r\n\r\n大职门希望每位职场掌门的经验都能惠及更多人，帮助更多人成长，从而实现自己的职业理想。\r\n', '4', 'n170428047');
INSERT INTO `news_content` VALUES ('nc17051800118', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170518025');
INSERT INTO `news_content` VALUES ('nc17051800119', '2', 'upload/news/n170518025/nc17051800119_contentimg.jpg', '2', 'n170518025');
INSERT INTO `news_content` VALUES ('nc17051800121', '3', '扫描上方二维码，下载并安装大职门APP。即刻学他人所长，并分享你的经验吧。\r\n----------------------\r\n\r\n早在2013年3月9日，《经济学人》杂志就正式提出共享经济的概念。虽然共享在人类历史上存在已久，但真正成为一种经济形态绝对离不开互联网的爆发式增长。从威客到众包，从Airbnb 到 Uber 再到滴滴，共享经济的浪潮一浪高过一浪。\r\n\r\n在此背景下，清华大学经济管理学院著名教授朱岩提出了“智慧人口红利”概念：适应于共享经济的诞生，一种全新的劳动人口正在形成：他们互相连接、具有远高于从前的知识获取能力和信息掌握能力、具有空前的创造力。这种新的劳动人口将为中国经济注入新的活力，他们的价值创造能力大幅度提升，从而通过贡献智慧让中国的人口优势能够继续存在，我们把这种新型的人口红利称为“智慧人口红利”。\r\n\r\n大职门APP是专业的职场经验分享平台，致力于推动职业经验共享，释放智慧人口红利。“我们希望那些拥有丰富经验的职场资深人士能够发挥更大的价值，将其多年积累的经验更充分地分享、传播开来，帮助那些缺乏职场经验的人获得快速成长的机会，从而提升整个职场的效率，进而提升企业的竞争能力。”大职门APP首席运营官张彬说到。\r\n\r\n大职门APP入驻了不同行业的职场大咖，他们也乐意分享自己的经验。从行业趋势研判到企业运营体系，从岗位体系建设到具体岗位实践，从业务流程到职能管理，从职场心理学到人际关系，从生涯规划到职业转型，几乎覆盖了职场发展过程中可能遇到的所有问题。和网络上搜集到的散乱、劣质资料相比，大职门APP推出的是成体系的纯干货，而且都来自实战经验总结，更有针对性，也更容易吸收。职场大咖们梳理出来的成体系的经验分享课程，只需一次劳动，便可长久分享下去，边际成本无限趋近于零。这也是互联网时代赋予这种模式的可能性。\r\n\r\n作为知识共享这个大类下的细分领域，职业经验共享将成为“智慧人口红利”的下一个受益者。张彬认为：“对于职业经验丰富的人来说，除了利用经验为组织做贡献，还可分享给后辈，让更多的人受益。互联网没有兴起时，一个人的经验再丰富，能影响的范围也有限，能惠及的人始终有限，这在某种意义上也是一种浪费。互联网共享经济的蓬勃发展给了智慧人口将自己的经验变现的机会，每位职场人士都可以将自己的经验梳理出来，以经验包的形式在互联网平台上与他人共享。”\r\n\r\n三人行必有我师，术业有专攻。“职业经验的分享并不一定都来自大咖，只要你的经历具备代表意义，能给后来人以指引，都具备很大的价值。自己做过的、经历过的，自然可以梳理出来，分享给没有做过的、没有经历过的，这就是经验的共享与传承。”张彬总结到。\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '4', 'n170518025');
INSERT INTO `news_content` VALUES ('nc17051800122', '2', 'upload/news/n170518025/nc17051800122_contentimg.png', '3', 'n170518025');
INSERT INTO `news_content` VALUES ('nc17051900123', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170519026');
INSERT INTO `news_content` VALUES ('nc17051900124', '2', 'upload/news/n170519026/nc17051900124_contentimg.jpg', '2', 'n170519026');
INSERT INTO `news_content` VALUES ('nc17051900125', '3', '日前，清华大学《创业导引——与创业名家面对面》课程邀请到华创资本合伙人——唐大牛先生，为大家讲述《创业是追逐机会还是创造价值，了解创业者是技术也是艺术》。\r\n\r\n\r\n◆ 技术层面与艺术层面\r\n\r\n有人问我们如何判断一个好的项目，我们希望这个公司的下限也很高、上限也很高。同时，我们会看他的技术层面和艺术层面到底如何，这两个维度还是可以比较和衡量的。其实它不光可以衡量任何的公司，也可以衡量任何一个人。\r\n\r\n我自己的职业生涯是我在南京读研究生时候，当时比较幸运，研究生期间不是很忙，我就可以在外面做事情。我最早以为我这一辈子应该是写代码的，然后我开始写代码，后来发现光写代码不行，得有人设计算法，你就得设计算法。你做完这个工作之后，你会发现你还得进一步定义你的产品到底是什么，把底层架构搭完之后，产品做完以后，当然要走向市场，走向市场还有营销问题，正好这么一段工作经历，让我自己完成了技术层面的训练，让我自身的能力组合比较多元。\r\n\r\n但后来这件事我没有继续做了，回过头来说，我当时对人的部分的关注是不够的，你虽然懂得很多东西，但是对人的因素，也就是艺术层面了解还是不够，因为商业的背后都是人。从那个时候起，就开始这个部分自我的训练。\r\n\r\n技术层面跟艺术层面交替提升的过程基本就是我自己一路走过来的过程。我们会说一个创业者，第一，他要有一定的愿景，就是在他的视野里，这个世界应该跟今天有点不一样，应该变的更好一点，或者会增加一些东西，一些对人有更多的关怀、和更多人利益关切的东西。他能感觉到，然后去做，把这个东西实现出来。就涉及到另外一个话题，目前这个市场到底有没有机会的问题，我个人认为还是有非常多的机会，因为所有跟品质相关的、跟服务有关的、跟艺术、跟设计有关的、跟价值有关的东西、跟技术有关的东西，我们都还处在很早阶段，绝对不会没有机会。\r\n\r\n\r\n◆ 投什么样的创业者？\r\n \r\n◆ 天才？全才？\r\n\r\n今天上午见一个创业者，曾经是一本知名杂志的主编，我说“其实你作为一个主编已经养成了非常多的技能了，但是你未必能够成为一个特别优秀的管理者。为了把这个事做成，团队必须在商业上足够成熟，有很好的管理能力。”\r\n\r\n我有一个很深的感受，在中国，大家都在讲中国创业有很多挑战，我最近的感触是目前大环境对创业者的苛刻。另一方面表现为，本来是天才型的选手，被迫要变成全才型选手，我看到很多天才，在这个过程中，这个人变的没有特色了。全才的意思就是说整个公司需要ABCDE五个能力，但这时候创业者身上的每个能力可能都不是满分的。比如这个人要有天生的领导能力，在管理上还要知道怎么做流程、怎么做运营，研发技术。一个创业者早期时候获得这些资源很难，每部分都要把自己训练成60分、70分，但是整个体系就不会那么强了。\r\n\r\n \r\n◆ 有趣会花钱的人\r\n\r\n我们喜欢的创业者是有趣会花钱的人。有趣是什么意思呢？有趣跟艺术层面有点相像，我们希望跟他聊之后他有这样的想法：第一，他可能会照顾到更多人；第二，这些人如果被照顾到之后，某方面的品质有提升。现在有很多跟创业有关的活动，各种各样的比赛，有非常多有趣的创业的计划。但是，所有这些东西会有一个转换点，这个转换点是从一个主意真正开始往商业转。转换点是什么呢？我认为转换在于会不会有一个主意，令你非常兴奋，进而你开始想到它跟钱的关系，如果这个主意没有逼迫你到想钱的问题的时候，还真的只是一个主意。\r\n\r\n什么是创业公司？有一个“创”字在里面，当然是创造价值的公司。大家都知道，价值在商业世界里是用钱衡量的，很多人默认创业公司一定是创造钱的公司，当然不是，钱是银行印的，没有一个创业公司真正创造钱。所谓商业公司，在现代商业制度里，当有了货币、有了有限责任公司这么一个体系之后，要做的事情就是把一种形式的货币流动转变成另外一个形式的货币流动。其实投资投什么？投资投的是你会发现整个货币在这个地方流动效率高出在别的地方，我们愿意把钱放在这个地方。当你的流速变高的过程中，现金流动价值在变高。创业公司创造的不是货币，创造的是货币的流动。当你没有引发货币流动时候，你想的还是一个主意，不是一个生意。\r\n\r\n会花钱是什么意思呢？你知道钱该往哪个方面用，这才是真正的会花钱，不是你拿钱之后，发现我得买桌子，我得换显示器，当然这些很容易，但这个不叫会花钱。会花钱是你真的知道为了要完成这样一个商业愿景，我知道我今天拥有什么能力，以及我还要获得什么能力，有些能力可以用钱能买到，有些能力还得通过钱的投入逐步积累得到。会花钱意味着两点，一是已经从商业角度考虑这个问题；二是已经开始从战略角度考虑这个问题，这是商业角度里最根本的衡量标准，至少我是这么看的。\r\n\r\n我们投过一些很年轻的创业者，他拿到的天使投资钱的时候，他不会怯场。举个例子，我见过一个人，我觉得他身上商业角色特别重，他不是市侩的商人，他对商业不怯场，可能家里条件也不是那么好，在学校里的时候做过很多校内经营的小生意，使得他对商业这件事有亲近感。\r\n\r\n◆ 追逐机会 or 创造价值\r\n\r\n过去的十年时间对于创业公司更多的机会就是追逐机会，先追求量，一旦中国有的行业，规模都是极大无比的，比如移动互联网，比如刚刚讲的大数据。中国人做大数据有一个很大优势，我们的体量足够大，我们不管做什么东西，因为有这么多人在，数据量是大的，最近人工智能发展很大程度上是数据量和计算能力的增长；\r\n\r\n第二，大数据东西，很多时候跟基础设施投资有关，在中国基础设施投资这件事情一直以来有着很大优势，可以在很短时间里把基础设施建立起来；\r\n\r\n第三，大数据的使用场景非常广泛。\r\n\r\n这三个因素加在一起，我们非常看好这个行业。\r\n\r\n如果大家相信我们已经到了一个新的阶段的话，更多中小企业使命是在创造价值，而不是在追逐机会。追逐机会的公司会有一个很大的特点，会有很多公司涌到一个方向里，大家一下把市场撑起来了，很短时间之内，伴随着百亿级、千亿级甚至万亿级市场。在中国我们谈到商业，我们都觉得十年简直是不可思议的事情，但是在国外十年其实是非常基本的尺度。我们中国的十年相当于人家三十年，很大原因是我们有足够大的体量。另外，由于起点比较低，我们特别具备创业当中重要的精神，非常非常勤奋，非常非常愿意投入，花很多很多时间。所以，我们能够做的这么快。\r\n\r\n我个人不是那么提倡所谓创业公司狼性因素，什么原因呢？你每天跟打仗一样，可以把竞争这个事做到很好，但是要把创造这个事情做的很好，不能每天在完全沉浸在具体的细节里。有些人能够非常厉害的把这两个事都做的很好，所以他们做出来的公司是顶级公司，他们既承载过去十多年时间里高速成长、大规模状态，同时他们还不断有创造力，可能最后是通过组织架构的形式实现的。如果去阿里，你会发现不同层次级别的人干的事是不一样的，有些人可能负责打仗，有些人负责创造，中间人干的是衔接工作。不能说我今天要创业，就奔着一定要成为马云，当然可以，但实际上并不是每个人都能成为马云，你完全可以做非常不错的有价值的公司，公司一方面要很有执行力，另一方面还要有创造力。\r\n\r\n最后一句话总结我今天主要讲的内容，我自己认为最终极的投资还是你决定把你的时间花在跟哪些人在一起。在清华这样一个环境里，有非常非常多的选择，大家有比我们当时更好的机会，从总体上而言，当时我在学校里的时候，还是比较幸运的，正好有一些机会碰到了这个事、碰到了那个事，拓展了一些资源。但是，跟现在在学校的学生来说是不能相比的，我们那个时候世界是很小的，必须得往前多走一步，才能多看到一点。这个世界一直都在变化，这也是为什么这个世界上会有那么多人觉得创业这个事很有乐趣，他愿意参与到不同的创业过程中，以上就是我对创业和投资的理解。\r\n\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '3', 'n170519026');
INSERT INTO `news_content` VALUES ('nc17052000126', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170520027');
INSERT INTO `news_content` VALUES ('nc17052000127', '2', 'upload/news/n170520027/nc17052000127_contentimg.jpg', '2', 'n170520027');
INSERT INTO `news_content` VALUES ('nc17052000128', '3', '无忧精英网(www.51jingying.com)通过调研，对女性的职场压力源、家庭财务开支、自我能力提升等问题分析比较，发布了《2017年职场女性压力报告》。此次调研参与的职场女性为5044人，其中工作年限五年以上占40%，本科以上学历占50%，硕士和博士占比14%，来自北上广深一线城市及省会城市的人数占到65%，覆盖互联网、金融、房地产、汽车、贸易制造、培训教育等九大行业。\r\n\r\n\r\n● 职场女性能够理性对待“二胎政策”，多数人克服困难积极响应。\r\n\r\n本次调研，职场妈妈的比例占到75%，其中有20%女性已经有2个或者2个以上孩子。在国家二胎政策的推动下，更多单孩家庭做出响应，已有一个孩子打算再要二胎宝宝的家庭占到67%，意愿度相当高。受访女性表示，自己是独生子女在孤单寂寞环境中长大，那种没有兄弟姐妹的遗憾，希望可以通过自己小家庭弥补。她们认为，辛苦是暂时的，着眼未来，这个决定应该利大于弊，不会后悔。\r\n\r\n同时，调查中的29%的女性明确表示不会要二胎。她们觉得现在生活压力非常大，“生孩子容易，养孩子难”。在房价飙升、生活成本叠加的今天，女性朋友认为有一个孩子足矣，在力所能及的范围里，将所有资源投入到一个孩子身上，给他最好的，也不会出现偏袒，只要尽到做父母的责任，也是理性的选择。\r\n\r\n还有少部分女性持观望态度，虽然都是“适孕”年龄，但阻力也不小。一个原因来自老人和配偶，特别是家中双亲年事已高，明确表示不会帮忙；另一个主要因素来自孩子的抵触情绪，家里的老大不喜欢再来一个“竞争对手”分享爸爸妈妈的爱。因此，如何处理好谁带孩子的问题、以及两个孩子的关系，都没有做好周全准备。\r\n\r\n\r\n● 孩子的精神和物质投入一样不能少，教育是家庭支出最大项目。\r\n\r\n虽然受访女性普遍对再要一个孩子有很强的意愿，但抚养孩子成长的开支也让许多家庭感受到不小的压力。现代家庭非常重视孩子的身心发育，吃的要营养，穿的要得体，带孩子出去旅游开拓视野，也是很多家庭必不可少的项目。上海一家专门承接海外游学服务的文化交流公司接受我们的采访表示，这几年海外游学越来越火，除了学校组织外，也有几个家庭拼团去加拿大、澳大利亚、美国、英国等学校考察，费用都比较高，但在乎品质的家长认为物有所值。\r\n\r\n本次调查有60%职场妈妈选择家庭开支最大项来自“教育”。从无忧精英网之前对于培训市场调研来看，儿童及青少年的教育市场这几年蓬勃发展，产生了大量的猎头职位来应对这种市场需求。无论是职场妈妈还是全职妈妈，都秉持“孩子不能输在起跑线上”的朴素观点，每个孩子每节课根据城市和项目的不同人均花费在200-500元/小时，近一半的家庭在孩子教育上的花费占全年家庭收入15%以上。\r\n\r\n\r\n● 职场女性分身乏术，兼顾工作与家庭挑战多多\r\n\r\n除了金钱，还有时间和精力。受访的女性有50%以上每天花2-3小时用于孩子的功课辅导，如果是二孩家庭，这个时间还会更长。所以很多职场妈妈不得不放弃工作，做回全职妈妈。全职妈妈普遍认为她们一点不比上班轻松，每天重心都围绕孩子，与社会脱节。职场妈妈与全职妈妈最大的不同，除了照顾家庭，还必须扮演好工作的角色。很多职场女性有了孩子之后会酌情考虑转岗，选择一些时间较为宽松、工作强度不大的工作，以更好的照顾孩子。但毕竟不是所有公司都有这样的弹性机制，因此，因为孩子生病、学校活动或者假期没人代管等原因，很多职场妈妈不得不向公司请假。虽然站在雇主方角度，这些理由也是情有可原，但次数过多频繁，也会影响工作完成。因此很多孩子较小的职场妈妈在回归职场上也困难较多，雇主方因担心孩子牵扯太多精力，而不得不顾虑求职者是否能全身心投入工作，更倾向于无孩无负担的年轻人。\r\n\r\n正所谓“熊掌和鱼，不可兼得”。报告中的数据也证实这一点，85%职场妈妈认为照顾孩子的确影响到事业的发展，很多晋升的机会需要投入更多精力，加班、出差是常态化，在现实面前，她们很难做出取舍。无忧精英网通过对职场精英女性的追踪发现，绝大多数能够做到平衡的高管，主要依靠家人分担，采取“家人和保姆”协作的方式，才能放心在职场打拼。\r\n\r\n\r\n● 做到“陪伴”力不从心，“自我增值”迫在眉睫。\r\n\r\n在刚刚过去的母亲节，很多受访者表示都给自己的妈妈买了礼物或者送上祝福，但总体流露出由于平时工作忙，陪伴母亲的时间是很有限的。70%的人能够每天或者每周看望父母，这个数字非常难得。同时也有303人表示有事才联系，与父母交流的内容也围绕着生活、健康等，工作方面提及很少，不想父母无谓的担心。\r\n\r\n“陪伴是最长情的告白”，这句话很多人认可但做到却不容易。无论是自己的父母，还是自己的小孩，职场女性都有很多的遗憾，部分职场妈妈表示在孩子成长过程中，由于工作原因，错过很多难忘的“第一次”，非常无奈。也有因为工作在外地，不能在父母身边，只有在生病的时候才赶回家，也很自责。通过参与这次调研，也让很多受访者意识到“珍惜眼前人”，给家人更多的陪伴才是最好的礼物。\r\n\r\n本次调查的最后，是关于职场女性“自我升值”的话题。90%以上受访者都意识到时间宝贵，如何将有限时间实现“效能最大化”，是每位继续自己职业生涯的女性都不得不思考的问题。从“时间管理”转为“精力管理”，是一个质的变化。超人妈妈，就是让自己时刻保持充足的能量，通过学习、提升技能胜任新的工作内容，保持自己竞争力。很多工作机会并没有性别标签，却有能量标签，无忧精英网最新行业职能显示，年薪50万以上的关键职位，女性比例并不少于男性，机会一样是给有准备、有能力的人。\r\n\r\n综上所述，职场女性压力源自工作和家庭等多个方面，在职业上升期，她们比男性有更多的考验和阻力。作为职场妈妈，一方面不能忽略孩子的成长，同时也不想让自己的职业生涯半途而废，就更需要积极、乐观向上能量应对各种变化。结合数据无忧精英网也采访了一些企业代表，大多雇主表示二胎政策放开后，企业的确感受到压力，但大多企业也能认同这是企业必须承担的的社会责任，除了希望国家尽快落实配套的政策措施外，企业也建议职场女性能够摆正位置不要放大“特殊化”，认为自己是被照顾的对象，降低工作要求，人际关系紧张，造成不好的影响。\r\n\r\n无忧精英网首席职业发展顾问赵争女士表示：“女性角色在职场中发挥着重要的作用，她们坚韧顽强，心思细腻，尤其做了职场妈妈，包容度更高。我们看到很多职场女性通过自己的智慧，不断挖掘自身的潜力，能够很好的平衡家庭与工作的关系。而作为企业方，如果能够建立有效的规则，倡导激发女性能力的企业文化，也必将在未来的人才争夺中保持主动。”\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', '3', 'n170520027');
INSERT INTO `news_content` VALUES ('nc17052300129', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170523028');
INSERT INTO `news_content` VALUES ('nc17052300130', '2', 'upload/news/n170523028/nc17052300130_contentimg.jpg', '2', 'n170523028');
INSERT INTO `news_content` VALUES ('nc17052300131', '3', '近日，清华大学《创业导引——与创业名家面对面》课程邀请到了Plug and Play硅谷科技孵化中心，中国管理合伙人&CEO——赵晨先生，为大家讲述如何撰写商业计划书、路演技巧和创业生态体系。\r\n\r\n\r\n◆ 商业计划书的框架\r\n\r\n商业计划书可以帮助大家梳理一个逻辑，我作为一个创业团队的CEO，给投资人要讲一个故事，相当于在卖我公司的股份，是一个销售员。很多投资人都是大咖，他们每天的时间都安排很紧，所以逻辑一定要清晰。\r\n\r\n\r\n◆ 找到合适的投资人\r\n\r\n每一个投资人看的领域都不一样，比如一个做人工智能的投资人，如果给他看做电商的项目，出于礼貌，他可能会听你讲完，但最后可能不会有实际合作，他不会投你的项目。跟投资人或者投资机构接触之前，了解到我的项目和投资人是不是对口的是非常重要的。\r\n\r\n\r\n◆ 一句话介绍产品\r\n\r\n见到投资人后，组织好自己的语言，一句话介绍自己的产品，在5分钟之内将项目讲清楚，让投资人对你的项目感兴趣。不管谈男女朋友也好，还是谈项目也好，如果给投资人第一印象是这个团队不错、这个技术不错，之后就有兴趣再认真听你讲完剩下的25分钟，55分钟。\r\n\r\n\r\n◆ 面临的问题&解决方案\r\n\r\n没有我的产品之前，市场上用户面临的是什么问题？针对他们的问题，我们的解决方案是什么？是能帮他更快的完成工作吗？是能帮他省钱吗？是能帮他多挣钱吗？我们一定要想好应用场景。另外，早期我们最看中的是团队、市场规模、商业模式。\r\n\r\n\r\n◆ 市场规模\r\n\r\n大家都在说市场规模，了解这个市场的规模有多少，是做什么用的呢？我举个例子，比如一个领域市场总共10亿美金，在前6个月或者前1年针对其中某一个细分领域，可能只是1亿人民币市场。如果这个项目我做的好，一年之内希望能占到5%的市场份额，一年之内可能有500万左右的收入。怎么算这个基数？其实有非常好的方法，比如针对某一个行业可以去找很多数据库，尤其是学校的学生，学校网站、图书馆上肯定有很多数据库，还有艾瑞咨询出的报告等等。\r\n\r\n\r\n◆ 商业模式\r\n\r\n我卖一个东西，价格多少？成本是多少？利润是多少，有不同的商业模式。但是，一定要有一个商业模式，不是去烧资本的钱，一定要有一个长期的赚钱方式。我们在2014年刚回到国内投资过程中，那会儿很多O2O非常火，很多项目找到我们，说我们初期目标是把我们用户做到两百万用户、五百万用户。怎么赚钱呢？我们的用户到达五百万之后，我们自然就能赚钱了，我们自然就有商业模式出来了。即便你没有那么多清晰的商业模式之前，你至少要想一两个初期能够维持自己团队运营和获得基本收入的商业模式。\r\n\r\n\r\n◆ 现阶段竞争分析\r\n\r\n我们今天下午过一个项目，创始人从普林斯顿回来，他说一句话特别有意思，No ?Idea?Is New? Idea。任何人想到的一个主意肯定都有人想到了，有些创业者也说我的创业项目给你，你可一定不要给别人看，我这个是最棒的商业模式，我有最棒的专利技术产品。但大多数情况下，市场上已经有相似产品在，甚至有做的更早、更好的，一定要花时间去了解。你不做竞争分析，你不了解市面上的人都在干什么，只顾着埋着头做你的产品和研发，做出来之后，首先你发现没有人愿意买单，第二你发现别人比你做的好的多，我白做了，所以一定要做好竞争分析，非常重要。\r\n\r\n做竞品分析，市面上有许多平台可以查询，比如一些科技媒体，一些创业融资平台，上面有很多创业融资信息，哪个项目到A轮了，哪个项目到B轮了，这些都可以了解。\r\n\r\n\r\n◆ 股权结构\r\n\r\n股权架构清晰吗？谁是大股东？谁在董事会里边？谁在做重要决策？这些内容一定要在创业的初期在搭建团队的过程中就要写清楚了，为什么？你可能现在觉得兄弟姐妹三四个人合伙做个公司非常好，我们一起吃点苦注册个公司。但你发现当公司一旦有融资进来了，一旦有收入了，比如现在有非常好的投资机构找到你们公司，说要给你们投资一千万，出于本性，这时候都会提一些问题，对于公司未来的发展，我如何把控？我能够拿到多少股份？很多公司因为之前股权分配不清晰，造成之后公司内部有很多矛盾，最后甚至造成公司散伙的情况都有，股权结构一定要讲清楚。\r\n\r\n\r\n◆ 融资计划\r\n\r\n我在国外上学的时候，有一门非常简单的课程，算是财务预测。在初期过程中，大部分预测都是错的，比如这个月我花多少钱，我有多少收入，这些预测一年以后回过来看，80%都是不准确的。但是，你做这样一个预测分析是帮你梳理一个大概的花费预算，比如我要雇人，我要租办公室，我要做广告，我要做产品开发，我要开模，我要做样机，都要花钱，这些数字都是根据你基于现在的执行现状前提下做的预测。收入方面，比如我会卖多少订单，有多少技术授权费用，第一季度赚多少钱，第二季度赚多少钱。\r\n\r\n\r\n◆ 六个月的支出计划\r\n\r\n比如我融五百万，其中30%要用于人，30%用于市场，要打广告卖我的东西，还有20%日常运营，还有20％做其他的。同时，你还要和投资人讲我计划第一季度、第二季度、第三季度做什么，比如我觉得第一季度工程师团队5个人，第三季度可能到10个人了，投资机构如果看到这样数据的时候，他肯定更加信任，觉得这个CEO是经过思考才出来这个数的，而不是拍脑袋得到的。\r\n\r\n\r\n◆ 商业计划PPT形式精美是否重要\r\n\r\nPPT最重要的是要让人看着舒服、信息表达得清楚。即使格式没有那么精美，但是能把事情说清楚，又能更早的接触投资人，那么做的特别特别精美就没那么必要。当然，做的美一点没坏处，但是你要说把这页东西用特别漂亮的毛笔字写出来，有必要花这个时间吗？没有必要，如果团队里刚好运气好，有一个会做PPT，能优化一下，我觉得没坏处，但是如果多花两天、三天时间把完全一模一样PPT内容做的更精美，我觉得没有太大必要，也没必要花钱找美化PPT公司做一下，如果真的好的项目、好的团队，不用特别好的PPT，也不需要特别长，10-15页就可以。\r\n\r\n\r\n◆ 演讲技巧\r\n\r\n我当时在Toast Masters上学的时候，实话实说，知道第二天要上台讲话，头一天晚上都睡不好觉，上去磕磕绊绊的，而且要用英文讲，讲不利落。后来上课的过程中，有些老师非常善于表达自己，有些外国人非常善于演讲。有些非常简单的技巧，比如自信、声音洪亮、眼神交流、肢体语言，讲的过程中会跟大家有些互动，帮助吸引大家的注意力。\r\n\r\n一定要掌握好自己要讲的内容，比如我今天不需要PPT也能讲今天的内容。但是，如果我不能掌握今天讲得内容，一边想着面对多少听众，一边还要记着要讲什么的话，有这种牵绊存在，讲的时候肯定会很紧张。很难说有什么诀窍能够帮你很快很舒适的在五百人前面讲话，我会把底下所有小伙伴、所有听众都当成我的朋友或者当成我的家人，这样我在演讲的时候，心里就没那么紧张了。\r\n\r\nDRESS LIKE THE MAN／WOMAN YOU WANT TO BECOME。底下观众是谁，我要穿对应的合适衣服，比如今天是比较轻松的学校的环境，牛仔裤就可以了，比如我到大企业展示或者一些行业论坛，根据企业的风格，我就需要穿西装，可能穿其它服饰，在国外是非常注重这点的。\r\n\r\n\r\n◆ 创业生态体系\r\n\r\n在创业初期，除了风险投资之外，你可能还需要什么？有做产品的，有做招人的，有做财务管理的，对于初级团队来说，最重要的肯定是招人和做产品。\r\n\r\n同时，你会发现初期还有市场推广的需求，你可能需要很多媒体帮你做推广，给你的企业带来知名度，让大家了解你，就是给自己打广告。当然，还有很多创业活动、论坛会议等，有科技主题的、金融主题的，少则几百人、多则几千人舞台上都可以介绍自己的项目。\r\n\r\n另外，在初期，大量国外创业团队项目介绍里必定会有一页放他们的导师，因为创业团队很年轻，他们在行业里并没有特别多的积累，他们愿意找一些这个行业里大企业高管做他们的导师，不管通过什么形式激励导师，比如给他一些导师股份，或者给他一些实际资金奖励，帮他辅导我的团队的初期，甚至对接一些他行业里的客户、行业里的资源给我。所以，有很多行业导师可以帮助我们创业团队初期更好、更快的了解市场。\r\n\r\n有些小伙伴不会毕业之后马上考虑创业，去一些大的公司也是一个方向。现在有大量的企业，比如腾讯，比如百度，比如小米，都有自己的投资团队、创新团队、自己的孵化器，为什么？因为这些大企业自己发展过程中都需要一些新的技术创新来带动自己传统业务的转型升级，把自己技术做的更领先，好和他们的竞争对手去比。\r\n\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！\r\n', '3', 'n170523028');
INSERT INTO `news_content` VALUES ('nc17052300132', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170523029');
INSERT INTO `news_content` VALUES ('nc17052300133', '2', 'upload/news/n170523029/nc17052300133_contentimg.jpg', '2', 'n170523029');
INSERT INTO `news_content` VALUES ('nc17052300134', '3', '日前，清华大学《创业导引——与创业名家面对面》课程邀请到了洪泰基金创始人、资深投资银行家、前华泰联合证券公司董事长——盛希泰先生，为大家讲述我国经历的四次经济大重启、面临的五大机遇和创业者必备的六大特征。\r\n\r\n\r\n◆ 中国正经历第四次经济大重启\r\n\r\n一个人最大的机会就是能够与时代同步、与时代共振，而不是五年、十年之后发现你同学成功了，一拍大腿，我当年为什么没那样做，这是最愚蠢、最可悲的。新中国成立以来，在经济方面经历了四次大重启，我们正处在这第四次当中......\r\n\r\n\r\n○ 第一次 1978年改革开放\r\n\r\n1960年到1972年出生的人是最幸运的，因为赶上了一切的好时代，包括恢复高考，包括进入机关、进入企业，包括经商。但大众创业、万众创新这八个字如果放20年前提出来，却很难找到支点，因为那个时候大家刚刚有机会去工作，根本没有冲动去创业，有一个饭碗已经很不错了。\r\n\r\n\r\n○ 第二次 1992年邓小平南巡\r\n\r\n1992年小平同志南巡，时间特别重要，特别伟大，真的是中国经济的重启，也是政治的重启，我就是92南巡的受益者。我1992年年底、1993年初实习，找工作，跑去了深圳，当时我在南开大学读书。南开的同学在天津，有两个走向，一个走向来北京，因为专业很不错，进入国家部委，很简单。另外一个走向是去深圳。后来就有了这样的结果，一种结果是凡是去深圳的同学，大概率事件，比来北京的出成绩出的早很多，做的也好很多。第二，凡是做证券行业的，就是金融证券公司的，大概率事件，比别的行业的同学做的好一些。时势造英雄，任何人不要夸大自己的成就，运气占很大比重。\r\n\r\n\r\n○ 第三次 2002年加入WTO\r\n\r\n大家一定要格外的回顾一下这个时间点，因为这个离我们比较近。中国最大的发展动力是来自于2002年以后，回顾一下，2002年中国有什么呢？而现在呢，差别太大了，中国人真的有钱了，真的富起来了。\r\n\r\n2002年到2005年的时候，房价根本没涨，我记得当时我在证券公司当总裁，我们在上海世纪公园旁边，给员工买房子，7000元/平方米，我估计现在乘以20没问题了。包括股市、石油、黄金、其它所有大宗商品都是从2002年开始起步的，尤其是从2005年到2012年这8年，经历了中国历史上最伟大的造富运动，几乎每一个人，除非只有现金、只有存款，只要买了一套房子，除了通胀因素之外，身价仍然有非常大的增值的。所以，2002年这个节点对中国太重要了，整个商品涌现全世界，中国变为世界工厂，特别伟大的。\r\n\r\n\r\n○ 第四次 供给侧改革＋双创时代\r\n\r\n第四次就是现在这次，就像1992年我把握小平同志南巡机会一样，你们要把握的是这个机会。经济上的一个词是供给侧改革和双创时代，我最早讲这个题目是去年的3、4月份，在哈佛大学年度中国论坛上。\r\n\r\n当时讲了这么一个故事，20多年前，我上学的时候，很多同学到美国去了，那时中国和美国差距多大。一个男同学拿到美国签证后，楼前排的全是女生，一点都不夸张，你能到美国去，带我去天堂。20年下来了，怎么样呢？先不说同学做的好不好？当然，肯定有做的好的，但大概率事件，做的没那么好。他们的个性没有了，被美国人磨的没什么棱了，他们的劲儿没了，自信没了。\r\n\r\n90后的中国人，应该是扬眉吐气的，应该是彰显气质的，因为背后的中国跟20年前完全不一样，此处不留爷，自有留爷处。90后的孩子不要唱空中国，因为过去20年移民的人，都错过一个世界奇迹。中国高增长、低通胀20多年，打破了所有经济学家能够达到的理论极限，90后应该清楚，不要错过中国，这是那天我讲的核心题目。\r\n\r\n\r\n◆ 五大机遇 稳定发展 经济可期\r\n\r\n中国政治非常稳定，尤其最近这几年，特别稳定。回忆一下五年前，有一个词叫群体事件，这五年这个词基本没有了，听不见了。\r\n\r\n摩根士丹利研究部门在2月14日为中国经济送上重磅“情书”，说中国2027年可以跨入世界发达国家行列，发达国家标准是什么？我们去年人均GDP8100美金，根据2015年最新的国际货币基金组织的报告，人均GDP达到12475美金就可以叫做发达国家。进入发达国家行列，大部分都是很小国家，像欧洲小国可能只有几百万人口，中国这么大的国家，人均达到这么一个水平是很困难的。报告指出我国2030年达到20万亿美金的总量，达到这个水准，我们只需要维持年增长率GDP4.6%就可以。\r\n\r\n\r\n◆ 整体富裕 消费升级\r\n\r\n整体富裕这个词不是虚拟的词。最近这些年有一个词叫消费升级，消费升级绝对不是说某一个人有钱了，一定是整体有钱。\r\n\r\n其实消费升级最刺激的例子是我们跑到日本买马桶盖、买菜刀、买电饭煲。老百姓的口味变了，需求变了，供给没改变。所以，供给侧改革太有必要了。\r\n\r\n\r\n◆ 移动互联网 中国世纪\r\n\r\n中国现在有10亿部智能手机，这个数据超过全世界所有发达国家人口的总和，美国能不颤抖吗？这个时代，我非常有民族自豪感。\r\n\r\n类似，为什么腾讯出现在中国？为什么FACEBOOK出现在美国？因为分别代表全世界两大语言体。德国，多少人讲德语？日本，多少人讲日语？这就是中国的机会，中国人的世纪。\r\n\r\n\r\n◆ 90后 改变中国 改变世界\r\n\r\n90后是中国正常的第一代人，精神层次上不残废的第一代人。我们有一个词叫短期经济，有紧箍咒，量入为出是必须的，而今天的90后，除了个别家庭条件很差的之外，很多人的思维方式不一样，消费习惯，行为习惯也不一样。95后孩子、00后孩子不用微信，用QQ。FACEBOOK在美国也有危机感，00后的孩子不一定用FACEBOOK，这都是变化。\r\n\r\n大众创业、万众创新这个国策正好跟目前90后的个性完美的结合，如果是50后、60后的人，根本没饭吃，突然有饭吃了，稳定的工资，还折腾什么呢？90后的人觉得是不是能够更自由一点？另外，习主席提的供给侧改革跟这个十字路口完全吻合，供给侧改革的核心是创新，大众创业的核心也是创新。\r\n\r\n\r\n◆ 大麻烦 大机遇\r\n\r\n大家知道，春节大年三十那天收发红包多少个？142亿个，敲钟那个时段，每秒钟76万个，为什么会这样？美国可能吗？还有一个数据，去年中国第三方移动支付是5.5万亿美元，美国1120亿美元，这种差距不可思议，这也是弯道超车最伟大的例子。美国老百姓人手几个信用卡，中国老百姓70%、80%从来没用过信用卡，一步跨过信用卡时代。在移动互联网领域，大家都会有机会，这是我们的机会。\r\n\r\n\r\n◆ 创业必备6大特征\r\n\r\n\r\n○ 第一 合伙人思维\r\n\r\n合伙人要相互尊重、等量齐观、相互互补，很重要。名义上是合伙人，100%我说了算，这不叫合伙人，必须等量齐观、相互互补才能走的好。一个单位一旦一个人说了算，所有人都是你的下属，就完蛋了。我看项目时候，如果这个家伙没有合伙人，我是不投的，是没有未来的。\r\n\r\n\r\n○ 第二 格局很重要\r\n\r\n谁没有性格？谁都有性格，方式都不一样。能不能包容别人？能不能听听不同意见？这点很重要。一个人成功很大标志就是自我控制能力，要能够容的下别人，容的下不同意见，容的下能干的人。\r\n\r\n\r\n○ 第三 同甘共苦\r\n\r\n好的时候能一块过好日子，差的时候才有可能跟你共度难关，这就是老大的气质。原来我在证券公司当总裁，其实我不大管具体事，他们觉得很奇怪，后来问我什么原因？我说每一个董事长、总裁都可以说我有个人魅力，我决策多么精明，这些我都不讲。有一条，我说“我非常善于做后勤部长”。什么是后勤部长？善于给别人提供平台，善于给别人服务，善于兑现别人的利益，这就是后勤部长。作为老大，你能干没用，你的队员能干才有意义，这点非常非常重要。\r\n\r\n\r\n○ 第四 善于做计划\r\n\r\n要善于做计划，并且一定要算帐，中国第一个娱乐上市公司华谊兄弟，现在市值很高，为什么能上市？我说因为他最善于把一个企业计划做好，账算到位，而不是胡说八道满嘴跑火车。\r\n\r\n\r\n○ 第五 选择智慧\r\n\r\n选择智慧，不管创业，还是工作，都很重要，人一生的时间是有限的，这是公理。怎么分配决定你是不是有成就，要把时间分配给有意义的人和事。\r\n\r\n\r\n○ 第六 细心\r\n\r\n细心，这是一种习惯和自然，习惯成自然。我当总裁时，开始写一些小文章，我说从消灭错别字开始，我认为细心就这么基础，不用多讲。我想每一个人都读过书，写东西是饭碗之一，细心特别重要，很多时候都是这样。\r\n\r\n\r\n除了以上六条，有一句话是天理，十年磨一剑。很多年轻人恨不得明天就成功，马云多年前做黄页时候也失败了，马化腾当年为了融资，躺在床上好几天起不来床，都需要时间，都需要时代，只要方向对了，并且努力，你需要的只是时间。\r\n\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！\r\n', '3', 'n170523029');
INSERT INTO `news_content` VALUES ('nc17052300135', '1', '大职门APP——专业的职场经验与技能分享平台', '1', 'n170523030');
INSERT INTO `news_content` VALUES ('nc17052300136', '2', 'upload/news/n170523030/nc17052300136_contentimg.jpg', '2', 'n170523030');
INSERT INTO `news_content` VALUES ('nc17052300137', '3', '日前，清华大学《创业导引——与创业名家面对面》课程邀请到了掌柜攻略&勺子课堂创始人兼CEO——宋宣先生分享自己的创业经验，为大家讲述《走向盈利！资本“寒冬”下的“红海”创业法则》。\r\n\r\n宋宣，2015 年 3 月创办餐饮行业产业媒体“掌柜攻略”，专注于餐饮行业产业报道；2016 年 1 月创办“勺子课堂”，为中国餐饮行业中大量中小商家提供了优质的职业教育课程，教学科目涉及：营运、营销、选址、采购、出品等多个领域。\r\n\r\n\r\n◆ 创业一定是对“职业”的“理性选择”\r\n\r\n第一份工作决定一生！\r\n\r\n原来我不信这句话，现在深深信了，这句话就是我自己反复实践的结果。我从开始实习就是跟媒体相关，其实就是跟内容相关，到现在为止都没有脱离“内容”这两个字，一直靠笔杆子活着。第一份工作决定你的一生，之后每一个工作、你做的每一件事情都会和你当初第一份工作、第一次职业选择高度相关。\r\n\r\n\r\n◆ 做一个你爱的职业，然后从职业的选择到创业\r\n\r\n当你选择创业时候，很多优秀创业者的项目往往来自于自己的爱好。在这么多垂直媒体当中，我为什么想到餐饮行业？有一个原因就是我非常好吃，我是非常标准的金牛座，可以为了吃付出一切的代价，我从来不会在吃上省任何一分钱。所以，你是不是爱自己的职业，这件事情特别重要。\r\n\r\n我觉得创业一定是对职业的理性选择，它不是我突然一拍桌子想到一个特别厉害点子我就创业了，我想说这样创业100%失败。我周围有很多创业者，到现在为止我认识的创业者还不存在任何一个人是突然兴起做一件事情然后做的特别好，没有，而且即使有也不可复制。所以，理性选择职业，这是一切创业的开始。\r\n\r\n\r\n◆ 理性的创业\r\n\r\n理性创业，我支解为足够的职业积累、对商业的理解、超强的学习能力。\r\n\r\n\r\n◆ 足够的职业积累\r\n\r\n我认为足够的职业积累等于职业能力的积累＋职业技能的积累。到现在为止，我所看到非常多的优秀创业者，也是非常优秀的职业人，他们往往拥有能力和技能双重的属性，能力指的是他们有非常好的心态，他们同时能够有非常好的职业感，他们在做事情时候知道拿捏的分寸在哪儿，到职场之后你会发现中国有一个词非常伟大，叫“度”，很多事情做的度非常重要，拿捏准确度实际上是你在职场当中、在人与人沟通非常重要的一点，有些人觉得这样会不会很累？这是必要的。第二，职业技能，你想干的这件事情，你自己能不能干？千万不要妄想我今天想干一件事情，自己不会，然后去找一堆会的人来帮助你。我想说有这种可能，我也见过很多人自己不会这件事情，然后找很多人做成这件事情。\r\n\r\n\r\n◆ 对商业的理解\r\n\r\n对商业的理解非常重要，包括对市场需求的判断力和构建商业模式的能力。很多创业者实际上自己缔结一个伪需求，然后开始疯狂地找用户，最终希望能够成为一个怎么样怎么样的企业，对于需求的判断力和你能够把一个非刚需市场变成刚需市场的能力对于创业者来讲非常重要。你去发现一个商业模式，你去发现一个需求，并且把这个需求通过自己模型的构建变成一个商业模式，最终落地到带领团队去做，其实是非常苦的过程。\r\n\r\n我相信大家看到了非常多的经典案例，许多商业判断其实来自于生活，来自于你身边的事情，而并不来自于你们所看的伟大的书、伟大的商业模式是怎么构建的，以及巨头们如何讲述自己的经历。发现身边的商业是最基础的能力，所有巨头也都是从身边商业开始的，所以，观察周围的商业其实非常重要。\r\n\r\n\r\n◆ 超强的学习能力\r\n\r\n如果一个创业者在自己整个创业过程当中不去学习必死无疑，无论你原来多么聪明，你有多少知识，你都会发现创业一年之后或者几年之后你的知识根本不够用，或者你突然发现原来曾经在大学里没有学好的科目恰恰是今天我的大短板，而你必须去补。有句话说，工作之后再学习，工作之后再考研，工作之后再怎么怎么样，其实这句话也很难做到，因为你真的没有时间，所以，现在珍惜每分每秒很重要。\r\n\r\n超强的学习能力，我认为有三点：\r\n\r\n○ 第一，对自我的认知能力，每一个人都会对商业有基本判断，并不是所有事情你都能做，很多事情似乎我们并没有能力做。你能做什么？或者你的团队所拥有的核心能力是哪些？不拥有哪些能力？谁可能比你强非常多？如果他真的比你强的非常多，你用多长时间能够追上他，如果追不上他，这件事情你还做不做？首先你非常清醒的认知自己是谁，要做自己能做的事情。\r\n\r\n○ 第二，要有一个非常平稳的心态去做事情，有时候创业者对外做大量PR的时候，会说非常多假的数据，这有时也是必要的。但是，有些创业者说着说着自己都信了，这是非常大的问题。要对自己有非常清醒的认识，有非常平稳的心态，做事情很务实，对一个创业者来说是需要具备的素质。\r\n\r\n○ 第三，强大的目标感，目标不是说让你有多大动力做一件事情，而是告诉你要往哪走，很多创业者最大问题是干着干着不知道自己要去哪儿，然后开始乱走，越走越散，做出一堆业务，最后全死掉了。所谓愿景这个词非常非常虚，但是也非常重要，当一个人自己没有愿景时候，你根本不知道自己要去哪儿。\r\n\r\n创业是理性的职业选择，是对商业深刻理解后的厚积薄发，是自我进化的自然产物。所以，我有一个观点，任何创业的成功是必然的，这个观点有一点偏激，但是，我个人觉得也有一定的道理，到现在为止也没有见过任何偶然成功的人，任何创业成功真的是必然的，一定是大量积累到最后的结果，不可能是当中突然有一个什么偶然性的因素，然后使得你今天做到现在，不可能是这样。\r\n', '3', 'n170523030');
INSERT INTO `news_content` VALUES ('nc17052300138', '3', '◆ 创造可持续的商业模式\r\n\r\n创造可持续的商业模式，任何不盈利的公司，都不是可持续的，我分三个模块：\r\n\r\n第一，如何提出/构建商业模式；\r\n第二，如何验证商业模式？\r\n第三，实践商业模式。\r\n\r\n\r\n○ 一，提出/构建商业模式\r\n你是谁，比你打算怎么做更重要，上面已经提到。用户的内心不会接受一个“十全十美”的人，比如你男朋友或者女朋友是十全十美的人，站在你面前，会觉得好害怕，不知道他要干什么。我个人觉得今天也不可能出现一个APP能满足生活当中一切需求，所以，我们基本还是更加倾向在一个市场当中做的最专业的。比如必胜客，最近犯了非常重要的错误，他已经是中国披萨市场当中的老大，所以开始横向扩张，开始出现牛排、意面等等。有一次我跟我朋友去必胜客吃饭，吃完出来之后发现一个问题，我发现今天没有点匹萨，点了小吃拼盘，一人一个意面吃饱了，这就是一顿工作餐，但我们确实去匹萨店吃的，你们不觉得有问题吗？但如果我想吃好吃的牛排时，我会选择必胜客吗？可能会在街头巷尾某一个专业级牛排小店里找一个非常棒的师傅，他非常会烹制牛排，我会去找这样的店。匹萨也是，我会找做匹萨最好吃的品牌去吃，每个消费者都更倾向于找到最专业的人，而不是找到十全十美的人。\r\n\r\n不要试图构建商业闭环，我们参加各种路演时候，见过很多创业者阐述自己产品时候希望自己能做整个商业上的大闭环。假设今天有一个餐饮老板跟你说他想从种地这件事情开始干，大米自己种的，猪是自己养的，所有的原材料都是自己做的，到最后厨房自己的，服务自己的，外卖团队也是自己搭建的，觉得他能做成吗？太难了，这就是所谓商业大闭环，到今天为止，除了巨头有机会能够构建自己的商业闭环以外，大部分企业是不可能做到这点的。人类文明的出现是建立在不断的社会大分工基础之上，农业与畜牧业的分开，使得人类文明进步了一大块。\r\n\r\n构建付费模式，不要妄图改变交易规则。这个事情其实也是非常重要的创业原则，很多人都希望用户用我的服务都免费，然后我的服务是向其他人收费，用这种逻辑思考商业模式。但是，这个世界上最好的商业模式就是前项收费。什么叫前项收费，就是我这有一个东西，你需要，你拿走。前项收费有一个前提，是要建立在一个需求模型前提之下，也就是说假设今天我们所有人非常非常的渴，但是，我们是在一个水塘边上，你们就不需要我来卖水。但是，今天我们在一个大沙漠里，你们就需要我卖水。任何刚需都是建立在一套场景下。在你能够创造的场景下，最好的商业模式就是前项收费，你生产了什么卖什么，就这么简单。\r\n\r\n确定核心壁垒，这是投资人跟创业者沟通时候问的最多的问题。如果你的一个产品没有壁垒，那就说明你很容易被人超越，我不认为今天突然能够找到一个没有竞争对手的市场。高筑墙、广积粮，这是所有创业者内心口号，高筑墙是不断提高自己的壁垒，没有构建壁垒的能力，这个模式就不属于你。核心的壁垒需要有持续的迭代能力，首先，作为创始人来讲，必须有非常强的学习能力，如果没有很强的学习能力，不可能不断迭代自己的产品。另外一点，产品闭环，自己产品能够自己迭代，能够在创始人与机制共同作用下不断的演进才是非常好的产品。\r\n\r\n\r\n○ 二，验证商业模式\r\n验证商业模式，这是我验证我自己商业模式提出的问题，市场规模是否足够大？这句话说的再现实点，这个市场能不能养活你？是不是伪造需求？是刚需？还是非刚需？第三，你的竞争/潜在竞争对手是谁？有多少？如果说我今天想做搜索引擎，那就是不太可能的事情，当然，除非是能够找到搜索引擎新的痛点或者新的表达方式，但是，如果你用他原来的老路径打他，那不可能。\r\n\r\n\r\n○ 三，实践商业模式\r\n模式不能光靠想，还得去实践。首先，寻找团队，这个事特别重要，但是，有一点特别值得关注，在一个团队中拿主意的只有一个人，就是公司创始人，只有创始人能够决定这个企业当中一切的事情。昨天晚上我见了海底捞创始人张勇和施永宏，施永宏说搞定一个团队无非两件事情：\r\n第一，让他在你这干的很开心；\r\n第二，挣到足够的钱。\r\n但是，达到这两点非常不容易。\r\n\r\n\r\n互补比强强联合更重要，有时候一个团队中全是特别牛的人也有问题，大家互相打，自己做自己这摊事情。作为公司老板、创始人，我就不能特别细致的管某一个业务特别细的一件事情，即使你认为他是错的，你也不能直接管，一定通过相应的管道、通过机制解决问题。如果这个创始人天天处理非常鸡毛蒜皮的事情，这个企业一定发展不大。创始人必须是一切的核心。老板文化就是公司文化，尤其在公司早期的时候，公司的文化的确就是由老板个人建立起来的，随着团队不断扩大而不断演进，然后变成整个公司的文化。\r\n\r\n\r\n--------------------------------\r\n感谢您下载和使用大职门APP！\r\n\r\n如果您想分享职场经验，成为职场掌门人，\r\n请关注我们的\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n如果您有什么意见和建议，或是对课程学习有什么要求，也可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！\r\n', '4', 'n170523030');

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
INSERT INTO `orders` VALUES ('or17051000001', '2017-05-10 21:25:10', '0.10', '2', '4007892001201705100344389078', 'c17051000001', '0');
INSERT INTO `orders` VALUES ('or17051300003', '2017-05-13 16:10:24', '0.10', '2', '4009482001201705130683454737', 'c17051300006', '0');
INSERT INTO `orders` VALUES ('or17051300004', '2017-05-13 16:39:40', '1.00', '3', '2017051321001004040235315422', 'c17051300006', '0');
INSERT INTO `orders` VALUES ('or17051400006', '2017-05-14 08:35:13', '0.01', '1', null, 'c17051100002', '0');
INSERT INTO `orders` VALUES ('or17051400007', '2017-05-14 14:41:23', '0.01', '1', null, 'c17051100002', '0');
INSERT INTO `orders` VALUES ('or17051600105', '2017-05-16 13:51:52', '0.01', '2', '4006382001201705161065773597', 'c17051300007', '0');
INSERT INTO `orders` VALUES ('or17051600106', '2017-05-16 16:16:22', '0.01', '1', null, 'c17051600010', '0');
INSERT INTO `orders` VALUES ('or17051900337', '2017-05-19 12:56:51', '4.90', '2', '4007612001201705191518327287', 'c17051900016', '0');
INSERT INTO `orders` VALUES ('or17052100338', '2017-05-21 12:09:44', '2.90', '1', null, 'c17051100005', '0');
INSERT INTO `orders` VALUES ('or17052100339', '2017-05-21 17:57:15', '19.00', '1', null, 'c17051100005', '0');
INSERT INTO `orders` VALUES ('or17052200349', '2017-05-22 12:33:26', '2.90', '1', null, 'c17051100005', '0');
INSERT INTO `orders` VALUES ('or17052400384', '2017-05-24 09:34:07', '0.99', '1', null, 'c17051100005', '0');
INSERT INTO `orders` VALUES ('or17052400386', '2017-05-24 22:15:33', '49.00', '2', '4006222001201705242424318856', 'c17051100005', '0');
INSERT INTO `orders` VALUES ('or17052500387', '2017-05-25 05:20:35', '4.90', '1', null, 'c17051100005', '0');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `pid` varchar(12) NOT NULL COMMENT '主键。产品ID，生成规则：p+年+月+日+5位数字。例如：p17031200001',
  `pname` varchar(100) DEFAULT NULL COMMENT '产品名称',
  `type` varchar(1) DEFAULT NULL COMMENT '产品类型。1:技能包，2:经验包。',
  `price` decimal(15,2) unsigned DEFAULT NULL COMMENT '产品价格',
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
INSERT INTO `product` VALUES ('p17051000001', '学几招，让你的PPT更炫酷！', '1', '4.90', '0', '——简洁明快的PPT设计技能包！\r\n\r\n\r\n------------------\r\n如果您对课程学习有什么要求，可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', 'upload/product/p17051000001/p17051000001_listimg.jpg', '0', '99', 'u170510002', '1', '2017-05-10 20:47:30', '0', '2017-05-10 20:47:30', '3', '0');
INSERT INTO `product` VALUES ('p17051100002', '读名校MBA 实现职场进阶', '2', '29.90', '0', '由专注于MBA面试辅导的“方楠笔记”出品。\r\n\r\n课程涵盖从报名准备到面试、笔试及毕业后职业发展的全部内容。\r\n\r\n注：标示价格为整个经验包的价格。\r\n\r\n------------------\r\n\r\n读MBA有用吗？\r\n\r\n肯定有用，但收益大小因人而异。\r\n\r\n名校MBA品牌效应显著，投资收益率更高，考取难度也更大。\r\n\r\n如果可能，谁都愿意读名牌。\r\n\r\n你的条件够不够？\r\n\r\n如何客观分析自己？\r\n\r\n怎么选择学校？\r\n\r\n如何把握备考节奏？\r\n\r\n面试注意事项？\r\n\r\nMBA和职业规划如何结合？\r\n\r\n转型与进阶？\r\n\r\n……\r\n\r\n这个经验包都能给你答案。\r\n\r\nMBA备考经验包，\r\n\r\n由读过各大名校MBA的一众大咖倾情奉献。\r\n\r\n\r\n------------------\r\n如果您对课程学习有什么要求，可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', 'upload/product/p17051100002/p17051100002_listimg.jpg', '0', '1', 'u170510001', '1', '2017-05-11 10:57:35', '0', '2017-05-11 10:57:35', '1', '1');
INSERT INTO `product` VALUES ('p17051200004', '白话金融科技', '2', '49.00', '0', '本经验包将持续更新一年时间，每周更新 3 次，涵盖下列全部 14 个主题。\r\n\r\n注：所标价格为整个经验包的价格。\r\n\r\n-------------------\r\n\r\n互联网金融火爆时期，各路豪杰争相蹭热点。\r\n \r\n风云变幻，如今谈“互金”如同“谈虎”。\r\n \r\n取而代之的是“金融科技”。\r\n \r\n大职门APP整合金融科技领域资源，力邀多位业内资深人士组成“FinTech 小组”，潜心打造系列课：《白话金融科技》\r\n \r\n我们将用浅显易懂的语言，深入浅出地分享金融科技领域的知识和实践经验，帮您把握金融科技发展趋势，抓住金融科技领域的机会。\r\n \r\n《白话金融科技》分为基础篇和进阶篇两部分。\r\n \r\n第一年为基础篇，主要包含以下主题：\r\n1、网络借贷信息中介\r\n2、互联网消费金融\r\n3、征信\r\n4、互联网保险\r\n5、互联网众筹\r\n6、互联网支付\r\n7、区块链\r\n8、互联网证券销售\r\n9、电子货币\r\n10、智能投顾\r\n11、大数据与风控\r\n12、金融科技安全\r\n13、云计算、物联网与金融基础设施\r\n14、人工智能的未来\r\n \r\n跟我们一起走，你会受益无穷！\r\n\r\n------------------\r\n如果您对课程学习有什么要求，可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', 'upload/product/p17051200004/p17051200004_listimg.jpg', '1', '99', 'u170510001', '1', '2017-05-12 22:12:38', '0', '2017-05-12 22:12:38', '2', '1');
INSERT INTO `product` VALUES ('p17051300005', '帮你蹚平职场中的坑', '2', '19.00', '0', '本经验包每周更新两次课程，共更新52周。\r\n\r\n每次课程涉及一个主题，由职场“老炮儿”现身说法，分享职场中的实战经验。\r\n\r\n注意：所标示价格为整个经验包的价格。\r\n\r\n------------------\r\n\r\n职场是个江湖，远比你能想到的复杂。\r\n \r\n事是你做的，功是别人的？\r\n \r\n别人争斗，你是牺牲品？\r\n \r\n领导说要把公司当家，为什么做起来那么别扭？\r\n \r\n有话直说，够坦荡，依然逃不过遭人暗算？\r\n \r\n你是学霸，偏偏职场无法称霸？\r\n \r\n公司挺好的，就是上司要搞你？\r\n \r\n机会挺好，空降兵怎么那么难存活？\r\n \r\n……\r\n \r\n职场江湖，到处是坑！\r\n \r\n早日掌握应对之法，早日走上康庄大道！\r\n \r\n大职门APP邀请不同行业的企业高管，那些无论好事坏事，反正“吃过见过”的人们，组成“职场老炮儿小组”，并联袂打造经验包《帮你蹚平职场中的坑》。\r\n \r\n该经验包几乎覆盖职场中可能遇到的所有的坑，“老炮儿”们将携手助你职场腾飞。\r\n\r\n\r\n------------------\r\n如果您对课程学习有什么要求，可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', 'upload/product/p17051300005/p17051300005_listimg.jpg', '1', '99', 'u170513027', '1', '2017-05-13 22:21:02', '0', '2017-05-13 22:21:02', '1', '0');
INSERT INTO `product` VALUES ('p17051400007', '微信小程序详解', '1', '29.90', '1', '微信小程序是怎么一回事。\r\n\r\n\r\n------------------\r\n如果您对课程学习有什么要求，可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', 'upload/product/p17051400007/p17051400007_listimg.png', '0', '99', 'u170510001', '1', '2017-05-14 13:51:43', '0', '2017-05-14 13:51:43', '3', '0');
INSERT INTO `product` VALUES ('p17051400008', '淘宝开店之入门秘籍', '2', '2.90', '0', '本讲由开心淘母婴坊运营者分享。\r\n开心淘母婴坊历经3年时间，从零做到2个蓝皇冠等级。店主小文在这个过程中积累了大量的开店和运营经验，熟练的掌握了一套有效促进商品出售的技巧。\r\n如果你也想开店，或正发愁自己的店铺为什么不卖货，那就快来听听她的经验分享，看看对你有没有帮助。\r\n\r\n\r\n------------------\r\n如果您对课程学习有什么要求，可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', 'upload/product/p17051400008/p17051400008_listimg.png', '0', '99', 'u170514029', '1', '2017-05-14 16:23:34', '0', '2017-05-14 16:23:34', '1', '0');
INSERT INTO `product` VALUES ('p17051700009', '明知山有虎，偏走创业路！', '2', '19.00', '0', '本创业经验包，由投资人、创业家、企业高管联合贡献。\r\n\r\n内容涵盖了股权设计、团队组建、商业计划书、估值、商业模式梳理、创业方向分析、创业经历分享等内容，每周更新一次，52次课为一个完整的经验包。\r\n\r\n注：所标示价格为整个经验包的价格。\r\n\r\n------------------\r\n\r\n创业大潮下，不创业会感觉少点什么。\r\n\r\n有人一时兴起，就想随便玩玩。\r\n\r\n创业终究是一件严肃的事情，你需要做好十足的准备。\r\n\r\n什么样的人适合创业？\r\n\r\n如何选择创业方向？\r\n\r\n核心团队怎么组建？\r\n\r\n懂股权设计吗？\r\n\r\n会写商业计划书吗？\r\n\r\n……\r\n\r\n上路之前，你得向过来人取取经。\r\n\r\n\r\n------------------\r\n如果您对课程学习有什么要求，可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', 'upload/product/p17051700009/p17051700009_listimg.jpg', '1', '99', 'u170510001', '3', '2017-05-17 20:52:13', '0', '2017-05-17 20:52:13', '0', '0');
INSERT INTO `product` VALUES ('p17052100011', '创业路上坑很多，要不要去创业？', '2', '2.90', '0', '创业路上很多坑，你要不要去创业？\r\n \r\n创业大潮下，很多人都觉得，不创业会少点什么。\r\n \r\n有人一时兴起，就想随便玩玩。有人心怀壮志，追求个人价值。\r\n \r\n创业终究是一件严肃的事情，一旦上路，你会发现，有很多问题是以前想都没想过的。\r\n \r\n因此，上路前，一定要听听过来人的意见。\r\n \r\n本讲是由为润资本创始合伙人姚鑫为大家分享。\r\n \r\n姚鑫简介：\r\n职业生涯品牌教练，优势教练，为润资本创始合伙人，毕业于清华大学经管学院，主要研究创业管理，中小企业成长。曾于外资500强，民营上市公司，大型国企。\r\n擅长资本运作、企业商业模式架构、中小企业研究。\r\n主持过多个企业的并购交易。拥有丰富的股权和债权投资经验。\r\n\r\n------------------\r\n如果您对课程学习有什么要求，可以通过\r\n微信公众号：大职门（ID：dazhimen）、\r\n微博：@大职门 ，给我们留言。\r\n\r\n我们会根据您的意见及时改进，为您提供更优质的产品和服务！', 'upload/product/p17052100011/p17052100011_listimg.jpg', '0', '99', 'u170510011', '1', '2017-05-21 10:47:26', '0', '2017-05-21 10:47:26', '1', '0');
INSERT INTO `product` VALUES ('p17052400012', '怎样做职业选择才能事半功倍？', '2', '0.99', '0', '——乐宝教育河北分公司总经理卫琛，告诉你得这样做。', 'upload/product/p17052400012/p17052400012_listimg.jpg', '0', '99', 'u170510014', '1', '2017-05-24 08:27:17', '0', '2017-05-24 08:27:17', '1', '0');
INSERT INTO `product` VALUES ('p17052400013', '供应链融资那些事儿', '2', '4.90', '0', '听融银资本创始发起人李彬，说供应链融资那些事儿。', 'upload/product/p17052400013/p17052400013_listimg.jpg', '0', '99', 'u170510010', '1', '2017-05-24 23:05:47', '0', '2017-05-24 23:05:47', '1', '0');

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
INSERT INTO `product_image` VALUES ('p17051000001_1', 'upload/product/p17051000001/p17051000001_mainimg_1.jpg', 'p17051000001');
INSERT INTO `product_image` VALUES ('p17051100002_1', 'upload/product/p17051100002/p17051100002_mainimg_1.jpg', 'p17051100002');
INSERT INTO `product_image` VALUES ('p17051200004_1', 'upload/product/p17051200004/p17051200004_mainimg_1.jpg', 'p17051200004');
INSERT INTO `product_image` VALUES ('p17051300005_1', 'upload/product/p17051300005/p17051300005_mainimg_1.jpg', 'p17051300005');
INSERT INTO `product_image` VALUES ('p17051400007_1', 'upload/product/p17051400007/p17051400007_mainimg_1.png', 'p17051400007');
INSERT INTO `product_image` VALUES ('p17051400008_1', 'upload/product/p17051400008/p17051400008_mainimg_1.png', 'p17051400008');
INSERT INTO `product_image` VALUES ('p17051700009_1', 'upload/product/p17051700009/p17051700009_mainimg_1.jpg', 'p17051700009');
INSERT INTO `product_image` VALUES ('p17052100011_1', 'upload/product/p17052100011/p17052100011_mainimg_1.jpg', 'p17052100011');
INSERT INTO `product_image` VALUES ('p17052400012_1', 'upload/product/p17052400012/p17052400012_mainimg_1.jpg', 'p17052400012');
INSERT INTO `product_image` VALUES ('p17052400013_1', 'upload/product/p17052400013/p17052400013_mainimg_1.jpg', 'p17052400013');

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
INSERT INTO `recharge` VALUES ('r17051100001', '0.01', 'c17051000001', '3', '2017051121001004800237596656', '2017-05-11 13:25:20', '0');
INSERT INTO `recharge` VALUES ('r17051100002', '0.01', 'c17051000001', '2', '4007892001201705110455556536', '2017-05-11 20:14:39', '0');
INSERT INTO `recharge` VALUES ('r17051300007', '1.00', 'c17051300006', '2', '4009482001201705130681803784', '2017-05-13 16:08:53', '0');
INSERT INTO `recharge` VALUES ('r17051300008', '0.10', 'c17051300007', '2', '4006382001201705130691201159', '2017-05-13 17:08:38', '0');
INSERT INTO `recharge` VALUES ('r17051300009', '0.01', 'c17051000001', '2', '4007892001201705130717433715', '2017-05-13 20:16:48', '0');
INSERT INTO `recharge` VALUES ('r17051400011', '0.01', 'c17051100002', '2', '4007892001201705140762428690', '2017-05-14 08:34:44', '0');
INSERT INTO `recharge` VALUES ('r17051400012', '0.01', 'c17051100002', '2', '4007892001201705140801193007', '2017-05-14 13:53:56', '0');
INSERT INTO `recharge` VALUES ('r17051400013', '0.01', 'c17051100002', '2', '4007892001201705140798028129', '2017-05-14 14:00:45', '0');
INSERT INTO `recharge` VALUES ('r17051400014', '50.00', 'c17051100005', '2', '4006222001201705140812389017', '2017-05-14 15:10:09', '0');
INSERT INTO `recharge` VALUES ('r17051600017', '10.00', 'c17051600010', '3', '2017051621001004220234504413', '2017-05-16 16:15:36', '0');
INSERT INTO `recharge` VALUES ('r17051700020', '0.01', 'c17051100002', '2', '4007892001201705171222751483', '2017-05-17 13:30:38', '0');
INSERT INTO `recharge` VALUES ('r17051700027', '0.01', 'c17051100002', '2', '4007892001201705171272602050', '2017-05-17 19:52:19', '0');

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
INSERT INTO `role` VALUES ('r170510001', '产品管理1', '上传课程——经验包、技能包。', '1');
INSERT INTO `role` VALUES ('r170511002', '掌门管理1', '', '1');

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
INSERT INTO `sequence` VALUES ('course_seq', '37', '1', '100000');
INSERT INTO `sequence` VALUES ('customer_seq', '19', '1', '100000');
INSERT INTO `sequence` VALUES ('news_content_seq', '138', '1', '100000');
INSERT INTO `sequence` VALUES ('news_seq', '30', '1', '1000');
INSERT INTO `sequence` VALUES ('order_seq', '387', '1', '100000');
INSERT INTO `sequence` VALUES ('product_seq', '13', '1', '100000');
INSERT INTO `sequence` VALUES ('recharge_seq', '32', '1', '100000');
INSERT INTO `sequence` VALUES ('role_seq', '2', '1', '1000');
INSERT INTO `sequence` VALUES ('user_seq', '30', '1', '1000');
INSERT INTO `sequence` VALUES ('verifycode_seq', '51', '1', '100000');

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
  `name` varchar(100) DEFAULT NULL COMMENT '用户姓名',
  `mphone` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `password` varchar(50) DEFAULT NULL COMMENT '密码，密文存储。加密规则为：md5(uid+明文password)',
  `gender` varchar(1) DEFAULT NULL COMMENT '性别。1:男，2:女',
  `type` varchar(1) DEFAULT NULL COMMENT '人员类型。1:掌门，2:管理员。',
  `loginname` varchar(100) DEFAULT NULL COMMENT '登录系统时的账户名称',
  `remarks` varchar(500) DEFAULT NULL COMMENT '备注信息',
  `isdel` varchar(1) DEFAULT '0' COMMENT '用户是否为已删除状态。1:已删除，0:正常状态。',
  `createdate` datetime DEFAULT NULL COMMENT '用户创建时间',
  `identity` varchar(100) DEFAULT NULL COMMENT '如果是掌门时，用于存储掌门的身份信息',
  `introduction` varchar(3000) DEFAULT NULL COMMENT '掌门的介绍信息',
  `headerimg` varchar(500) DEFAULT NULL COMMENT '掌门头像的存储地址',
  `indexsort` varchar(2) DEFAULT '99' COMMENT '掌门的首页排序',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `index_loginname` (`loginname`) USING BTREE COMMENT '登录名唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台用户信息表。注意，type字段用于区分 当前用户是掌门还是管理员。';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('u170428042', '管理员', '18756412356', 'd34d3f817d152159bc0cbbdc6a2c642c', '1', '2', 'admin', '', '0', '2017-04-28 16:48:06', null, null, null, '99');
INSERT INTO `user` VALUES ('u170503048', 'test', null, '5a105e8b9d40e1329780d62ea2265d8a', '1', '1', null, null, '1', '2017-05-03 10:56:55', '1', '', 'upload/master/u170503048/u170503048.png', '99');
INSERT INTO `user` VALUES ('u170503049', 'test', null, '5a105e8b9d40e1329780d62ea2265d8a', '1', '1', null, null, '1', '2017-05-03 10:57:45', '1', '', 'upload/master/u170503049/u170503049.png', '99');
INSERT INTO `user` VALUES ('u170503050', 'test', null, '5a105e8b9d40e1329780d62ea2265d8a', '1', '2', null, '', '1', '2017-05-03 10:58:42', null, null, null, '99');
INSERT INTO `user` VALUES ('u170510001', 'FinTech小组', '18547891234', '986b1f187de593ee41ab8a2f7b06d7e8', '1', '1', 'dzm', null, '0', '2017-05-10 18:39:01', '掌门人', '大职门，职场经验与技能分享平台，智慧人口红利下的分享经济模式。 \r\n\r\n在职场某一领域具有丰富积累的人都算智慧人口，在大职门，我们将智慧人口统称为职场掌门，他们的经验和技能可以帮助很多人。\r\n\r\n大职门是职场掌门分享经验与技能的平台，通过释放智慧人口红利，帮助掌门获得额外的变现机会。 \r\n大职门也是学习者快速提升自己，获取职场突破的渠道。出于对劳动者尊重，学习者需要向职场掌门支付小额费用。 \r\n\r\n大职门希望每位职场掌门的经验都能惠及更多人，帮助更多人成长，从而实现自己的职业理想。', 'upload/master/u170510001/u170510001.png', '99');
INSERT INTO `user` VALUES ('u170510002', '掌门1', null, 'afd9e9d86dd62755cb8ffa442b78bad8', '1', '1', null, null, '1', '2017-05-10 20:36:18', '掌门11', '掌门1test', 'upload/master/u170510002/u170510002.jpg', '99');
INSERT INTO `user` VALUES ('u170510003', '赵英著', '13000000000', '13d64751f54aff9573dbdabec110ae6c', '1', '1', 'zhaoyingzhu', null, '0', '2017-05-10 20:59:55', '曾任一家央企CEO三年以上。', '现任浙江大学特聘领导力讲师、广东财经大学创业导师、南海公学（商学院）特聘教师、中国村东升科技园创业导师、高管教练；\r\n\r\n中国人民大学文学学士；\r\n清华大学工商管理硕士；\r\n\r\n具有十年企业基、中、高层从业经验（生产+营销），曾任一家央企CEO三年以上。\r\n\r\n赵英著在十几年的工作历程中，从基层奋斗到央企高管，期间不忘提升自己的理论水平，完成了由理论到实践，再由实践到理论的循环。在这个过程中，他在领导力开发、团队建设、创新能力培养和商业模式变革四大领域里，积累了丰富的工作经验。\r\n\r\n他进入培训行业后，大展身手，取得了累累硕果：他获比亚迪汽车集团荣誉讲师、2015年全国百强讲师、全国职业资格高级培训师、《4D卓越团队》认证讲师、《领越领导力》认证讲师、《创新设计思维》认证讲师等荣誉，曾担任海尔集团690计划培训师、中国航天空间创客计划培训师、招商银行金鹰计划培训师、建设银行雏鹰计划培训师，主讲过海尔集团“高情商组织培养实战”、国家电网“创新变革环境下的团队领导力”、比亚迪汽车“卓越销售团队建设”等课程。\r\n\r\n他的授课风格富有激情、激励人心；案例研讨、专业到位；互动教学、以学员为中心；解决问题、现场输出成果。他今后将在大职门分享更多有价值的课程。', 'upload/master/u170510003/u170510003.jpg', '99');
INSERT INTO `user` VALUES ('u170510004', '吴学军', '13000000000', '749aba980ce2a6087d1ec3f03487a44a', '1', '1', 'wuxuejun', null, '0', '2017-05-10 21:39:49', '超过十年技术开发、产品运营和企业管理经验。', '北京智网易联科技有限公司CEO、创始人；\r\n\r\n百米打车副总裁、联合创始人；\r\n\r\nJuniper Networks 中国研发中心部门经理；\r\n\r\n清华大学工商管理硕士，计算机专业硕士；\r\n\r\n超过十年技术开发、产品运营和企业管理经验，近十年的互联网及网络安全经验，曾在世界500强企业担任重要技术管理工作并拥有两项美国专利。\r\n\r\n码易（mayigeek.com）是北京智网易联科技有限公司旗下的高质量软件交付服务平台。为需求客户提供高质量的软件产品研发、软件技术孵化、软件运营及推广服务，为专业软件交付团队和个人开发者提供任务众包、项目管理、人才招募、技术指导、互动社区等丰富的经营、工作和交流服务。\r\n\r\n依托于强大的自有团队和平台上汇集的数万名互联网软件开发者、数百个专业软件交付团队，已为包括世界/中国500强、政府/事业机构和优秀创业企业在内的数百家客户完成了数百款产品的高质量交付。', 'upload/master/u170510004/u170510004.jpg', '99');
INSERT INTO `user` VALUES ('u170510005', '丁润强', '13000000000', '00b7accd0b093b0bcab0fda89b3ea030', '1', '1', 'dingrunqiang', null, '0', '2017-05-10 21:44:24', '具有丰富的创业经验和企业管理经验。', '丁小小教育创始人&CEO，致力于为自己的女儿和全天下的孩子提供最好的教育。\r\n\r\n清华大学-MIT国际工商管理硕士，律师。\r\n\r\n曾任启迪教育集团总裁，并购过巨人教育集团，创办过上下电商、租车宝。\r\n\r\n现兼任启迪金服投资总监，清华MBA校友导师。\r\n\r\n丁小小公司是由启迪教育集团前总裁丁润强与6岁的女儿共同创办，于2015年1月设立于清华科技园，并获得水木清华校友种子基金的天使投资。 丁小小喜欢画画，有着丰富的想象力和创造力，她给爸爸起了个一个名字叫“丁小小大力士爸爸”，她画了一条鱼龙送给爸爸妈妈，并且希望爸爸妈妈能像鱼龙那样，总是给她甜蜜的微笑，这条鱼龙也就成为了丁小小公司的标志。丁小小公司的使命是成为甜蜜家庭亲子关系的小使者，通过个性礼物传达与分享喜悦，拉近心与心的距离。\r\n\r\n丁润强有着丰富的创业经验和企业管理经验，而且精通法律，并担任过多家公司的法律顾问。他将会在大职门分享自己多年来的创业经验，期望帮助后来者更好地绕过创业路上的那些坑。另外，在企业管理和投融资方面，他同样可以贡献很多有价值的经验。', 'upload/master/u170510005/u170510005.jpg', '99');
INSERT INTO `user` VALUES ('u170510006', '马兆辉', '13000000000', 'd19c45d768252e15b43f51ff366da88a', '1', '1', 'mazhaohui', null, '0', '2017-05-10 21:49:46', '在地产、金融等领域工作经验丰富。', '现任河北国大集团金融事业部副总经理、基金公司总经理；\r\n\r\n对外经济贸易大学金融专业硕士研究生；\r\n\r\n曾任北京中能联合物资公司副总经理、财务总监；\r\n天山地产集团金融事业部融资副总经理；\r\n河北安联地产集团资本总监、基金公司总经理等职务。\r\n\r\n马兆辉在地产、金融等领域工作经验丰富，而且职业生涯经历过多次成功转型，他将在大职门分享地产、金融行业的职场发展经验，希望能帮助同学们做好职业生涯规划，实现职业目标。\r\n\r\n国大集团有限责任公司成立于1997年3月，是经石家庄市国有资产管理委员会批准的国有资产授权经营公司，目前已发展成为集酒店经营、房地产、食品、商贸业于一体的企业集团公司。曾跻身于“中国500家商业综合服务大型企业”、“市商贸系统利税大户”行列，连续五年被市委、市政府授予“商贸系统最佳综合效益企业”称号，连续叁年被省工商局授予省级“重合同、守信用单位”称号，并被授予“省企业管理先进单位”、“河北省优秀企业金马奖”、“市推行现代营销方式先进单位”、“企业改革与管理创新奖”, 先后荣誉全国五一劳动奖状、河北省、石家庄市文明单位、石家庄市党建工作十面红旗等荣誉称号。', 'upload/master/u170510006/u170510006.png', '2');
INSERT INTO `user` VALUES ('u170510007', '荆晋南', '13000000000', 'ae1472660fe0fe41af5b6944e62b726e', '1', '1', 'jingjinnan', null, '0', '2017-05-10 21:54:16', '国家级高新技术企业 - 极欧科技股份有限公司董事会秘书', '曾服务于大型国企 - 国机汽车股份有限公司，任投资业务主任。\r\n\r\n北京航空航天大学工学学士；\r\n清华大学与MIT Sloan管理学硕士。\r\n\r\n现任国家级高新技术企业 - 极欧科技股份有限公司董事会秘书。\r\n\r\n他放弃了国有企业稳定轻松的工作模式，选择了朝气蓬勃的高新技术企业，这代表了互联网+时代一部分青年才俊的价值选择。荆晋南愿意将自己多年来积累的职场经验以及从国企转向民企的心路历程分享给大家。\r\n\r\n极欧科技股份有限公司，成立于2012年，为国家级高新技术企业，公司研发人员占比60%。\r\n\r\n极欧科技旗下极盟平台目前已完成自媒体产业生态运营的众多布局，包括为中国100万家广告公司免费赋能的人工智能自媒体投放交易平台系统，和正在研发的针对全球1000万自媒体人运营使用的人工智能机器写作工具，从而形成了领先行业的“数据＋工具＋人工智能＋自媒体资源”的四大核心能力和商业战略的能力支撑。\r\n\r\n未来，极欧科技将不断围绕自媒体产业进行生态布局，不断将“数据＋工具＋人工智能”的技术力与面向未来的商业战略能力相结合，为全球自媒体人提供更有商业价值的产品、服务和变现能力，并以自媒体产业生态为原点，在广告、微商、在线教育和金融等延伸生态中，形成全方面的生态整合和产业壁垒。', 'upload/master/u170510007/u170510007.jpg', '99');
INSERT INTO `user` VALUES ('u170510008', '雷俊', '13000000000', '4e626c9e1712ba2c6544fc527901667e', '1', '1', 'leijun', null, '0', '2017-05-10 22:02:50', '具有计算机技术背景，也拥有丰富的金融行业工作经验', '现任国新基金投资总监，专注于一级市场投资。在一级半市场投资（定向增发业务）及二级市场投资领域也具有丰富的经验。\r\n\r\n上海交通大学电子工程系学士，计算机系硕士；\r\n清华大学国际MBA。\r\n\r\n曾就职于银河投资和赛门铁克公司，完成了从软件开发工程师到金融行业的转型。\r\n\r\n他在从工程师到机构投资者的发展转变过程中积累了丰富的经验，他希望将科技、金融及管理相结合，形成适应新时代要求的全新投资理念，并助力科技创新企业插上腾飞的翅膀。\r\n\r\n国新基金管理有限公司是经中国国资委批准设立的私募股权投资基金管理公司，总部位于北京。国新基金目前旗下管理基金有国新科创股权投资基金（有限合伙）一期，风险投资基金、核技术专项基金、并购基金、固定收益类基金等正在筹建中。\r\n\r\n雷俊具有计算机技术背景，也拥有丰富的金融行业工作经验，他在把控当前金融科技发展趋势方面有独到优势。他愿意将自己的转型经历和职场经验分享给大家，也愿意将自己对金融科技的独特理解贡献出来。', 'upload/master/u170510008/u170510008.png', '99');
INSERT INTO `user` VALUES ('u170510009', '刘暐', '13000000000', 'a88eb5d31ca166b391f20f874e13ba91', '1', '1', 'liuwei', null, '0', '2017-05-10 22:07:26', '苹果公司北京三里屯Apple Store高级经理', '毕业于浙江大学电子信息工程专业，清华大学国际MBA。\r\n\r\n2005年至2010年，曾就职于中国空间技术研究院，北京握奇数据系统有限公司，负责无线产品开发和早起移动支付方案探索研究。\r\n\r\n2012年至2015年就职于沃尔玛中国股份有限公司，主导供应链，采购和O2O业务流程优化及IT系统开发。\r\n\r\n2015年至今，任苹果公司北京三里屯Apple Store高级经理。\r\n\r\n从工程师到管理者，他希望在Apple继续探索如何将零售业，科技以及人文相结合，打造无与伦比的顾客体验和运营体系。\r\n\r\n关于苹果公司，无需再多介绍。刘暐的经历很有借鉴意义，从技术到管理，他完成了职业生涯的华丽转身。\r\n\r\n在接下来的日子里，刘暐会将自己转型过程中的心得体会分享给大家。我们也将有机会更进一步了解，在沃尔玛和苹果公司工作是一种怎样的体验，这两家公司的文化和管理体系又有什么样的差别。\r\n\r\n对于同样技术出身，但依然未找到职业锚的同学来说，可以从刘暐的经历中学到很多东西。', 'upload/master/u170510009/u170510009.jpg', '99');
INSERT INTO `user` VALUES ('u170510010', '李彬', '13000000000', '689357b21e6273bab509073f0757c11f', '1', '1', 'libin', null, '0', '2017-05-10 22:15:43', '具有20多年的银行与金融业从业经验。', '融银资本创始发起人；\r\n\r\n曾任中国银行某分行行长。\r\n\r\n具有20多年的银行与金融业从业经验，对公司信贷、财务管理、会计核算及贸易、投融资管理、地产金融、商业保理、融资租赁、基金及保险等领域均非常熟悉。\r\n\r\n李彬的经验主要集中于金融行业，他将在大职门分享自己从业20多年来的经验，以期能帮助更多后来者。', 'upload/master/u170510010/u170510010.jpg', '99');
INSERT INTO `user` VALUES ('u170510011', '姚鑫', '13000000000', '8e1db7f85c9a89265f65d9aed7232a9f', '1', '1', 'yaoxin', null, '0', '2017-05-10 22:18:08', '专注于股权投资和创业辅导。', '现任为润资本创始合伙人，擅长资本运作，拥有丰富的股权和债权投资经验。\r\n\r\n毕业于清华大学经济管理学院，工商管理硕士。\r\n\r\n职业生涯品牌教练，优势教练，主要研究创业管理，企业商业模式构架研究及中小企业成长。\r\n\r\n他具有丰富的职场经验，曾任职于三星电子、河北建投等外资500强和大型国有企业。\r\n\r\n姚鑫既有丰富的职场经验，又有创业经验，当前专注于股权投资和创业辅导。他将会在大职门分享创业和股权投资的经验和技巧。', 'upload/master/u170510011/u170510011.jpg', '99');
INSERT INTO `user` VALUES ('u170510012', '唐海川', '13000000000', 'cf3ecba36f9b60614ea0686c0e7e63d1', '1', '1', 'tanghaichuan', null, '0', '2017-05-10 22:20:46', '拥有丰富的项目运营经验和品牌公关经验。', '现任太美了网CEO、创始人，专注于医美行业的互联网化整合。\r\n\r\n历任海航集团市场部总监、\r\n星美集团整合营销部总监，\r\n上海方泽金融首席营销官，\r\n并担任过多家互联网公司市场部顾问。\r\n\r\n毕业于外经济贸易大学；\r\n\r\n他拥有丰富的项目运营经验和品牌公关经验，对新媒体、新技术、新环境下的互联网行业有自己独到的见解。\r\n\r\n唐海川有着丰富的企业管理经验，尤其是营销经验，他将在大职门分享自己多年来的营销管理心得，以及专业的互联网营销策略。\r\n\r\n太美了网（www.taimeile.com）隶属于太美东方（北京）信息技术有限公司，这是一家年轻的行业垂直互联网信息平台和移动新媒体技术服务公司，基于类似O2O的基础运营模式，重点关注大健康、年轻化等相关领域，旨在建立行业公正、透明的信息交流与分享机制，创造一个真实、可信的行业价值生态，为机构用户和终端会员不断提供创新的增值服务。\r\n\r\n太美东方首先将为众多爱美人士提供一个查询、分享和交流的空间，然而有别于传统的行业平台或社交媒体，太美东方相信获取真实、公正的信息可以帮助爱美人士少走弯路，甚至于避免上当受骗，为此，太美东方不愿意为了获得所谓佣金而放弃自己的中立性和独立性，而是坚持走开放平台的路线。另一方面，显而易见，大健康、年轻化等相关领域必将引领中国未来黄金增长新的10年，太美东方更进一步着眼于大健康、年轻化的产业生态发展，追随人们对自身健康和生活品质越来越高的需求，通过多元化整合“互联网+”的价值创造过程，为广大爱美人士和医疗健康专业人士提供更加灵活多样和高品质的选择，进而实现平台生态的可持续发展目标。', 'upload/master/u170510012/u170510012.jpg', '1');
INSERT INTO `user` VALUES ('u170510013', '崔基哲', '13000000000', '6180fa5588d73f22f8d2fda7bd10d3da', '1', '1', 'cuijizhe', null, '0', '2017-05-10 22:24:00', '专注于人力资源体系研究、企业员工软实力培训、员工职业化理念提升、职场发展规划等领域，具有丰富的经验。', '现任北京优仕汇人力资源有限公司研发总监，负责培训体系研发工作。\r\n\r\n历任三星中国总部市场部经理、\r\n北京大学社会责任研究所副所长等职；\r\n\r\n1992年毕业于清华大学土木工程系；\r\n\r\n著有《解开洛克菲勒难题》、《黄金思维决定成功》、《黄金思维软实力》等书；\r\n\r\n崔基哲多年来专注于人力资源体系研究、企业员工软实力培训、员工职业化理念提升、职场发展规划等领域，合作过不同行业的企业，积累了丰富的经验。\r\n\r\n崔基哲乐意将自己多年来的研究成果和经验总结分享给遇到职场困惑的人们。', 'upload/master/u170510013/u170510013.jpg', '99');
INSERT INTO `user` VALUES ('u170510014', '卫琛', '13000000000', 'f1e5aa7fd3a3848057d2c4a45dbd1832', '1', '1', 'weichen', null, '0', '2017-05-10 22:39:29', '具有丰富的销售和团队领导经验。', '现为乐宝教育河北分公司总经理；\r\n\r\n本科毕业于吉林大学计算机专业；\r\n\r\n兼任河北省社区教育培训协会学前教育分会理事。\r\n \r\n进入大学后，卫琛发现自己并不喜欢所选的计算机专业，因此他把时间更多的花在了其他领域，加上其鲜明的性格特点，毕业后他并未像其他同学一样走上技术岗位，而是选择了一个公司最最屌丝、最历练人的岗位—销售。十几年来，他从事过医疗、广告、地产、教育等行业，积累了丰富的销售和带团队经验，也对多个行业有独到和深刻的见解。在从“小弟”到“大哥”再到“扛把子”的蜕变过程中，他内心也曾饱受煎熬，心路历程颇有启发意义。“一个公司，收入最低的员工是销售；收入最高的员工也是销售。销售，是一个人人都能入门的岗位；销售，又是一个很难入门的岗位。”这是他带团队时最常挂在嘴边的一句话。\r\n\r\n对于很多职场人士来说，在发展中少不了困惑，比如：“从业几年的我，现在还是专员，为什么升不到主管、经理甚至总监？” “为何一同起步的同事早已将我远远抛在了身后？” “为何蜕变的“馅饼”没有砸到我的脑袋？”等等，类似这些问题，卫琛将会在大职门进行分享。', 'upload/master/u170510014/u170510014.jpg', '99');
INSERT INTO `user` VALUES ('u170510015', '张君谨', '13000000000', 'dbd92ec79bc5213460f671d5e8caf85c', '1', '1', 'zhangjunjin', null, '0', '2017-05-10 22:43:39', '一直在资本领域深耕细作，帮助多个项目实现新三板上市。', '现任考拉基金投资副总裁；\r\n\r\n本科毕业于天津大学，\r\n硕士毕业于清华大学；\r\n\r\n曾创办呆毛直播，成功获得风险投资，在二次元细分领域取得领先地位，还获得央视报道。\r\n\r\n曾就职于芳晟创投、君联资本、中科招商和汤森路透等知名企业。\r\n\r\n张君谨一直在资本领域深耕细作，最初负责股票交易所得数据移植和开发工作，后来在一级市场投资领域摸爬滚打4年多，帮助多个项目实现新三板上市，现在专注于互联网金融、汽车金融、服务升级以及文娱等行业的早期投资。他还曾亲历创业，成功创办呆毛直播。\r\n\r\n通过十几年的工作经历，张君谨对创业和创投市场都非常熟悉。他愿意将自己的创业和投资经验分享给大职门平台上的所有用户。', 'upload/master/u170510015/u170510015.jpg', '99');
INSERT INTO `user` VALUES ('u170510016', '杨冰', '13300000000', '133e659d2fddaa2fa9f27012077e8286', '1', '1', 'yangbing', null, '0', '2017-05-10 22:46:15', '在大数据开发与服务领域颇有丰富的积累，并有丰富的国际贸易和投资经验。', '现任北京易智通科技公司董事长，专注于大数据开发与服务；\r\n\r\n兼任南非-中国经济贸易促进委员会执行副主席；\r\n国际狮子会北京清听队创队队员。\r\n\r\n本科毕业于河北工业大学，\r\n研究生毕业于清华大学。\r\n\r\n杨冰对高科技行业非常了解，一直紧随移动互联网发展的浪潮，他的公司在大数据开发与服务领域颇有积累，可服务于很多有需求的机构。\r\n\r\n同时，作为南非与中国经济贸易促进委员会执行副主席，他在促进中国和南非，甚至和其它国家的对外贸易方面颇有建树，积累了丰富的国际贸易和投资经验。在大职门，他会将自己的国内外经验总结出来，分享给后来者，以帮助更多人取得成功。', 'upload/master/u170510016/u170510016.jpg', '99');
INSERT INTO `user` VALUES ('u170510017', '白津', '13000000000', 'e6ce86acd60efe98904fc461284a7412', '1', '1', 'baijin', null, '0', '2017-05-10 22:52:37', '中信产业基金高级投资经理，负责PE私募股权投资。', '现任中信产业基金高级投资经理，负责PE私募股权投资；\r\n\r\n北京化工大学化学专业学士、自动化专业硕士；\r\n清华大学工商管理硕士；\r\n\r\n曾在霍尼韦尔国际做工业自动化工程项目管理的项目经理。\r\n\r\n白津的求学经历涉及三个不同专业，代表着他对自己职业发展道路的选择变迁。有了目标就去追求，勇敢实践，亲自去验证自己的选择是否合理。在求学和职业转型的历程中，他找到了自己真正感兴趣并愿意为之长久奋斗的职业方向，他的经历很典型，总结出来的经验和教训也有足够的借鉴意义。\r\n\r\n重要的是，他愿意将自己的经验和教训分享出来，以期帮助后来者少走弯路，早日步入职业发展的正轨。', 'upload/master/u170510017/u170510017.jpg', '99');
INSERT INTO `user` VALUES ('u170510018', '张道全', '13000000000', '1b094350e28d663dc86a8c8cdc36a2db', '1', '1', 'zhangdaoquan', null, '0', '2017-05-10 22:55:21', '一直从事IT领域工作，技术功底扎实，同时对金融投资有深入研究。', '现为自由职业投资人，专注于美股、期权投资；\r\n\r\n1999年毕业于北京科技大学；\r\n\r\n曾任职IBM、中联等公司，由工程师做到技术管理岗位。\r\n\r\n他毕业后一直从事IT领域工作，技术功底扎实，同时对金融投资有深入研究，在做到IBM部门经理职位后决定改变自己的生活方式，转而进入自由职业投资领域，对美股、期权的投资颇有心得。\r\n\r\n在这个个体崛起的时代，人对组织的依赖在逐步消除，越来越多的人开始利用自己的强大能力和丰富的专业知识独立于组织之外，他们追求自由，也获得了丰厚的物质回报。当然，做职业选择的过程更具有借鉴意义，他将会在大职门分享自己做投资的经历和如何进行职业选择的思考过程。', 'upload/master/u170510018/u170510018.jpg', '99');
INSERT INTO `user` VALUES ('u170510019', '胡亮', '13000000000', '4a76c1fdf568cb77a8189f2b00afb51d', '1', '1', 'huliang', null, '0', '2017-05-10 22:58:16', '具有丰富的创业经历，因此他对各种类型公司的产品研发和运营都有自己的深刻见解。', '现任大社保网CEO & CTO；\r\n\r\n天津大学计算机系硕士；\r\n\r\n曾任好贷网技术副总，并在新浪和百度从事研发工作多年，具有扎实的技术功底；\r\n\r\n有多次创业经历，属于连续创业者，积累了丰富的创业实践。\r\n\r\n计算机系科班出身的胡亮一直致力于互联网领域，他既经历过大公司，也服务过中小规模的公司，还具有丰富的创业经历，因此他对各种类型公司的产品研发和运营都有自己的深刻见解。关于技术、产品、运营等问题，他能帮你分析整理职场中常见的技术或者管理问题，帮你找到解决方案。\r\n\r\n由于目前创办的大社保网属于互联网+人力资源服务领域，胡亮对人力资源相关的问题，比如：薪资、社保、公积金、个税、劳动法等均可以提供咨询服务。', 'upload/master/u170510019/u170510019.jpg', '99');
INSERT INTO `user` VALUES ('u170510020', '刘建义', '13000000000', 'c3cc8b73fd44fc99b0089700d2a18a03', '1', '1', 'liujianyi', null, '0', '2017-05-10 23:01:33', '在投融资、金融创新产品研发以及金融风险控制方面具有丰富的经验和独到的见解。', '现任河北海盛集团董事长；\r\n\r\n河北海外亲友联谊会副会长；\r\n河北省九三学社省直社员。\r\n\r\n毕业于西北工业大学工商管理系，现在读MBA研究生。\r\n\r\n刘建义先生意识超前，于2008年10月创建河北当代人才交流有限公司，2009年5月创建河北海盛通赢投资咨询有限公司。随着公司逐步发展和经验的积累，他随后又于2014年10月创建海盛普惠投资管理有限公司，11月创建海盛聚力河北网络科技有限公司，刘建义先生身体力行的为海盛集团的发展繁荣做出了极大的贡献，同年12月创建以冀贷通为品牌的互联网金融服务平台，并陆续创建本市普惠店以及邢台、保定、承德、张家口、上海等分公司。\r\n\r\n刘建义先生是一位善于学习、善于创新、具有国际和全局视野的企业领导人。曾主导研发“风险控制系统”与“冀贷通P2P网贷平台系统”。在投融资、金融创新产品研发以及金融风险控制方面具有丰富的经验和独到的见解，长期致力于通过实体店与互联网P2P金融相结合模式创新实现普惠金融。\r\n\r\n对于社会，他始终把承担社会责任看作义不容辞，在2015年7月份承办了为纪念中国人民抗日战争暨世界反法西斯战争胜利70周年由省委宣传部批准的“英烈祭、民族魂、中国梦”大型书法绘画摄影诗词展，受到了省市领导及群众的好评。', 'upload/master/u170510020/u170510020.jpg', '99');
INSERT INTO `user` VALUES ('u170510021', '李春艳', '13000000000', '713ee6589134292a737384c2ec043072', '2', '1', 'lichunyan', null, '0', '2017-05-10 23:04:10', '对金融会计、企业上市辅导、股权并购等业务具有丰富的理论及实战经验。', '深耕于银行、信托及证券等行业二十多年；\r\n高级会计师。\r\n\r\n毕业于河北经贸大学会计学专业。\r\n\r\n对金融会计、企业上市辅导、股权并购等业务具有丰富的理论及实战经验。\r\n\r\n曾在国家级期刊上发表论文10余篇。\r\n\r\n李春艳的职业发展走得是专业路线，20年的深耕让她积累了金融、财务方面深厚的理论知识和实践经验，她将在大职门分享金融、财务方面的经验包，以期能帮助更多的人。', 'upload/master/u170510021/u170510021.jpg', '99');
INSERT INTO `user` VALUES ('u170510022', '李斌阳', '13000000000', 'a2f44319f660479fe70165f2e1690a09', '1', '1', 'libinyang', null, '0', '2017-05-10 23:08:08', '担任ACL、IJCAI、NAACL、EMNLP等著名学术会议的程序委员会委员及JCST、FCS等……', '现任国际关系学院信息科技系副教授，承担多项国家自然科学基金。担任ACL、IJCAI、NAACL、EMNLP等著名学术会议的程序委员会委员以及JCST、FCS等著名学术期刊审稿人。\r\n\r\n曾在香港中文大学就职，任副研究员。\r\n\r\n博士毕业于香港中文大学，研究方向为自然语言处理、社会计算。\r\n\r\n李斌阳多年来从事自然语言处理和社会计算等方向的研究，他将在大职门分享自己多年来的教学、科研心得。\r\n \r\n国际关系学院始建于1949年，在周恩来总理的亲切关怀下成立，是一所富有优良传统的高等学府。\r\n学校以国际问题和外语教学科研为重点、以培养品学兼优的复合型人才为目标，办学模式和办学特色鲜明，在国内外享有较高声誉。学校师资力量雄厚，办学资源充足，不断探索和创新教学方法，长期坚持宽口径、厚基础、新视野、强素质的办学传统，注重培养学生广阔的国际视野、深厚的专业底蕴和扎实的外语基础，重视综合分析、创新思维和实践能力的培养，为政府部门、科研院所、企事业单位、传播媒体等培养输送了大批优秀人才。许多毕业生已经成长为蜚声中外的专家学者、业务骨干。\r\n \r\n学校设有国际政治、国际经济与贸易、英语、日语、法语、传播学、法学、信息管理与信息系统、公共管理、行政管理等10个专业，分别开设国际政治理论研究、国际政治外交实践、国际经济与贸易、政府采购、英语语言文化、英语翻译、应用日语、应用法语、文化与传播、汉语国际传播、法学、数据科学与工程、信息安全、智能信息处理、国际事务管理、涉外管理等16个专业方向。学校长期坚持小班教学，坚持精细化培养，是没有实行大规模扩招的极少数全国重点高校之一。', 'upload/master/u170510022/u170510022.jpg', '99');
INSERT INTO `user` VALUES ('u170510023', '任东林', '12300000000', '7a63fca1c232aa5e576989ce6107a79d', '1', '1', 'rendonglin', null, '0', '2017-05-10 23:11:39', '在投资能源、先进制造、新技术等领域的过程中积累了丰富的经验。', '现任保利国际控股高级投资经理，专注于能源、先进制造、新技术风险投资以及跨国并购。\r\n\r\n先后毕业于中国地质大学和清华大学。\r\n\r\n曾就职于知名风险投资公司北极光创投和全球最大的油田技术服务公司斯伦贝谢。\r\n\r\n他在斯伦贝谢工作期间便周游过世界，现在保利控股也有跨国并购业务，他的国际化眼光和经验非常契合。\r\n\r\n任东林既在跨国外企工作过，也服务过中国大型央企，国际化经验丰富。在投资能源、先进制造、新技术等领域的过程中也积累了丰富的经验，他愿意将自己的职场经验以及对相关行业的深刻理解分享给大家。\r\n\r\n中国保利集团公司系国务院国有资产监督管理委员会管理的大型中央企业，于1992年经国务院、中央军委批准组建。30多年来，保利集团已形成以国际贸易、房地产开发、文化艺术经营、资源领域投资开发、民用爆炸物品产销及相关服务为主业的“五业并举、多元发展”格局，业务遍布全球100多个国家及国内100余个城市。在美国财富杂志发布的2015年世界500强排行榜上，保利集团以2014年度260.5亿美元营业收入排名第457位。 ', 'upload/master/u170510023/u170510023.jpg', '99');
INSERT INTO `user` VALUES ('u170510024', '彭鹏', '13300000000', 'a11a59a08b3ea82bb381e1ed24222361', '1', '1', 'pengpeng', null, '0', '2017-05-10 23:15:10', '曾任深圳深讯信息科技有限公司软件工程师、腾讯公司创新中心技术专家。', '现任河南建筑技术学院教师，致力于计算机技术教学，只为实现教书育人、服务大家的情怀。\r\n\r\n吉林大学计算机专业学士，郑州大学计算机系硕士。\r\n\r\n曾任深圳深讯信息科技有限公司软件工程师、腾讯公司创新中心技术专家。\r\n\r\n彭鹏的职业生涯选择可能会让很多人不理解：为什么放着腾讯公司的好工作不要，非得离职去郑州的一所大学当教师？\r\n\r\n要回答这个问题，我们可以用职业锚的理论，也可以非常感性的说是个人情怀所致。当前这个时代，物欲横流，名利为先，能遵从自己内心选择，已实属不易。每一种已选择都代表了价值取向，独特的经历往往更有价值。\r\n\r\n彭鹏将在大职门分享自己在腾讯工作期间的心得体会，以及决定去当教师时，如何进行抉择的心路历程，相信会对很多同学有启发意义。', 'upload/master/u170510024/u170510024.jpg', '99');
INSERT INTO `user` VALUES ('u170511025', '安庆', null, '84ddd7b0eb3d0d85c0703edfa013ecb7', '1', '1', null, null, '1', '2017-05-11 15:39:41', '现任', '现任', 'upload/master/u170511025/u170511025.png', '99');
INSERT INTO `user` VALUES ('u170511026', '叶海涛', '13000000000', '0323c48be0fce7cca753109546bc8494', '1', '1', 'yehaitao', null, '0', '2017-05-11 17:17:04', '曾管理、操盘地产私募基金逾20亿、参与不良资产并购总案值逾80亿', '曾任欧盟中国基金合伙人、多家私募基金执行总裁；\r\n\r\n曾在香港派诺蒙（亚洲）有限公司任职十余年，在集团委派下先后创立两个公司：东莞莱尔尚鞋业有限公司、尚志鞋业（四川）有限公司。\r\n\r\n毕业于清华大学和美国麻省理工大学联合培养的IMBA；\r\n\r\n现为88购物网创始人。\r\n\r\n叶海涛凭着不断上进的决心和坚韧的毅力，在职业道路上取得了一次又一次的进步。他长期从事房地产、资产金融化及二级市场研究，在清华深造后转入资本领域工作，曾管理、操盘地产私募基金逾20亿、参与不良资产并购总案值逾80亿。就在工作进入正轨，并取得一定成就的时候，不安分的他又在2016年创办88购物网，开始了新的征程。', 'upload/master/u170511026/u170511026.jpg', '99');
INSERT INTO `user` VALUES ('u170513027', '职场老炮儿小组', '13000000000', '847e4be090c61a31d61fd9b351df71a4', '1', '1', 'laopao', null, '0', '2017-05-13 22:17:54', '掌门人', '大职门，职场经验与技能分享平台，智慧人口红利下的分享经济模式。   \r\n\r\n在职场某一领域具有丰富积累的人都算智慧人口，在大职门，我们将智慧人口统称为职场掌门，他们的经验和技能可以帮助很多人。\r\n\r\n大职门是职场掌门分享经验与技能的平台，通过释放智慧人口红利，帮助掌门获得额外的变现机会。  \r\n\r\n大职门也是学习者快速提升自己，获取职场突破的渠道。出于对劳动者尊重，学习者需要向职场掌门支付小额费用。\r\n\r\n大职门希望每位职场掌门的经验都能惠及更多人，帮助更多人成长，从而实现自己的职业理想。', 'upload/master/u170513027/u170513027.jpg', '99');
INSERT INTO `user` VALUES ('u170514028', '淘宝运营', null, '441eec387a836eb1e138e9f6406550cb', '2', '1', null, null, '1', '2017-05-14 11:28:52', '淘宝运营掌门人', '在淘宝刚兴起的时候，很多人通过开店赚了不少钱。这些人是先行者，走在了趋势的前列。现在，依然有很多人在开淘宝店，而且经营得红红火火，让身边人好生羡慕。\r\n \r\n受经济形势影响，很多生意大不如前，不少人跃跃欲试想开淘宝店。光有想法不行，虽然开设店铺也不难，但淘宝店运营有很多门道，如果你不掌握，肯定赚不到钱，你的店铺也将变成僵尸店。\r\n \r\n磨刀不误砍柴工，在你准备上路前，一定要拿到《淘宝开店之入门秘籍》……', 'upload/master/u170514028/u170514028.jpg', '99');
INSERT INTO `user` VALUES ('u170514029', '大职门亨亨地产小组', '13000000000', '3c92c02d46582da9bbfd7d3546a19142', '1', '1', 'henghengdichan', null, '0', '2017-05-14 16:20:40', '房地产行业人士', '近些年来，房地产一直是很火的行业，对中国经济的影响也至关重大。\r\n \r\n房地产话题已是老百姓日常聊天经常提及的，但很多人只了解皮毛，都是根据媒体信息人云亦云。\r\n\r\n我们对这个行业有深刻理解，并在房地产行业研究分析、房地产开发业务流程、岗位体系设置、各岗位工作内容、实践经验与所需技能等方面都有丰富的经验。', 'upload/master/u170514029/u170514029.jpg', '99');
INSERT INTO `user` VALUES ('u170517030', '安庆', '13000000099', '052548b8b9f8fda91a0b5fbe1298a0ed', '1', '1', 'anqing', null, '0', '2017-05-17 21:04:32', '掌门人', ' ', 'upload/master/u170517030/u170517030.jpg', '99');

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
INSERT INTO `verifycode` VALUES ('v17051100001', '13520197512', '622782', '1494470068806', '2017-05-11 10:29:28');
INSERT INTO `verifycode` VALUES ('v17051100002', '13520197515', '686287', '1494471096565', '2017-05-11 10:46:36');
INSERT INTO `verifycode` VALUES ('v17051100003', '13520197512', '227616', '1494472770756', '2017-05-11 11:14:30');
INSERT INTO `verifycode` VALUES ('v17051100004', '13520197512', '648631', '1494478275723', '2017-05-11 12:46:15');
INSERT INTO `verifycode` VALUES ('v17051100005', '13520197512', '162718', '1494479163018', '2017-05-11 13:01:03');
INSERT INTO `verifycode` VALUES ('v17051100006', '18811045102', '084181', '1494488392550', '2017-05-11 15:34:52');
INSERT INTO `verifycode` VALUES ('v17051100007', '13520197512', '083350', '1494500375162', '2017-05-11 18:54:35');
INSERT INTO `verifycode` VALUES ('v17051200008', '13520197512', '005848', '1494562926968', '2017-05-12 12:17:06');
INSERT INTO `verifycode` VALUES ('v17051300009', '15510152940', '185584', '1494665143855', '2017-05-13 16:40:43');
INSERT INTO `verifycode` VALUES ('v17051300010', '15510152940', '224979', '1494665201714', '2017-05-13 16:41:41');
INSERT INTO `verifycode` VALUES ('v17051300011', '15510152940', '593171', '1494665239262', '2017-05-13 16:42:19');
INSERT INTO `verifycode` VALUES ('v17051300012', '15510152940', '151983', '1494665286871', '2017-05-13 16:43:06');
INSERT INTO `verifycode` VALUES ('v17051300013', '15510152940', '038069', '1494665349387', '2017-05-13 16:44:09');
INSERT INTO `verifycode` VALUES ('v17051300014', '15510152940', '126575', '1494666185361', '2017-05-13 16:58:05');
INSERT INTO `verifycode` VALUES ('v17051300015', '15510152940', '905661', '1494666314425', '2017-05-13 17:00:14');
INSERT INTO `verifycode` VALUES ('v17051400016', '13520197512', '301076', '1494717601113', '2017-05-14 07:15:01');
INSERT INTO `verifycode` VALUES ('v17051400017', '13520197512', '483095', '1494721933086', '2017-05-14 08:27:13');
INSERT INTO `verifycode` VALUES ('v17051400018', '13520197512', '707260', '1494722064587', '2017-05-14 08:29:24');
INSERT INTO `verifycode` VALUES ('v17051400019', '13980475096', '131786', '1494722200025', '2017-05-14 08:31:40');
INSERT INTO `verifycode` VALUES ('v17051400020', '13520197512', '567109', '1494722281417', '2017-05-14 08:33:01');
INSERT INTO `verifycode` VALUES ('v17051400021', '13520197512', '539797', '1494722358886', '2017-05-14 08:34:18');
INSERT INTO `verifycode` VALUES ('v17051400022', '13520197512', '140182', '1494722398855', '2017-05-14 08:34:58');
INSERT INTO `verifycode` VALUES ('v17051400023', '13520197512', '136279', '1494741589277', '2017-05-14 13:54:49');
INSERT INTO `verifycode` VALUES ('v17051400024', '13520197512', '590376', '1494741924195', '2017-05-14 14:00:24');
INSERT INTO `verifycode` VALUES ('v17051400025', '13520197512', '916145', '1494742864184', '2017-05-14 14:16:04');
INSERT INTO `verifycode` VALUES ('v17051400026', '13520197512', '621061', '1494744371131', '2017-05-14 14:41:11');
INSERT INTO `verifycode` VALUES ('v17051400027', '13580963508', '023213', '1494745942954', '2017-05-14 15:07:22');
INSERT INTO `verifycode` VALUES ('v17051500028', '18733259535', '570862', '1494801474889', '2017-05-15 06:32:54');
INSERT INTO `verifycode` VALUES ('v17051500029', '13520197512', '988258', '1494818343442', '2017-05-15 11:14:03');
INSERT INTO `verifycode` VALUES ('v17051500030', '13520197512', '105252', '1494820534566', '2017-05-15 11:50:34');
INSERT INTO `verifycode` VALUES ('v17051600031', '13520197512', '466075', '1494918487015', '2017-05-16 15:03:07');
INSERT INTO `verifycode` VALUES ('v17051600032', '18722420589', '994993', '1494922777571', '2017-05-16 16:14:37');
INSERT INTO `verifycode` VALUES ('v17051600033', '18722420589', '528959', '1494922866461', '2017-05-16 16:16:06');
INSERT INTO `verifycode` VALUES ('v17051600034', '13520197512', '314478', '1494950307922', '2017-05-16 23:53:27');
INSERT INTO `verifycode` VALUES ('v17051700035', '18733259535', '215803', '1495017952542', '2017-05-17 18:40:52');
INSERT INTO `verifycode` VALUES ('v17051700036', '18733259535', '901493', '1495018014104', '2017-05-17 18:41:54');
INSERT INTO `verifycode` VALUES ('v17051700037', '18733259535', '907209', '1495019411767', '2017-05-17 19:05:11');
INSERT INTO `verifycode` VALUES ('v17051700038', '18733259535', '752210', '1495020585590', '2017-05-17 19:24:45');
INSERT INTO `verifycode` VALUES ('v17051700039', '13614147789', '184241', '1495027345655', '2017-05-17 21:17:25');
INSERT INTO `verifycode` VALUES ('v17052100040', '18722420589', '393509', '1495340016981', '2017-05-21 12:08:36');
INSERT INTO `verifycode` VALUES ('v17052100041', '18811045102', '584835', '1495340074981', '2017-05-21 12:09:34');
INSERT INTO `verifycode` VALUES ('v17052100042', '18811045102', '628556', '1495360918524', '2017-05-21 17:56:58');
INSERT INTO `verifycode` VALUES ('v17052200043', '13520197512', '162800', '1495391428713', '2017-05-22 02:25:28');
INSERT INTO `verifycode` VALUES ('v17052200044', '18811045102', '253368', '1495427891219', '2017-05-22 12:33:11');
INSERT INTO `verifycode` VALUES ('v17052200045', '18833332045', '265488', '1495428024766', '2017-05-22 12:35:24');
INSERT INTO `verifycode` VALUES ('v17052200046', '13520197512', '009134', '1495440741816', '2017-05-22 16:07:21');
INSERT INTO `verifycode` VALUES ('v17052300047', '15666666666', '411717', '1495504644930', '2017-05-23 09:52:24');
INSERT INTO `verifycode` VALUES ('v17052400048', '18131166128', '892616', '1495582631578', '2017-05-24 07:32:11');
INSERT INTO `verifycode` VALUES ('v17052400049', '18811045102', '676202', '1495589940526', '2017-05-24 09:34:00');
INSERT INTO `verifycode` VALUES ('v17052500050', '18811045102', '014767', '1495661126050', '2017-05-25 05:20:26');
INSERT INTO `verifycode` VALUES ('v17052500051', '13520197512', '737906', '1495705623952', '2017-05-25 17:42:03');

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
