package com.campus.system.domain.file;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.campus.common.annotation.Excel;
import com.campus.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 共享文件对象 campus_shared_file
 *
 * @author CrazyLee
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("campus_shared_file")
public class CampusSharedFile extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 文件ID */
    @TableId(type = IdType.AUTO)
    private Long fileId;

    /** 文件标题 */
    @Excel(name = "文件标题")
    @NotBlank(message = "文件标题不能为空")
    @Size(max = 120, message = "文件标题长度不能超过120个字符")
    private String fileName;

    /** 原始文件名 */
    @Excel(name = "原始文件名")
    private String originalName;

    /** 访问地址 */
    private String fileUrl;

    /** 存储路径 */
    private String filePath;

    /** 文件后缀 */
    @Excel(name = "文件后缀")
    private String fileSuffix;

    /** 文件大小 */
    @Excel(name = "文件大小")
    @NotNull(message = "文件大小不能为空")
    private Long fileSize;

    /** 文件分类 */
    @Excel(name = "文件分类", dictType = "campus_file_category")
    private String fileCategory;

    /** 访问范围 */
    @Excel(name = "访问范围", dictType = "campus_file_scope")
    private String accessScope;

    /** 上传用户ID */
    private Long uploadUserId;

    /** 下载次数 */
    @Excel(name = "下载次数")
    private Integer downloadCount;

    /** 状态 */
    @Excel(name = "状态", readConverterExp = "0=正常,1=隐藏")
    private String status;

    /** 删除标志 */
    private String delFlag;
}
