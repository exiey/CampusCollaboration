package com.campus.web.controller.file;

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
import com.campus.system.domain.file.CampusSharedFile;
import com.campus.system.domain.vo.CampusSharedFileVo;
import com.campus.system.service.file.ICampusSharedFileService;

/**
 * 共享文件管理
 *
 * @author CrazyLee
 */
@RestController
@RequestMapping("/campus/file")
public class CampusSharedFileController extends BaseController
{
    @Autowired
    private ICampusSharedFileService campusSharedFileService;

    /**
     * 查询文件列表
     */
    @PreAuthorize("@ss.hasPermi('campus:file:list')")
    @GetMapping("/list")
    public TableDataInfo list(CampusSharedFile file)
    {
        Page<CampusSharedFileVo> page = startPage();
        IPage<CampusSharedFileVo> result = campusSharedFileService.selectCampusSharedFilePage(page, file);
        return getDataTable(result);
    }

    /**
     * 导出文件列表
     */
    @PreAuthorize("@ss.hasPermi('campus:file:export')")
    @Log(title = "文件管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(CampusSharedFile file, jakarta.servlet.http.HttpServletResponse response)
    {
        List<CampusSharedFileVo> list = campusSharedFileService.selectCampusSharedFileList(file);
        ExcelUtil<CampusSharedFileVo> util = new ExcelUtil<>(CampusSharedFileVo.class);
        util.exportExcel(response, list, "文件数据");
    }

    /**
     * 获取文件详情
     */
    @PreAuthorize("@ss.hasPermi('campus:file:query')")
    @GetMapping("/{fileId}")
    public AjaxResult getInfo(@PathVariable Long fileId)
    {
        return success(campusSharedFileService.selectCampusSharedFileById(fileId));
    }

    /**
     * 新增共享文件
     */
    @PreAuthorize("@ss.hasPermi('campus:file:add')")
    @Log(title = "文件管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody CampusSharedFile file)
    {
        file.setUploadUserId(getUserId());
        file.setCreateBy(getUsername());
        return toAjax(campusSharedFileService.insertCampusSharedFile(file));
    }

    /**
     * 修改共享文件
     */
    @PreAuthorize("@ss.hasPermi('campus:file:edit')")
    @Log(title = "文件管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody CampusSharedFile file)
    {
        file.setUpdateBy(getUsername());
        return toAjax(campusSharedFileService.updateCampusSharedFile(file));
    }

    /**
     * 删除共享文件
     */
    @PreAuthorize("@ss.hasPermi('campus:file:remove')")
    @Log(title = "文件管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{fileIds}")
    public AjaxResult remove(@PathVariable Long[] fileIds)
    {
        return toAjax(campusSharedFileService.deleteCampusSharedFileByIds(fileIds));
    }

    /**
     * 下载文件（增加下载计数）
     */
    @PreAuthorize("@ss.hasPermi('campus:file:query')")
    @PutMapping("/download/{fileId}")
    public AjaxResult download(@PathVariable Long fileId)
    {
        return toAjax(campusSharedFileService.updateCampusSharedFileDownloadCount(fileId));
    }
}
