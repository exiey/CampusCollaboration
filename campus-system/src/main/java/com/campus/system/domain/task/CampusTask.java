package com.campus.system.domain.task;

import java.util.Date;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.campus.common.annotation.Excel;
import com.campus.common.core.domain.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 校园任务对象 campus_task
 *
 * @author CrazyLee
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("campus_task")
public class CampusTask extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 任务ID */
    @TableId(type = IdType.AUTO)
    private Long taskId;

    /** 任务标题 */
    @Excel(name = "任务标题")
    @NotBlank(message = "任务标题不能为空")
    @Size(max = 120, message = "任务标题长度不能超过120个字符")
    private String taskTitle;

    /** 任务内容 */
    @Excel(name = "任务内容")
    @Size(max = 1000, message = "任务内容长度不能超过1000个字符")
    private String taskContent;

    /** 发布教师ID */
    private Long publishUserId;

    /** 接收学生ID */
    private Long receiveUserId;

    /** 优先级 */
    @Excel(name = "优先级", dictType = "campus_task_priority")
    private String priority;

    /** 任务状态 */
    @Excel(name = "任务状态", dictType = "campus_task_status")
    private String taskStatus;

    /** 进度百分比 */
    @Excel(name = "进度")
    @Min(value = 0, message = "进度不能小于0")
    @Max(value = 100, message = "进度不能大于100")
    private Integer progressPercent;

    /** 开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "开始时间", width = 20, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;

    /** 截止时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "截止时间", width = 20, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date deadlineTime;

    /** 完成时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "完成时间", width = 20, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date finishTime;

    /** 附件名称 */
    @Excel(name = "附件名称")
    private String attachmentName;

    /** 附件地址 */
    private String attachmentUrl;

    /** 评论数量 */
    @Excel(name = "评论数量")
    private Integer commentCount;

    /** 删除标志 */
    private String delFlag;
}
