package com.campus.quartz.mapper;

import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import com.campus.quartz.domain.SysJob;

/**
 * 调度任务信息 数据层
 * 
 * @author crazyLee
 */
public interface SysJobMapper extends BaseMapper<SysJob>
{
    /**
     * 查询调度任务日志集合 - Keep for dynamic SQL
     * 
     * @param job 调度信息
     * @return 操作日志集合
     */
    public List<SysJob> selectJobList(SysJob job);

    /**
     * 查询调度任务日志集合（MyBatis-Plus分页）
     * 
     * @param page 分页对象
     * @param job 调度信息
     * @return 调度任务分页结果
     */
    public IPage<SysJob> selectJobPage(Page<SysJob> page, @Param("job") SysJob job);

    /**
     * 查询所有调度任务 - Keep for @PostConstruct init
     * 
     * @return 调度任务列表
     */
    public List<SysJob> selectJobAll();

    // REMOVED: selectJobById - use BaseMapper.selectById()
    // REMOVED: deleteJobById - use BaseMapper.deleteById()
    // REMOVED: updateJob - use BaseMapper.updateById()
    // REMOVED: insertJob - use BaseMapper.insert()

    /**
     * 批量删除调度任务信息 - Keep for array parameter
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    public int deleteJobByIds(Long[] ids);
}
