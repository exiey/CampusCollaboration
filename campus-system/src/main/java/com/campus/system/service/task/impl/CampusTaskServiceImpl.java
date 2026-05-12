package com.campus.system.service.task.impl;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.campus.common.exception.ServiceException;
import com.campus.system.domain.task.CampusTask;
import com.campus.system.domain.task.CampusTaskComment;
import com.campus.system.domain.vo.CampusTaskCommentVo;
import com.campus.system.domain.vo.CampusTaskVo;
import com.campus.system.mapper.task.CampusTaskCommentMapper;
import com.campus.system.mapper.task.CampusTaskMapper;
import com.campus.system.service.task.ICampusTaskService;

/**
 * 校园任务服务实现
 *
 * @author CrazyLee
 */
@Service
public class CampusTaskServiceImpl implements ICampusTaskService
{
    @Autowired
    private CampusTaskMapper taskMapper;

    @Autowired
    private CampusTaskCommentMapper commentMapper;

    /**
     * 查询任务列表
     *
     * @param task 查询条件
     * @return 任务视图列表
     */
    @Override
    public List<CampusTaskVo> selectCampusTaskList(CampusTask task)
    {
        return taskMapper.selectCampusTaskList(task);
    }

    /**
     * 分页查询任务列表
     *
     * @param page 分页参数
     * @param task 查询条件
     * @return 分页结果
     */
    @Override
    public IPage<CampusTaskVo> selectCampusTaskPage(Page<CampusTaskVo> page, CampusTask task)
    {
        return taskMapper.selectCampusTaskPage(page, task);
    }

    /**
     * 根据ID查询任务详情
     *
     * @param taskId 任务ID
     * @return 任务视图对象
     */
    @Override
    public CampusTaskVo selectCampusTaskById(Long taskId)
    {
        return taskMapper.selectCampusTaskById(taskId);
    }

    /**
     * 新增任务
     *
     * @param task 任务对象
     * @return 影响行数
     */
    @Override
    public int insertCampusTask(CampusTask task)
    {
        if (task.getTaskStatus() == null)
        {
            task.setTaskStatus("0");
        }
        if (task.getProgressPercent() == null)
        {
            task.setProgressPercent(0);
        }
        return taskMapper.insertCampusTask(task);
    }

    /**
     * 修改任务
     *
     * @param task 任务对象
     * @return 影响行数
     */
    @Override
    public int updateCampusTask(CampusTask task)
    {
        return taskMapper.updateCampusTask(task);
    }

    /**
     * 批量删除任务
     *
     * @param taskIds 任务ID数组
     * @return 影响行数
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteCampusTaskByIds(Long[] taskIds)
    {
        commentMapper.deleteCampusTaskCommentByTaskIds(taskIds);
        return taskMapper.deleteCampusTaskByIds(taskIds);
    }

    /**
     * 更新任务状态
     *
     * @param task 包含taskId、taskStatus的任务对象
     * @return 影响行数
     */
    @Override
    public int updateCampusTaskStatus(CampusTask task)
    {
        CampusTaskVo existing = taskMapper.selectCampusTaskById(task.getTaskId());
        if (existing == null)
        {
            throw new ServiceException("任务不存在");
        }
        if ("2".equals(task.getTaskStatus()))
        {
            task.setProgressPercent(100);
            task.setFinishTime(new Date());
        }
        return taskMapper.updateCampusTaskStatus(task);
    }

    /**
     * 查询任务评论列表
     *
     * @param taskId 任务ID
     * @return 评论视图列表
     */
    @Override
    public List<CampusTaskCommentVo> selectCampusTaskCommentList(Long taskId)
    {
        return commentMapper.selectCampusTaskCommentList(taskId);
    }

    /**
     * 新增任务评论
     *
     * @param comment 评论对象
     * @return 影响行数
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertCampusTaskComment(CampusTaskComment comment)
    {
        int rows = commentMapper.insertCampusTaskComment(comment);
        if (rows > 0)
        {
            int count = commentMapper.countCampusTaskCommentByTaskId(comment.getTaskId());
            taskMapper.updateCampusTaskCommentCount(comment.getTaskId(), count);
        }
        return rows;
    }

    /**
     * 删除任务评论
     *
     * @param commentId 评论ID
     * @return 影响行数
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteCampusTaskCommentById(Long commentId)
    {
        int rows = commentMapper.deleteCampusTaskCommentById(commentId);
        return rows;
    }
}
