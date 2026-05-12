package com.campus.quartz.service.impl;

import java.util.List;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.campus.quartz.domain.SysJobLog;
import com.campus.quartz.mapper.SysJobLogMapper;
import com.campus.quartz.service.ISysJobLogService;

/**
 * 定时任务调度日志信息 服务层
 * 
 * @author crazyLee
 */
@Service
public class SysJobLogServiceImpl extends ServiceImpl<SysJobLogMapper, SysJobLog> implements ISysJobLogService
{
    // REMOVED: @Autowired private SysJobLogMapper jobLogMapper;
    // Use inherited baseMapper instead

    /**
     * 获取quartz调度器日志的计划任务
     * 
     * @param jobLog 调度日志信息
     * @return 调度任务日志集合
     */
    @Override
    public List<SysJobLog> selectJobLogList(SysJobLog jobLog)
    {
        return baseMapper.selectJobLogList(jobLog);
    }

    /**
     * 获取quartz调度器日志的计划任务（MyBatis-Plus分页）
     * 
     * @param page 分页对象
     * @param jobLog 调度日志信息
     * @return 调度任务日志分页结果
     */
    @Override
    public IPage<SysJobLog> selectJobLogPage(Page<SysJobLog> page, SysJobLog jobLog)
    {
        return baseMapper.selectJobLogPage(page, jobLog);
    }

    /**
     * 通过调度任务日志ID查询调度信息
     * 
     * @param jobLogId 调度任务日志ID
     * @return 调度任务日志对象信息
     */
    @Override
    public SysJobLog selectJobLogById(Long jobLogId)
    {
        return baseMapper.selectById(jobLogId);
    }

    /**
     * 新增任务日志
     * 
     * @param jobLog 调度日志信息
     */
    @Override
    public void addJobLog(SysJobLog jobLog)
    {
        baseMapper.insert(jobLog);
    }

    /**
     * 批量删除调度日志信息
     * 
     * @param logIds 需要删除的数据ID
     * @return 结果
     */
    @Override
    public int deleteJobLogByIds(Long[] logIds)
    {
        return baseMapper.deleteJobLogByIds(logIds);
    }

    /**
     * 删除任务日志
     * 
     * @param jobId 调度日志ID
     */
    @Override
    public int deleteJobLogById(Long jobId)
    {
        return baseMapper.deleteById(jobId);
    }

    /**
     * 清空任务日志
     */
    @Override
    public void cleanJobLog()
    {
        baseMapper.cleanJobLog();
    }
}
