<template>
  <div class="app-container">
    <!-- 搜索表单 -->
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="请假标题" prop="leaveTitle">
        <el-input v-model="queryParams.leaveTitle" placeholder="请输入请假标题" clearable style="width: 200px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="请假类型" prop="leaveType">
        <el-select v-model="queryParams.leaveType" placeholder="请选择类型" clearable style="width: 200px">
          <el-option v-for="dict in campus_leave_type" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="审批状态" prop="leaveStatus">
        <el-select v-model="queryParams.leaveStatus" placeholder="请选择状态" clearable style="width: 200px">
          <el-option v-for="dict in campus_leave_status" :key="dict.value" :label="dict.label" :value="dict.value" />
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
        <el-button type="primary" plain icon="Plus" v-hasPermi="['campus:leave:add']" @click="handleAdd">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="Edit" :disabled="!single" v-hasPermi="['campus:leave:edit']" @click="handleUpdate">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="!multiple" v-hasPermi="['campus:leave:remove']" @click="handleDelete">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Download" v-hasPermi="['campus:leave:export']" @click="handleExport">导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <!-- 数据表格 -->
    <el-table :data="dataList" v-loading="loading" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="申请人" prop="applicantUserName" width="90" align="center" />
      <el-table-column label="请假标题" prop="leaveTitle" :show-overflow-tooltip="true" />
      <el-table-column label="类型" prop="leaveType" width="70" align="center">
        <template #default="scope">
          <dict-tag :options="campus_leave_type" :value="scope.row.leaveType" />
        </template>
      </el-table-column>
      <el-table-column label="开始时间" prop="startTime" width="110" align="center">
        <template #default="scope">{{ parseTime(scope.row.startTime, '{y}-{m}-{d}') }}</template>
      </el-table-column>
      <el-table-column label="结束时间" prop="endTime" width="110" align="center">
        <template #default="scope">{{ parseTime(scope.row.endTime, '{y}-{m}-{d}') }}</template>
      </el-table-column>
      <el-table-column label="天数" prop="leaveDays" width="60" align="center" />
      <el-table-column label="状态" prop="leaveStatus" width="80" align="center">
        <template #default="scope">
          <dict-tag :options="campus_leave_status" :value="scope.row.leaveStatus" />
        </template>
      </el-table-column>
      <el-table-column label="审批教师" prop="approverUserName" width="90" align="center" />
      <el-table-column label="操作" min-width="140" align="center" fixed="right">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleDetail(scope.row)">详情</el-button>
          <el-dropdown v-if="scope.row.leaveStatus === '0'" trigger="click" @command="(cmd) => handleCommand(cmd, scope.row)">
            <el-button link type="primary">更多<el-icon><ArrowDown /></el-icon></el-button>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item command="approve" v-hasPermi="['campus:leave:audit']" icon="Check">审批</el-dropdown-item>
                <el-dropdown-item command="edit" v-hasPermi="['campus:leave:edit']" icon="Edit">修改</el-dropdown-item>
                <el-dropdown-item command="delete" divided v-hasPermi="['campus:leave:remove']" icon="Delete" style="color: var(--el-color-danger)">删除</el-dropdown-item>
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
            <el-form-item label="请假标题" prop="leaveTitle">
              <el-input v-model="form.leaveTitle" placeholder="请输入请假标题" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="请假类型" prop="leaveType">
              <el-select v-model="form.leaveType" placeholder="请选择类型" style="width: 100%">
                <el-option v-for="dict in campus_leave_type" :key="dict.value" :label="dict.label" :value="dict.value" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="请假天数" prop="leaveDays">
              <el-input-number v-model="form.leaveDays" :min="0.5" :max="30" :step="0.5" :precision="1" style="width: 100%" />
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
            <el-form-item label="结束时间" prop="endTime">
              <el-date-picker v-model="form.endTime" type="datetime" placeholder="选择结束时间" value-format="YYYY-MM-DD HH:mm:ss" style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="联系电话" prop="contactPhone">
              <el-input v-model="form.contactPhone" placeholder="请输入联系电话" maxlength="11" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="24">
            <el-form-item label="请假原因" prop="leaveReason">
              <el-input v-model="form.leaveReason" type="textarea" :rows="4" placeholder="请输入请假原因" />
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
    <el-dialog title="请假详情" v-model="detailOpen" width="600px" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="申请人">{{ detailData.applicantUserName }}</el-descriptions-item>
        <el-descriptions-item label="所属部门">{{ detailData.applicantDeptName }}</el-descriptions-item>
        <el-descriptions-item label="请假标题" :span="2">{{ detailData.leaveTitle }}</el-descriptions-item>
        <el-descriptions-item label="请假类型">
          <dict-tag :options="campus_leave_type" :value="detailData.leaveType" />
        </el-descriptions-item>
        <el-descriptions-item label="审批状态">
          <dict-tag :options="campus_leave_status" :value="detailData.leaveStatus" />
        </el-descriptions-item>
        <el-descriptions-item label="开始时间">{{ parseTime(detailData.startTime) }}</el-descriptions-item>
        <el-descriptions-item label="结束时间">{{ parseTime(detailData.endTime) }}</el-descriptions-item>
        <el-descriptions-item label="请假天数">{{ detailData.leaveDays }}</el-descriptions-item>
        <el-descriptions-item label="联系电话">{{ detailData.contactPhone }}</el-descriptions-item>
        <el-descriptions-item label="请假原因" :span="2">{{ detailData.leaveReason }}</el-descriptions-item>
        <el-descriptions-item label="审批教师">{{ detailData.approverUserName }}</el-descriptions-item>
        <el-descriptions-item label="审批时间">{{ parseTime(detailData.auditTime) }}</el-descriptions-item>
        <el-descriptions-item label="审批意见" :span="2">{{ detailData.auditRemark }}</el-descriptions-item>
      </el-descriptions>
    </el-dialog>

    <!-- 审批弹窗 -->
    <el-dialog title="请假审批" v-model="approveOpen" width="500px" append-to-body>
      <el-form ref="approveRef" :model="approveForm" :rules="approveRules" label-width="100px">
        <el-form-item label="申请人">{{ approveForm.applicantUserName }}</el-form-item>
        <el-form-item label="请假标题">{{ approveForm.leaveTitle }}</el-form-item>
        <el-form-item label="审批结果" prop="leaveStatus">
          <el-radio-group v-model="approveForm.leaveStatus">
            <el-radio value="1">批准</el-radio>
            <el-radio value="2">驳回</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="审批意见" prop="auditRemark">
          <el-input v-model="approveForm.auditRemark" type="textarea" :rows="3" placeholder="请输入审批意见" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button type="primary" @click="submitApprove">确 定</el-button>
        <el-button @click="approveOpen = false">取 消</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, getCurrentInstance, onMounted } from 'vue'
import { listLeave, getLeave, addLeave, updateLeave, delLeave, approveLeave } from '@/api/campus/leave'

const { proxy } = getCurrentInstance()
const { campus_leave_type, campus_leave_status } = proxy.useDict('campus_leave_type', 'campus_leave_status')

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
  leaveTitle: undefined, leaveType: undefined, leaveStatus: undefined
})

const form = ref({})
const rules = {
  leaveTitle: [{ required: true, message: '请假标题不能为空', trigger: 'blur' }],
  leaveType: [{ required: true, message: '请选择请假类型', trigger: 'change' }],
  leaveReason: [{ required: true, message: '请假原因不能为空', trigger: 'blur' }],
  startTime: [{ required: true, message: '请选择开始时间', trigger: 'change' }],
  endTime: [{ required: true, message: '请选择结束时间', trigger: 'change' }],
  leaveDays: [{ required: true, message: '请假天数不能为空', trigger: 'blur' }]
}

/* 详情 */
const detailOpen = ref(false)
const detailData = ref({})

/* 审批 */
const approveOpen = ref(false)
const approveForm = ref({})
const approveRules = {
  leaveStatus: [{ required: true, message: '请选择审批结果', trigger: 'change' }],
  auditRemark: [{ required: true, message: '请输入审批意见', trigger: 'blur' }]
}

function getList() {
  loading.value = true
  listLeave(queryParams).then(res => {
    dataList.value = res.rows
    total.value = res.total
  }).finally(() => { loading.value = false })
}

function handleQuery() { queryParams.pageNum = 1; getList() }
function resetQuery() { proxy.resetForm('queryRef'); handleQuery() }

function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.leaveId)
  single.value = selection.length === 1
  multiple.value = selection.length > 0
}

function reset() {
  form.value = {
    leaveId: undefined, leaveType: undefined, leaveTitle: undefined,
    leaveReason: undefined, startTime: undefined, endTime: undefined,
    leaveDays: 1.0, contactPhone: undefined, remark: undefined
  }
  proxy.resetForm('formRef')
}

function handleAdd() { reset(); open.value = true; title.value = '新增请假' }

function handleUpdate(row) {
  reset()
  const leaveId = row?.leaveId || ids.value[0]
  getLeave(leaveId).then(res => {
    form.value = res.data
    open.value = true
    title.value = '修改请假'
  })
}

function submitForm() {
  proxy.$refs['formRef'].validate(valid => {
    if (!valid) return
    if (form.value.leaveId) {
      updateLeave(form.value).then(() => {
        proxy.$modal.msgSuccess('修改成功')
        open.value = false
        getList()
      })
    } else {
      addLeave(form.value).then(() => {
        proxy.$modal.msgSuccess('新增成功')
        open.value = false
        getList()
      })
    }
  })
}

function handleDelete(row) {
  const delIds = row?.leaveId ? [row.leaveId] : ids.value
  proxy.$modal.confirm('确认删除所选记录？').then(() => delLeave(delIds)).then(() => {
    getList()
    proxy.$modal.msgSuccess('删除成功')
  }).catch(() => {})
}

function handleDetail(row) {
  getLeave(row.leaveId).then(res => {
    detailData.value = res.data
    detailOpen.value = true
  })
}

function handleApprove(row) {
  getLeave(row.leaveId).then(res => {
    approveForm.value = {
      leaveId: res.data.leaveId,
      applicantUserName: res.data.applicantUserName,
      leaveTitle: res.data.leaveTitle,
      leaveStatus: undefined,
      auditRemark: undefined
    }
    approveOpen.value = true
  })
}

function submitApprove() {
  proxy.$refs['approveRef'].validate(valid => {
    if (!valid) return
    approveLeave(approveForm.value).then(() => {
      proxy.$modal.msgSuccess('审批成功')
      approveOpen.value = false
      getList()
    })
  })
}

function handleExport() {
  proxy.download('campus/leave/export', { ...queryParams }, '请假数据.xlsx')
}

function handleCommand(command, row) {
  const actions = { approve: handleApprove, edit: handleUpdate, delete: handleDelete }
  actions[command]?.(row)
}

function cancel() { open.value = false; reset() }

onMounted(() => { getList() })
</script>
