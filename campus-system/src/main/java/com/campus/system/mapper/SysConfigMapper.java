package com.campus.system.mapper;

import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.campus.system.domain.SysConfig;

/**
 * 参数配置 数据层
 *
 * @author crazyLee
 */
public interface SysConfigMapper extends BaseMapper<SysConfig>
{
    /**
     * 查询参数配置信息
     *
     * @param config 参数配置信息
     * @return 参数配置信息
     */
    public SysConfig selectConfig(SysConfig config);

    /**
     * 查询参数配置列表
     *
     * @param config 参数配置信息
     * @return 参数配置集合
     */
    public List<SysConfig> selectConfigList(SysConfig config);

    /**
     * 根据键名查询参数配置信息
     *
     * @param configKey 参数键名
     * @return 参数配置信息
     */
    public SysConfig checkConfigKeyUnique(String configKey);

    // Simple CRUD methods removed - now provided by BaseMapper:
    // - selectById(Long id)
    // - insert(SysConfig config)
    // - updateById(SysConfig config)
    // - deleteById(Long id)
    // - deleteBatchIds(Collection<Long> ids)
}
