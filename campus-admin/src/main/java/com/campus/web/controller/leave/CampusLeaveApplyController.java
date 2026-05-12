package com.campus.web.controller.leave;

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
import com.campus.system.domain.leave.CampusLeaveApply;
import com.campus.system.domain.vo.CampusLeaveApplyVo;
import com.campus.system.service.leave.ICampusLeaveApplyService;

/**
 * 请假管理
 *
 * @author CrazyLee
 */
@RestController
@RequestMapping("/campus/leave")
public class CampusLeaveApplyController extends BaseController
{
    @Autowired
    private ICampusLeaveApplyService campusLeaveApplyService;

    /**
     * 查询请假列表
     * 数据作用域: 学生只能查看自己的请假, 教师/管理员查看全部
     */
    @PreAuthorize("@ss.hasPermi('campus:leave:list')")
    @GetMapping("/list")
    public TableDataInfo list(CampusLeaveApply leaveApply)
    {
        // 学生角色只能查看自己的请假记录
        if (SecurityUtils.hasRole("student") && !SecurityUtils.hasRole("admin"))
        {
            leaveApply.setApplicantUserId(getUserId());
        }
        Page<CampusLeaveApplyVo> page = startPage();
        IPage<CampusLeaveApplyVo> result = campusLeaveApplyService.selectCampusLeaveApplyPage(page, leaveApply);
        return getDataTable(result);
    }

    /**
     * 导出请假列表
     */
    @PreAuthorize("@ss.hasPermi('campus:leave:export')")
    @Log(title = "请假管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(CampusLeaveApply leaveApply, jakarta.servlet.http.HttpServletResponse response)
    {
        if (SecurityUtils.hasRole("student") && !SecurityUtils.hasRole("admin"))
        {
            leaveApply.setApplicantUserId(SecurityUtils.getUserId());
        }
        List<CampusLeaveApplyVo> list = campusLeaveApplyService.selectCampusLeaveApplyList(leaveApply);
        ExcelUtil<CampusLeaveApplyVo> util = new ExcelUtil<>(CampusLeaveApplyVo.class);
        util.exportExcel(response, list, "请假数据");
    }

    /**
     * 获取请假详情
     */
    @PreAuthorize("@ss.hasPermi('campus:leave:query')")
    @GetMapping("/{leaveId}")
    public AjaxResult getInfo(@PathVariable Long leaveId)
    {
        return success(campusLeaveApplyService.selectCampusLeaveApplyById(leaveId));
    }

    /**
     * 新增请假申请
     */
    @PreAuthorize("@ss.hasPermi('campus:leave:add')")
    @Log(title = "请假管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody CampusLeaveApply leaveApply)
    {
        leaveApply.setApplicantUserId(getUserId());
        leaveApply.setCreateBy(getUsername());
        return toAjax(campusLeaveApplyService.insertCampusLeaveApply(leaveApply));
    }

    /**
     * 修改请假申请
     */
    @PreAuthorize("@ss.hasPermi('campus:leave:edit')")
    @Log(title = "请假管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody CampusLeaveApply leaveApply)
    {
        leaveApply.setUpdateBy(getUsername());
        return toAjax(campusLeaveApplyService.updateCampusLeaveApply(leaveApply));
    }

    /**
     * 删除请假申请
     */
    @PreAuthorize("@ss.hasPermi('campus:leave:remove')")
    @Log(title = "请假管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{leaveIds}")
    public AjaxResult remove(@PathVariable Long[] leaveIds)
    {
        return toAjax(campusLeaveApplyService.deleteCampusLeaveApplyByIds(leaveIds));
    }

    /**
     * 审批请假申请
     */
    @PreAuthorize("@ss.hasPermi('campus:leave:audit')")
    @Log(title = "请假审批", businessType = BusinessType.UPDATE)
    @PutMapping("/approve")
    public AjaxResult approve(@RequestBody CampusLeaveApply leaveApply)
    {
        leaveApply.setApproverUserId(getUserId());
        leaveApply.setUpdateBy(getUsername());
        return toAjax(campusLeaveApplyService.approveCampusLeaveApply(leaveApply));
    }

    /**
     * 撤回请假申请
     */
    @PreAuthorize("@ss.hasPermi('campus:leave:edit')")
    @Log(title = "请假撤回", businessType = BusinessType.UPDATE)
    @PutMapping("/revoke/{leaveId}")
    public AjaxResult revoke(@PathVariable Long leaveId)
    {
        return toAjax(campusLeaveApplyService.revokeCampusLeaveApply(leaveId));
    }
}
