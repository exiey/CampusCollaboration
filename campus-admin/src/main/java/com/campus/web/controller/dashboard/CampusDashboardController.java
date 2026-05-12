package com.campus.web.controller.dashboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.campus.common.core.controller.BaseController;
import com.campus.common.core.domain.AjaxResult;
import com.campus.system.service.dashboard.ICampusDashboardService;

/**
 * 仪表盘数据
 *
 * @author CrazyLee
 */
@RestController
@RequestMapping("/campus/dashboard")
public class CampusDashboardController extends BaseController
{
    @Autowired
    private ICampusDashboardService campusDashboardService;

    /**
     * 获取管理员仪表盘数据
     */
    @PreAuthorize("@ss.hasRole('admin')")
    @GetMapping("/admin")
    public AjaxResult adminDashboard()
    {
        return success(campusDashboardService.getAdminDashboard());
    }

    /**
     * 获取教师仪表盘数据
     */
    @PreAuthorize("@ss.hasRole('teacher')")
    @GetMapping("/teacher")
    public AjaxResult teacherDashboard()
    {
        return success(campusDashboardService.getTeacherDashboard(getUserId()));
    }
}
