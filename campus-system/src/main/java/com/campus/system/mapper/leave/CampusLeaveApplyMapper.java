package com.campus.system.mapper.leave;

import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import com.campus.system.domain.leave.CampusLeaveApply;
import com.campus.system.domain.vo.CampusLeaveApplyVo;

/**
 * 请假申请数据层
 *
 * @author CrazyLee
 */
public interface CampusLeaveApplyMapper extends BaseMapper<CampusLeaveApply>
{
    List<CampusLeaveApplyVo> selectCampusLeaveApplyList(CampusLeaveApply leaveApply);

    IPage<CampusLeaveApplyVo> selectCampusLeaveApplyPage(Page<CampusLeaveApplyVo> page, @Param("leaveApply") CampusLeaveApply leaveApply);

    CampusLeaveApplyVo selectCampusLeaveApplyById(Long leaveId);

    int insertCampusLeaveApply(CampusLeaveApply leaveApply);

    int updateCampusLeaveApply(CampusLeaveApply leaveApply);

    int deleteCampusLeaveApplyByIds(Long[] leaveIds);

    int approveCampusLeaveApply(CampusLeaveApply leaveApply);

    int revokeCampusLeaveApply(@Param("leaveId") Long leaveId, @Param("updateBy") String updateBy);
}
