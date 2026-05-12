package com.campus.system.domain.vo;

import com.campus.system.domain.task.CampusTaskComment;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 任务评论视图对象
 *
 * @author CrazyLee
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class CampusTaskCommentVo extends CampusTaskComment
{
    private static final long serialVersionUID = 1L;

    /** 评论用户姓名 */
    private String commentUserName;

    /** 评论用户头像 */
    private String commentUserAvatar;

    /** 回复目标用户姓名 */
    private String replyUserName;
}
