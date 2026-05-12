package com.campus.system.service.impl;

import java.util.List;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.campus.system.domain.SysOperLog;
import com.campus.system.mapper.SysOperLogMapper;
import com.campus.system.service.ISysOperLogService;

/**
 * 操作日志 服务层处理
 * 
 * @author crazyLee
 */
@Service
public class SysOperLogServiceImpl extends ServiceImpl<SysOperLogMapper, SysOperLog> implements ISysOperLogService {

    // REMOVED: @Autowired private SysOperLogMapper operLogMapper;
    // Use inherited baseMapper instead

    /**
     * 新增操作日志
     * 
     * @param operLog 操作日志对象
     */
    @Override
    public void insertOperlog(SysOperLog operLog) {
        baseMapper.insert(operLog);
    }

    /**
     * 查询系统操作日志集合
     * 
     * @param operLog 操作日志对象
     * @return 操作日志集合
     */
    @Override
    public List<SysOperLog> selectOperLogList(SysOperLog operLog) {
        return baseMapper.selectOperLogList(operLog);
    }

    /**
     * 查询系统操作日志集合（MyBatis-Plus分页）
     * 
     * @param page 分页对象
     * @param operLog 操作日志对象
     * @return 操作日志分页结果
     */
    @Override
    public IPage<SysOperLog> selectOperLogPage(Page<SysOperLog> page, SysOperLog operLog) {
        return baseMapper.selectOperLogPage(page, operLog);
    }

    /**
     * 批量删除系统操作日志
     * 
     * @param operIds 需要删除的操作日志ID
     * @return 结果
     */
    @Override
    public int deleteOperLogByIds(Long[] operIds) {
        return baseMapper.deleteOperLogByIds(operIds);
    }

    /**
     * 查询操作日志详细
     * 
     * @param operId 操作ID
     * @return 操作日志对象
     */
    @Override
    public SysOperLog selectOperLogById(Long operId) {
        return baseMapper.selectById(operId);
    }

    /**
     * 清空操作日志
     */
    @Override
    public void cleanOperLog() {
        baseMapper.cleanOperLog();
    }
}
