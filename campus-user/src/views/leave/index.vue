<template>
  <div class="leave-page">
    <div class="page-header">
      <div>
        <h2 class="page-title">请假申请</h2>
        <p class="page-desc">提交和查看请假申请</p>
      </div>
      <el-button type="primary" icon="Plus" @click="handleAdd">新建请假</el-button>
    </div>

    <div class="filter-bar">
      <el-select v-model="queryParams.leaveStatus" placeholder="审批状态" clearable style="width: 140px" @change="handleQuery">
        <el-option label="待审批" value="0" />
        <el-option label="已批准" value="1" />
        <el-option label="已驳回" value="2" />
        <el-option label="已撤回" value="3" />
      </el-select>
      <el-select v-model="queryParams.leaveType" placeholder="请假类型" clearable style="width: 140px" @change="handleQuery">
        <el-option label="事假" value="1" />
        <el-option label="病假" value="2" />
        <el-option label="其他" value="3" />
      </el-select>
      <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
      <el-button icon="Refresh" @click="resetQuery">重置</el-button>
    </div>

    <div v-loading="loading" class="leave-list">
      <div v-if="leaveList.length === 0 && !loading" class="empty-state">
        <el-icon :size="48" class="empty-icon"><DocumentChecked /></el-icon>
        <p class="empty-text">暂无请假记录</p>
        <el-button type="primary" plain @click="handleAdd">提交请假申请</el-button>
      </div>
      <div v-for="item in leaveList" :key="item.leaveId" class="leave-card">
        <div class="leave-card-header">
          <el-tag :type="getStatusType(item.leaveStatus)" size="small">{{ getStatusLabel(item.leaveStatus) }}</el-tag>
          <el-tag type="info" size="small">{{ getTypeLabel(item.leaveType) }}</el-tag>
          <span class="leave-days">{{ item.leaveDays }}天</span>
        </div>
        <h4 class="leave-title">{{ item.leaveTitle }}</h4>
        <p class="leave-reason">{{ item.leaveReason }}</p>
        <div class="leave-time">
          <span>{{ formatDate(item.startTime) }} ~ {{ formatDate(item.endTime) }}</span>
        </div>
        <div class="leave-footer">
          <span v-if="item.approverUserName" class="leave-approver">审批教师：{{ item.approverUserName }}</span>
          <span v-if="item.auditRemark" class="leave-audit">审批意见：{{ item.auditRemark }}</span>
          <el-button v-if="item.leaveStatus === '0'" type="warning" plain size="small" @click="handleRevoke(item)">撤回</el-button>
        </div>
      </div>
    </div>

    <div v-if="total > 0" class="pagination-wrap">
      <el-pagination background layout="total, prev, pager, next" :total="total" :page-size="queryParams.pageSize" v-model:current-page="queryParams.pageNum" @current-change="getList" />
    </div>

    <!-- 新建请假弹窗 -->
    <el-dialog title="新建请假申请" v-model="dialogVisible" width="560px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="请假标题" prop="leaveTitle">
          <el-input v-model="form.leaveTitle" placeholder="请输入请假标题" maxlength="120" />
        </el-form-item>
        <el-form-item label="请假类型" prop="leaveType">
          <el-select v-model="form.leaveType" placeholder="请选择类型" style="width: 100%">
            <el-option label="事假" value="1" />
            <el-option label="病假" value="2" />
            <el-option label="其他" value="3" />
          </el-select>
        </el-form-item>
        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="开始时间" prop="startTime">
              <el-date-picker v-model="form.startTime" type="datetime" placeholder="选择开始时间" value-format="YYYY-MM-DD HH:mm:ss" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="结束时间" prop="endTime">
              <el-date-picker v-model="form.endTime" type="datetime" placeholder="选择结束时间" value-format="YYYY-MM-DD HH:mm:ss" style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="请假天数" prop="leaveDays">
              <el-input-number v-model="form.leaveDays" :min="0.5" :max="30" :step="0.5" :precision="1" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系电话" prop="contactPhone">
              <el-input v-model="form.contactPhone" placeholder="请输入联系电话" maxlength="11" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="请假原因" prop="leaveReason">
          <el-input v-model="form.leaveReason" type="textarea" :rows="4" placeholder="请输入请假原因" maxlength="500" show-word-limit />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" :loading="submitLoading" @click="submitForm">提交申请</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { DocumentChecked } from '@element-plus/icons-vue'
import { listMyLeave, addLeave, revokeLeave } from '@/api/leave'

const loading = ref(false)
const total = ref(0)
const leaveList = ref([])
const dialogVisible = ref(false)
const submitLoading = ref(false)
const formRef = ref(null)

const queryParams = reactive({ pageNum: 1, pageSize: 10, leaveStatus: undefined, leaveType: undefined })

const form = ref({})
const rules = {
  leaveTitle: [{ required: true, message: '请输入请假标题', trigger: 'blur' }],
  leaveType: [{ required: true, message: '请选择请假类型', trigger: 'change' }],
  leaveReason: [{ required: true, message: '请输入请假原因', trigger: 'blur' }],
  startTime: [{ required: true, message: '请选择开始时间', trigger: 'change' }],
  endTime: [{ required: true, message: '请选择结束时间', trigger: 'change' }],
  leaveDays: [{ required: true, message: '请输入请假天数', trigger: 'blur' }]
}

const statusMap = { '0': '待审批', '1': '已批准', '2': '已驳回', '3': '已撤回' }
const statusTypeMap = { '0': 'warning', '1': 'success', '2': 'danger', '3': 'info' }
const typeMap = { '1': '事假', '2': '病假', '3': '其他' }

function getStatusLabel(s) { return statusMap[s] || '未知' }
function getStatusType(s) { return statusTypeMap[s] || 'info' }
function getTypeLabel(t) { return typeMap[t] || '其他' }
function formatDate(d) { return d ? d.substring(0, 10) : '-' }

function getList() {
  loading.value = true
  listMyLeave(queryParams).then(res => {
    leaveList.value = res.rows || []
    total.value = res.total || 0
  }).finally(() => { loading.value = false })
}

function handleQuery() { queryParams.pageNum = 1; getList() }
function resetQuery() { queryParams.leaveStatus = undefined; queryParams.leaveType = undefined; handleQuery() }

function handleAdd() {
  form.value = { leaveTitle: undefined, leaveType: undefined, leaveReason: undefined, startTime: undefined, endTime: undefined, leaveDays: 1.0, contactPhone: undefined }
  dialogVisible.value = true
}

function submitForm() {
  formRef.value.validate(valid => {
    if (!valid) return
    submitLoading.value = true
    addLeave(form.value).then(() => {
      ElMessage.success('请假申请提交成功')
      dialogVisible.value = false
      getList()
    }).finally(() => { submitLoading.value = false })
  })
}

function handleRevoke(item) {
  ElMessageBox.confirm('确定撤回该请假申请吗？', '提示', { type: 'warning' }).then(() => {
    revokeLeave(item.leaveId).then(() => {
      ElMessage.success('撤回成功')
      getList()
    })
  }).catch(() => {})
}

onMounted(() => { getList() })
</script>

<style scoped>
.leave-page { padding-bottom: var(--space-xl); }
.page-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: var(--space-lg); }
.page-title { font-family: var(--font-heading); font-size: 22px; color: var(--text-primary); margin-bottom: 4px; }
.page-desc { font-size: 14px; color: var(--text-secondary); margin: 0; }

.filter-bar {
  display: flex; align-items: center; gap: var(--space-sm); flex-wrap: wrap;
  margin-bottom: var(--space-lg); padding: var(--space-md);
  background: var(--bg-card); border-radius: var(--radius-lg); box-shadow: var(--shadow-sm);
}

.leave-list { display: flex; flex-direction: column; gap: var(--space-sm); min-height: 200px; }

.empty-state { text-align: center; padding: var(--space-3xl) 0; }
.empty-icon { color: var(--text-placeholder); margin-bottom: var(--space-sm); }
.empty-text { font-size: 16px; color: var(--text-secondary); margin-bottom: var(--space-md); }

.leave-card {
  background: var(--bg-card); border-radius: var(--radius-lg); padding: var(--space-lg);
  box-shadow: var(--shadow-sm); transition: all 200ms ease;
}

.leave-card:hover { box-shadow: var(--shadow-md); }

.leave-card-header { display: flex; align-items: center; gap: var(--space-sm); margin-bottom: var(--space-sm); }
.leave-days { font-size: 13px; font-weight: 600; color: var(--color-primary); }
.leave-title { font-size: 16px; font-weight: 600; color: var(--text-primary); margin-bottom: 4px; }
.leave-reason { font-size: 14px; color: var(--text-regular); line-height: 1.5; margin-bottom: var(--space-sm); display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
.leave-time { font-size: 13px; color: var(--text-secondary); margin-bottom: var(--space-sm); }
.leave-footer { display: flex; align-items: center; gap: var(--space-md); flex-wrap: wrap; }
.leave-approver, .leave-audit { font-size: 13px; color: var(--text-secondary); }

.pagination-wrap { display: flex; justify-content: center; margin-top: var(--space-xl); }

@media (prefers-reduced-motion: reduce) { .leave-card { transition: none; } }
</style>
