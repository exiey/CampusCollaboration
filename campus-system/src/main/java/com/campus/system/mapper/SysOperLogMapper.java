package com.campus.system.mapper;

import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import com.campus.system.domain.SysOperLog;

/**
 * 操作日志 数据层
 * 
 * @author crazyLee
 */
public interface SysOperLogMapper extends BaseMapper<SysOperLog> {
    
    // REMOVED: insertOperlog - use BaseMapper.insert()
    // REMOVED: selectOperLogById - use BaseMapper.selectById()

    /**
     * 查询系统操作日志集合 - Keep for dynamic SQL
     * 
     * @param operLog 操作日志对象
     * @return 操作日志集合
     */
    public List<SysOperLog> selectOperLogList(SysOperLog operLog);

    /**
     * 查询系统操作日志集合（MyBatis-Plus分页）
     * 
     * @param page 分页对象
     * @param operLog 操作日志对象
     * @return 操作日志分页结果
     */
    public IPage<SysOperLog> selectOperLogPage(Page<SysOperLog> page, @Param("operLog") SysOperLog operLog);

    /**
     * 批量删除系统操作日志 - Keep for array parameter
     * 
     * @param operIds 需要删除的操作日志ID
     * @return 结果
     */
    public int deleteOperLogByIds(Long[] operIds);

    /**
     * 清空操作日志 - Keep for truncate operation
     */
    public void cleanOperLog();
}
