package com.campus.system.mapper;

import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import com.campus.system.domain.SysNotice;

/**
 * 通知公告表 数据层
 * 
 * @author crazyLee
 */
public interface SysNoticeMapper extends BaseMapper<SysNotice> {
    
    // REMOVED: selectNoticeById - use BaseMapper.selectById()
    // REMOVED: insertNotice - use BaseMapper.insert()
    // REMOVED: updateNotice - use BaseMapper.updateById()
    // REMOVED: deleteNoticeById - use BaseMapper.deleteById()

    /**
     * 查询公告列表 - Keep for dynamic SQL
     * 
     * @param notice 公告信息
     * @return 公告集合
     */
    public List<SysNotice> selectNoticeList(SysNotice notice);

    /**
     * 查询公告列表（MyBatis-Plus分页）
     * 
     * @param page 分页对象
     * @param notice 公告信息
     * @return 公告分页结果
     */
    public IPage<SysNotice> selectNoticePage(Page<SysNotice> page, @Param("notice") SysNotice notice);

    /**
     * 批量删除公告信息 - Keep for array parameter
     * 
     * @param noticeIds 需要删除的公告ID
     * @return 结果
     */
    public int deleteNoticeByIds(Long[] noticeIds);
}
