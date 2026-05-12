package com.campus.web.controller.task;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.campus.common.annotation.Log;
import com.campus.common.core.controller.BaseController;
import com.campus.common.core.domain.AjaxResult;
import com.campus.common.core.page.TableDataInfo;
import com.campus.common.enums.BusinessType;
import com.campus.common.utils.poi.ExcelUtil;
import com.campus.common.utils.SecurityUtils;
import com.campus.system.domain.task.CampusTask;
import com.campus.system.domain.task.CampusTaskComment;
import com.campus.system.domain.vo.CampusTaskCommentVo;
import com.campus.system.domain.vo.CampusTaskVo;
import com.campus.system.service.task.ICampusTaskService;

/**
 * 任务管理
 *
 * @author CrazyLee
 */
@RestController
@RequestMapping("/campus/task")
public class CampusTaskController extends BaseController
{
    @Autowired
    private ICampusTaskService campusTaskService;

    /**
     * 查询任务列表
     * 数据作用域: 学生只看分配给自己的任务, 教师只看自己发布的任务, 管理员查看全部
     */
    @PreAuthorize("@ss.hasPermi('campus:task:list')")
    @GetMapping("/list")
    public TableDataInfo list(CampusTask task)
    {
        if (!SecurityUtils.hasRole("admin"))
        {
            if (SecurityUtils.hasRole("student"))
            {
                // 学生只能看到分配给自己的任务
                task.setReceiveUserId(getUserId());
            }
            else if (SecurityUtils.hasRole("teacher"))
            {
                // 教师只能看到自己发布的任务
                task.setPublishUserId(getUserId());
            }
        }
        Page<CampusTaskVo> page = startPage();
        IPage<CampusTaskVo> result = campusTaskService.selectCampusTaskPage(page, task);
        return getDataTable(result);
    }

    /**
     * 导出任务列表
     */
    @PreAuthorize("@ss.hasPermi('campus:task:export')")
    @Log(title = "任务管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(CampusTask task, jakarta.servlet.http.HttpServletResponse response)
    {
        if (!SecurityUtils.hasRole("admin"))
        {
            if (SecurityUtils.hasRole("student"))
            {
                task.setReceiveUserId(SecurityUtils.getUserId());
            }
            else if (SecurityUtils.hasRole("teacher"))
            {
                task.setPublishUserId(SecurityUtils.getUserId());
            }
        }
        List<CampusTaskVo> list = campusTaskService.selectCampusTaskList(task);
        ExcelUtil<CampusTaskVo> util = new ExcelUtil<>(CampusTaskVo.class);
        util.exportExcel(response, list, "任务数据");
    }

    /**
     * 获取任务详情
     */
    @PreAuthorize("@ss.hasPermi('campus:task:query')")
    @GetMapping("/{taskId}")
    public AjaxResult getInfo(@PathVariable Long taskId)
    {
        return success(campusTaskService.selectCampusTaskById(taskId));
    }

    /**
     * 新增任务
     */
    @PreAuthorize("@ss.hasPermi('campus:task:add')")
    @Log(title = "任务管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody CampusTask task)
    {
        task.setPublishUserId(getUserId());
        task.setCreateBy(getUsername());
        return toAjax(campusTaskService.insertCampusTask(task));
    }

    /**
     * 修改任务
     */
    @PreAuthorize("@ss.hasPermi('campus:task:edit')")
    @Log(title = "任务管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody CampusTask task)
    {
        task.setUpdateBy(getUsername());
        return toAjax(campusTaskService.updateCampusTask(task));
    }

    /**
     * 删除任务
     */
    @PreAuthorize("@ss.hasPermi('campus:task:remove')")
    @Log(title = "任务管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{taskIds}")
    public AjaxResult remove(@PathVariable Long[] taskIds)
    {
        return toAjax(campusTaskService.deleteCampusTaskByIds(taskIds));
    }

    /**
     * 更新任务状态
     */
    @PreAuthorize("@ss.hasPermi('campus:task:edit')")
    @Log(title = "任务管理", businessType = BusinessType.UPDATE)
    @PutMapping("/status")
    public AjaxResult changeStatus(@RequestBody CampusTask task)
    {
        task.setUpdateBy(getUsername());
        return toAjax(campusTaskService.updateCampusTaskStatus(task));
    }

    /**
     * 查询任务评论列表
     */
    @PreAuthorize("@ss.hasPermi('campus:task:query')")
    @GetMapping("/comment/{taskId}")
    public AjaxResult commentList(@PathVariable Long taskId)
    {
        List<CampusTaskCommentVo> list = campusTaskService.selectCampusTaskCommentList(taskId);
        return success(list);
    }

    /**
     * 新增任务评论
     */
    @PreAuthorize("@ss.hasPermi('campus:task:edit')")
    @Log(title = "任务评论", businessType = BusinessType.INSERT)
    @PostMapping("/comment")
    public AjaxResult addComment(@Validated @RequestBody CampusTaskComment comment)
    {
        comment.setCommentUserId(getUserId());
        comment.setCreateBy(getUsername());
        return toAjax(campusTaskService.insertCampusTaskComment(comment));
    }

    /**
     * 删除任务评论
     */
    @PreAuthorize("@ss.hasPermi('campus:task:edit')")
    @Log(title = "任务评论", businessType = BusinessType.DELETE)
    @DeleteMapping("/comment/{commentId}")
    public AjaxResult removeComment(@PathVariable Long commentId)
    {
        return toAjax(campusTaskService.deleteCampusTaskCommentById(commentId));
    }
}
