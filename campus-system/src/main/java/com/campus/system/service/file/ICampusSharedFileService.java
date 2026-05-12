package com.campus.system.service.file;

import java.util.List;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.campus.system.domain.file.CampusSharedFile;
import com.campus.system.domain.vo.CampusSharedFileVo;

/**
 * 共享文件服务接口
 *
 * @author CrazyLee
 */
public interface ICampusSharedFileService
{
    List<CampusSharedFileVo> selectCampusSharedFileList(CampusSharedFile file);

    IPage<CampusSharedFileVo> selectCampusSharedFilePage(Page<CampusSharedFileVo> page, CampusSharedFile file);

    CampusSharedFileVo selectCampusSharedFileById(Long fileId);

    int insertCampusSharedFile(CampusSharedFile file);

    int updateCampusSharedFile(CampusSharedFile file);

    int deleteCampusSharedFileByIds(Long[] fileIds);

    int updateCampusSharedFileDownloadCount(Long fileId);
}
