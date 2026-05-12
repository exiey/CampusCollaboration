package com.campus.system.service.dashboard;

import java.util.Map;

/**
 * 仪表盘服务接口
 *
 * @author CrazyLee
 */
public interface ICampusDashboardService
{
    Map<String, Object> getAdminDashboard();

    Map<String, Object> getTeacherDashboard(Long teacherUserId);
}
