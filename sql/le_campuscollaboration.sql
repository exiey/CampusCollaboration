/*
 Navicat Premium Dump SQL

 Source Server         : crazy
 Source Server Type    : MySQL
 Source Server Version : 80043 (8.0.43)
 Source Host           : localhost:3306
 Source Schema         : le_campuscollaboration

 Target Server Type    : MySQL
 Target Server Version : 80043 (8.0.43)
 File Encoding         : 65001

 Date: 13/04/2026 17:00:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for campus_leave_apply
-- ----------------------------
DROP TABLE IF EXISTS `campus_leave_apply`;
CREATE TABLE `campus_leave_apply`  (
  `leave_id` bigint NOT NULL AUTO_INCREMENT COMMENT '请假ID',
  `applicant_user_id` bigint NOT NULL COMMENT '申请人ID',
  `approver_user_id` bigint NULL DEFAULT NULL COMMENT '审批教师ID',
  `leave_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请假类型（1事假 2病假 3其他）',
  `leave_title` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '请假标题',
  `leave_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请假原因',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `leave_days` decimal(5, 1) NOT NULL DEFAULT 1.0 COMMENT '请假天数',
  `leave_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '审批状态（0待审批 1已批准 2已驳回 3已撤回）',
  `contact_phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '联系电话',
  `audit_remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '审批意见',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审批时间',
  `revoke_time` datetime NULL DEFAULT NULL COMMENT '撤回时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0存在 2删除）',
  PRIMARY KEY (`leave_id`) USING BTREE,
  INDEX `idx_leave_applicant`(`applicant_user_id` ASC) USING BTREE,
  INDEX `idx_leave_approver`(`approver_user_id` ASC) USING BTREE,
  INDEX `idx_leave_status`(`leave_status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '校园请假申请表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of campus_leave_apply
-- ----------------------------
INSERT INTO `campus_leave_apply` VALUES (1, 2, 1, '1', '返校交通请假', '周末返校车次延误，需要顺延一天返校并补做课程任务。', '2026-04-12 08:00:00', '2026-04-12 18:00:00', 1.0, '1', '13800138002', 'ͬ��', '2026-04-12 23:44:58', NULL, 'student01', '2026-04-11 09:10:00', 'admin', '2026-04-12 23:44:58', '等待教师审批', '2');
INSERT INTO `campus_leave_apply` VALUES (2, 2, 3, '2', '感冒就诊请假', '上午发热去校医院就诊，需要请假半天。', '2026-04-02 08:30:00', '2026-04-02 12:00:00', 0.5, '1', '13800138002', '注意休息，下午返班后补交课程记录。', '2026-04-02 09:00:00', NULL, 'student01', '2026-04-02 08:10:00', 'teacher01', '2026-04-02 09:00:00', '已审批通过', '0');
INSERT INTO `campus_leave_apply` VALUES (3, 2, 3, '3', '竞赛集训请假', '需参加校级竞赛集训，希望调整晚自习签到。', '2026-04-06 18:30:00', '2026-04-07 21:00:00', 1.0, '2', '13800138002', '请先补齐指导教师签字材料后再次提交。', '2026-04-06 17:45:00', NULL, 'student01', '2026-04-06 15:20:00', 'teacher01', '2026-04-06 17:45:00', '材料不完整被驳回', '0');
INSERT INTO `campus_leave_apply` VALUES (101, 2, NULL, '1', '123', '12312312312', '2026-04-13 15:33:41', '2026-04-14 00:00:00', 1.0, '3', NULL, '', NULL, '2026-04-13 15:33:49', 'student01', '2026-04-13 15:33:46', 'student01', '2026-04-13 15:33:49', NULL, '2');
INSERT INTO `campus_leave_apply` VALUES (102, 2, 3, '1', '321', '12312312312312', '2026-04-13 16:56:43', '2026-04-14 00:00:00', 1.0, '1', NULL, '3123123123', '2026-04-13 16:56:59', NULL, 'student01', '2026-04-13 16:56:48', 'teacher01', '2026-04-13 16:56:59', NULL, '0');

-- ----------------------------
-- Table structure for campus_shared_file
-- ----------------------------
DROP TABLE IF EXISTS `campus_shared_file`;
CREATE TABLE `campus_shared_file`  (
  `file_id` bigint NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `file_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件标题',
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '原始文件名',
  `file_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '访问地址',
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '存储路径',
  `file_suffix` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '文件后缀',
  `file_size` bigint NOT NULL DEFAULT 0 COMMENT '文件大小（字节）',
  `file_category` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '4' COMMENT '文件分类（1教学资料 2作业文档 3通知文件 4其他）',
  `access_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '访问范围（0全员可见 1仅教师可见 2仅管理员可见）',
  `upload_user_id` bigint NOT NULL COMMENT '上传用户ID',
  `download_count` int NOT NULL DEFAULT 0 COMMENT '下载次数',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '状态（0正常 1隐藏）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0存在 2删除）',
  PRIMARY KEY (`file_id`) USING BTREE,
  INDEX `idx_shared_file_user`(`upload_user_id` ASC) USING BTREE,
  INDEX `idx_shared_file_category`(`file_category` ASC) USING BTREE,
  INDEX `idx_shared_file_scope`(`access_scope` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '校园共享文件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of campus_shared_file
-- ----------------------------
INSERT INTO `campus_shared_file` VALUES (1, '开题模板与排版要求', '开题模板.docx', '/profile/upload/2026/04/opening-template.docx', '/upload/2026/04/opening-template.docx', 'docx', 245760, '1', '0', 3, 13, '0', 'teacher01', '2026-04-05 08:40:00', 'teacher01', '2026-04-05 08:40:00', '教师共享模板文件', '0');
INSERT INTO `campus_shared_file` VALUES (2, '任务分工说明', '任务分工说明.pdf', '/profile/upload/2026/04/task-division.pdf', '/upload/2026/04/task-division.pdf', 'pdf', 184320, '2', '0', 2, 5, '0', 'student01', '2026-04-09 19:15:00', 'admin', '2026-04-13 16:37:53', '学生上传的协作文档', '0');
INSERT INTO `campus_shared_file` VALUES (3, '教师审批规范', '教师审批规范.xlsx', '/profile/upload/2026/04/teacher-approval-rule.xlsx', '/upload/2026/04/teacher-approval-rule.xlsx', 'xlsx', 102400, '3', '1', 1, 3, '0', 'admin', '2026-04-07 10:00:00', 'admin', '2026-04-07 10:00:00', '教师审批工作参考文件', '0');

-- ----------------------------
-- Table structure for campus_task
-- ----------------------------
DROP TABLE IF EXISTS `campus_task`;
CREATE TABLE `campus_task`  (
  `task_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `task_title` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务标题',
  `task_content` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '任务内容',
  `publish_user_id` bigint NOT NULL COMMENT '发布教师ID',
  `receive_user_id` bigint NOT NULL COMMENT '接收学生ID',
  `priority` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '优先级（0低 1中 2高 3紧急）',
  `task_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '任务状态（0待处理 1进行中 2已完成 3已取消）',
  `progress_percent` int NOT NULL DEFAULT 0 COMMENT '进度百分比',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `deadline_time` datetime NULL DEFAULT NULL COMMENT '截止时间',
  `finish_time` datetime NULL DEFAULT NULL COMMENT '完成时间',
  `attachment_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '附件名称',
  `attachment_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '附件地址',
  `comment_count` int NOT NULL DEFAULT 0 COMMENT '评论数量',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0存在 2删除）',
  PRIMARY KEY (`task_id`) USING BTREE,
  INDEX `idx_task_publish_user`(`publish_user_id` ASC) USING BTREE,
  INDEX `idx_task_receive_user`(`receive_user_id` ASC) USING BTREE,
  INDEX `idx_task_status`(`task_status` ASC) USING BTREE,
  INDEX `idx_task_deadline`(`deadline_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '校园任务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of campus_task
-- ----------------------------
INSERT INTO `campus_task` VALUES (1, '毕业设计开题报告提交', '请根据导师意见补充研究现状与技术路线，并在截止前上传开题报告初稿。', 3, 2, '3', '1', 70, '2026-04-08 08:30:00', '2026-04-12 18:00:00', NULL, '开题报告任务说明.docx', '/profile/upload/2026/04/task-opening-guide.docx', 3, 'teacher01', '2026-04-08 08:30:00', 'admin', '2026-04-13 16:37:21', '导师重点关注国内外研究现状部分', '0');
INSERT INTO `campus_task` VALUES (2, '校园协同平台功能演示彩排', '请梳理任务中心、文件中心和请假审批三条核心流程，准备下周课堂演示。', 3, 2, '2', '1', 0, '2026-04-10 09:00:00', '2026-04-15 17:30:00', NULL, '', '', 3, 'teacher01', '2026-04-10 09:00:00', 'student01', '2026-04-13 16:56:14', '用于班级项目展示', '0');
INSERT INTO `campus_task` VALUES (3, '班级周报整理', '将本周班级任务完成情况汇总成周报并提交给指导教师。', 3, 2, '1', '2', 100, '2026-04-01 14:00:00', '2026-04-03 18:00:00', '2026-04-03 16:20:00', '班级周报模板.xlsx', '/profile/upload/2026/04/class-weekly-template.xlsx', 1, 'teacher01', '2026-04-01 14:00:00', 'student01', '2026-04-03 16:20:00', '已用于教师周例会', '0');

-- ----------------------------
-- Table structure for campus_task_comment
-- ----------------------------
DROP TABLE IF EXISTS `campus_task_comment`;
CREATE TABLE `campus_task_comment`  (
  `comment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `task_id` bigint NOT NULL COMMENT '任务ID',
  `comment_user_id` bigint NOT NULL COMMENT '评论用户ID',
  `reply_user_id` bigint NULL DEFAULT NULL COMMENT '回复目标用户ID',
  `comment_content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0存在 2删除）',
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `idx_task_comment_task`(`task_id` ASC) USING BTREE,
  INDEX `idx_task_comment_user`(`comment_user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '校园任务评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of campus_task_comment
-- ----------------------------
INSERT INTO `campus_task_comment` VALUES (1, 1, 3, 2, '请补充近五年的校园协同平台相关文献，并把技术路线图一起上传。', 'teacher01', '2026-04-09 09:20:00', 'teacher01', '2026-04-09 09:20:00', '导师评论', '0');
INSERT INTO `campus_task_comment` VALUES (2, 1, 2, 3, '已补充 3 篇参考文献，今晚会提交更新后的版本。', 'student01', '2026-04-10 20:00:00', 'student01', '2026-04-10 20:00:00', '学生反馈', '0');
INSERT INTO `campus_task_comment` VALUES (3, 3, 2, 3, '周报已经提交到共享文件区，请老师查收。', 'student01', '2026-04-03 16:25:00', 'student01', '2026-04-03 16:25:00', '结项说明', '0');
INSERT INTO `campus_task_comment` VALUES (100, 2, 1, NULL, '123123', 'admin', '2026-04-13 13:46:54', '', NULL, NULL, '0');
INSERT INTO `campus_task_comment` VALUES (101, 1, 1, NULL, '3213213123', 'admin', '2026-04-13 16:37:30', '', NULL, NULL, '0');
INSERT INTO `campus_task_comment` VALUES (102, 2, 3, NULL, '32131231', 'teacher01', '2026-04-13 16:51:55', '', NULL, NULL, '0');
INSERT INTO `campus_task_comment` VALUES (103, 2, 2, NULL, '312312', 'student01', '2026-04-13 16:56:18', '', NULL, NULL, '0');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '日历信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '已触发的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '暂停的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '调度器状态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '触发器详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-12-18 18:03:00', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-12-18 18:03:00', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-light', 'Y', 'admin', '2025-12-18 18:03:00', 'admin', '2026-04-12 23:24:47', '校园协同工作平台默认使用浅色主题');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2025-12-18 18:03:00', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2025-12-18 18:03:00', 'admin', '2026-04-12 23:24:47', '开启用户注册功能，供学生自助注册');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-12-18 18:03:00', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2025-12-18 18:03:00', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2025-12-18 18:03:00', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (9, '账号自助-默认注册角色', 'sys.user.defaultRole', '2', 'N', 'admin', '2026-04-12 23:24:47', 'admin', '2026-04-12 23:24:47', '学生角色 role_id=2');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '湖北文理学院', 0, '校长办公室', '13800138001', 'office@hbuas.edu.cn', '0', '0', 'admin', '2025-12-18 18:02:59', 'admin', '2026-04-12 23:24:47');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '计算机工程学院', 1, '王院长', '13800138004', 'cs@hbuas.edu.cn', '0', '0', 'admin', '2025-12-18 18:02:59', 'admin', '2026-04-12 23:24:47');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '管理学院', 2, '赵院长', '13800138005', 'manage@hbuas.edu.cn', '0', '0', 'admin', '2025-12-18 18:02:59', 'admin', '2026-04-12 23:24:47');
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '物联网工程2432班', 1, '李老师', '13800138003', 'iot2432@hbuas.edu.cn', '0', '0', 'admin', '2025-12-18 18:02:59', 'admin', '2026-04-12 23:24:47');
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '软件工程2431班', 2, '周老师', '13800138006', 'se2431@hbuas.edu.cn', '0', '0', 'admin', '2025-12-18 18:02:59', 'admin', '2026-04-12 23:24:47');
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '数据科学2311班', 3, '陈老师', '13800138007', 'ds2311@hbuas.edu.cn', '0', '0', 'admin', '2025-12-18 18:02:59', 'admin', '2026-04-12 23:24:47');
INSERT INTO `sys_dept` VALUES (106, 100, '0,100', '校园信息中心', 3, '系统平台主管', '13800138008', 'it@hbuas.edu.cn', '0', '0', 'admin', '2025-12-18 18:02:59', 'admin', '2026-04-12 23:24:47');
INSERT INTO `sys_dept` VALUES (107, 100, '0,100', '学生工作处', 4, '辅导员办公室', '13800138009', 'student@hbuas.edu.cn', '0', '0', 'admin', '2025-12-18 18:02:59', 'admin', '2026-04-12 23:24:47');
INSERT INTO `sys_dept` VALUES (108, 100, '0,100', '文学院', 5, '刘院长', '13800138010', 'arts@hbuas.edu.cn', '0', '0', 'admin', '2025-12-18 18:02:59', 'admin', '2026-04-12 23:24:47');
INSERT INTO `sys_dept` VALUES (109, 100, '0,100', '国际教育学院', 6, '孙院长', '13800138011', 'global@hbuas.edu.cn', '0', '0', 'admin', '2025-12-18 18:02:59', 'admin', '2026-04-12 23:24:47');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 124 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (102, 1, '待处理', '0', 'campus_task_status', '', 'info', 'Y', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '任务初始状态');
INSERT INTO `sys_dict_data` VALUES (103, 2, '进行中', '1', 'campus_task_status', '', 'warning', 'N', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '任务执行中状态');
INSERT INTO `sys_dict_data` VALUES (104, 3, '已完成', '2', 'campus_task_status', '', 'success', 'N', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '任务完成状态');
INSERT INTO `sys_dict_data` VALUES (105, 4, '已取消', '3', 'campus_task_status', '', 'info', 'N', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '任务取消状态');
INSERT INTO `sys_dict_data` VALUES (106, 1, '低', '0', 'campus_task_priority', '', 'info', 'N', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '低优先级任务');
INSERT INTO `sys_dict_data` VALUES (107, 2, '中', '1', 'campus_task_priority', '', 'primary', 'Y', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '中优先级任务');
INSERT INTO `sys_dict_data` VALUES (108, 3, '高', '2', 'campus_task_priority', '', 'warning', 'N', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '高优先级任务');
INSERT INTO `sys_dict_data` VALUES (109, 4, '紧急', '3', 'campus_task_priority', '', 'danger', 'N', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '紧急任务');
INSERT INTO `sys_dict_data` VALUES (110, 1, '教学资料', '1', 'campus_file_category', '', 'primary', 'Y', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '课程与教学资料');
INSERT INTO `sys_dict_data` VALUES (111, 2, '作业文档', '2', 'campus_file_category', '', 'success', 'N', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '作业与成果文件');
INSERT INTO `sys_dict_data` VALUES (112, 3, '通知文件', '3', 'campus_file_category', '', 'warning', 'N', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '通知与公告附件');
INSERT INTO `sys_dict_data` VALUES (113, 4, '其他', '4', 'campus_file_category', '', 'info', 'N', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '其他业务文件');
INSERT INTO `sys_dict_data` VALUES (114, 1, '全员可见', '0', 'campus_file_scope', '', 'primary', 'Y', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '师生均可访问');
INSERT INTO `sys_dict_data` VALUES (115, 2, '仅教师可见', '1', 'campus_file_scope', '', 'warning', 'N', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '仅教师与管理员可见');
INSERT INTO `sys_dict_data` VALUES (116, 3, '仅管理员可见', '2', 'campus_file_scope', '', 'danger', 'N', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '仅管理员可见');
INSERT INTO `sys_dict_data` VALUES (117, 1, '事假', '1', 'campus_leave_type', '', 'primary', 'Y', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '个人事务请假');
INSERT INTO `sys_dict_data` VALUES (118, 2, '病假', '2', 'campus_leave_type', '', 'danger', 'N', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '身体不适请假');
INSERT INTO `sys_dict_data` VALUES (119, 3, '其他', '3', 'campus_leave_type', '', 'info', 'N', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '其他原因请假');
INSERT INTO `sys_dict_data` VALUES (120, 1, '待审批', '0', 'campus_leave_status', '', 'warning', 'Y', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '请假提交后待审批');
INSERT INTO `sys_dict_data` VALUES (121, 2, '已批准', '1', 'campus_leave_status', '', 'success', 'N', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '请假已批准');
INSERT INTO `sys_dict_data` VALUES (122, 3, '已驳回', '2', 'campus_leave_status', '', 'danger', 'N', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '请假被驳回');
INSERT INTO `sys_dict_data` VALUES (123, 4, '已撤回', '3', 'campus_leave_status', '', 'info', 'N', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '请假已撤回');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 107 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (101, '任务状态', 'campus_task_status', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '校园协同工作平台任务状态');
INSERT INTO `sys_dict_type` VALUES (102, '任务优先级', 'campus_task_priority', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '校园协同工作平台任务优先级');
INSERT INTO `sys_dict_type` VALUES (103, '文件分类', 'campus_file_category', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '校园协同工作平台文件分类');
INSERT INTO `sys_dict_type` VALUES (104, '文件访问范围', 'campus_file_scope', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '校园协同工作平台文件访问范围');
INSERT INTO `sys_dict_type` VALUES (105, '请假类型', 'campus_leave_type', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '校园协同工作平台请假类型');
INSERT INTO `sys_dict_type` VALUES (106, '请假状态', 'campus_leave_status', '0', 'admin', '2026-04-12 23:24:48', '', NULL, '校园协同工作平台请假状态');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-12-18 18:03:01', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-12-18 18:03:01', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-12-18 18:03:01', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 141 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 143', 'Windows10', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 143', 'Windows10', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 143', 'Windows10', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 143', 'Windows10', '1', '验证码错误', NULL);
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 143', 'Windows10', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 143', 'Windows10', '0', '退出成功', NULL);
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 143', 'Windows10', '1', '验证码错误', NULL);
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 143', 'Windows10', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Curl 8.16.0', '', '1', '验证码已失效', NULL);
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Curl 8.16.0', '', '1', '验证码已失效', NULL);
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Curl 8.16.0', '', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Curl 8.16.0', '', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Curl 8.16.0', '', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Curl 8.16.0', '', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Curl 8.16.0', '', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Curl 8.16.0', '', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Curl 8.16.0', '', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (117, 'teacher01', '127.0.0.1', '内网IP', 'Curl 8.16.0', '', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (118, 'testuser01', '127.0.0.1', '内网IP', 'Curl 8.16.0', '', '0', '注册成功', NULL);
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '退出成功', NULL);
INSERT INTO `sys_logininfor` VALUES (124, 'teacher01', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '1', '验证码错误', NULL);
INSERT INTO `sys_logininfor` VALUES (125, 'teacher01', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (127, 'student01', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '1', '验证码已失效', NULL);
INSERT INTO `sys_logininfor` VALUES (128, 'student01', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (129, 'student01', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (130, 'student01', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '退出成功', NULL);
INSERT INTO `sys_logininfor` VALUES (131, 'teacher01', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (132, 'teacher01', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '退出成功', NULL);
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '退出成功', NULL);
INSERT INTO `sys_logininfor` VALUES (135, 'teacher01', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (136, 'teacher01', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '退出成功', NULL);
INSERT INTO `sys_logininfor` VALUES (137, 'teacher01', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (138, 'student01', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '1', '验证码已失效', NULL);
INSERT INTO `sys_logininfor` VALUES (139, 'student01', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', NULL);
INSERT INTO `sys_logininfor` VALUES (140, 'student01', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '退出成功', NULL);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2216 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-12-18 18:03:00', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '1', '1', '', 'monitor', 'admin', '2025-12-18 18:03:00', 'admin', '2026-04-13 13:40:10', '系统监控目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-12-18 18:03:00', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-12-18 18:03:00', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '1', '0', 'system:menu:list', 'tree-table', 'admin', '2025-12-18 18:03:00', 'admin', '2026-04-13 13:40:31', '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '1', '0', 'system:dept:list', 'tree', 'admin', '2025-12-18 18:03:00', 'admin', '2026-04-13 13:40:27', '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '1', '0', 'system:post:list', 'post', 'admin', '2025-12-18 18:03:00', 'admin', '2026-04-13 13:40:24', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '1', '0', 'system:dict:list', 'dict', 'admin', '2025-12-18 18:03:00', 'admin', '2026-04-13 13:40:21', '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '1', '0', 'system:config:list', 'edit', 'admin', '2025-12-18 18:03:00', 'admin', '2026-04-13 13:40:18', '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-12-18 18:03:00', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-12-18 18:03:00', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-12-18 18:03:00', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-12-18 18:03:00', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-12-18 18:03:00', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-12-18 18:03:00', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-12-18 18:03:00', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-12-18 18:03:00', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-12-18 18:03:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '校园协同', 0, 3, 'campus', NULL, '', '', 1, 0, 'M', '0', '0', '', 'education', 'admin', '2026-04-13 13:40:58', '', NULL, '校园协同管理目录');
INSERT INTO `sys_menu` VALUES (2001, '任务管理', 2000, 1, 'task', 'campus/task/index', '', '', 1, 0, 'C', '0', '0', 'campus:task:list', 'edit', 'admin', '2026-04-13 13:40:58', '', NULL, '任务管理菜单');
INSERT INTO `sys_menu` VALUES (2010, '任务查询', 2001, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'campus:task:query', '#', 'admin', '2026-04-13 13:40:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '任务新增', 2001, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'campus:task:add', '#', 'admin', '2026-04-13 13:40:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '任务修改', 2001, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'campus:task:edit', '#', 'admin', '2026-04-13 13:40:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2013, '任务删除', 2001, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'campus:task:remove', '#', 'admin', '2026-04-13 13:40:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2014, '任务导出', 2001, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'campus:task:export', '#', 'admin', '2026-04-13 13:40:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2101, '文件管理', 2000, 2, 'file', 'campus/file/index', '', '', 1, 0, 'C', '0', '0', 'campus:file:list', 'documentation', 'admin', '2026-04-13 13:40:58', '', NULL, '文件管理菜单');
INSERT INTO `sys_menu` VALUES (2110, '文件查询', 2101, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'campus:file:query', '#', 'admin', '2026-04-13 13:40:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2111, '文件新增', 2101, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'campus:file:add', '#', 'admin', '2026-04-13 13:40:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2112, '文件修改', 2101, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'campus:file:edit', '#', 'admin', '2026-04-13 13:40:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2113, '文件删除', 2101, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'campus:file:remove', '#', 'admin', '2026-04-13 13:40:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2114, '文件导出', 2101, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'campus:file:export', '#', 'admin', '2026-04-13 13:40:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2201, '请假管理', 2000, 3, 'leave', 'campus/leave/index', '', '', 1, 0, 'C', '0', '0', 'campus:leave:list', 'date', 'admin', '2026-04-13 13:40:58', '', NULL, '请假管理菜单');
INSERT INTO `sys_menu` VALUES (2210, '请假查询', 2201, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'campus:leave:query', '#', 'admin', '2026-04-13 13:40:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2211, '请假新增', 2201, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'campus:leave:add', '#', 'admin', '2026-04-13 13:40:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2212, '请假修改', 2201, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'campus:leave:edit', '#', 'admin', '2026-04-13 13:40:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2213, '请假删除', 2201, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'campus:leave:remove', '#', 'admin', '2026-04-13 13:40:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2214, '请假导出', 2201, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'campus:leave:export', '#', 'admin', '2026-04-13 13:40:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2215, '请假审批', 2201, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'campus:leave:audit', '#', 'admin', '2026-04-13 13:40:58', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '开题答辩资料提交通知', '2', 0xE8AFB7E59084E78FADE5ADA6E7949FE4BA8EE69CACE591A8E4BA9431383A3030E5898DE59CA8E5B9B3E58FB0E4BBBBE58AA1E4B8ADE5BF83E68F90E4BAA4E5BC80E9A298E7AD94E8BEA9E8B584E69699EFBC8CE68C87E5AFBCE69599E5B888E59CA8E7BABFE5AEA1E6A0B8E38082, '0', 'admin', '2025-12-18 18:03:01', 'admin', '2026-04-12 23:24:47', '校园公告');
INSERT INTO `sys_notice` VALUES (2, '平台维护提醒：本周日晚系统巡检', '1', 0xE6A0A1E59BADE58D8FE5908CE5B7A5E4BD9CE5B9B3E58FB0E5B086E4BA8EE69CACE591A8E697A532323A30302D32333A3030E8BF9BE8A18CE4BE8BE8A18CE5B7A1E6A380EFBC8CE69C9FE997B4E69687E4BBB6E4B88AE4BCA0E4B88EE8AFB7E58187E5AEA1E689B9E58A9FE883BDE58FAFE883BDE79FADE69A82E4B88DE58FAFE794A8E38082, '0', 'admin', '2025-12-18 18:03:01', 'admin', '2026-04-12 23:24:47', '运维通知');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 156 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, 'BizUnit管理', 1, 'com.ruoyi.generator.controller.GenEnhancedController.saveBizUnit()', 'POST', 1, 'admin', '研发部门', '/tool/gen/bizUnit/save', '127.0.0.1', '内网IP', '{\"aggregate\":true,\"associationsJson\":\"[{\\\"mainField\\\":\\\"parent_id\\\",\\\"refTable\\\":\\\"biz_category\\\",\\\"refField\\\":\\\"category_id\\\",\\\"labelField\\\":\\\"category_name\\\",\\\"strategy\\\":\\\"JOIN\\\"},{\\\"mainField\\\":\\\"create_by\\\",\\\"refTable\\\":\\\"sys_user\\\",\\\"refField\\\":\\\"user_id\\\",\\\"labelField\\\":\\\"user_name\\\",\\\"strategy\\\":\\\"JOIN\\\"},{\\\"mainField\\\":\\\"update_by\\\",\\\"refTable\\\":\\\"sys_user\\\",\\\"refField\\\":\\\"user_id\\\",\\\"labelField\\\":\\\"user_name\\\",\\\"strategy\\\":\\\"JOIN\\\"}]\",\"bizKey\":\"category\",\"bizName\":\"产品分类\",\"bizPath\":\"category\",\"dependenciesJson\":\"[{\\\"bizKey\\\":\\\"sys-user\\\",\\\"serviceClass\\\":\\\"ISysUserService\\\",\\\"fieldName\\\":\\\"sysUserService\\\",\\\"required\\\":true}]\",\"id\":1,\"mainTableId\":2,\"schemaVersion\":\"1.0.0\",\"singleTable\":false,\"subTablesJson\":\"[{\\\"tableId\\\":5,\\\"fkColumn\\\":\\\"category_id\\\",\\\"relationType\\\":\\\"ONE_TO_MANY\\\",\\\"cascadeDelete\\\":true},{\\\"tableId\\\":6,\\\"fkColumn\\\":\\\"category_id\\\",\\\"relationType\\\":\\\"ONE_TO_MANY\\\",\\\"cascadeDelete\\\":false}]\",\"updateTime\":\"2025-12-18 21:44:43.804805800\"} ', '{\"body\":{\"aggregate\":true,\"associationsJson\":\"[{\\\"mainField\\\":\\\"parent_id\\\",\\\"refTable\\\":\\\"biz_category\\\",\\\"refField\\\":\\\"category_id\\\",\\\"labelField\\\":\\\"category_name\\\",\\\"strategy\\\":\\\"JOIN\\\"},{\\\"mainField\\\":\\\"create_by\\\",\\\"refTable\\\":\\\"sys_user\\\",\\\"refField\\\":\\\"user_id\\\",\\\"labelField\\\":\\\"user_name\\\",\\\"strategy\\\":\\\"JOIN\\\"},{\\\"mainField\\\":\\\"update_by\\\",\\\"refTable\\\":\\\"sys_user\\\",\\\"refField\\\":\\\"user_id\\\",\\\"labelField\\\":\\\"user_name\\\",\\\"strategy\\\":\\\"JOIN\\\"}]\",\"bizKey\":\"category\",\"bizName\":\"产品分类\",\"bizPath\":\"category\",\"dependenciesJson\":\"[{\\\"bizKey\\\":\\\"sys-user\\\",\\\"serviceClass\\\":\\\"ISysUserService\\\",\\\"fieldName\\\":\\\"sysUserService\\\",\\\"required\\\":true}]\",\"id\":1,\"mainTableId\":2,\"schemaVersion\":\"1.0.0\",\"singleTable\":false,\"subTablesJson\":\"[{\\\"tableId\\\":5,\\\"fkColumn\\\":\\\"category_id\\\",\\\"relationType\\\":\\\"ONE_TO_MANY\\\",\\\"cascadeDelete\\\":true},{\\\"tableId\\\":6,\\\"fkColumn\\\":\\\"category_id\\\",\\\"relationType\\\":\\\"ONE_TO_MANY\\\",\\\"cascadeDelete\\\":false}]\",\"updateTime\":\"2025-12-18 21:44:43.804805800\"},\"headers\":{},\"statusCode\":\"OK\",\"statusCodeValue\":200}', 0, '', NULL, 45);
INSERT INTO `sys_oper_log` VALUES (101, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"category\",\"className\":\"BizCategory\",\"columns\":[{\"capJavaField\":\"CategoryId\",\"columnComment\":\"分类ID\",\"columnId\":18,\"columnName\":\"category_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-12-18 19:03:03\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"categoryId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ParentId\",\"columnComment\":\"父分类ID\",\"columnId\":19,\"columnName\":\"parent_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-12-18 19:03:03\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"parentId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":true,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":true},{\"capJavaField\":\"Ancestors\",\"columnComment\":\"祖级列表\",\"columnId\":20,\"columnName\":\"ancestors\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-12-18 19:03:03\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"ancestors\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":true,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CategoryName\",\"columnComment\":\"分类名称\",\"columnId\":21,\"columnName\":\"category_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-12-18 19:03:03\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"is', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 83);
INSERT INTO `sys_oper_log` VALUES (102, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"产品分类表-删除标志\",\"dictType\":\"biz_category_del_flag\",\"params\":{},\"remark\":\"由AI智能推荐自动创建\",\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 188);
INSERT INTO `sys_oper_log` VALUES (103, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"cssClass\":\"\",\"default\":false,\"dictLabel\":\"存在\",\"dictSort\":1,\"dictType\":\"biz_category_del_flag\",\"dictValue\":\"0\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 23);
INSERT INTO `sys_oper_log` VALUES (104, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"cssClass\":\"\",\"default\":false,\"dictLabel\":\"删除\",\"dictSort\":2,\"dictType\":\"biz_category_del_flag\",\"dictValue\":\"2\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 16);
INSERT INTO `sys_oper_log` VALUES (105, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":103,\"nickName\":\"ceshi\",\"params\":{},\"postIds\":[1,2],\"roleIds\":[2],\"sex\":\"0\",\"status\":\"0\",\"userId\":100,\"userName\":\"ceshi\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 163);
INSERT INTO `sys_oper_log` VALUES (106, '用户管理', 4, 'com.ruoyi.web.controller.system.SysUserController.insertAuthRole()', 'PUT', 1, 'admin', '研发部门', '/system/user/authRole', '127.0.0.1', '内网IP', '{\"roleIds\":\"2\",\"userId\":\"100\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 24);
INSERT INTO `sys_oper_log` VALUES (107, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2026-01-14 14:25:37\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发部门\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"\",\"loginIp\":\"\",\"nickName\":\"ceshi\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[1,2],\"remark\":\"123\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"ceshi\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 1989);
INSERT INTO `sys_oper_log` VALUES (108, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2026-01-14 14:25:37\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发部门\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"\",\"loginIp\":\"\",\"nickName\":\"ceshi\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[1,2],\"remark\":\"123\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"ceshi\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 780);
INSERT INTO `sys_oper_log` VALUES (109, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', '研发部门', '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 4828);
INSERT INTO `sys_oper_log` VALUES (110, '用户管理', 3, 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/user/100', '127.0.0.1', '内网IP', '[100] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 829);
INSERT INTO `sys_oper_log` VALUES (111, '用户管理', 5, 'com.ruoyi.web.controller.system.SysUserController.export()', 'POST', 1, 'admin', '研发部门', '/system/user/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', '', 0, '', NULL, 694);
INSERT INTO `sys_oper_log` VALUES (112, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114],\"params\":{},\"roleId\":100,\"roleKey\":\"cs\",\"roleName\":\"cs\",\"roleSort\":3,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 275);
INSERT INTO `sys_oper_log` VALUES (113, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', '研发部门', '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2026-01-14 14:27:08\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"roleId\":100,\"roleKey\":\"cs\",\"roleName\":\"cs\",\"roleSort\":3,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 28);
INSERT INTO `sys_oper_log` VALUES (114, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2026-01-14 14:27:08\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[3,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,115],\"params\":{},\"roleId\":100,\"roleKey\":\"cs\",\"roleName\":\"cs\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 37);
INSERT INTO `sys_oper_log` VALUES (115, '角色管理', 3, 'com.ruoyi.web.controller.system.SysRoleController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/role/100', '127.0.0.1', '内网IP', '[100] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 37);
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"color\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"sc\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"cs\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 28);
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2000', '127.0.0.1', '内网IP', '2000 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 257);
INSERT INTO `sys_oper_log` VALUES (118, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":101,\"deptName\":\"深圳总公司\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"parentName\":\"若依科技\",\"phone\":\"15888888888\",\"status\":\"1\"} ', '{\"msg\":\"该部门包含未停用的子部门！\",\"code\":500}', 0, '', NULL, 14);
INSERT INTO `sys_oper_log` VALUES (119, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,102\",\"children\":[],\"deptId\":109,\"deptName\":\"财务部门\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":2,\"params\":{},\"parentId\":102,\"parentName\":\"长沙分公司\",\"phone\":\"15888888888\",\"status\":\"1\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 42);
INSERT INTO `sys_oper_log` VALUES (120, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,102\",\"children\":[],\"deptId\":109,\"deptName\":\"财务部门\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":2,\"params\":{},\"parentId\":102,\"parentName\":\"长沙分公司\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 32);
INSERT INTO `sys_oper_log` VALUES (121, '岗位管理', 2, 'com.ruoyi.web.controller.system.SysPostController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/post', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-12-18 18:03:00\",\"flag\":false,\"params\":{},\"postCode\":\"user\",\"postId\":4,\"postName\":\"普通员工\",\"postSort\":4,\"remark\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"updateTime\":\"2026-01-14 14:28:16\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 37);
INSERT INTO `sys_oper_log` VALUES (122, '岗位管理', 2, 'com.ruoyi.web.controller.system.SysPostController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/post', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-12-18 18:03:00\",\"flag\":false,\"params\":{},\"postCode\":\"user\",\"postId\":4,\"postName\":\"普通员工\",\"postSort\":4,\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-01-14 14:28:17\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 21);
INSERT INTO `sys_oper_log` VALUES (123, '任务管理', 1, 'com.campus.web.controller.task.CampusTaskController.add()', 'POST', 1, 'admin', '校园信息中心', '/campus/task', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-12 23:44:31\",\"deadlineTime\":\"2026-04-15 18:00:00\",\"params\":{},\"priority\":\"1\",\"progressPercent\":0,\"publishUserId\":1,\"receiveUserId\":2,\"startTime\":\"2026-04-12 09:00:00\",\"taskContent\":\"�ӿڲ�����\",\"taskId\":100,\"taskStatus\":\"0\",\"taskTitle\":\"C2��������\",\"updateBy\":\"admin\",\"updateTime\":\"2026-04-12 23:44:31\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 223);
INSERT INTO `sys_oper_log` VALUES (124, '任务管理', 2, 'com.campus.web.controller.task.CampusTaskController.edit()', 'PUT', 1, 'admin', '校园信息中心', '/campus/task', '127.0.0.1', '内网IP', '{\"params\":{},\"priority\":\"2\",\"taskId\":100,\"taskTitle\":\"C2��������-���޸�\",\"updateBy\":\"admin\",\"updateTime\":\"2026-04-12 23:44:31\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 16);
INSERT INTO `sys_oper_log` VALUES (125, '任务管理', 2, 'com.campus.web.controller.task.CampusTaskController.changeStatus()', 'PUT', 1, 'admin', '校园信息中心', '/campus/task/status', '127.0.0.1', '内网IP', '{\"finishTime\":\"2026-04-12 23:44:31\",\"params\":{},\"progressPercent\":100,\"taskId\":100,\"taskStatus\":\"2\",\"updateBy\":\"admin\",\"updateTime\":\"2026-04-12 23:44:31\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 23);
INSERT INTO `sys_oper_log` VALUES (126, '任务管理', 3, 'com.campus.web.controller.task.CampusTaskController.remove()', 'DELETE', 1, 'admin', '校园信息中心', '/campus/task/100', '127.0.0.1', '内网IP', '[100] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 54);
INSERT INTO `sys_oper_log` VALUES (127, '请假管理', 1, 'com.campus.web.controller.leave.CampusLeaveApplyController.add()', 'POST', 1, 'admin', '校园信息中心', '/campus/leave', '127.0.0.1', '内网IP', '{\"applicantUserId\":1,\"approverUserId\":3,\"contactPhone\":\"13800000000\",\"createBy\":\"admin\",\"createTime\":\"2026-04-12 23:44:58\",\"endTime\":\"2026-04-13 18:00:00\",\"leaveDays\":1.0,\"leaveId\":100,\"leaveReason\":\"�ӿڲ���\",\"leaveStatus\":\"0\",\"leaveTitle\":\"C2�������\",\"leaveType\":\"1\",\"params\":{},\"startTime\":\"2026-04-13 08:00:00\",\"updateBy\":\"admin\",\"updateTime\":\"2026-04-12 23:44:58\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 150);
INSERT INTO `sys_oper_log` VALUES (128, '请假审批', 2, 'com.campus.web.controller.leave.CampusLeaveApplyController.approve()', 'PUT', 1, 'admin', '校园信息中心', '/campus/leave/approve', '127.0.0.1', '内网IP', '{\"approverUserId\":1,\"auditRemark\":\"ͬ��\",\"leaveId\":1,\"leaveStatus\":\"1\",\"params\":{},\"updateBy\":\"admin\",\"updateTime\":\"2026-04-12 23:44:58\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 136);
INSERT INTO `sys_oper_log` VALUES (129, '请假撤回', 2, 'com.campus.web.controller.leave.CampusLeaveApplyController.revoke()', 'PUT', 1, 'admin', '校园信息中心', '/campus/leave/revoke/100', '127.0.0.1', '内网IP', '100 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 136);
INSERT INTO `sys_oper_log` VALUES (130, '文件管理', 1, 'com.campus.web.controller.file.CampusSharedFileController.add()', 'POST', 1, 'admin', '校园信息中心', '/campus/file', '127.0.0.1', '内网IP', '{\"accessScope\":\"0\",\"createBy\":\"admin\",\"createTime\":\"2026-04-12 23:44:58\",\"fileCategory\":\"1\",\"fileId\":100,\"fileName\":\"C2�����ļ�\",\"filePath\":\"/upload/test.pdf\",\"fileSize\":102400,\"fileSuffix\":\"pdf\",\"fileUrl\":\"/profile/upload/test.pdf\",\"originalName\":\"test.pdf\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-04-12 23:44:58\",\"uploadUserId\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 54);
INSERT INTO `sys_oper_log` VALUES (131, '文件管理', 3, 'com.campus.web.controller.file.CampusSharedFileController.remove()', 'DELETE', 1, 'admin', '校园信息中心', '/campus/file/100', '127.0.0.1', '内网IP', '[100] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 11);
INSERT INTO `sys_oper_log` VALUES (132, '菜单管理', 2, 'com.campus.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '校园信息中心', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-18 18:03:00\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"系统监控\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 77);
INSERT INTO `sys_oper_log` VALUES (133, '菜单管理', 2, 'com.campus.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '校园信息中心', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/config/index\",\"createTime\":\"2025-12-18 18:03:00\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":106,\"menuName\":\"参数设置\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":1,\"path\":\"config\",\"perms\":\"system:config:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 23);
INSERT INTO `sys_oper_log` VALUES (134, '菜单管理', 2, 'com.campus.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '校园信息中心', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/dict/index\",\"createTime\":\"2025-12-18 18:03:00\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":105,\"menuName\":\"字典管理\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":1,\"path\":\"dict\",\"perms\":\"system:dict:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 189);
INSERT INTO `sys_oper_log` VALUES (135, '菜单管理', 2, 'com.campus.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '校园信息中心', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/post/index\",\"createTime\":\"2025-12-18 18:03:00\",\"icon\":\"post\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":104,\"menuName\":\"岗位管理\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":1,\"path\":\"post\",\"perms\":\"system:post:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 189);
INSERT INTO `sys_oper_log` VALUES (136, '菜单管理', 2, 'com.campus.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '校园信息中心', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/dept/index\",\"createTime\":\"2025-12-18 18:03:00\",\"icon\":\"tree\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":103,\"menuName\":\"部门管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":1,\"path\":\"dept\",\"perms\":\"system:dept:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 45);
INSERT INTO `sys_oper_log` VALUES (137, '菜单管理', 2, 'com.campus.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '校园信息中心', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/menu/index\",\"createTime\":\"2025-12-18 18:03:00\",\"icon\":\"tree-table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":102,\"menuName\":\"菜单管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":1,\"path\":\"menu\",\"perms\":\"system:menu:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 471);
INSERT INTO `sys_oper_log` VALUES (138, '任务评论', 1, 'com.campus.web.controller.task.CampusTaskController.addComment()', 'POST', 1, 'admin', '校园信息中心', '/campus/task/comment', '127.0.0.1', '内网IP', '{\"commentContent\":\"123123\",\"commentId\":100,\"commentUserId\":1,\"createBy\":\"admin\",\"createTime\":\"2026-04-13 13:46:54\",\"params\":{},\"taskId\":2,\"updateBy\":\"admin\",\"updateTime\":\"2026-04-13 13:46:54\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 84);
INSERT INTO `sys_oper_log` VALUES (139, '请假管理', 1, 'com.campus.web.controller.leave.CampusLeaveApplyController.add()', 'POST', 1, 'student01', '物联网工程2432班', '/campus/leave', '127.0.0.1', '内网IP', '{\"applicantUserId\":2,\"createBy\":\"student01\",\"createTime\":\"2026-04-13 15:33:46\",\"endTime\":\"2026-04-14 00:00:00\",\"leaveDays\":1,\"leaveId\":101,\"leaveReason\":\"12312312312\",\"leaveStatus\":\"0\",\"leaveTitle\":\"123\",\"leaveType\":\"1\",\"params\":{},\"startTime\":\"2026-04-13 15:33:41\",\"updateBy\":\"student01\",\"updateTime\":\"2026-04-13 15:33:46\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 29);
INSERT INTO `sys_oper_log` VALUES (140, '请假撤回', 2, 'com.campus.web.controller.leave.CampusLeaveApplyController.revoke()', 'PUT', 1, 'student01', '物联网工程2432班', '/campus/leave/revoke/101', '127.0.0.1', '内网IP', '101 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 20);
INSERT INTO `sys_oper_log` VALUES (141, '个人信息', 2, 'com.campus.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'student01', '物联网工程2432班', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"student01@stu.hbuas.edu.cn\",\"nickName\":\"张三\",\"params\":{},\"phonenumber\":\"13800138002\",\"sex\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 21);
INSERT INTO `sys_oper_log` VALUES (142, '角色管理', 2, 'com.campus.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '校园信息中心', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-18 18:03:00\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,107,2000,2001,2101,2201,1035,2010,2012,2110,2111,2210,2211,2212],\"params\":{},\"remark\":\"学生默认注册角色\",\"roleId\":2,\"roleKey\":\"student\",\"roleName\":\"学生\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 68);
INSERT INTO `sys_oper_log` VALUES (143, '任务管理', 2, 'com.campus.web.controller.task.CampusTaskController.edit()', 'PUT', 1, 'admin', '校园信息中心', '/campus/task', '127.0.0.1', '内网IP', '{\"attachmentName\":\"\",\"attachmentUrl\":\"\",\"commentCount\":1,\"createBy\":\"teacher01\",\"createTime\":\"2026-04-10 09:00:00\",\"deadlineTime\":\"2026-04-15 17:30:00\",\"params\":{},\"priority\":\"2\",\"progressPercent\":0,\"publishUserId\":3,\"receiveUserId\":2,\"remark\":\"用于班级项目展示\",\"startTime\":\"2026-04-10 09:00:00\",\"taskContent\":\"请梳理任务中心、文件中心和请假审批三条核心流程，准备下周课堂演示。\",\"taskId\":2,\"taskStatus\":\"0\",\"taskTitle\":\"校园协同平台功能演示彩排\",\"updateBy\":\"admin\",\"updateTime\":\"2026-04-10 09:00:00\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 271);
INSERT INTO `sys_oper_log` VALUES (144, '任务管理', 2, 'com.campus.web.controller.task.CampusTaskController.edit()', 'PUT', 1, 'admin', '校园信息中心', '/campus/task', '127.0.0.1', '内网IP', '{\"attachmentName\":\"开题报告任务说明.docx\",\"attachmentUrl\":\"/profile/upload/2026/04/task-opening-guide.docx\",\"commentCount\":2,\"createBy\":\"teacher01\",\"createTime\":\"2026-04-08 08:30:00\",\"deadlineTime\":\"2026-04-12 18:00:00\",\"params\":{},\"priority\":\"3\",\"progressPercent\":70,\"publishUserId\":3,\"receiveUserId\":2,\"remark\":\"导师重点关注国内外研究现状部分\",\"startTime\":\"2026-04-08 08:30:00\",\"taskContent\":\"请根据导师意见补充研究现状与技术路线，并在截止前上传开题报告初稿。\",\"taskId\":1,\"taskStatus\":\"1\",\"taskTitle\":\"毕业设计开题报告提交\",\"updateBy\":\"admin\",\"updateTime\":\"2026-04-10 20:10:00\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 13);
INSERT INTO `sys_oper_log` VALUES (145, '任务评论', 1, 'com.campus.web.controller.task.CampusTaskController.addComment()', 'POST', 1, 'admin', '校园信息中心', '/campus/task/comment', '127.0.0.1', '内网IP', '{\"commentContent\":\"3213213123\",\"commentId\":101,\"commentUserId\":1,\"createBy\":\"admin\",\"createTime\":\"2026-04-13 16:37:30\",\"params\":{},\"taskId\":1,\"updateBy\":\"admin\",\"updateTime\":\"2026-04-13 16:37:30\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 30);
INSERT INTO `sys_oper_log` VALUES (146, '文件管理', 2, 'com.campus.web.controller.file.CampusSharedFileController.edit()', 'PUT', 1, 'admin', '校园信息中心', '/campus/file', '127.0.0.1', '内网IP', '{\"accessScope\":\"1\",\"createBy\":\"student01\",\"createTime\":\"2026-04-09 19:15:00\",\"downloadCount\":5,\"fileCategory\":\"2\",\"fileId\":2,\"fileName\":\"任务分工说明\",\"filePath\":\"/upload/2026/04/task-division.pdf\",\"fileSize\":184320,\"fileSuffix\":\"pdf\",\"fileUrl\":\"/profile/upload/2026/04/task-division.pdf\",\"originalName\":\"任务分工说明.pdf\",\"params\":{},\"remark\":\"学生上传的协作文档\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-04-09 19:15:00\",\"uploadUserId\":2} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 14);
INSERT INTO `sys_oper_log` VALUES (147, '文件管理', 2, 'com.campus.web.controller.file.CampusSharedFileController.edit()', 'PUT', 1, 'admin', '校园信息中心', '/campus/file', '127.0.0.1', '内网IP', '{\"accessScope\":\"0\",\"createBy\":\"student01\",\"createTime\":\"2026-04-09 19:15:00\",\"downloadCount\":5,\"fileCategory\":\"2\",\"fileId\":2,\"fileName\":\"任务分工说明\",\"filePath\":\"/upload/2026/04/task-division.pdf\",\"fileSize\":184320,\"fileSuffix\":\"pdf\",\"fileUrl\":\"/profile/upload/2026/04/task-division.pdf\",\"originalName\":\"任务分工说明.pdf\",\"params\":{},\"remark\":\"学生上传的协作文档\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-04-13 16:37:50\",\"uploadUserId\":2} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 11);
INSERT INTO `sys_oper_log` VALUES (148, '请假管理', 3, 'com.campus.web.controller.leave.CampusLeaveApplyController.remove()', 'DELETE', 1, 'admin', '校园信息中心', '/campus/leave/1,101', '127.0.0.1', '内网IP', '[1,101] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 16);
INSERT INTO `sys_oper_log` VALUES (149, '任务管理', 2, 'com.campus.web.controller.task.CampusTaskController.edit()', 'PUT', 1, 'teacher01', '计算机工程学院', '/campus/task', '127.0.0.1', '内网IP', '{\"attachmentName\":\"\",\"attachmentUrl\":\"\",\"commentCount\":1,\"createBy\":\"teacher01\",\"createTime\":\"2026-04-10 09:00:00\",\"deadlineTime\":\"2026-04-15 17:30:00\",\"params\":{},\"priority\":\"2\",\"progressPercent\":0,\"publishUserId\":3,\"receiveUserId\":2,\"remark\":\"用于班级项目展示\",\"startTime\":\"2026-04-10 09:00:00\",\"taskContent\":\"请梳理任务中心、文件中心和请假审批三条核心流程，准备下周课堂演示。\",\"taskId\":2,\"taskStatus\":\"0\",\"taskTitle\":\"校园协同平台功能演示彩排\",\"updateBy\":\"teacher01\",\"updateTime\":\"2026-04-13 16:37:17\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 31);
INSERT INTO `sys_oper_log` VALUES (150, '任务评论', 1, 'com.campus.web.controller.task.CampusTaskController.addComment()', 'POST', 1, 'teacher01', '计算机工程学院', '/campus/task/comment', '127.0.0.1', '内网IP', '{\"commentContent\":\"32131231\",\"commentId\":102,\"commentUserId\":3,\"createBy\":\"teacher01\",\"createTime\":\"2026-04-13 16:51:55\",\"params\":{},\"taskId\":2,\"updateBy\":\"teacher01\",\"updateTime\":\"2026-04-13 16:51:55\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 38);
INSERT INTO `sys_oper_log` VALUES (151, '任务管理', 2, 'com.campus.web.controller.task.CampusTaskController.changeStatus()', 'PUT', 1, 'student01', '物联网工程2432班', '/campus/task/status', '127.0.0.1', '内网IP', '{\"params\":{},\"taskId\":2,\"taskStatus\":\"1\",\"updateBy\":\"student01\",\"updateTime\":\"2026-04-13 16:56:14\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 17);
INSERT INTO `sys_oper_log` VALUES (152, '任务评论', 1, 'com.campus.web.controller.task.CampusTaskController.addComment()', 'POST', 1, 'student01', '物联网工程2432班', '/campus/task/comment', '127.0.0.1', '内网IP', '{\"commentContent\":\"312312\",\"commentId\":103,\"commentUserId\":2,\"createBy\":\"student01\",\"createTime\":\"2026-04-13 16:56:18\",\"params\":{},\"taskId\":2,\"updateBy\":\"student01\",\"updateTime\":\"2026-04-13 16:56:18\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 21);
INSERT INTO `sys_oper_log` VALUES (153, '请假管理', 1, 'com.campus.web.controller.leave.CampusLeaveApplyController.add()', 'POST', 1, 'student01', '物联网工程2432班', '/campus/leave', '127.0.0.1', '内网IP', '{\"applicantUserId\":2,\"createBy\":\"student01\",\"createTime\":\"2026-04-13 16:56:48\",\"endTime\":\"2026-04-14 00:00:00\",\"leaveDays\":1,\"leaveId\":102,\"leaveReason\":\"12312312312312\",\"leaveStatus\":\"0\",\"leaveTitle\":\"321\",\"leaveType\":\"1\",\"params\":{},\"startTime\":\"2026-04-13 16:56:43\",\"updateBy\":\"student01\",\"updateTime\":\"2026-04-13 16:56:48\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 21);
INSERT INTO `sys_oper_log` VALUES (154, '请假审批', 2, 'com.campus.web.controller.leave.CampusLeaveApplyController.approve()', 'PUT', 1, 'teacher01', '计算机工程学院', '/campus/leave/approve', '127.0.0.1', '内网IP', '{\"approverUserId\":3,\"auditRemark\":\"3123123123\",\"leaveId\":102,\"leaveStatus\":\"1\",\"leaveTitle\":\"321\",\"params\":{},\"updateBy\":\"teacher01\",\"updateTime\":\"2026-04-13 16:56:59\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 23);
INSERT INTO `sys_oper_log` VALUES (155, '个人信息', 2, 'com.campus.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'student01', '物联网工程2432班', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"student01@stu.hbuas.edu.cn\",\"nickName\":\"张三\",\"params\":{},\"phonenumber\":\"13800138002\",\"sex\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 23);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'president', '校长', 1, '0', 'admin', '2025-12-18 18:03:00', 'admin', '2026-04-12 23:24:47', '学校层级岗位');
INSERT INTO `sys_post` VALUES (2, 'dean', '院长', 2, '0', 'admin', '2025-12-18 18:03:00', 'admin', '2026-04-12 23:24:47', '学院层级岗位');
INSERT INTO `sys_post` VALUES (3, 'teacher', '教师', 3, '0', 'admin', '2025-12-18 18:03:00', 'admin', '2026-04-12 23:24:47', '教师业务岗位');
INSERT INTO `sys_post` VALUES (4, 'student', '学生', 4, '0', 'admin', '2025-12-18 18:03:00', 'admin', '2026-04-12 23:24:47', '学生默认岗位');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-12-18 18:03:00', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '学生', 'student', 2, '5', 1, 1, '0', '0', 'admin', '2025-12-18 18:03:00', 'admin', '2026-04-13 15:34:25', '学生默认注册角色');
INSERT INTO `sys_role` VALUES (3, '教师', 'teacher', 3, '4', 1, 1, '0', '0', 'admin', '2026-04-12 23:24:47', 'admin', '2026-04-12 23:24:47', '教师业务角色');
INSERT INTO `sys_role` VALUES (100, '历史测试角色', 'legacy_test', 3, '1', 1, 1, '1', '2', 'admin', '2026-01-14 14:27:08', 'admin', '2026-04-12 23:24:47', '保留历史测试数据，避免影响业务角色编号');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (3, 101);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 2000);
INSERT INTO `sys_role_menu` VALUES (1, 2001);
INSERT INTO `sys_role_menu` VALUES (1, 2010);
INSERT INTO `sys_role_menu` VALUES (1, 2011);
INSERT INTO `sys_role_menu` VALUES (1, 2012);
INSERT INTO `sys_role_menu` VALUES (1, 2013);
INSERT INTO `sys_role_menu` VALUES (1, 2014);
INSERT INTO `sys_role_menu` VALUES (1, 2101);
INSERT INTO `sys_role_menu` VALUES (1, 2110);
INSERT INTO `sys_role_menu` VALUES (1, 2111);
INSERT INTO `sys_role_menu` VALUES (1, 2112);
INSERT INTO `sys_role_menu` VALUES (1, 2113);
INSERT INTO `sys_role_menu` VALUES (1, 2114);
INSERT INTO `sys_role_menu` VALUES (1, 2201);
INSERT INTO `sys_role_menu` VALUES (1, 2210);
INSERT INTO `sys_role_menu` VALUES (1, 2211);
INSERT INTO `sys_role_menu` VALUES (1, 2212);
INSERT INTO `sys_role_menu` VALUES (1, 2213);
INSERT INTO `sys_role_menu` VALUES (1, 2214);
INSERT INTO `sys_role_menu` VALUES (1, 2215);
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 2000);
INSERT INTO `sys_role_menu` VALUES (2, 2001);
INSERT INTO `sys_role_menu` VALUES (2, 2010);
INSERT INTO `sys_role_menu` VALUES (2, 2012);
INSERT INTO `sys_role_menu` VALUES (2, 2101);
INSERT INTO `sys_role_menu` VALUES (2, 2110);
INSERT INTO `sys_role_menu` VALUES (2, 2111);
INSERT INTO `sys_role_menu` VALUES (2, 2201);
INSERT INTO `sys_role_menu` VALUES (2, 2210);
INSERT INTO `sys_role_menu` VALUES (2, 2211);
INSERT INTO `sys_role_menu` VALUES (2, 2212);
INSERT INTO `sys_role_menu` VALUES (3, 100);
INSERT INTO `sys_role_menu` VALUES (3, 2000);
INSERT INTO `sys_role_menu` VALUES (3, 2001);
INSERT INTO `sys_role_menu` VALUES (3, 2010);
INSERT INTO `sys_role_menu` VALUES (3, 2011);
INSERT INTO `sys_role_menu` VALUES (3, 2012);
INSERT INTO `sys_role_menu` VALUES (3, 2101);
INSERT INTO `sys_role_menu` VALUES (3, 2110);
INSERT INTO `sys_role_menu` VALUES (3, 2111);
INSERT INTO `sys_role_menu` VALUES (3, 2112);
INSERT INTO `sys_role_menu` VALUES (3, 2201);
INSERT INTO `sys_role_menu` VALUES (3, 2210);
INSERT INTO `sys_role_menu` VALUES (3, 2215);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 106, 'admin', '校园管理员', '00', 'admin@hbuas.edu.cn', '13800138001', '2', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-04-13 16:36:46', '2025-12-18 18:02:59', 'admin', '2025-12-18 18:02:59', 'admin', '2026-04-12 23:24:47', '平台超级管理员账号');
INSERT INTO `sys_user` VALUES (2, 103, 'student01', '张三', '00', 'student01@stu.hbuas.edu.cn', '13800138002', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-04-13 16:30:26', '2026-04-12 23:24:47', 'admin', '2025-12-18 18:02:59', 'admin', '2026-04-13 16:57:32', '学生测试账号');
INSERT INTO `sys_user` VALUES (3, 101, 'teacher01', '李四', '00', 'teacher01@hbuas.edu.cn', '13800138003', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-04-13 16:43:28', '2026-04-12 23:24:47', 'admin', '2026-04-12 23:24:47', 'admin', '2026-04-12 23:24:47', '教师测试账号');
INSERT INTO `sys_user` VALUES (100, 103, 'ceshi', 'ceshi', '00', '', '', '0', '', '$2a$10$FRGDYzmy3/H7FqZ.R4TAXOPbF8FJ4hPOEx0xPmDG39K2RjOACpaye', '1', '2', '', NULL, '2026-01-14 14:26:00', 'admin', '2026-01-14 14:25:37', 'admin', '2026-04-12 23:24:47', '历史测试账号停用');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 4);
INSERT INTO `sys_user_post` VALUES (3, 3);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (3, 3);

SET FOREIGN_KEY_CHECKS = 1;
