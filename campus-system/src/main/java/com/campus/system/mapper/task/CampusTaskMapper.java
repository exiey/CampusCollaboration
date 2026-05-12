package com.campus.system.mapper.task;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.campus.system.domain.task.CampusTask;
import com.campus.system.domain.vo.CampusTaskVo;

/**
 * 校园任务数据层
 *
 * @author CrazyLee
 */
public interface CampusTaskMapper extends BaseMapper<CampusTask>
{
    List<CampusTaskVo> selectCampusTaskList(CampusTask task);

    IPage<CampusTaskVo> selectCampusTaskPage(Page<CampusTaskVo> page, @Param("task") CampusTask task);

    CampusTaskVo selectCampusTaskById(Long taskId);

    int insertCampusTask(CampusTask task);

    int updateCampusTask(CampusTask task);

    int deleteCampusTaskByIds(Long[] taskIds);

    int updateCampusTaskStatus(CampusTask task);

    int updateCampusTaskCommentCount(@Param("taskId") Long taskId, @Param("commentCount") Integer commentCount);
}
