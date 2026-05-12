package com.campus.system.mapper;

import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import com.campus.system.domain.SysLogininfor;

/**
 * 系统访问日志情况信息 数据层
 * 
 * @author crazyLee
 */
public interface SysLogininforMapper extends BaseMapper<SysLogininfor> {
    
    // REMOVED: insertLogininfor - use BaseMapper.insert()

    /**
     * 查询系统登录日志集合 - Keep for dynamic SQL
     * 
     * @param logininfor 访问日志对象
     * @return 登录记录集合
     */
    public List<SysLogininfor> selectLogininforList(SysLogininfor logininfor);

    /**
     * 查询系统登录日志集合（MyBatis-Plus分页）
     * 
     * @param page 分页对象
     * @param logininfor 访问日志对象
     * @return 登录记录分页结果
     */
    public IPage<SysLogininfor> selectLogininforPage(Page<SysLogininfor> page, @Param("logininfor") SysLogininfor logininfor);

    /**
     * 批量删除系统登录日志 - Keep for array parameter
     * 
     * @param infoIds 需要删除的登录日志ID
     * @return 结果
     */
    public int deleteLogininforByIds(Long[] infoIds);

    /**
     * 清空系统登录日志 - Keep for truncate operation
     * 
     * @return 结果
     */
    public int cleanLogininfor();
}
