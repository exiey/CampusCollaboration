package com.campus.system.service.leave;

import java.util.List;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.campus.system.domain.leave.CampusLeaveApply;
import com.campus.system.domain.vo.CampusLeaveApplyVo;

/**
 * 请假申请服务接口
 *
 * @author CrazyLee
 */
public interface ICampusLeaveApplyService
{
    List<CampusLeaveApplyVo> selectCampusLeaveApplyList(CampusLeaveApply leaveApply);

    IPage<CampusLeaveApplyVo> selectCampusLeaveApplyPage(Page<CampusLeaveApplyVo> page, CampusLeaveApply leaveApply);

    CampusLeaveApplyVo selectCampusLeaveApplyById(Long leaveId);

    int insertCampusLeaveApply(CampusLeaveApply leaveApply);

    int updateCampusLeaveApply(CampusLeaveApply leaveApply);

    int deleteCampusLeaveApplyByIds(Long[] leaveIds);

    int approveCampusLeaveApply(CampusLeaveApply leaveApply);

    int revokeCampusLeaveApply(Long leaveId);
}
