package com.campus.system.domain.vo;

import com.campus.system.domain.leave.CampusLeaveApply;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 请假申请视图对象
 *
 * @author CrazyLee
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class CampusLeaveApplyVo extends CampusLeaveApply
{
    private static final long serialVersionUID = 1L;

    /** 申请人姓名 */
    private String applicantUserName;

    /** 申请人部门 */
    private String applicantDeptName;

    /** 审批教师姓名 */
    private String approverUserName;
}
