<template>
  <div class="app-container">
    <!-- 搜索表单 -->
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="文件标题" prop="fileName">
        <el-input v-model="queryParams.fileName" placeholder="请输入文件标题" clearable style="width: 200px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="文件分类" prop="fileCategory">
        <el-select v-model="queryParams.fileCategory" placeholder="请选择分类" clearable style="width: 200px">
          <el-option v-for="dict in campus_file_category" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="访问范围" prop="accessScope">
        <el-select v-model="queryParams.accessScope" placeholder="请选择范围" clearable style="width: 200px">
          <el-option v-for="dict in campus_file_scope" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 工具栏 -->
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" v-hasPermi="['campus:file:add']" @click="handleAdd">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="Edit" :disabled="!single" v-hasPermi="['campus:file:edit']" @click="handleUpdate">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="!multiple" v-hasPermi="['campus:file:remove']" @click="handleDelete">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Download" v-hasPermi="['campus:file:export']" @click="handleExport">导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <!-- 数据表格 -->
    <el-table :data="dataList" v-loading="loading" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="文件标题" prop="fileName" :show-overflow-tooltip="true" />
      <el-table-column label="文件后缀" prop="fileSuffix" width="80" align="center" />
      <el-table-column label="文件大小" prop="fileSize" width="100" align="center">
        <template #default="scope">{{ formatSize(scope.row.fileSize) }}</template>
      </el-table-column>
      <el-table-column label="分类" prop="fileCategory" width="100" align="center">
        <template #default="scope">
          <dict-tag :options="campus_file_category" :value="scope.row.fileCategory" />
        </template>
      </el-table-column>
      <el-table-column label="访问范围" prop="accessScope" width="110" align="center">
        <template #default="scope">
          <dict-tag :options="campus_file_scope" :value="scope.row.accessScope" />
        </template>
      </el-table-column>
      <el-table-column label="上传者" prop="uploadUserName" width="100" align="center" />
      <el-table-column label="下载次数" prop="downloadCount" width="90" align="center" />
      <el-table-column label="上传时间" prop="createTime" width="110" align="center">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" min-width="140" align="center" fixed="right">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" v-hasPermi="['campus:file:edit']" @click="handleUpdate(scope.row)">修改</el-button>
          <el-dropdown trigger="click" @command="(cmd) => handleCommand(cmd, scope.row)">
            <el-button link type="primary">更多<el-icon><ArrowDown /></el-icon></el-button>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item command="download" icon="Download">下载</el-dropdown-item>
                <el-dropdown-item command="delete" divided icon="Delete" style="color: var(--el-color-danger)">删除</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <!-- 新增/编辑弹窗 -->
    <el-dialog :title="title" v-model="open" width="600px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
        <el-row :gutter="20">
          <el-col :span="24">
            <el-form-item label="文件标题" prop="fileName">
              <el-input v-model="form.fileName" placeholder="请输入文件标题" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="文件分类" prop="fileCategory">
              <el-select v-model="form.fileCategory" placeholder="请选择分类" style="width: 100%">
                <el-option v-for="dict in campus_file_category" :key="dict.value" :label="dict.label" :value="dict.value" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="访问范围" prop="accessScope">
              <el-select v-model="form.accessScope" placeholder="请选择范围" style="width: 100%">
                <el-option v-for="dict in campus_file_scope" :key="dict.value" :label="dict.label" :value="dict.value" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="24">
            <el-form-item label="上传文件" prop="fileUrl">
              <file-upload v-model="form.fileUrl" :limit="1" @upload-success="handleFileUploadSuccess" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="状态" prop="status">
              <el-select v-model="form.status" placeholder="请选择状态" style="width: 100%">
                <el-option label="正常" value="0" />
                <el-option label="隐藏" value="1" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" :rows="3" placeholder="请输入备注" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, getCurrentInstance, onMounted, watch } from 'vue'
import { listFile, getFile, addFile, updateFile, delFile, downloadFile } from '@/api/campus/file'

const { proxy } = getCurrentInstance()
const { campus_file_category, campus_file_scope } = proxy.useDict('campus_file_category', 'campus_file_scope')

const loading = ref(false)
const total = ref(0)
const dataList = ref([])
const showSearch = ref(true)
const open = ref(false)
const title = ref('')
const ids = ref([])
const single = ref(false)
const multiple = ref(false)

const queryParams = reactive({
  pageNum: 1, pageSize: 10,
  fileName: undefined, fileCategory: undefined, accessScope: undefined
})

const form = ref({})
const rules = {
  fileName: [{ required: true, message: '文件标题不能为空', trigger: 'blur' }],
  fileCategory: [{ required: true, message: '请选择文件分类', trigger: 'change' }],
  accessScope: [{ required: true, message: '请选择访问范围', trigger: 'change' }],
  fileUrl: [{ required: true, message: '请上传文件', trigger: 'change' }]
}

function getList() {
  loading.value = true
  listFile(queryParams).then(res => {
    dataList.value = res.rows
    total.value = res.total
  }).finally(() => { loading.value = false })
}

function handleQuery() { queryParams.pageNum = 1; getList() }
function resetQuery() { proxy.resetForm('queryRef'); handleQuery() }

function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.fileId)
  single.value = selection.length === 1
  multiple.value = selection.length > 0
}

function reset() {
  form.value = {
    fileId: undefined, fileName: undefined, originalName: undefined,
    fileUrl: undefined, filePath: undefined, fileSuffix: undefined,
    fileSize: undefined, fileCategory: '4', accessScope: '0',
    status: '0', remark: undefined
  }
  proxy.resetForm('formRef')
}

function handleAdd() { reset(); open.value = true; title.value = '新增文件' }

function handleUpdate(row) {
  reset()
  const fileId = row?.fileId || ids.value[0]
  getFile(fileId).then(res => {
    form.value = res.data
    open.value = true
    title.value = '修改文件'
  })
}

function handleFileUploadSuccess(res, uploadFile) {
  const fileUrl = res?.fileName || getPathname(res?.url)
  form.value.fileUrl = fileUrl
  form.value.filePath = normalizeFilePath(fileUrl)
  form.value.originalName = res?.originalFilename || uploadFile?.name || undefined
  form.value.fileSuffix = extractSuffix(res?.newFileName || res?.originalFilename || uploadFile?.name)
  form.value.fileSize = uploadFile?.size || form.value.fileSize
}

function submitForm() {
  proxy.$refs['formRef'].validate(valid => {
    if (!valid) return
    if (form.value.fileId) {
      updateFile(form.value).then(() => {
        proxy.$modal.msgSuccess('修改成功')
        open.value = false
        getList()
      })
    } else {
      addFile(form.value).then(() => {
        proxy.$modal.msgSuccess('新增成功')
        open.value = false
        getList()
      })
    }
  })
}

function handleDelete(row) {
  const delIds = row?.fileId ? [row.fileId] : ids.value
  proxy.$modal.confirm('确认删除所选文件？').then(() => delFile(delIds)).then(() => {
    getList()
    proxy.$modal.msgSuccess('删除成功')
  }).catch(() => {})
}

function handleDownload(row) {
  downloadFile(row.fileId).then(() => {
    if (row.fileUrl) {
      window.open(import.meta.env.VITE_APP_BASE_API + row.fileUrl, '_blank')
    }
    getList()
  })
}

function handleExport() {
  proxy.download('campus/file/export', { ...queryParams }, '文件数据.xlsx')
}

function handleCommand(command, row) {
  const actions = { download: handleDownload, delete: handleDelete }
  actions[command]?.(row)
}

function formatSize(bytes) {
  if (!bytes || bytes === 0) return '0 B'
  const units = ['B', 'KB', 'MB', 'GB']
  const i = Math.floor(Math.log(bytes) / Math.log(1024))
  return (bytes / Math.pow(1024, i)).toFixed(1) + ' ' + units[i]
}

function getPathname(url) {
  if (!url) return undefined
  if (url.startsWith('/')) return url
  try {
    return new URL(url).pathname
  } catch {
    return url
  }
}

function normalizeFilePath(fileUrl) {
  const pathname = getPathname(fileUrl)
  if (!pathname) return undefined
  return pathname.startsWith('/profile/') ? pathname.replace('/profile', '') : pathname
}

function extractSuffix(fileName) {
  if (!fileName || !fileName.includes('.')) return undefined
  return fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase()
}

function cancel() { open.value = false; reset() }

watch(() => form.value.fileUrl, value => {
  if (value) {
    return
  }
  form.value.originalName = undefined
  form.value.filePath = undefined
  form.value.fileSuffix = undefined
  form.value.fileSize = undefined
})

onMounted(() => { getList() })
</script>
