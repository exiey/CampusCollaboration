package com.campus.system.domain.vo;

import com.campus.system.domain.file.CampusSharedFile;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 共享文件视图对象
 *
 * @author CrazyLee
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class CampusSharedFileVo extends CampusSharedFile
{
    private static final long serialVersionUID = 1L;

    /** 上传用户姓名 */
    private String uploadUserName;

    /** 上传用户部门 */
    private String uploadDeptName;
}
