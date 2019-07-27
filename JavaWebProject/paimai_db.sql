-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(20)  NOT NULL COMMENT 'user_name',
  `password` varchar(20)  NOT NULL COMMENT '登录密码',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `gender` varchar(4)  NOT NULL COMMENT '性别',
  `birthDate` varchar(20)  NULL COMMENT '生日',
  `userImage` varchar(60)  NOT NULL COMMENT '用户照片',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `city` varchar(20)  NOT NULL COMMENT '所在城市',
  `address` varchar(80)  NOT NULL COMMENT '家庭地址',
  `email` varchar(50)  NULL COMMENT '邮箱',
  `paypalAccount` varchar(20)  NOT NULL COMMENT 'paypal账户名',
  `createTime` varchar(20)  NULL COMMENT '注册时间',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_itemClass` (
  `classId` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品分类id',
  `className` varchar(50)  NOT NULL COMMENT '商品类别名称',
  `classDesc` varchar(2000)  NOT NULL COMMENT '类别描述',
  PRIMARY KEY (`classId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_item` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `itemClassObj` int(11) NOT NULL COMMENT '商品分类',
  `pTitle` varchar(80)  NOT NULL COMMENT '商品标题',
  `itemPhoto` varchar(60)  NOT NULL COMMENT '商品图片',
  `itemDesc` varchar(5000)  NOT NULL COMMENT '商品描述',
  `userObj` varchar(20)  NOT NULL COMMENT '发布人',
  `startPrice` float NOT NULL COMMENT '起拍价',
  `startTime` varchar(20)  NULL COMMENT '起拍时间',
  `endTime` varchar(20)  NULL COMMENT '结束时间',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_productBidding` (
  `biddingId` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `itemObj` int(11) NOT NULL COMMENT '竞拍商品',
  `userObj` varchar(20)  NOT NULL COMMENT '竞拍用户',
  `biddingTime` varchar(20)  NULL COMMENT '竞拍时间',
  `biddingPrice` float NOT NULL COMMENT '竞拍出价',
  PRIMARY KEY (`biddingId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_postInfo` (
  `postInfoId` int(11) NOT NULL AUTO_INCREMENT COMMENT '帖子id',
  `pTitle` varchar(80)  NOT NULL COMMENT '帖子标题',
  `content` varchar(5000)  NOT NULL COMMENT '帖子内容',
  `userObj` varchar(20)  NOT NULL COMMENT '发帖人',
  `addTime` varchar(20)  NULL COMMENT '发帖时间',
  `hitNum` int(11) NOT NULL COMMENT '浏览量',
  PRIMARY KEY (`postInfoId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_reply` (
  `replyId` int(11) NOT NULL AUTO_INCREMENT COMMENT '回复id',
  `postInfoObj` int(11) NOT NULL COMMENT '被回帖子',
  `content` varchar(2000)  NOT NULL COMMENT '回复内容',
  `userObj` varchar(20)  NOT NULL COMMENT '回复人',
  `replyTime` varchar(20)  NULL COMMENT '回复时间',
  PRIMARY KEY (`replyId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_userFollow` (
  `followId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录id',
  `userObj1` varchar(20)  NOT NULL COMMENT '被关注人',
  `userObj2` varchar(20)  NOT NULL COMMENT '关注人',
  `followTime` varchar(20)  NULL COMMENT '关注时间',
  PRIMARY KEY (`followId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_item ADD CONSTRAINT FOREIGN KEY (itemClassObj) REFERENCES t_itemClass(classId);
ALTER TABLE t_item ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_productBidding ADD CONSTRAINT FOREIGN KEY (itemObj) REFERENCES t_item(itemId);
ALTER TABLE t_productBidding ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_postInfo ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_reply ADD CONSTRAINT FOREIGN KEY (postInfoObj) REFERENCES t_postInfo(postInfoId);
ALTER TABLE t_reply ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_userFollow ADD CONSTRAINT FOREIGN KEY (userObj1) REFERENCES t_userInfo(user_name);
ALTER TABLE t_userFollow ADD CONSTRAINT FOREIGN KEY (userObj2) REFERENCES t_userInfo(user_name);


