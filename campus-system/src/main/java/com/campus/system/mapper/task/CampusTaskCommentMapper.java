package com.campus.system.mapper.task;

import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.campus.system.domain.task.CampusTaskComment;
import com.campus.system.domain.vo.CampusTaskCommentVo;

/**
 * 任务评论数据层
 *
 * @author CrazyLee
 */
public interface CampusTaskCommentMapper extends BaseMapper<CampusTaskComment>
{
    List<CampusTaskCommentVo> selectCampusTaskCommentList(Long taskId);

    int insertCampusTaskComment(CampusTaskComment comment);

    int deleteCampusTaskCommentById(Long commentId);

    int deleteCampusTaskCommentByTaskIds(Long[] taskIds);

    int countCampusTaskCommentByTaskId(Long taskId);
}
