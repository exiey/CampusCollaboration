<template>
  <div class="app-container">
    <!-- 搜索表单 -->
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="任务标题" prop="taskTitle">
        <el-input v-model="queryParams.taskTitle" placeholder="请输入任务标题" clearable style="width: 200px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="任务状态" prop="taskStatus">
        <el-select v-model="queryParams.taskStatus" placeholder="请选择状态" clearable style="width: 200px">
          <el-option v-for="dict in campus_task_status" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="优先级" prop="priority">
        <el-select v-model="queryParams.priority" placeholder="请选择优先级" clearable style="width: 200px">
          <el-option v-for="dict in campus_task_priority" :key="dict.value" :label="dict.label" :value="dict.value" />
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
        <el-button type="primary" plain icon="Plus" v-hasPermi="['campus:task:add']" @click="handleAdd">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="Edit" :disabled="!single" v-hasPermi="['campus:task:edit']" @click="handleUpdate">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="!multiple" v-hasPermi="['campus:task:remove']" @click="handleDelete">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Download" v-hasPermi="['campus:task:export']" @click="handleExport">导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <!-- 数据表格 -->
    <el-table :data="dataList" v-loading="loading" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="任务标题" prop="taskTitle" :show-overflow-tooltip="true" />
      <el-table-column label="发布教师" prop="publishUserName" width="100" align="center" />
      <el-table-column label="接收学生" prop="receiveUserName" width="100" align="center" />
      <el-table-column label="优先级" prop="priority" width="80" align="center">
        <template #default="scope">
          <dict-tag :options="campus_task_priority" :value="scope.row.priority" />
        </template>
      </el-table-column>
      <el-table-column label="状态" prop="taskStatus" width="80" align="center">
        <template #default="scope">
          <dict-tag :options="campus_task_status" :value="scope.row.taskStatus" />
        </template>
      </el-table-column>
      <el-table-column label="进度" prop="progressPercent" width="80" align="center">
        <template #default="scope">{{ scope.row.progressPercent }}%</template>
      </el-table-column>
      <el-table-column label="截止时间" prop="deadlineTime" width="110" align="center">
        <template #default="scope">
          <span>{{ parseTime(scope.row.deadlineTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" min-width="140" align="center" fixed="right">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" v-hasPermi="['campus:task:edit']" @click="handleUpdate(scope.row)">修改</el-button>
          <el-dropdown trigger="click" @command="(cmd) => handleCommand(cmd, scope.row)">
            <el-button link type="primary">更多<el-icon><ArrowDown /></el-icon></el-button>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item command="detail" icon="View">详情</el-dropdown-item>
                <el-dropdown-item command="comment" icon="ChatDotRound">评论</el-dropdown-item>
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
    <el-dialog :title="title" v-model="open" width="700px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
        <el-row :gutter="20">
          <el-col :span="24">
            <el-form-item label="任务标题" prop="taskTitle">
              <el-input v-model="form.taskTitle" placeholder="请输入任务标题" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="24">
            <el-form-item label="任务内容" prop="taskContent">
              <el-input v-model="form.taskContent" type="textarea" :rows="4" placeholder="请输入任务内容" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="接收学生" prop="receiveUserId">
              <el-select v-model="form.receiveUserId" placeholder="请选择接收学生" filterable style="width: 100%">
                <el-option v-for="u in studentOptions" :key="u.userId" :label="u.nickName" :value="u.userId" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="优先级" prop="priority">
              <el-select v-model="form.priority" placeholder="请选择优先级" style="width: 100%">
                <el-option v-for="dict in campus_task_priority" :key="dict.value" :label="dict.label" :value="dict.value" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="开始时间" prop="startTime">
              <el-date-picker v-model="form.startTime" type="datetime" placeholder="选择开始时间" value-format="YYYY-MM-DD HH:mm:ss" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="截止时间" prop="deadlineTime">
              <el-date-picker v-model="form.deadlineTime" type="datetime" placeholder="选择截止时间" value-format="YYYY-MM-DD HH:mm:ss" style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="任务状态" prop="taskStatus">
              <el-select v-model="form.taskStatus" placeholder="请选择状态" style="width: 100%">
                <el-option v-for="dict in campus_task_status" :key="dict.value" :label="dict.label" :value="dict.value" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="进度" prop="progressPercent">
              <el-input-number v-model="form.progressPercent" :min="0" :max="100" :step="10" style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="24">
            <el-form-item label="附件" prop="attachmentUrl">
              <file-upload v-model="form.attachmentUrl" :limit="1" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" :rows="2" placeholder="请输入备注" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </template>
    </el-dialog>

    <!-- 详情弹窗 -->
    <el-dialog title="任务详情" v-model="detailOpen" width="700px" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="任务标题" :span="2">{{ detailData.taskTitle }}</el-descriptions-item>
        <el-descriptions-item label="发布教师">{{ detailData.publishUserName }}</el-descriptions-item>
        <el-descriptions-item label="接收学生">{{ detailData.receiveUserName }}</el-descriptions-item>
        <el-descriptions-item label="优先级">
          <dict-tag :options="campus_task_priority" :value="detailData.priority" />
        </el-descriptions-item>
        <el-descriptions-item label="状态">
          <dict-tag :options="campus_task_status" :value="detailData.taskStatus" />
        </el-descriptions-item>
        <el-descriptions-item label="进度">{{ detailData.progressPercent }}%</el-descriptions-item>
        <el-descriptions-item label="评论数">{{ detailData.commentCount }}</el-descriptions-item>
        <el-descriptions-item label="开始时间">{{ parseTime(detailData.startTime) }}</el-descriptions-item>
        <el-descriptions-item label="截止时间">{{ parseTime(detailData.deadlineTime) }}</el-descriptions-item>
        <el-descriptions-item label="完成时间">{{ parseTime(detailData.finishTime) }}</el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ parseTime(detailData.createTime) }}</el-descriptions-item>
        <el-descriptions-item label="任务内容" :span="2">{{ detailData.taskContent }}</el-descriptions-item>
        <el-descriptions-item label="备注" :span="2">{{ detailData.remark }}</el-descriptions-item>
      </el-descriptions>
    </el-dialog>

    <!-- 评论弹窗 -->
    <el-dialog title="任务评论" v-model="commentOpen" width="600px" append-to-body>
      <div class="comment-list" v-loading="commentLoading">
        <div v-if="commentList.length === 0" class="comment-empty">暂无评论</div>
        <div v-for="item in commentList" :key="item.commentId" class="comment-item">
          <div class="comment-header">
            <span class="comment-user">{{ item.commentUserName }}</span>
            <span class="comment-time">{{ parseTime(item.createTime) }}</span>
          </div>
          <div class="comment-content">{{ item.commentContent }}</div>
        </div>
      </div>
      <el-divider />
      <el-form :inline="false">
        <el-form-item>
          <el-input v-model="commentContent" type="textarea" :rows="3" placeholder="请输入评论内容" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitComment">发表评论</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, getCurrentInstance, onMounted } from 'vue'
import { listTask, getTask, addTask, updateTask, delTask, listTaskComment, addTaskComment } from '@/api/campus/task'
import { listUser } from '@/api/system/user'

const { proxy } = getCurrentInstance()
const { campus_task_status, campus_task_priority } = proxy.useDict('campus_task_status', 'campus_task_priority')

const loading = ref(false)
const total = ref(0)
const dataList = ref([])
const showSearch = ref(true)
const open = ref(false)
const title = ref('')
const ids = ref([])
const single = ref(false)
const multiple = ref(false)
const studentOptions = ref([])

const queryParams = reactive({
  pageNum: 1, pageSize: 10,
  taskTitle: undefined, taskStatus: undefined, priority: undefined
})

const form = ref({})
const rules = {
  taskTitle: [{ required: true, message: '任务标题不能为空', trigger: 'blur' }],
  receiveUserId: [{ required: true, message: '请选择接收学生', trigger: 'change' }],
  priority: [{ required: true, message: '请选择优先级', trigger: 'change' }]
}

/* 详情 */
const detailOpen = ref(false)
const detailData = ref({})

/* 评论 */
const commentOpen = ref(false)
const commentLoading = ref(false)
const commentList = ref([])
const commentContent = ref('')
const currentTaskId = ref(null)

function getList() {
  loading.value = true
  listTask(queryParams).then(res => {
    dataList.value = res.rows
    total.value = res.total
  }).finally(() => { loading.value = false })
}

function handleQuery() { queryParams.pageNum = 1; getList() }
function resetQuery() { proxy.resetForm('queryRef'); handleQuery() }

function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.taskId)
  single.value = selection.length === 1
  multiple.value = selection.length > 0
}

function reset() {
  form.value = {
    taskId: undefined, taskTitle: undefined, taskContent: undefined,
    receiveUserId: undefined, priority: '1', taskStatus: '0',
    progressPercent: 0, startTime: undefined, deadlineTime: undefined,
    attachmentName: undefined, attachmentUrl: undefined, remark: undefined
  }
  proxy.resetForm('formRef')
}

function handleAdd() {
  reset()
  loadStudents()
  open.value = true
  title.value = '新增任务'
}

function handleUpdate(row) {
  reset()
  loadStudents()
  const taskId = row?.taskId || ids.value[0]
  getTask(taskId).then(res => {
    form.value = res.data
    open.value = true
    title.value = '修改任务'
  })
}

function submitForm() {
  proxy.$refs['formRef'].validate(valid => {
    if (!valid) return
    if (form.value.taskId) {
      updateTask(form.value).then(() => {
        proxy.$modal.msgSuccess('修改成功')
        open.value = false
        getList()
      })
    } else {
      addTask(form.value).then(() => {
        proxy.$modal.msgSuccess('新增成功')
        open.value = false
        getList()
      })
    }
  })
}

function handleDelete(row) {
  const delIds = row?.taskId ? [row.taskId] : ids.value
  proxy.$modal.confirm('确认删除所选任务？').then(() => delTask(delIds)).then(() => {
    getList()
    proxy.$modal.msgSuccess('删除成功')
  }).catch(() => {})
}

function handleExport() {
  proxy.download('campus/task/export', { ...queryParams }, '任务数据.xlsx')
}

function handleCommand(command, row) {
  const actions = { detail: handleDetail, comment: handleComment, delete: handleDelete }
  actions[command]?.(row)
}

function handleDetail(row) {
  getTask(row.taskId).then(res => {
    detailData.value = res.data
    detailOpen.value = true
  })
}

function handleComment(row) {
  currentTaskId.value = row.taskId
  commentContent.value = ''
  commentOpen.value = true
  loadComments()
}

function loadComments() {
  commentLoading.value = true
  listTaskComment(currentTaskId.value).then(res => {
    commentList.value = res.data || []
  }).finally(() => { commentLoading.value = false })
}

function submitComment() {
  if (!commentContent.value.trim()) {
    proxy.$modal.msgWarning('请输入评论内容')
    return
  }
  addTaskComment({ taskId: currentTaskId.value, commentContent: commentContent.value }).then(() => {
    proxy.$modal.msgSuccess('评论成功')
    commentContent.value = ''
    loadComments()
    getList()
  })
}

function loadStudents() {
  listUser({ roleId: 2, pageNum: 1, pageSize: 500 }).then(res => {
    studentOptions.value = res.rows || []
  })
}

function cancel() { open.value = false; reset() }

onMounted(() => { getList() })
</script>

<style lang="scss" scoped>
.comment-list {
  max-height: 360px;
  overflow-y: auto;
}

.comment-empty {
  text-align: center;
  color: var(--text-secondary, #86909C);
  padding: 24px 0;
}

.comment-item {
  padding: 12px 0;
  border-bottom: 1px solid var(--border-color-light, #F2F3F5);

  &:last-child { border-bottom: none; }
}

.comment-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 6px;
}

.comment-user {
  font-weight: 600;
  font-size: 14px;
  color: var(--text-primary, #1E3A8A);
}

.comment-time {
  font-size: 12px;
  color: var(--text-secondary, #86909C);
}

.comment-content {
  font-size: 14px;
  color: var(--text-regular, #4E5969);
  line-height: 1.6;
}
</style>
