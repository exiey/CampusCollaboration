package com.campus.system.service.leave.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.campus.common.exception.ServiceException;
import com.campus.system.domain.leave.CampusLeaveApply;
import com.campus.system.domain.vo.CampusLeaveApplyVo;
import com.campus.system.mapper.leave.CampusLeaveApplyMapper;
import com.campus.system.service.leave.ICampusLeaveApplyService;

/**
 * 请假申请服务实现
 *
 * @author CrazyLee
 */
@Service
public class CampusLeaveApplyServiceImpl implements ICampusLeaveApplyService
{
    @Autowired
    private CampusLeaveApplyMapper leaveApplyMapper;

    /**
     * 查询请假列表
     *
     * @param leaveApply 查询条件
     * @return 请假视图列表
     */
    @Override
    public List<CampusLeaveApplyVo> selectCampusLeaveApplyList(CampusLeaveApply leaveApply)
    {
        return leaveApplyMapper.selectCampusLeaveApplyList(leaveApply);
    }

    /**
     * 分页查询请假列表
     *
     * @param page 分页参数
     * @param leaveApply 查询条件
     * @return 分页结果
     */
    @Override
    public IPage<CampusLeaveApplyVo> selectCampusLeaveApplyPage(Page<CampusLeaveApplyVo> page, CampusLeaveApply leaveApply)
    {
        return leaveApplyMapper.selectCampusLeaveApplyPage(page, leaveApply);
    }

    /**
     * 根据ID查询请假详情
     *
     * @param leaveId 请假ID
     * @return 请假视图对象
     */
    @Override
    public CampusLeaveApplyVo selectCampusLeaveApplyById(Long leaveId)
    {
        return leaveApplyMapper.selectCampusLeaveApplyById(leaveId);
    }

    /**
     * 新增请假申请
     *
     * @param leaveApply 请假对象
     * @return 影响行数
     */
    @Override
    public int insertCampusLeaveApply(CampusLeaveApply leaveApply)
    {
        leaveApply.setLeaveStatus("0");
        return leaveApplyMapper.insertCampusLeaveApply(leaveApply);
    }

    /**
     * 修改请假申请
     *
     * @param leaveApply 请假对象
     * @return 影响行数
     */
    @Override
    public int updateCampusLeaveApply(CampusLeaveApply leaveApply)
    {
        CampusLeaveApplyVo existing = leaveApplyMapper.selectCampusLeaveApplyById(leaveApply.getLeaveId());
        if (existing == null)
        {
            throw new ServiceException("请假申请不存在");
        }
        if (!"0".equals(existing.getLeaveStatus()))
        {
            throw new ServiceException("只有待审批状态的请假才能修改");
        }
        return leaveApplyMapper.updateCampusLeaveApply(leaveApply);
    }

    /**
     * 批量删除请假申请
     *
     * @param leaveIds 请假ID数组
     * @return 影响行数
     */
    @Override
    public int deleteCampusLeaveApplyByIds(Long[] leaveIds)
    {
        return leaveApplyMapper.deleteCampusLeaveApplyByIds(leaveIds);
    }

    /**
     * 审批请假申请
     *
     * @param leaveApply 包含leaveId、leaveStatus、auditRemark的请假对象
     * @return 影响行数
     */
    @Override
    public int approveCampusLeaveApply(CampusLeaveApply leaveApply)
    {
        CampusLeaveApplyVo existing = leaveApplyMapper.selectCampusLeaveApplyById(leaveApply.getLeaveId());
        if (existing == null)
        {
            throw new ServiceException("请假申请不存在");
        }
        if (!"0".equals(existing.getLeaveStatus()))
        {
            throw new ServiceException("只有待审批状态的请假才能审批");
        }
        return leaveApplyMapper.approveCampusLeaveApply(leaveApply);
    }

    /**
     * 撤回请假申请
     *
     * @param leaveId 请假ID
     * @return 影响行数
     */
    @Override
    public int revokeCampusLeaveApply(Long leaveId)
    {
        CampusLeaveApplyVo existing = leaveApplyMapper.selectCampusLeaveApplyById(leaveId);
        if (existing == null)
        {
            throw new ServiceException("请假申请不存在");
        }
        if (!"0".equals(existing.getLeaveStatus()))
        {
            throw new ServiceException("只有待审批状态的请假才能撤回");
        }
        return leaveApplyMapper.revokeCampusLeaveApply(leaveId, existing.getCreateBy());
    }
}
