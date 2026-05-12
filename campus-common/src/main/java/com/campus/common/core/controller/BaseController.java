package com.campus.common.core.controller;

import java.beans.PropertyEditorSupport;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import com.campus.common.constant.HttpStatus;
import com.campus.common.core.domain.AjaxResult;
import com.campus.common.core.domain.model.LoginUser;
import com.campus.common.core.page.PageDomain;
import com.campus.common.core.page.TableDataInfo;
import com.campus.common.core.page.TableSupport;
import com.campus.common.utils.DateUtils;
import com.campus.common.utils.SecurityUtils;
import com.campus.common.utils.StringUtils;

/**
 * web层通用数据处理
 * 
 * @author crazyLee
 */
public class BaseController
{
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * Allowed characters for order-by column names (prevent SQL injection)
     * Only alphanumeric and underscore are allowed
     */
    private static final Pattern ORDER_COLUMN_PATTERN = Pattern.compile("^[a-zA-Z0-9_]+$");

    /**
     * 将前台传递过来的日期格式的字符串，自动转化为Date类型
     */
    @InitBinder
    public void initBinder(WebDataBinder binder)
    {
        // Date 类型转换
        binder.registerCustomEditor(Date.class, new PropertyEditorSupport()
        {
            @Override
            public void setAsText(String text)
            {
                setValue(DateUtils.parseDate(text));
            }
        });
    }

    /**
     * 构建MyBatis-Plus分页对象（新方法）
     * 从请求参数中读取pageNum, pageSize, orderByColumn, isAsc
     * 
     * Features:
     * - Default pageNum to 1 if null or < 1
     * - Default pageSize to 10 if null or < 1
     * - Convert column name to snake_case using toUnderScoreCase()
     * - Security validation: only allow alphanumeric and underscore in column names
     * - Single-column sorting only (multi-column like "a asc,b desc" not supported)
     *
     * @param <T> 泛型类型
     * @return MyBatis-Plus分页对象
     */
    protected <T> Page<T> startPage()
    {
        PageDomain pageDomain = TableSupport.buildPageRequest();
        Integer pageNum = pageDomain.getPageNum();
        Integer pageSize = pageDomain.getPageSize();
        
        // Default value handling
        if (pageNum == null || pageNum < 1)
        {
            pageNum = 1;
        }
        if (pageSize == null || pageSize < 1)
        {
            pageSize = 10;
        }
        
        Page<T> page = new Page<>(pageNum, pageSize);

        String orderBy = pageDomain.getOrderBy();
        if (StringUtils.isNotBlank(orderBy))
        {
            // Parse orderBy: "column_name asc" or "column_name desc"
            // Use trim + \\s+ for robust whitespace handling
            String[] parts = orderBy.trim().split("\\s+");
            if (parts.length >= 1)
            {
                // Convert to snake_case
                String column = StringUtils.toUnderScoreCase(parts[0]);
                // Security validation: only allow alphanumeric and underscore
                if (ORDER_COLUMN_PATTERN.matcher(column).matches())
                {
                    boolean isAsc = parts.length < 2 || !"desc".equalsIgnoreCase(parts[1]);
                    page.addOrder(isAsc ? OrderItem.asc(column) : OrderItem.desc(column));
                }
                // If column contains invalid characters, silently ignore sorting
            }
        }
        return page;
    }

    /**
     * 响应MyBatis-Plus分页数据
     *
     * @param page MyBatis-Plus分页结果
     * @return 分页数据
     */
    protected TableDataInfo getDataTable(IPage<?> page)
    {
        TableDataInfo rspData = new TableDataInfo();
        rspData.setCode(HttpStatus.SUCCESS);
        rspData.setMsg("查询成功");
        rspData.setRows(page.getRecords());
        rspData.setTotal(page.getTotal());
        return rspData;
    }

    /**
     * 响应请求分页数据（用于内存列表，非数据库分页）
     * 
     * @param list 列表数据
     * @return 分页数据
     */
    protected TableDataInfo getDataTable(List<?> list)
    {
        TableDataInfo rspData = new TableDataInfo();
        rspData.setCode(HttpStatus.SUCCESS);
        rspData.setMsg("查询成功");
        rspData.setRows(list);
        rspData.setTotal(list.size());
        return rspData;
    }

    /**
     * 返回成功
     */
    public AjaxResult success()
    {
        return AjaxResult.success();
    }

    /**
     * 返回失败消息
     */
    public AjaxResult error()
    {
        return AjaxResult.error();
    }

    /**
     * 返回成功消息
     */
    public AjaxResult success(String message)
    {
        return AjaxResult.success(message);
    }
    
    /**
     * 返回成功消息
     */
    public AjaxResult success(Object data)
    {
        return AjaxResult.success(data);
    }

    /**
     * 返回失败消息
     */
    public AjaxResult error(String message)
    {
        return AjaxResult.error(message);
    }

    /**
     * 返回警告消息
     */
    public AjaxResult warn(String message)
    {
        return AjaxResult.warn(message);
    }

    /**
     * 响应返回结果
     * 
     * @param rows 影响行数
     * @return 操作结果
     */
    protected AjaxResult toAjax(int rows)
    {
        return rows > 0 ? AjaxResult.success() : AjaxResult.error();
    }

    /**
     * 响应返回结果
     * 
     * @param result 结果
     * @return 操作结果
     */
    protected AjaxResult toAjax(boolean result)
    {
        return result ? success() : error();
    }

    /**
     * 页面跳转
     */
    public String redirect(String url)
    {
        return StringUtils.format("redirect:{}", url);
    }

    /**
     * 获取用户缓存信息
     */
    public LoginUser getLoginUser()
    {
        return SecurityUtils.getLoginUser();
    }

    /**
     * 获取登录用户id
     */
    public Long getUserId()
    {
        return getLoginUser().getUserId();
    }

    /**
     * 获取登录部门id
     */
    public Long getDeptId()
    {
        return getLoginUser().getDeptId();
    }

    /**
     * 获取登录用户名
     */
    public String getUsername()
    {
        return getLoginUser().getUsername();
    }
}
