package com.campus.framework.config;

import java.util.Date;
import org.apache.ibatis.reflection.MetaObject;
import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.campus.common.utils.SecurityUtils;

/**
 * MyBatis-Plus 审计字段自动填充处理器
 *
 * 自动填充 createBy, createTime, updateBy, updateTime 字段
 *
 * @author crazyLee
 */
public class AuditMetaObjectHandler implements MetaObjectHandler
{
    @Override
    public void insertFill(MetaObject metaObject)
    {
        this.strictInsertFill(metaObject, "createTime", Date.class, new Date());
        this.strictInsertFill(metaObject, "createBy", String.class, getUsername());
        this.strictInsertFill(metaObject, "updateTime", Date.class, new Date());
        this.strictInsertFill(metaObject, "updateBy", String.class, getUsername());
    }

    @Override
    public void updateFill(MetaObject metaObject)
    {
        this.strictUpdateFill(metaObject, "updateTime", Date.class, new Date());
        this.strictUpdateFill(metaObject, "updateBy", String.class, getUsername());
    }

    /**
     * 获取当前登录用户名，如果获取失败则返回空字符串
     */
    private String getUsername()
    {
        try
        {
            return SecurityUtils.getUsername();
        }
        catch (Exception e)
        {
            // 在未登录状态下（如系统初始化）返回空字符串
            return "";
        }
    }
}
