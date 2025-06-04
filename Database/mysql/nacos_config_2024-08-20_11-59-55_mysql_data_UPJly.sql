-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: nacos_config
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `config_info`
--

DROP TABLE IF EXISTS `config_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'group_id',
  `content` longtext COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COLLATE utf8mb3_bin COMMENT 'source user',
  `src_ip` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'app_name',
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'configuration description',
  `c_use` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'configuration usage',
  `effect` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL COMMENT '配置生效的描述',
  `type` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL COMMENT '配置的类型',
  `c_schema` text COLLATE utf8mb3_bin COMMENT '配置的模式',
  `encrypted_data_key` varchar(1024) COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT '密钥',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfo_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='config_info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info`
--

LOCK TABLES `config_info` WRITE;
/*!40000 ALTER TABLE `config_info` DISABLE KEYS */;
INSERT INTO `config_info` VALUES (2,'blog-cloud-auth-dev.yaml','DEFAULT_GROUP','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 08:43:18','2024-08-15 15:43:22',NULL,'192.168.56.1','blog-cloud-auth','91452963-e494-45b7-b518-5430c283bca1','blog-cloud-auth服务主配置','','','yaml','',''),(3,'datasource.yaml','DEFAULT_GROUP','# 配置配置应用的常规、非敏感、不变动的属性\nspring:\n  datasource:\n    # 数据库连接 URL\n    url: jdbc:mysql://192.168.56.10:3306/blog_cloud?useUnicode=true&characterEncoding=UTF-8&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=GMT%2B8\n    # 数据库用户名\n    username: lcqh_auth\n    # 数据库密码\n    password: 479368\n    # 数据库驱动类名\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    # 显式指定数据源类型为 HikariDataSource\n    type: com.zaxxer.hikari.HikariDataSource\n    # HikariCP 是一个高性能的 JDBC 连接池实现，它通常用于提高应用程序的性能和响应速度\n    hikari:\n      # 连接池中最小空闲连接数\n      minimum-idle: 5\n      # 连接池中最大连接数\n      maximum-pool-size: 10\n      # 连接闲置超时时间（毫秒）\n      idle-timeout: 600000\n      # 获取连接的超时时间（毫秒）\n      connection-timeout: 30000\n\n  data:\n    redis:\n      # Redis 服务器的 IP 地址\n      host: 192.168.56.10\n      # Redis 服务器的端口号，默认为 6379\n      port: 6379\n      # 默认使用的数据库索引，默认为 0\n      database: 0\n      # Redis 服务器的密码，如果没有设置密码，则设置为 null\n      password: 479368\n      # 命令执行的超时时间（毫秒）\n      timeout: 10000\n      # Lettuce 是 Redis 的异步客户端，它提供了高性能的非阻塞 I/O 操作。默认使用 Lettuce 作为 Redis 客户端\n\n  jackson:\n    time-zone: GMT+8\n    date-format: yyyy-MM-dd HH:mm:ss\n\n# mybatis-plus 配置\nmybatis-plus:\n  mapper-locations: classpath*:/mapper/**/*.xml\n  global-config:\n    # 关闭 mybatis-plus 横幅打印\n    banner: false\n    # 逻辑删除配置\n    db-config:\n      logic-delete-field: delFlag	 # 全局逻辑删除的实体字段名\n      logic-delete-value: 1		 # 逻辑已删除值(默认为 1)\n      logic-not-delete-value: 0		# 逻辑未删除值(默认为 0)\n  configuration:\n    # 启用 sql 打印\n    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n\n# 监控配置\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \"*\"\n  endpoint:\n    health:\n      show-details: always\n\n','2ab3c02469cb29cd114c6200d4f859e4','2024-08-14 08:48:21','2024-08-14 11:29:04',NULL,'192.168.56.1','','91452963-e494-45b7-b518-5430c283bca1','应用程序数据源配置','','','yaml','',''),(4,'blog-cloud-auth.yaml','DEFAULT_GROUP','spring:\n  application:\n    name: blog-cloud-auth\nserver:\n  port: 8888','db03ed651126197c60aaf402c49ccc58','2024-08-14 08:59:17','2024-08-14 08:59:17',NULL,'192.168.56.1','blog-cloud-auth','','blog-cloud-auth服务主配置',NULL,NULL,'yaml',NULL,''),(5,'datasource.yaml','DEFAULT_GROUP','spring:\n  datasource:\n    url: jdbc:mysql://192.168.56.10:3306/nacos_config?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false\n    username: lcqh\n    password: 479368\n    driver-class-name: com.mysql.cj.jdbc.Driver\n  jpa:\n    hibernate:\n      ddl-auto: update\n    show-sql: true\n    properties:\n      hibernate:\n        dialect: org.hibernate.dialect.MySQL5Dialect','7627c57efd89a42dc06135a66fd2c9c8','2024-08-14 08:59:17','2024-08-14 08:59:17',NULL,'192.168.56.1','','','应用程序数据源配置',NULL,NULL,'yaml',NULL,''),(6,'blog-cloud-gateway.yaml','DEFAULT_GROUP','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:00:44','2024-08-14 09:00:44',NULL,'192.168.56.1','blog-cloud-gateway','','blog-cloud-gateway网关服务主配置',NULL,NULL,'yaml',NULL,''),(7,'blog-cloud-monitor.yaml','DEFAULT_GROUP','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:02:35','2024-08-14 09:02:35',NULL,'192.168.56.1','blog-cloud-monitor','','blog-cloud-monitor监控服务主配置',NULL,NULL,'yaml',NULL,''),(8,'blog-cloud-service.yaml','DEFAULT_GROUP','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:03:35','2024-08-14 09:03:35',NULL,'192.168.56.1','blog-cloud-service','','blog-cloud-service业务服务主配置',NULL,NULL,'yaml',NULL,''),(9,'blog-cloud-auth-prod.yaml','DEFAULT_GROUP','spring:\n  application:\n    name: blog-cloud-auth\nserver:\n  port: 8888','db03ed651126197c60aaf402c49ccc58','2024-08-14 09:04:49','2024-08-14 09:04:49',NULL,'192.168.56.1','blog-cloud-auth','03aa8c6a-48f8-462f-a95b-5248424c657f','blog-cloud-auth服务主配置',NULL,NULL,'yaml',NULL,''),(10,'datasource.yaml','DEFAULT_GROUP','spring:\n  datasource:\n    url: jdbc:mysql://192.168.56.10:3306/nacos_config?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false\n    username: lcqh\n    password: 479368\n    driver-class-name: com.mysql.cj.jdbc.Driver\n  jpa:\n    hibernate:\n      ddl-auto: update\n    show-sql: true\n    properties:\n      hibernate:\n        dialect: org.hibernate.dialect.MySQL5Dialect','7627c57efd89a42dc06135a66fd2c9c8','2024-08-14 09:04:49','2024-08-14 09:04:49',NULL,'192.168.56.1','','03aa8c6a-48f8-462f-a95b-5248424c657f','应用程序数据源配置',NULL,NULL,'yaml',NULL,''),(11,'blog-cloud-gatewa-prod.yaml','DEFAULT_GROUP','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:04:49','2024-08-14 09:04:49',NULL,'192.168.56.1','blog-cloud-gateway','03aa8c6a-48f8-462f-a95b-5248424c657f','blog-cloud-gateway网关服务主配置',NULL,NULL,'yaml',NULL,''),(12,'blog-cloud-monitor-prod.yaml','DEFAULT_GROUP','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:04:49','2024-08-14 09:04:49',NULL,'192.168.56.1','blog-cloud-monitor','03aa8c6a-48f8-462f-a95b-5248424c657f','blog-cloud-monitor监控服务主配置',NULL,NULL,'yaml',NULL,''),(13,'blog-cloud-service-prod.yaml','DEFAULT_GROUP','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:04:49','2024-08-14 09:04:49',NULL,'192.168.56.1','blog-cloud-service','03aa8c6a-48f8-462f-a95b-5248424c657f','blog-cloud-service业务服务主配置',NULL,NULL,'yaml',NULL,''),(14,'blog-cloud-auth-test.yaml','DEFAULT_GROUP','spring:\n  application:\n    name: blog-cloud-auth\nserver:\n  port: 8888','db03ed651126197c60aaf402c49ccc58','2024-08-14 09:05:23','2024-08-14 09:05:23',NULL,'192.168.56.1','blog-cloud-auth','ff5810ac-5eb2-485d-8c32-e0314fa30af3','blog-cloud-auth服务主配置',NULL,NULL,'yaml',NULL,''),(15,'datasource.yaml','DEFAULT_GROUP','spring:\n  datasource:\n    url: jdbc:mysql://192.168.56.10:3306/nacos_config?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false\n    username: lcqh\n    password: 479368\n    driver-class-name: com.mysql.cj.jdbc.Driver\n  jpa:\n    hibernate:\n      ddl-auto: update\n    show-sql: true\n    properties:\n      hibernate:\n        dialect: org.hibernate.dialect.MySQL5Dialect','7627c57efd89a42dc06135a66fd2c9c8','2024-08-14 09:05:23','2024-08-14 09:05:23',NULL,'192.168.56.1','','ff5810ac-5eb2-485d-8c32-e0314fa30af3','应用程序数据源配置',NULL,NULL,'yaml',NULL,''),(16,'blog-cloud-gatewa-test.yaml','DEFAULT_GROUP','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:05:23','2024-08-14 09:05:23',NULL,'192.168.56.1','blog-cloud-gateway','ff5810ac-5eb2-485d-8c32-e0314fa30af3','blog-cloud-gateway网关服务主配置',NULL,NULL,'yaml',NULL,''),(17,'blog-cloud-monitor-test.yaml','DEFAULT_GROUP','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:05:23','2024-08-14 09:05:23',NULL,'192.168.56.1','blog-cloud-monitor','ff5810ac-5eb2-485d-8c32-e0314fa30af3','blog-cloud-monitor监控服务主配置',NULL,NULL,'yaml',NULL,''),(18,'blog-cloud-service-test.yaml','DEFAULT_GROUP','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:05:23','2024-08-14 09:05:23',NULL,'192.168.56.1','blog-cloud-service','ff5810ac-5eb2-485d-8c32-e0314fa30af3','blog-cloud-service业务服务主配置',NULL,NULL,'yaml',NULL,''),(19,'blog-cloud-gatewa-dev.yaml','DEFAULT_GROUP','spring:\n  application:\n    name: blog-cloud-gateway','5e88f941571a05738c90ba4376409765','2024-08-14 09:06:11','2024-08-15 15:42:55',NULL,'192.168.56.1','blog-cloud-gateway','91452963-e494-45b7-b518-5430c283bca1','blog-cloud-gateway网关服务主配置','','','yaml','',''),(20,'blog-cloud-monitor-dev.yaml','DEFAULT_GROUP','spring:\n  application:\n    name: blog-cloud-monitor','bde629dc25381da2c3c64b08acbb558e','2024-08-14 09:06:11','2024-08-15 15:42:04',NULL,'192.168.56.1','blog-cloud-monitor','91452963-e494-45b7-b518-5430c283bca1','blog-cloud-monitor监控服务主配置','','','yaml','',''),(21,'blog-cloud-service-dev.yaml','DEFAULT_GROUP','# 配置 actuator 对外指标\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \"*\"\n  endpoint:\n    prometheus:\n      enabled: true\n    health:\n      show-details: always\n  # 配置 Prometheus 监控\n  prometheus:\n    metrics:\n      export:\n        enabled: true\n  # 这个应用所有上报的 metrics 都会带上 application 这个标签的值，用于区分不同应用\n  metrics:\n    tags:\n      application: ${spring.application.name}\n\n# 然后可以通过访问 http://localhost:8081/actuator 获取应用指标信息\n# 然后可以通过访问 http://localhost:8081/actuator/prometheus 获取Prometheus格式的指标数据','a876fab1fad37f0327aacff9cbc12533','2024-08-14 09:06:11','2024-08-16 13:01:30',NULL,'192.168.56.1','blog-cloud-service','91452963-e494-45b7-b518-5430c283bca1','blog-cloud-service业务服务主配置','','','yaml','','');
/*!40000 ALTER TABLE `config_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_aggr`
--

DROP TABLE IF EXISTS `config_info_aggr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info_aggr` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'datum_id',
  `content` longtext COLLATE utf8mb3_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'app_name',
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfoaggr_datagrouptenantdatum` (`data_id`,`group_id`,`tenant_id`,`datum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='增加租户字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_aggr`
--

LOCK TABLES `config_info_aggr` WRITE;
/*!40000 ALTER TABLE `config_info_aggr` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_aggr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_beta`
--

DROP TABLE IF EXISTS `config_info_beta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info_beta` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COLLATE utf8mb3_bin COMMENT 'source user',
  `src_ip` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` varchar(1024) COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT '密钥',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfobeta_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='config_info_beta';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_beta`
--

LOCK TABLES `config_info_beta` WRITE;
/*!40000 ALTER TABLE `config_info_beta` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_beta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_tag`
--

DROP TABLE IF EXISTS `config_info_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COLLATE utf8mb3_bin COMMENT 'source user',
  `src_ip` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfotag_datagrouptenanttag` (`data_id`,`group_id`,`tenant_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='config_info_tag';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_tag`
--

LOCK TABLES `config_info_tag` WRITE;
/*!40000 ALTER TABLE `config_info_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_tags_relation`
--

DROP TABLE IF EXISTS `config_tags_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_tags_relation` (
  `id` bigint NOT NULL COMMENT 'id',
  `tag_name` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint NOT NULL AUTO_INCREMENT COMMENT 'nid, 自增长标识',
  PRIMARY KEY (`nid`),
  UNIQUE KEY `uk_configtagrelation_configidtag` (`id`,`tag_name`,`tag_type`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='config_tag_relation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_tags_relation`
--

LOCK TABLES `config_tags_relation` WRITE;
/*!40000 ALTER TABLE `config_tags_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_tags_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_capacity`
--

DROP TABLE IF EXISTS `group_capacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_capacity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='集群、各Group容量信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_capacity`
--

LOCK TABLES `group_capacity` WRITE;
/*!40000 ALTER TABLE `group_capacity` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_capacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `his_config_info`
--

DROP TABLE IF EXISTS `his_config_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `his_config_info` (
  `id` bigint unsigned NOT NULL COMMENT 'id',
  `nid` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'nid, 自增标识',
  `data_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COLLATE utf8mb3_bin COMMENT 'source user',
  `src_ip` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'source ip',
  `op_type` char(10) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'operation type',
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` varchar(1024) COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT '密钥',
  PRIMARY KEY (`nid`),
  KEY `idx_gmt_create` (`gmt_create`),
  KEY `idx_gmt_modified` (`gmt_modified`),
  KEY `idx_did` (`data_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='多租户改造';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `his_config_info`
--

LOCK TABLES `his_config_info` WRITE;
/*!40000 ALTER TABLE `his_config_info` DISABLE KEYS */;
INSERT INTO `his_config_info` VALUES (0,1,'blog-cloud-auth-dev.yaml','DEFAULT_GROUP','','name=\"测试\"','819908eb2a4bc014fb0b110eaf0120e1','2024-08-14 08:38:11','2024-08-14 16:38:12',NULL,'192.168.56.1','I','91452963-e494-45b7-b518-5430c283bca1',''),(1,2,'blog-cloud-auth-dev.yaml','DEFAULT_GROUP','','name=\"测试\"','819908eb2a4bc014fb0b110eaf0120e1','2024-08-14 08:41:47','2024-08-14 16:41:48',NULL,'192.168.56.1','D','91452963-e494-45b7-b518-5430c283bca1',''),(0,3,'blog-cloud-auth-dev.yaml','DEFAULT_GROUP','','spring:\n  application:\n    name: blog-cloud-auth\nserver:\n  port: 8080','9038ad01b76735e0419a66d8a806eabe','2024-08-14 08:43:17','2024-08-14 16:43:18',NULL,'192.168.56.1','I','91452963-e494-45b7-b518-5430c283bca1',''),(2,4,'blog-cloud-auth-dev.yaml','DEFAULT_GROUP','','spring:\n  application:\n    name: blog-cloud-auth\nserver:\n  port: 8080','9038ad01b76735e0419a66d8a806eabe','2024-08-14 08:43:44','2024-08-14 16:43:44',NULL,'192.168.56.1','U','91452963-e494-45b7-b518-5430c283bca1',''),(0,5,'datasource.yaml','DEFAULT_GROUP','','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 08:48:20','2024-08-14 16:48:21',NULL,'192.168.56.1','I','91452963-e494-45b7-b518-5430c283bca1',''),(2,6,'blog-cloud-auth-dev.yaml','DEFAULT_GROUP','blog-cloud-auth','spring:\n  application:\n    name: blog-cloud-auth\nserver:\n  port: 8080','9038ad01b76735e0419a66d8a806eabe','2024-08-14 08:51:40','2024-08-14 16:51:41',NULL,'192.168.56.1','U','91452963-e494-45b7-b518-5430c283bca1',''),(3,7,'datasource.yaml','DEFAULT_GROUP','','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 08:57:47','2024-08-14 16:57:47',NULL,'192.168.56.1','U','91452963-e494-45b7-b518-5430c283bca1',''),(0,8,'blog-cloud-auth.yaml','DEFAULT_GROUP','blog-cloud-auth','spring:\n  application:\n    name: blog-cloud-auth\nserver:\n  port: 8888','db03ed651126197c60aaf402c49ccc58','2024-08-14 08:59:17','2024-08-14 16:59:17',NULL,'192.168.56.1','I','',''),(0,9,'datasource.yaml','DEFAULT_GROUP','','spring:\n  datasource:\n    url: jdbc:mysql://192.168.56.10:3306/nacos_config?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false\n    username: lcqh\n    password: 479368\n    driver-class-name: com.mysql.cj.jdbc.Driver\n  jpa:\n    hibernate:\n      ddl-auto: update\n    show-sql: true\n    properties:\n      hibernate:\n        dialect: org.hibernate.dialect.MySQL5Dialect','7627c57efd89a42dc06135a66fd2c9c8','2024-08-14 08:59:17','2024-08-14 16:59:17',NULL,'192.168.56.1','I','',''),(0,10,'blog-cloud-gateway.yaml','DEFAULT_GROUP','blog-cloud-gateway','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:00:44','2024-08-14 17:00:44',NULL,'192.168.56.1','I','',''),(0,11,'blog-cloud-monitor.yaml','DEFAULT_GROUP','blog-cloud-monitor','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:02:35','2024-08-14 17:02:35',NULL,'192.168.56.1','I','',''),(0,12,'blog-cloud-service.yaml','DEFAULT_GROUP','blog-cloud-service','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:03:34','2024-08-14 17:03:35',NULL,'192.168.56.1','I','',''),(0,13,'blog-cloud-auth-prod.yaml','DEFAULT_GROUP','blog-cloud-auth','spring:\n  application:\n    name: blog-cloud-auth\nserver:\n  port: 8888','db03ed651126197c60aaf402c49ccc58','2024-08-14 09:04:48','2024-08-14 17:04:49',NULL,'192.168.56.1','I','03aa8c6a-48f8-462f-a95b-5248424c657f',''),(0,14,'datasource.yaml','DEFAULT_GROUP','','spring:\n  datasource:\n    url: jdbc:mysql://192.168.56.10:3306/nacos_config?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false\n    username: lcqh\n    password: 479368\n    driver-class-name: com.mysql.cj.jdbc.Driver\n  jpa:\n    hibernate:\n      ddl-auto: update\n    show-sql: true\n    properties:\n      hibernate:\n        dialect: org.hibernate.dialect.MySQL5Dialect','7627c57efd89a42dc06135a66fd2c9c8','2024-08-14 09:04:48','2024-08-14 17:04:49',NULL,'192.168.56.1','I','03aa8c6a-48f8-462f-a95b-5248424c657f',''),(0,15,'blog-cloud-gatewa-prod.yaml','DEFAULT_GROUP','blog-cloud-gateway','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:04:48','2024-08-14 17:04:49',NULL,'192.168.56.1','I','03aa8c6a-48f8-462f-a95b-5248424c657f',''),(0,16,'blog-cloud-monitor-prod.yaml','DEFAULT_GROUP','blog-cloud-monitor','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:04:48','2024-08-14 17:04:49',NULL,'192.168.56.1','I','03aa8c6a-48f8-462f-a95b-5248424c657f',''),(0,17,'blog-cloud-service-prod.yaml','DEFAULT_GROUP','blog-cloud-service','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:04:48','2024-08-14 17:04:49',NULL,'192.168.56.1','I','03aa8c6a-48f8-462f-a95b-5248424c657f',''),(0,18,'blog-cloud-auth-test.yaml','DEFAULT_GROUP','blog-cloud-auth','spring:\n  application:\n    name: blog-cloud-auth\nserver:\n  port: 8888','db03ed651126197c60aaf402c49ccc58','2024-08-14 09:05:23','2024-08-14 17:05:23',NULL,'192.168.56.1','I','ff5810ac-5eb2-485d-8c32-e0314fa30af3',''),(0,19,'datasource.yaml','DEFAULT_GROUP','','spring:\n  datasource:\n    url: jdbc:mysql://192.168.56.10:3306/nacos_config?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false\n    username: lcqh\n    password: 479368\n    driver-class-name: com.mysql.cj.jdbc.Driver\n  jpa:\n    hibernate:\n      ddl-auto: update\n    show-sql: true\n    properties:\n      hibernate:\n        dialect: org.hibernate.dialect.MySQL5Dialect','7627c57efd89a42dc06135a66fd2c9c8','2024-08-14 09:05:23','2024-08-14 17:05:23',NULL,'192.168.56.1','I','ff5810ac-5eb2-485d-8c32-e0314fa30af3',''),(0,20,'blog-cloud-gatewa-test.yaml','DEFAULT_GROUP','blog-cloud-gateway','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:05:23','2024-08-14 17:05:23',NULL,'192.168.56.1','I','ff5810ac-5eb2-485d-8c32-e0314fa30af3',''),(0,21,'blog-cloud-monitor-test.yaml','DEFAULT_GROUP','blog-cloud-monitor','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:05:23','2024-08-14 17:05:23',NULL,'192.168.56.1','I','ff5810ac-5eb2-485d-8c32-e0314fa30af3',''),(0,22,'blog-cloud-service-test.yaml','DEFAULT_GROUP','blog-cloud-service','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:05:23','2024-08-14 17:05:23',NULL,'192.168.56.1','I','ff5810ac-5eb2-485d-8c32-e0314fa30af3',''),(0,23,'blog-cloud-gatewa-dev.yaml','DEFAULT_GROUP','blog-cloud-gateway','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:06:10','2024-08-14 17:06:11',NULL,'192.168.56.1','I','91452963-e494-45b7-b518-5430c283bca1',''),(0,24,'blog-cloud-monitor-dev.yaml','DEFAULT_GROUP','blog-cloud-monitor','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:06:10','2024-08-14 17:06:11',NULL,'192.168.56.1','I','91452963-e494-45b7-b518-5430c283bca1',''),(0,25,'blog-cloud-service-dev.yaml','DEFAULT_GROUP','blog-cloud-service','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 09:06:10','2024-08-14 17:06:11',NULL,'192.168.56.1','I','91452963-e494-45b7-b518-5430c283bca1',''),(2,26,'blog-cloud-auth-dev.yaml','DEFAULT_GROUP','blog-cloud-auth','spring:\n  application:\n    name: blog-cloud-auth\nserver:\n  port: 8888','db03ed651126197c60aaf402c49ccc58','2024-08-14 11:20:20','2024-08-14 19:20:20',NULL,'192.168.56.1','U','91452963-e494-45b7-b518-5430c283bca1',''),(3,27,'datasource.yaml','DEFAULT_GROUP','','spring:\n  datasource:\n    url: jdbc:mysql://192.168.56.10:3306/nacos_config?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false\n    username: lcqh\n    password: 479368\n    driver-class-name: com.mysql.cj.jdbc.Driver\n  jpa:\n    hibernate:\n      ddl-auto: update\n    show-sql: true\n    properties:\n      hibernate:\n        dialect: org.hibernate.dialect.MySQL5Dialect','7627c57efd89a42dc06135a66fd2c9c8','2024-08-14 11:29:03','2024-08-14 19:29:04',NULL,'192.168.56.1','U','91452963-e494-45b7-b518-5430c283bca1',''),(2,28,'blog-cloud-auth-dev.yaml','DEFAULT_GROUP','blog-cloud-auth','# 配置配置应用的常规、非敏感、不变动的属性\nspring:\n  datasource:\n    # 数据库连接 URL\n    url: jdbc:mysql://192.168.56.10:3306/blog_cloud?useUnicode=true&characterEncoding=UTF-8&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=GMT%2B8\n    # 数据库用户名\n    username: lcqh_auth\n    # 数据库密码\n    password: 479368\n    # 数据库驱动类名\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    # 显式指定数据源类型为 HikariDataSource\n    type: com.zaxxer.hikari.HikariDataSource\n    # HikariCP 是一个高性能的 JDBC 连接池实现，它通常用于提高应用程序的性能和响应速度\n    hikari:\n      # 连接池中最小空闲连接数\n      minimum-idle: 5\n      # 连接池中最大连接数\n      maximum-pool-size: 10\n      # 连接闲置超时时间（毫秒）\n      idle-timeout: 600000\n      # 获取连接的超时时间（毫秒）\n      connection-timeout: 30000\n\n  data:\n    redis:\n      # Redis 服务器的 IP 地址\n      host: 192.168.56.10\n      # Redis 服务器的端口号，默认为 6379\n      port: 6379\n      # 默认使用的数据库索引，默认为 0\n      database: 0\n      # Redis 服务器的密码，如果没有设置密码，则设置为 null\n      password: 479368\n      # 命令执行的超时时间（毫秒）\n      timeout: 10000\n      # Lettuce 是 Redis 的异步客户端，它提供了高性能的非阻塞 I/O 操作。默认使用 Lettuce 作为 Redis 客户端\n\n  jackson:\n    time-zone: GMT+8\n    date-format: yyyy-MM-dd HH:mm:ss\n\n# mybatis-plus 配置\nmybatis-plus:\n  mapper-locations: classpath*:/mapper/**/*.xml\n  global-config:\n    # 关闭 mybatis-plus 横幅打印\n    banner: false\n    # 逻辑删除配置\n    db-config:\n      logic-delete-field: delFlag	 # 全局逻辑删除的实体字段名\n      logic-delete-value: 1		 # 逻辑已删除值(默认为 1)\n      logic-not-delete-value: 0		# 逻辑未删除值(默认为 0)\n  configuration:\n    # 启用 sql 打印\n    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n\n\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \"*\"\n  endpoint:\n    health:\n      show-details: always\n\n','d9040bd5b31280ed05276565efd79b03','2024-08-14 11:31:10','2024-08-14 19:31:11',NULL,'192.168.56.1','U','91452963-e494-45b7-b518-5430c283bca1',''),(21,29,'blog-cloud-service-dev.yaml','DEFAULT_GROUP','blog-cloud-service','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-14 14:38:23','2024-08-14 22:38:23',NULL,'192.168.56.1','U','91452963-e494-45b7-b518-5430c283bca1',''),(21,30,'blog-cloud-service-dev.yaml','DEFAULT_GROUP','blog-cloud-service','spring:\n  application:\n    name: blog-cloud-service','62f08ee99f47ba54d2b42e97df634a8c','2024-08-14 14:42:35','2024-08-14 22:42:36',NULL,'192.168.56.1','U','91452963-e494-45b7-b518-5430c283bca1',''),(20,31,'blog-cloud-monitor-dev.yaml','DEFAULT_GROUP','blog-cloud-monitor','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-15 15:42:04','2024-08-15 23:42:04',NULL,'192.168.56.1','U','91452963-e494-45b7-b518-5430c283bca1',''),(21,32,'blog-cloud-service-dev.yaml','DEFAULT_GROUP','blog-cloud-service','server:\n  port: 6666','0497cba2d664dfa20f83833cef3bdabd','2024-08-15 15:42:30','2024-08-15 23:42:31',NULL,'192.168.56.1','U','91452963-e494-45b7-b518-5430c283bca1',''),(19,33,'blog-cloud-gatewa-dev.yaml','DEFAULT_GROUP','blog-cloud-gateway','spring:\n  application:\n    name: blog-cloud-auth','f40b01eed1985e51f3f497dcb5a8a140','2024-08-15 15:42:54','2024-08-15 23:42:55',NULL,'192.168.56.1','U','91452963-e494-45b7-b518-5430c283bca1',''),(2,34,'blog-cloud-auth-dev.yaml','DEFAULT_GROUP','blog-cloud-auth','server:\n  port: 8888','6a6bcb9ba8da29304e3a66661dec84a2','2024-08-15 15:43:21','2024-08-15 23:43:22',NULL,'192.168.56.1','U','91452963-e494-45b7-b518-5430c283bca1',''),(21,35,'blog-cloud-service-dev.yaml','DEFAULT_GROUP','blog-cloud-service','spring:\n  application:\n    name: blog-cloud-service','62f08ee99f47ba54d2b42e97df634a8c','2024-08-16 13:01:30','2024-08-16 21:01:30',NULL,'192.168.56.1','U','91452963-e494-45b7-b518-5430c283bca1','');
/*!40000 ALTER TABLE `his_config_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `role` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'role',
  `resource` varchar(128) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'resource',
  `action` varchar(8) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'action',
  UNIQUE KEY `uk_role_permission` (`role`,`resource`,`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `username` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'username',
  `role` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'role',
  UNIQUE KEY `idx_user_role` (`username`,`role`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_capacity`
--

DROP TABLE IF EXISTS `tenant_capacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_capacity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数',
  `max_aggr_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='租户容量信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_capacity`
--

LOCK TABLES `tenant_capacity` WRITE;
/*!40000 ALTER TABLE `tenant_capacity` DISABLE KEYS */;
/*!40000 ALTER TABLE `tenant_capacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_info`
--

DROP TABLE IF EXISTS `tenant_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_info_kptenantid` (`kp`,`tenant_id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='tenant_info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_info`
--

LOCK TABLES `tenant_info` WRITE;
/*!40000 ALTER TABLE `tenant_info` DISABLE KEYS */;
INSERT INTO `tenant_info` VALUES (1,'1','91452963-e494-45b7-b518-5430c283bca1','dev','开发环境','nacos',1723622590803,1723622590803),(2,'1','03aa8c6a-48f8-462f-a95b-5248424c657f','prod','生产环境','nacos',1723622703793,1723622703793),(3,'1','ff5810ac-5eb2-485d-8c32-e0314fa30af3','test','测试环境','nacos',1723622717352,1723622717352);
/*!40000 ALTER TABLE `tenant_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'username',
  `password` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'password',
  `enabled` tinyint(1) NOT NULL COMMENT 'enabled',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'nacos_config'
--

--
-- Dumping routines for database 'nacos_config'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-20 11:59:55
