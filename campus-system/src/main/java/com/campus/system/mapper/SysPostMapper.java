package com.campus.system.mapper;

import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import com.campus.system.domain.SysPost;

/**
 * 岗位信息 数据层
 * 
 * @author crazyLee
 */
public interface SysPostMapper extends BaseMapper<SysPost> {
    /**
     * 查询岗位数据集合 - Keep for dynamic SQL
     * 
     * @param post 岗位信息
     * @return 岗位数据集合
     */
    public List<SysPost> selectPostList(SysPost post);

    /**
     * 查询岗位数据集合（MyBatis-Plus分页）
     * 
     * @param page 分页对象
     * @param post 岗位信息
     * @return 岗位数据分页结果
     */
    public IPage<SysPost> selectPostPage(Page<SysPost> page, @Param("post") SysPost post);

    /**
     * 查询所有岗位 - Keep for custom query
     * 
     * @return 岗位列表
     */
    public List<SysPost> selectPostAll();

    // REMOVED: selectPostById - use BaseMapper.selectById()
    // REMOVED: deletePostById - use BaseMapper.deleteById()
    // REMOVED: updatePost - use BaseMapper.updateById()
    // REMOVED: insertPost - use BaseMapper.insert()

    /**
     * 根据用户ID获取岗位选择框列表 - Keep for custom query
     * 
     * @param userId 用户ID
     * @return 选中岗位ID列表
     */
    public List<Long> selectPostListByUserId(Long userId);

    /**
     * 查询用户所属岗位组 - Keep for custom query
     * 
     * @param userName 用户名
     * @return 结果
     */
    public List<SysPost> selectPostsByUserName(String userName);

    /**
     * 批量删除岗位信息 - Keep for array parameter
     * 
     * @param postIds 需要删除的岗位ID
     * @return 结果
     */
    public int deletePostByIds(Long[] postIds);

    /**
     * 校验岗位名称 - Keep for unique check
     * 
     * @param postName 岗位名称
     * @return 结果
     */
    public SysPost checkPostNameUnique(String postName);

    /**
     * 校验岗位编码 - Keep for unique check
     * 
     * @param postCode 岗位编码
     * @return 结果
     */
    public SysPost checkPostCodeUnique(String postCode);
}
