package com.campus.system.service.impl;

import java.util.List;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.campus.system.domain.SysLogininfor;
import com.campus.system.mapper.SysLogininforMapper;
import com.campus.system.service.ISysLogininforService;

/**
 * 系统访问日志情况信息 服务层处理
 * 
 * @author crazyLee
 */
@Service
public class SysLogininforServiceImpl extends ServiceImpl<SysLogininforMapper, SysLogininfor> implements ISysLogininforService {

    // REMOVED: @Autowired private SysLogininforMapper logininforMapper;
    // Use inherited baseMapper instead

    /**
     * 新增系统登录日志
     * 
     * @param logininfor 访问日志对象
     */
    @Override
    public void insertLogininfor(SysLogininfor logininfor) {
        baseMapper.insert(logininfor);
    }

    /**
     * 查询系统登录日志集合
     * 
     * @param logininfor 访问日志对象
     * @return 登录记录集合
     */
    @Override
    public List<SysLogininfor> selectLogininforList(SysLogininfor logininfor) {
        return baseMapper.selectLogininforList(logininfor);
    }

    /**
     * 查询系统登录日志集合（MyBatis-Plus分页）
     * 
     * @param page 分页对象
     * @param logininfor 访问日志对象
     * @return 登录记录分页结果
     */
    @Override
    public IPage<SysLogininfor> selectLogininforPage(Page<SysLogininfor> page, SysLogininfor logininfor) {
        return baseMapper.selectLogininforPage(page, logininfor);
    }

    /**
     * 批量删除系统登录日志
     * 
     * @param infoIds 需要删除的登录日志ID
     * @return 结果
     */
    @Override
    public int deleteLogininforByIds(Long[] infoIds) {
        return baseMapper.deleteLogininforByIds(infoIds);
    }

    /**
     * 清空系统登录日志
     */
    @Override
    public void cleanLogininfor() {
        baseMapper.cleanLogininfor();
    }
}
