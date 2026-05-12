package com.campus.quartz.mapper;

import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import com.campus.quartz.domain.SysJobLog;

/**
 * 调度任务日志信息 数据层
 * 
 * @author crazyLee
 */
public interface SysJobLogMapper extends BaseMapper<SysJobLog>
{
    /**
     * 获取quartz调度器日志的计划任务 - Keep for dynamic SQL with date range
     * 
     * @param jobLog 调度日志信息
     * @return 调度任务日志集合
     */
    public List<SysJobLog> selectJobLogList(SysJobLog jobLog);

    /**
     * 获取quartz调度器日志的计划任务（MyBatis-Plus分页）
     * 
     * @param page 分页对象
     * @param jobLog 调度日志信息
     * @return 调度任务日志分页结果
     */
    public IPage<SysJobLog> selectJobLogPage(Page<SysJobLog> page, @Param("jobLog") SysJobLog jobLog);

    /**
     * 查询所有调度任务日志
     *
     * @return 调度任务日志列表
     */
    public List<SysJobLog> selectJobLogAll();

    // REMOVED: selectJobLogById - use BaseMapper.selectById()
    // REMOVED: insertJobLog - use BaseMapper.insert()
    // REMOVED: deleteJobLogById - use BaseMapper.deleteById()

    /**
     * 批量删除调度日志信息 - Keep for array parameter
     * 
     * @param logIds 需要删除的数据ID
     * @return 结果
     */
    public int deleteJobLogByIds(Long[] logIds);

    /**
     * 清空任务日志 - Keep for truncate operation
     */
    public void cleanJobLog();
}
