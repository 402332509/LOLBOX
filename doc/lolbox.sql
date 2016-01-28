/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50624
Source Host           : localhost:3306
Source Database       : lolbox

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2016-01-28 22:26:06
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for champion
-- ----------------------------
DROP TABLE IF EXISTS `champion`;
CREATE TABLE `champion` (
  `championId` int(15) NOT NULL AUTO_INCREMENT COMMENT '英雄使用情况id',
  `serverName` varchar(63) NOT NULL DEFAULT '' COMMENT '服务器',
  `playerName` varchar(63) NOT NULL DEFAULT '' COMMENT '玩家id',
  `championName` varchar(63) NOT NULL DEFAULT '' COMMENT '使用英雄',
  `matchStat` int(7) NOT NULL DEFAULT '0' COMMENT '使用场次',
  `winRate` decimal(10,0) NOT NULL DEFAULT '0' COMMENT '英雄胜率',
  `averageKDA` varchar(15) NOT NULL DEFAULT '0/0/0' COMMENT '场均KDA',
  `averageKDARating` varchar(15) NOT NULL DEFAULT '0.0' COMMENT '场均战损比',
  `averageDamage` int(7) NOT NULL DEFAULT '0' COMMENT '场均分钟输出',
  `averageEarn` int(7) NOT NULL DEFAULT '0' COMMENT '场均分钟金钱',
  `averageMinionsKilled` int(15) NOT NULL DEFAULT '0' COMMENT '十分钟补兵数',
  `totalMVP` int(7) NOT NULL DEFAULT '0' COMMENT '获得mvp数',
  `totalHope` int(7) NOT NULL DEFAULT '0',
  `duowanUpdateTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '多玩显示更新时间',
  `updateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`championId`),
  KEY `champion_player_index` (`playerName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='最近英雄使用情况';

-- ----------------------------
-- Table structure for equip
-- ----------------------------
DROP TABLE IF EXISTS `equip`;
CREATE TABLE `equip` (
  `equipName` varchar(63) NOT NULL DEFAULT '' COMMENT '装备名',
  `equipProperty` text NOT NULL COMMENT '装备属性',
  `equipIMG` varchar(63) NOT NULL COMMENT '装备图标',
  PRIMARY KEY (`equipName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='装备信息';

-- ----------------------------
-- Table structure for gamedetails
-- ----------------------------
DROP TABLE IF EXISTS `gamedetails`;
CREATE TABLE `gamedetails` (
  `detailId` int(15) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `matchId` int(15) NOT NULL COMMENT '对局id',
  `floor` varchar(15) NOT NULL DEFAULT '' COMMENT '对阵楼层',
  `serverName` varchar(63) NOT NULL DEFAULT '' COMMENT '服务器',
  `playerName` varchar(63) NOT NULL DEFAULT '' COMMENT '玩家id',
  `earn` varchar(15) NOT NULL COMMENT '本局经济',
  `KDA` varchar(15) NOT NULL DEFAULT '0/0/0' COMMENT 'KDA',
  `equip1` varchar(31) NOT NULL DEFAULT '' COMMENT '1装备栏',
  `equip2` varchar(31) NOT NULL DEFAULT '' COMMENT '2装备栏',
  `equip3` varchar(31) NOT NULL DEFAULT '' COMMENT '3装备栏',
  `equip4` varchar(31) NOT NULL DEFAULT '' COMMENT '4装备栏',
  `equip5` varchar(31) NOT NULL DEFAULT '' COMMENT '5装备栏',
  `equip6` varchar(31) NOT NULL DEFAULT '' COMMENT '6装备栏',
  `equip7` varchar(31) NOT NULL DEFAULT '' COMMENT '7装备栏',
  `averageMinionsKilled` int(15) NOT NULL DEFAULT '0' COMMENT '十分钟补兵数',
  `averageMinionsKDA` varchar(15) NOT NULL DEFAULT '0/0/0' COMMENT '十分钟KDA',
  `summonerSkill1` varchar(15) NOT NULL COMMENT '所带召唤师技能1',
  `summonerSkill2` varchar(15) NOT NULL COMMENT '所带召唤师技能2',
  `KDARating` varchar(15) NOT NULL DEFAULT '0.0' COMMENT '本局评分',
  `championUsed` varchar(63) NOT NULL DEFAULT '' COMMENT '本局使用英雄',
  `Killed` int(31) NOT NULL DEFAULT '0' COMMENT '本局补兵',
  `monsterKilled` int(31) NOT NULL DEFAULT '0' COMMENT '杀死野怪数',
  `downTower` int(7) NOT NULL DEFAULT '0' COMMENT '拆毁防御塔数',
  `downBarrack` int(7) NOT NULL DEFAULT '0' COMMENT '拆毁兵营数',
  `placeGuard` int(7) NOT NULL DEFAULT '0' COMMENT '放置侦查守卫数',
  `wipeGuard` int(7) NOT NULL DEFAULT '0' COMMENT '拆眼数',
  `highestKill` int(7) NOT NULL DEFAULT '0' COMMENT '最高未死亡杀人数',
  `pentaKill` int(3) NOT NULL DEFAULT '0' COMMENT '最高多杀',
  `highestCrit` int(15) NOT NULL DEFAULT '0' COMMENT '最高暴击',
  `totalHeal` int(15) NOT NULL DEFAULT '0' COMMENT '总治疗量',
  `finalDamage` int(15) NOT NULL DEFAULT '0' COMMENT '输出伤害',
  `bear` int(15) NOT NULL DEFAULT '0' COMMENT '承受伤害',
  `damageToChampion` int(15) NOT NULL DEFAULT '0' COMMENT '对英雄造成伤害',
  `magicDamage` int(15) NOT NULL DEFAULT '0' COMMENT '对英雄魔法伤害',
  `physicalDamage` int(15) NOT NULL DEFAULT '0' COMMENT '对英雄物理伤害',
  `trueDamage` int(15) NOT NULL DEFAULT '0' COMMENT '对英雄真实伤害',
  PRIMARY KEY (`detailId`),
  UNIQUE KEY `detail_matchId_index` (`matchId`),
  KEY `detail_player_index` (`playerName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='对局详细信息';

-- ----------------------------
-- Table structure for gamematch
-- ----------------------------
DROP TABLE IF EXISTS `gamematch`;
CREATE TABLE `gamematch` (
  `matchId` int(15) NOT NULL COMMENT '对局id',
  `matchType` varchar(63) DEFAULT '' COMMENT '匹配类型',
  `gameTime` time DEFAULT '00:00:00' COMMENT '游戏时长',
  `endTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '结束时间',
  `record` varchar(63) DEFAULT '' COMMENT '胜负战绩比',
  `goldRate` varchar(63) DEFAULT '' COMMENT '胜负金钱比',
  PRIMARY KEY (`matchId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='对局信息';

-- ----------------------------
-- Table structure for pagecache
-- ----------------------------
DROP TABLE IF EXISTS `pagecache`;
CREATE TABLE `pagecache` (
  `playerName` varchar(63) NOT NULL DEFAULT '' COMMENT '玩家id',
  `serverName` varchar(63) NOT NULL DEFAULT '' COMMENT '游戏大区',
  `matchId` varchar(63) NOT NULL DEFAULT '' COMMENT '比赛id',
  `html` longtext NOT NULL COMMENT 'html',
  `createTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '爬取时间',
  `updateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '待定',
  PRIMARY KEY (`playerName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='爬取缓存';

-- ----------------------------
-- Table structure for player
-- ----------------------------
DROP TABLE IF EXISTS `player`;
CREATE TABLE `player` (
  `playerId` int(15) NOT NULL AUTO_INCREMENT COMMENT '玩家唯一标示',
  `playerName` varchar(63) NOT NULL DEFAULT '' COMMENT '玩家id',
  `serverName` varchar(63) NOT NULL DEFAULT '' COMMENT '服务器',
  `strength` int(15) NOT NULL DEFAULT '0' COMMENT '玩家战斗力',
  PRIMARY KEY (`playerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家信息';
