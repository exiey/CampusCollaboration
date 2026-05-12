<template>
  <div class="file-page">
    <div class="page-header">
      <h2 class="page-title">文件中心</h2>
      <p class="page-desc">浏览和下载共享文件</p>
    </div>

    <div class="filter-bar">
      <el-input v-model="queryParams.fileName" placeholder="搜索文件名" prefix-icon="Search" clearable style="width: 240px" @keyup.enter="handleQuery" />
      <el-select v-model="queryParams.fileCategory" placeholder="文件分类" clearable style="width: 140px" @change="handleQuery">
        <el-option label="教学资料" value="1" />
        <el-option label="作业" value="2" />
        <el-option label="通知" value="3" />
        <el-option label="其他" value="4" />
      </el-select>
      <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
      <el-button icon="Refresh" @click="resetQuery">重置</el-button>
    </div>

    <div v-loading="loading" class="file-grid">
      <div v-if="fileList.length === 0 && !loading" class="empty-state">
        <el-icon :size="48" class="empty-icon"><FolderOpened /></el-icon>
        <p class="empty-text">暂无共享文件</p>
        <p class="empty-hint">教师上传文件后将在此显示</p>
      </div>
      <div v-for="file in fileList" :key="file.fileId" class="file-card">
        <div class="file-icon-wrap">
          <el-icon :size="32"><Document /></el-icon>
          <span class="file-suffix">{{ file.fileSuffix || '?' }}</span>
        </div>
        <div class="file-info">
          <h4 class="file-name">{{ file.fileName }}</h4>
          <div class="file-meta">
            <span>{{ formatSize(file.fileSize) }}</span>
            <span>{{ file.uploadUserName }}</span>
            <span>{{ formatDate(file.createTime) }}</span>
          </div>
          <div class="file-tags">
            <el-tag size="small" type="info">{{ getCategoryLabel(file.fileCategory) }}</el-tag>
            <span class="download-count">
              <el-icon :size="12"><Download /></el-icon>
              {{ file.downloadCount || 0 }}
            </span>
          </div>
        </div>
        <el-button type="primary" plain icon="Download" size="small" @click="handleDownload(file)">下载</el-button>
      </div>
    </div>

    <div v-if="total > 0" class="pagination-wrap">
      <el-pagination background layout="total, prev, pager, next" :total="total" :page-size="queryParams.pageSize" v-model:current-page="queryParams.pageNum" @current-change="getList" />
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { FolderOpened, Document, Download } from '@element-plus/icons-vue'
import { listFile, downloadFile } from '@/api/file'

const loading = ref(false)
const total = ref(0)
const fileList = ref([])
const queryParams = reactive({ pageNum: 1, pageSize: 12, fileName: undefined, fileCategory: undefined })

const categoryMap = { '1': '教学资料', '2': '作业', '3': '通知', '4': '其他' }
function getCategoryLabel(c) { return categoryMap[c] || '其他' }

function formatSize(bytes) {
  if (!bytes || bytes === 0) return '0 B'
  const units = ['B', 'KB', 'MB', 'GB']
  const i = Math.floor(Math.log(bytes) / Math.log(1024))
  return (bytes / Math.pow(1024, i)).toFixed(1) + ' ' + units[i]
}

function formatDate(d) { return d ? d.substring(0, 10) : '-' }

function getList() {
  loading.value = true
  listFile(queryParams).then(res => {
    fileList.value = res.rows || []
    total.value = res.total || 0
  }).finally(() => { loading.value = false })
}

function handleQuery() { queryParams.pageNum = 1; getList() }
function resetQuery() { queryParams.fileName = undefined; queryParams.fileCategory = undefined; handleQuery() }

function handleDownload(file) {
  downloadFile(file.fileId).then(() => {
    if (file.fileUrl) {
      const baseApi = import.meta.env.VITE_APP_BASE_API
      const url = file.fileUrl.startsWith('http') ? file.fileUrl : (baseApi === '/dev-api' ? 'http://localhost:8080' : '') + file.fileUrl
      window.open(url, '_blank')
    }
    ElMessage.success('下载计数已更新')
    getList()
  })
}

onMounted(() => { getList() })
</script>

<style scoped>
.file-page { padding-bottom: var(--space-xl); }
.page-header { margin-bottom: var(--space-lg); }
.page-title { font-family: var(--font-heading); font-size: 22px; color: var(--text-primary); margin-bottom: 4px; }
.page-desc { font-size: 14px; color: var(--text-secondary); margin: 0; }

.filter-bar {
  display: flex; align-items: center; gap: var(--space-sm); flex-wrap: wrap;
  margin-bottom: var(--space-lg); padding: var(--space-md);
  background: var(--bg-card); border-radius: var(--radius-lg); box-shadow: var(--shadow-sm);
}

.file-grid { display: flex; flex-direction: column; gap: var(--space-sm); min-height: 200px; }

.empty-state { text-align: center; padding: var(--space-3xl) 0; }
.empty-icon { color: var(--text-placeholder); margin-bottom: var(--space-sm); }
.empty-text { font-size: 16px; color: var(--text-secondary); margin-bottom: 4px; }
.empty-hint { font-size: 13px; color: var(--text-placeholder); }

.file-card {
  display: flex; align-items: center; gap: var(--space-md);
  background: var(--bg-card); border-radius: var(--radius-lg); padding: var(--space-md) var(--space-lg);
  box-shadow: var(--shadow-sm); transition: all 200ms ease;
}

.file-card:hover { box-shadow: var(--shadow-md); }

.file-icon-wrap {
  width: 56px; height: 56px; border-radius: var(--radius-md);
  background: var(--color-primary-lightest); display: flex; flex-direction: column;
  align-items: center; justify-content: center; flex-shrink: 0; color: var(--color-primary);
}

.file-suffix { font-size: 10px; font-weight: 600; text-transform: uppercase; margin-top: 2px; }

.file-info { flex: 1; min-width: 0; }
.file-name { font-size: 15px; font-weight: 600; color: var(--text-primary); margin-bottom: 4px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }

.file-meta {
  display: flex; gap: var(--space-md); font-size: 12px; color: var(--text-secondary); margin-bottom: 6px;
}

.file-tags { display: flex; align-items: center; gap: var(--space-sm); }
.download-count { display: flex; align-items: center; gap: 2px; font-size: 12px; color: var(--text-secondary); }

.pagination-wrap { display: flex; justify-content: center; margin-top: var(--space-xl); }

@media (max-width: 768px) {
  .file-card { flex-direction: column; align-items: flex-start; }
}

@media (prefers-reduced-motion: reduce) { .file-card { transition: none; } }
</style>
