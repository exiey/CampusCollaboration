package com.campus.system.domain.vo;

import com.campus.system.domain.task.CampusTask;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 任务视图对象
 *
 * @author CrazyLee
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class CampusTaskVo extends CampusTask
{
    private static final long serialVersionUID = 1L;

    /** 发布教师姓名 */
    private String publishUserName;

    /** 发布教师部门 */
    private String publishDeptName;

    /** 接收学生姓名 */
    private String receiveUserName;

    /** 接收学生部门 */
    private String receiveDeptName;
}
