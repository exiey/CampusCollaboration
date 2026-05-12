package com.campus.system.domain.leave;

import java.math.BigDecimal;
import java.util.Date;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.campus.common.annotation.Excel;
import com.campus.common.core.domain.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 请假申请对象 campus_leave_apply
 *
 * @author CrazyLee
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("campus_leave_apply")
public class CampusLeaveApply extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 请假ID */
    @TableId(type = IdType.AUTO)
    private Long leaveId;

    /** 申请人ID */
    private Long applicantUserId;

    /** 审批教师ID */
    private Long approverUserId;

    /** 请假类型 */
    @Excel(name = "请假类型", dictType = "campus_leave_type")
    @NotBlank(message = "请假类型不能为空")
    private String leaveType;

    /** 请假标题 */
    @Excel(name = "请假标题")
    @Size(max = 120, message = "请假标题长度不能超过120个字符")
    private String leaveTitle;

    /** 请假原因 */
    @Excel(name = "请假原因")
    @NotBlank(message = "请假原因不能为空")
    @Size(max = 500, message = "请假原因长度不能超过500个字符")
    private String leaveReason;

    /** 开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "开始时间", width = 20, dateFormat = "yyyy-MM-dd HH:mm:ss")
    @NotNull(message = "开始时间不能为空")
    private Date startTime;

    /** 结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "结束时间", width = 20, dateFormat = "yyyy-MM-dd HH:mm:ss")
    @NotNull(message = "结束时间不能为空")
    private Date endTime;

    /** 请假天数 */
    @Excel(name = "请假天数")
    @NotNull(message = "请假天数不能为空")
    @DecimalMin(value = "0.1", message = "请假天数必须大于0")
    private BigDecimal leaveDays;

    /** 请假状态 */
    @Excel(name = "请假状态", dictType = "campus_leave_status")
    private String leaveStatus;

    /** 联系电话 */
    @Excel(name = "联系电话")
    @Size(max = 11, message = "联系电话长度不能超过11个字符")
    private String contactPhone;

    /** 审批意见 */
    @Excel(name = "审批意见")
    @Size(max = 500, message = "审批意见长度不能超过500个字符")
    private String auditRemark;

    /** 审批时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "审批时间", width = 20, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date auditTime;

    /** 撤回时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "撤回时间", width = 20, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date revokeTime;

    /** 删除标志 */
    private String delFlag;
}
