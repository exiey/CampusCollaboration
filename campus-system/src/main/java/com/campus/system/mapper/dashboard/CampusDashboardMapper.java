package com.campus.system.mapper.dashboard;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.campus.system.domain.vo.CampusLeaveApplyVo;
import com.campus.system.domain.vo.CampusTaskCommentVo;
import com.campus.system.domain.vo.CampusTaskVo;

/**
 * 仪表盘统计数据层
 *
 * @author CrazyLee
 */
public interface CampusDashboardMapper
{
    Long countUserTotal();

    Long countTaskTotal(@Param("publishUserId") Long publishUserId);

    Long countPendingLeaveTotal(@Param("approverUserId") Long approverUserId);

    Long countFileTotal(@Param("uploadUserId") Long uploadUserId);

    List<Map<String, Object>> selectTaskStatusStats(@Param("publishUserId") Long publishUserId,
            @Param("receiveUserId") Long receiveUserId);

    List<Map<String, Object>> selectTaskTrend(@Param("publishUserId") Long publishUserId);

    List<Map<String, Object>> selectRoleStats();

    List<Map<String, Object>> selectLeaveStatusStats();

    List<Map<String, Object>> selectApprovalTrend(@Param("approverUserId") Long approverUserId);

    List<CampusTaskVo> selectRecentTaskList(@Param("publishUserId") Long publishUserId);

    List<CampusLeaveApplyVo> selectRecentLeaveList(@Param("approverUserId") Long approverUserId);

    List<CampusLeaveApplyVo> selectPendingLeaveList(@Param("approverUserId") Long approverUserId);

    List<CampusTaskCommentVo> selectRecentCommentList(@Param("publishUserId") Long publishUserId);
}
