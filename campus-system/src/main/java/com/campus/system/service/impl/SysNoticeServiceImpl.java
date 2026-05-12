package com.campus.system.service.impl;

import java.util.List;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.campus.system.domain.SysNotice;
import com.campus.system.mapper.SysNoticeMapper;
import com.campus.system.service.ISysNoticeService;

/**
 * 公告 服务层实现
 * 
 * @author crazyLee
 */
@Service
public class SysNoticeServiceImpl extends ServiceImpl<SysNoticeMapper, SysNotice> implements ISysNoticeService {

    // REMOVED: @Autowired private SysNoticeMapper noticeMapper;
    // Use inherited baseMapper instead

    /**
     * 查询公告信息
     * 
     * @param noticeId 公告ID
     * @return 公告信息
     */
    @Override
    public SysNotice selectNoticeById(Long noticeId) {
        return baseMapper.selectById(noticeId);
    }

    /**
     * 查询公告列表
     * 
     * @param notice 公告信息
     * @return 公告集合
     */
    @Override
    public List<SysNotice> selectNoticeList(SysNotice notice) {
        return baseMapper.selectNoticeList(notice);
    }

    /**
     * 查询公告列表（MyBatis-Plus分页）
     * 
     * @param page 分页对象
     * @param notice 公告信息
     * @return 公告分页结果
     */
    @Override
    public IPage<SysNotice> selectNoticePage(Page<SysNotice> page, SysNotice notice) {
        return baseMapper.selectNoticePage(page, notice);
    }

    /**
     * 新增公告
     * 
     * @param notice 公告信息
     * @return 结果
     */
    @Override
    public int insertNotice(SysNotice notice) {
        return baseMapper.insert(notice);
    }

    /**
     * 修改公告
     * 
     * @param notice 公告信息
     * @return 结果
     */
    @Override
    public int updateNotice(SysNotice notice) {
        return baseMapper.updateById(notice);
    }

    /**
     * 删除公告对象
     * 
     * @param noticeId 公告ID
     * @return 结果
     */
    @Override
    public int deleteNoticeById(Long noticeId) {
        return baseMapper.deleteById(noticeId);
    }

    /**
     * 批量删除公告信息
     * 
     * @param noticeIds 需要删除的公告ID
     * @return 结果
     */
    @Override
    public int deleteNoticeByIds(Long[] noticeIds) {
        return baseMapper.deleteNoticeByIds(noticeIds);
    }
}
