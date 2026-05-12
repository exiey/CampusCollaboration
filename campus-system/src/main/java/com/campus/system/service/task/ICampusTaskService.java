package com.campus.system.service.task;

import java.util.List;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.campus.system.domain.task.CampusTask;
import com.campus.system.domain.task.CampusTaskComment;
import com.campus.system.domain.vo.CampusTaskCommentVo;
import com.campus.system.domain.vo.CampusTaskVo;

/**
 * 校园任务服务接口
 *
 * @author CrazyLee
 */
public interface ICampusTaskService
{
    List<CampusTaskVo> selectCampusTaskList(CampusTask task);

    IPage<CampusTaskVo> selectCampusTaskPage(Page<CampusTaskVo> page, CampusTask task);

    CampusTaskVo selectCampusTaskById(Long taskId);

    int insertCampusTask(CampusTask task);

    int updateCampusTask(CampusTask task);

    int deleteCampusTaskByIds(Long[] taskIds);

    int updateCampusTaskStatus(CampusTask task);

    List<CampusTaskCommentVo> selectCampusTaskCommentList(Long taskId);

    int insertCampusTaskComment(CampusTaskComment comment);

    int deleteCampusTaskCommentById(Long commentId);
}
