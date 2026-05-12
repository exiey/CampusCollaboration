package com.campus.system.domain.task;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.campus.common.annotation.Excel;
import com.campus.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 任务评论对象 campus_task_comment
 *
 * @author CrazyLee
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("campus_task_comment")
public class CampusTaskComment extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 评论ID */
    @TableId(type = IdType.AUTO)
    private Long commentId;

    /** 任务ID */
    @NotNull(message = "任务ID不能为空")
    private Long taskId;

    /** 评论用户ID */
    private Long commentUserId;

    /** 回复目标用户ID */
    private Long replyUserId;

    /** 评论内容 */
    @Excel(name = "评论内容")
    @NotBlank(message = "评论内容不能为空")
    @Size(max = 500, message = "评论内容长度不能超过500个字符")
    private String commentContent;

    /** 删除标志 */
    private String delFlag;
}
