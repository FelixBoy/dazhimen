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
