package com.campus.system.service.file.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.campus.system.domain.file.CampusSharedFile;
import com.campus.system.domain.vo.CampusSharedFileVo;
import com.campus.system.mapper.file.CampusSharedFileMapper;
import com.campus.system.service.file.ICampusSharedFileService;

/**
 * 共享文件服务实现
 *
 * @author CrazyLee
 */
@Service
public class CampusSharedFileServiceImpl implements ICampusSharedFileService
{
    @Autowired
    private CampusSharedFileMapper sharedFileMapper;

    /**
     * 查询文件列表
     *
     * @param file 查询条件
     * @return 文件视图列表
     */
    @Override
    public List<CampusSharedFileVo> selectCampusSharedFileList(CampusSharedFile file)
    {
        return sharedFileMapper.selectCampusSharedFileList(file);
    }

    /**
     * 分页查询文件列表
     *
     * @param page 分页参数
     * @param file 查询条件
     * @return 分页结果
     */
    @Override
    public IPage<CampusSharedFileVo> selectCampusSharedFilePage(Page<CampusSharedFileVo> page, CampusSharedFile file)
    {
        return sharedFileMapper.selectCampusSharedFilePage(page, file);
    }

    /**
     * 根据ID查询文件详情
     *
     * @param fileId 文件ID
     * @return 文件视图对象
     */
    @Override
    public CampusSharedFileVo selectCampusSharedFileById(Long fileId)
    {
        return sharedFileMapper.selectCampusSharedFileById(fileId);
    }

    /**
     * 新增共享文件
     *
     * @param file 文件对象
     * @return 影响行数
     */
    @Override
    public int insertCampusSharedFile(CampusSharedFile file)
    {
        if (file.getStatus() == null)
        {
            file.setStatus("0");
        }
        return sharedFileMapper.insertCampusSharedFile(file);
    }

    /**
     * 修改共享文件
     *
     * @param file 文件对象
     * @return 影响行数
     */
    @Override
    public int updateCampusSharedFile(CampusSharedFile file)
    {
        return sharedFileMapper.updateCampusSharedFile(file);
    }

    /**
     * 批量删除共享文件
     *
     * @param fileIds 文件ID数组
     * @return 影响行数
     */
    @Override
    public int deleteCampusSharedFileByIds(Long[] fileIds)
    {
        return sharedFileMapper.deleteCampusSharedFileByIds(fileIds);
    }

    /**
     * 增加文件下载次数
     *
     * @param fileId 文件ID
     * @return 影响行数
     */
    @Override
    public int updateCampusSharedFileDownloadCount(Long fileId)
    {
        return sharedFileMapper.updateCampusSharedFileDownloadCount(fileId);
    }
}
