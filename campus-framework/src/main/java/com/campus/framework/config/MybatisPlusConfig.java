package com.campus.framework.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;

/**
 * MyBatis-Plus 配置
 *
 * This is the sole source of MyBatis/MyBatis-Plus configuration after migration.
 * The legacy MyBatisConfig has been disabled.
 *
 * Note: @MapperScan is NOT needed here because:
 * 1. The mybatis-plus-spring-boot3-starter auto-configures mapper scanning
 *    based on mybatis-plus.mapper-locations in application.yml
 * 2. The RuoYiApplication class may have its own @MapperScan that takes precedence
 *
 * @author crazyLee
 */
@Configuration
public class MybatisPlusConfig
{
    /**
     * MyBatis-Plus 插件配置
     */
    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor()
    {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        // 分页插件
        interceptor.addInnerInterceptor(new PaginationInnerInterceptor(DbType.MYSQL));
        return interceptor;
    }

    /**
     * 审计字段自动填充处理器
     */
    @Bean
    public MetaObjectHandler metaObjectHandler()
    {
        return new AuditMetaObjectHandler();
    }
}
