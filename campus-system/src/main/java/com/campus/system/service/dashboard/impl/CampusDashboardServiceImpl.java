package com.campus.system.service.dashboard.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.campus.system.domain.vo.CampusLeaveApplyVo;
import com.campus.system.domain.vo.CampusTaskCommentVo;
import com.campus.system.domain.vo.CampusTaskVo;
import com.campus.system.mapper.dashboard.CampusDashboardMapper;
import com.campus.system.service.dashboard.ICampusDashboardService;

/**
 * 仪表盘服务实现
 *
 * @author CrazyLee
 */
@Service
public class CampusDashboardServiceImpl implements ICampusDashboardService
{
    @Autowired
    private CampusDashboardMapper dashboardMapper;

    /**
     * 获取管理员仪表盘数据
     *
     * @return 仪表盘数据
     */
    @Override
    public Map<String, Object> getAdminDashboard()
    {
        Map<String, Object> result = new HashMap<>();

        result.put("userTotal", dashboardMapper.countUserTotal());
        result.put("taskTotal", dashboardMapper.countTaskTotal(null));
        result.put("pendingLeaveTotal", dashboardMapper.countPendingLeaveTotal(null));
        result.put("fileTotal", dashboardMapper.countFileTotal(null));

        List<Map<String, Object>> taskStatusStats = dashboardMapper.selectTaskStatusStats(null, null);
        result.put("taskStatusStats", taskStatusStats);

        List<Map<String, Object>> taskTrend = dashboardMapper.selectTaskTrend(null);
        result.put("taskTrend", taskTrend);

        List<Map<String, Object>> roleStats = dashboardMapper.selectRoleStats();
        result.put("roleStats", roleStats);

        List<Map<String, Object>> leaveStatusStats = dashboardMapper.selectLeaveStatusStats();
        result.put("leaveStatusStats", leaveStatusStats);

        List<CampusTaskVo> recentTasks = dashboardMapper.selectRecentTaskList(null);
        result.put("recentTasks", recentTasks);

        List<CampusLeaveApplyVo> recentLeaves = dashboardMapper.selectRecentLeaveList(null);
        result.put("recentLeaves", recentLeaves);

        return result;
    }

    /**
     * 获取教师仪表盘数据
     *
     * @param teacherUserId 教师用户ID
     * @return 仪表盘数据
     */
    @Override
    public Map<String, Object> getTeacherDashboard(Long teacherUserId)
    {
        Map<String, Object> result = new HashMap<>();

        result.put("myTaskTotal", dashboardMapper.countTaskTotal(teacherUserId));
        // 待审批请假尚未指定审批人，需查询全部待审批记录
        result.put("pendingLeaveTotal", dashboardMapper.countPendingLeaveTotal(null));
        result.put("myFileTotal", dashboardMapper.countFileTotal(teacherUserId));

        List<Map<String, Object>> taskStatusStats = dashboardMapper.selectTaskStatusStats(teacherUserId, null);
        result.put("taskStatusStats", taskStatusStats);

        List<Map<String, Object>> approvalTrend = dashboardMapper.selectApprovalTrend(teacherUserId);
        result.put("approvalTrend", approvalTrend);

        // 待审批请假尚未指定审批人，需查询全部待审批记录
        List<CampusLeaveApplyVo> pendingLeaves = dashboardMapper.selectPendingLeaveList(null);
        result.put("pendingLeaves", pendingLeaves);

        List<CampusTaskCommentVo> recentComments = dashboardMapper.selectRecentCommentList(teacherUserId);
        result.put("recentComments", recentComments);

        return result;
    }
}
