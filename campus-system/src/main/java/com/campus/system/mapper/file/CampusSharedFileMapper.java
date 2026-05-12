package com.campus.system.mapper.file;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.campus.system.domain.file.CampusSharedFile;
import com.campus.system.domain.vo.CampusSharedFileVo;

/**
 * 共享文件数据层
 *
 * @author CrazyLee
 */
public interface CampusSharedFileMapper extends BaseMapper<CampusSharedFile>
{
    List<CampusSharedFileVo> selectCampusSharedFileList(CampusSharedFile file);

    IPage<CampusSharedFileVo> selectCampusSharedFilePage(Page<CampusSharedFileVo> page, @Param("file") CampusSharedFile file);

    CampusSharedFileVo selectCampusSharedFileById(Long fileId);

    int insertCampusSharedFile(CampusSharedFile file);

    int updateCampusSharedFile(CampusSharedFile file);

    int deleteCampusSharedFileByIds(Long[] fileIds);

    int updateCampusSharedFileDownloadCount(Long fileId);
}
