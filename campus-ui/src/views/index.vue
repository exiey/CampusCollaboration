<template>
  <div class="app-container home">
    <!-- 管理员仪表盘 -->
    <template v-if="isAdmin">
      <!-- 统计卡片 -->
      <el-row :gutter="16" class="stat-row">
        <el-col :xs="12" :sm="12" :md="6" v-for="(card, i) in adminCards" :key="i">
          <div class="stat-card" :class="card.color">
            <div class="stat-header">
              <span class="stat-label">{{ card.label }}</span>
              <el-icon :size="20" class="stat-icon"><component :is="card.icon" /></el-icon>
            </div>
            <div class="stat-value">{{ card.value }}</div>
            <div class="stat-footer">
              <span class="stat-trend" :class="card.trendDir">{{ card.trend }}</span>
              <span class="stat-desc">{{ card.desc }}</span>
            </div>
          </div>
        </el-col>
      </el-row>

      <!-- 图表区 -->
      <el-row :gutter="16" class="chart-row">
        <el-col :xs="24" :md="12">
          <el-card shadow="never" class="chart-card">
            <template #header><span class="card-title">任务状态分布</span></template>
            <div ref="taskPieRef" class="chart-box"></div>
          </el-card>
        </el-col>
        <el-col :xs="24" :md="12">
          <el-card shadow="never" class="chart-card">
            <template #header><span class="card-title">近7天任务趋势</span></template>
            <div ref="taskTrendRef" class="chart-box"></div>
          </el-card>
        </el-col>
      </el-row>
      <el-row :gutter="16" class="chart-row">
        <el-col :xs="24" :md="8">
          <el-card shadow="never" class="chart-card">
            <template #header><span class="card-title">用户角色占比</span></template>
            <div ref="rolePieRef" class="chart-box"></div>
          </el-card>
        </el-col>
        <el-col :xs="24" :md="16">
          <el-card shadow="never" class="chart-card">
            <template #header><span class="card-title">请假审批统计</span></template>
            <div ref="leaveBarRef" class="chart-box"></div>
          </el-card>
        </el-col>
      </el-row>

      <!-- 数据区 -->
      <el-row :gutter="16" class="data-row">
        <el-col :xs="24" :md="12">
          <el-card shadow="never" class="data-card">
            <template #header><span class="card-title">最新任务动态</span></template>
            <el-table :data="adminData.recentTasks" size="small" :show-header="true" max-height="320">
              <el-table-column label="任务标题" prop="taskTitle" :show-overflow-tooltip="true" />
              <el-table-column label="发布教师" prop="publishUserName" width="90" align="center" />
              <el-table-column label="状态" prop="taskStatus" width="80" align="center">
                <template #default="{ row }">
                  <dict-tag :options="campus_task_status" :value="row.taskStatus" />
                </template>
              </el-table-column>
              <el-table-column label="截止时间" prop="deadlineTime" width="110" align="center">
                <template #default="{ row }">{{ parseTime(row.deadlineTime, '{y}-{m}-{d}') }}</template>
              </el-table-column>
            </el-table>
          </el-card>
        </el-col>
        <el-col :xs="24" :md="12">
          <el-card shadow="never" class="data-card">
            <template #header><span class="card-title">最新请假申请</span></template>
            <el-table :data="adminData.recentLeaves" size="small" :show-header="true" max-height="320">
              <el-table-column label="申请人" prop="applicantUserName" width="90" align="center" />
              <el-table-column label="请假标题" prop="leaveTitle" :show-overflow-tooltip="true" />
              <el-table-column label="类型" prop="leaveType" width="70" align="center">
                <template #default="{ row }">
                  <dict-tag :options="campus_leave_type" :value="row.leaveType" />
                </template>
              </el-table-column>
              <el-table-column label="状态" prop="leaveStatus" width="80" align="center">
                <template #default="{ row }">
                  <dict-tag :options="campus_leave_status" :value="row.leaveStatus" />
                </template>
              </el-table-column>
            </el-table>
          </el-card>
        </el-col>
      </el-row>

      <!-- 快捷操作 -->
      <el-row :gutter="16" class="quick-row">
        <el-col :span="24">
          <el-card shadow="never" class="quick-card">
            <template #header><span class="card-title">快捷操作</span></template>
            <div class="quick-actions">
              <el-button type="primary" plain icon="User" @click="$router.push('/system/user')">用户管理</el-button>
              <el-button type="primary" plain icon="Bell" @click="$router.push('/system/notice')">通知公告</el-button>
              <el-button type="primary" plain icon="Setting" @click="$router.push('/system/config')">参数设置</el-button>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </template>

    <!-- 教师仪表盘 -->
    <template v-else>
      <!-- 统计卡片 -->
      <el-row :gutter="16" class="stat-row">
        <el-col :xs="24" :sm="8" v-for="(card, i) in teacherCards" :key="i">
          <div class="stat-card" :class="card.color">
            <div class="stat-header">
              <span class="stat-label">{{ card.label }}</span>
              <el-icon :size="20" class="stat-icon"><component :is="card.icon" /></el-icon>
            </div>
            <div class="stat-value">{{ card.value }}</div>
            <div class="stat-footer">
              <span class="stat-desc">{{ card.desc }}</span>
            </div>
          </div>
        </el-col>
      </el-row>

      <!-- 图表区 -->
      <el-row :gutter="16" class="chart-row">
        <el-col :xs="24" :md="10">
          <el-card shadow="never" class="chart-card">
            <template #header><span class="card-title">我的任务状态分布</span></template>
            <div ref="tTaskPieRef" class="chart-box"></div>
          </el-card>
        </el-col>
        <el-col :xs="24" :md="14">
          <el-card shadow="never" class="chart-card">
            <template #header><span class="card-title">审批趋势</span></template>
            <div ref="tApprovalTrendRef" class="chart-box"></div>
          </el-card>
        </el-col>
      </el-row>

      <!-- 数据区 -->
      <el-row :gutter="16" class="data-row">
        <el-col :xs="24" :md="12">
          <el-card shadow="never" class="data-card">
            <template #header><span class="card-title">待审批请假</span></template>
            <el-table :data="teacherData.pendingLeaves" size="small" max-height="320">
              <el-table-column label="申请人" prop="applicantUserName" width="90" align="center" />
              <el-table-column label="请假标题" prop="leaveTitle" :show-overflow-tooltip="true" />
              <el-table-column label="天数" prop="leaveDays" width="60" align="center" />
              <el-table-column label="操作" width="80" align="center">
                <template #default="{ row }">
                  <el-button link type="primary" size="small" @click="$router.push('/campus/leave')">审批</el-button>
                </template>
              </el-table-column>
            </el-table>
          </el-card>
        </el-col>
        <el-col :xs="24" :md="12">
          <el-card shadow="never" class="data-card">
            <template #header><span class="card-title">最新任务评论</span></template>
            <el-table :data="teacherData.recentComments" size="small" max-height="320">
              <el-table-column label="评论人" prop="commentUserName" width="90" align="center" />
              <el-table-column label="评论内容" prop="commentContent" :show-overflow-tooltip="true" />
              <el-table-column label="时间" prop="createTime" width="110" align="center">
                <template #default="{ row }">{{ parseTime(row.createTime, '{y}-{m}-{d}') }}</template>
              </el-table-column>
            </el-table>
          </el-card>
        </el-col>
      </el-row>

      <!-- 快捷操作 -->
      <el-row :gutter="16" class="quick-row">
        <el-col :span="24">
          <el-card shadow="never" class="quick-card">
            <template #header><span class="card-title">快捷操作</span></template>
            <div class="quick-actions">
              <el-button type="primary" plain icon="Plus" @click="$router.push('/campus/task')">创建任务</el-button>
              <el-button type="warning" plain icon="Check" @click="$router.push('/campus/leave')">审批请假</el-button>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </template>
  </div>
</template>

<script setup name="Index">
import { ref, computed, onMounted, onBeforeUnmount, nextTick } from 'vue'
import { useRouter } from 'vue-router'
import useUserStore from '@/store/modules/user'
import { getAdminDashboard, getTeacherDashboard } from '@/api/dashboard'
import * as echarts from 'echarts'
import { Ticket, Clock, FolderOpened, User, DataAnalysis, List } from '@element-plus/icons-vue'

const { proxy } = getCurrentInstance()
const { campus_task_status, campus_leave_type, campus_leave_status } = proxy.useDict(
  'campus_task_status', 'campus_leave_type', 'campus_leave_status'
)

const isAdmin = computed(() => useUserStore().roles.includes('admin'))

const chartColors = ['#5B8FF9', '#5AD8A6', '#F6BD16', '#E86452', '#6DC8EC', '#945FB9']

/* ========== 管理员数据 ========== */
const adminData = ref({
  userTotal: 0, taskTotal: 0, pendingLeaveTotal: 0, fileTotal: 0,
  taskStatusStats: [], taskTrend: [], roleStats: [], leaveStatusStats: [],
  recentTasks: [], recentLeaves: []
})

const adminCards = computed(() => [
  { label: '用户总数', value: adminData.value.userTotal, color: 'blue', icon: User, trend: '', desc: '平台注册用户', trendDir: '' },
  { label: '任务总数', value: adminData.value.taskTotal, color: 'green', icon: Ticket, trend: '', desc: '全部任务', trendDir: '' },
  { label: '待审批请假', value: adminData.value.pendingLeaveTotal, color: 'yellow', icon: Clock, trend: '', desc: '等待教师审批', trendDir: '' },
  { label: '文件总数', value: adminData.value.fileTotal, color: 'cyan', icon: FolderOpened, trend: '', desc: '共享文件', trendDir: '' }
])

/* ========== 教师数据 ========== */
const teacherData = ref({
  myTaskTotal: 0, pendingLeaveTotal: 0, myFileTotal: 0,
  taskStatusStats: [], approvalTrend: [],
  pendingLeaves: [], recentComments: []
})

const teacherCards = computed(() => [
  { label: '我创建的任务', value: teacherData.value.myTaskTotal, color: 'blue', icon: Ticket, desc: '已分配任务数' },
  { label: '待审批请假', value: teacherData.value.pendingLeaveTotal, color: 'yellow', icon: Clock, desc: '等待审批' },
  { label: '上传文件数', value: teacherData.value.myFileTotal, color: 'green', icon: FolderOpened, desc: '我的共享文件' }
])

/* ========== ECharts 实例 ========== */
const taskPieRef = ref(null)
const taskTrendRef = ref(null)
const rolePieRef = ref(null)
const leaveBarRef = ref(null)
const tTaskPieRef = ref(null)
const tApprovalTrendRef = ref(null)

let charts = []

function initChart(el) {
  if (!el) return null
  const chart = echarts.init(el)
  charts.push(chart)
  return chart
}

function handleResize() {
  charts.forEach(c => c && c.resize())
}

/* ========== 字典翻译辅助 ========== */
function dictLabel(dictList, value) {
  if (!dictList || !dictList.length) return value
  const item = dictList.find(d => String(d.value) === String(value))
  return item ? item.label : value
}

/* ========== 管理员图表 ========== */
function renderAdminCharts() {
  nextTick(() => {
    /* 任务状态饼图 — 后端返回 [{name: '0', value: 1}, ...] 需要翻译 name */
    const pie1 = initChart(taskPieRef.value)
    if (pie1) {
      pie1.setOption({
        color: chartColors,
        tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
        legend: { bottom: 0, textStyle: { color: '#4E5969', fontSize: 12 } },
        series: [{
          type: 'pie', radius: ['45%', '70%'], center: ['50%', '45%'],
          itemStyle: { borderRadius: 6, borderColor: '#FCFCFD', borderWidth: 2 },
          label: { show: false },
          data: (adminData.value.taskStatusStats || []).map(item => ({
            name: dictLabel(campus_task_status.value, item.name), value: Number(item.value)
          }))
        }]
      })
    }

    /* 近7天任务趋势折线图 — 后端返回 [{name: '04-08', value: 1}, ...] */
    const line1 = initChart(taskTrendRef.value)
    if (line1) {
      const trend = adminData.value.taskTrend || []
      line1.setOption({
        color: chartColors,
        tooltip: { trigger: 'axis', backgroundColor: 'rgba(255,255,255,0.96)', borderColor: '#E5E6EB', textStyle: { color: '#1D2129' } },
        grid: { top: 20, right: 20, bottom: 30, left: 50, containLabel: true },
        xAxis: { type: 'category', data: trend.map(i => i.name), axisLine: { lineStyle: { color: '#E5E6EB' } }, axisLabel: { color: '#86909C' } },
        yAxis: { type: 'value', minInterval: 1, axisLine: { show: false }, axisLabel: { color: '#86909C' }, splitLine: { lineStyle: { color: '#F2F3F5', type: 'dashed' } } },
        series: [{
          type: 'line', smooth: true, symbolSize: 6, lineStyle: { width: 2.5 },
          areaStyle: { color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
            { offset: 0, color: 'rgba(91,143,249,0.25)' }, { offset: 1, color: 'rgba(91,143,249,0.02)' }
          ]) },
          data: trend.map(i => Number(i.value))
        }]
      })
    }

    /* 角色占比饼图 — 后端返回 [{name: '超级管理员', value: 1}, ...] 已是中文 */
    const pie2 = initChart(rolePieRef.value)
    if (pie2) {
      pie2.setOption({
        color: chartColors,
        tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
        legend: { bottom: 0, textStyle: { color: '#4E5969', fontSize: 12 } },
        series: [{
          type: 'pie', radius: ['45%', '70%'], center: ['50%', '45%'],
          itemStyle: { borderRadius: 6, borderColor: '#FCFCFD', borderWidth: 2 },
          label: { show: false },
          data: (adminData.value.roleStats || []).map(item => ({
            name: item.name, value: Number(item.value)
          }))
        }]
      })
    }

    /* 请假审批柱状图 — 后端返回 [{name: '0', value: 2}, ...] 需要翻译 name */
    const bar1 = initChart(leaveBarRef.value)
    if (bar1) {
      const stats = adminData.value.leaveStatusStats || []
      bar1.setOption({
        color: chartColors,
        tooltip: { trigger: 'axis', backgroundColor: 'rgba(255,255,255,0.96)', borderColor: '#E5E6EB', textStyle: { color: '#1D2129' } },
        grid: { top: 20, right: 20, bottom: 30, left: 50, containLabel: true },
        xAxis: { type: 'category', data: stats.map(i => dictLabel(campus_leave_status.value, i.name)), axisLine: { lineStyle: { color: '#E5E6EB' } }, axisLabel: { color: '#86909C' } },
        yAxis: { type: 'value', minInterval: 1, axisLine: { show: false }, axisLabel: { color: '#86909C' }, splitLine: { lineStyle: { color: '#F2F3F5', type: 'dashed' } } },
        series: [{
          type: 'bar', barWidth: 32, itemStyle: { borderRadius: [4, 4, 0, 0] },
          data: stats.map((i, idx) => ({ value: Number(i.value), itemStyle: { color: chartColors[idx % chartColors.length] } }))
        }]
      })
    }
  })
}

/* ========== 教师图表 ========== */
function renderTeacherCharts() {
  nextTick(() => {
    /* 教师任务状态饼图 — 使用字典翻译 */
    const pie1 = initChart(tTaskPieRef.value)
    if (pie1) {
      pie1.setOption({
        color: chartColors,
        tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
        legend: { bottom: 0, textStyle: { color: '#4E5969', fontSize: 12 } },
        series: [{
          type: 'pie', radius: ['45%', '70%'], center: ['50%', '45%'],
          itemStyle: { borderRadius: 6, borderColor: '#FCFCFD', borderWidth: 2 },
          label: { show: false },
          data: (teacherData.value.taskStatusStats || []).map(item => ({
            name: dictLabel(campus_task_status.value, item.name), value: Number(item.value)
          }))
        }]
      })
    }

    /* 审批趋势折线图 — 后端返回 [{date, approved, rejected}, ...] */
    const line1 = initChart(tApprovalTrendRef.value)
    if (line1) {
      const trend = teacherData.value.approvalTrend || []
      line1.setOption({
        color: ['#5AD8A6', '#E86452'],
        tooltip: { trigger: 'axis', backgroundColor: 'rgba(255,255,255,0.96)', borderColor: '#E5E6EB', textStyle: { color: '#1D2129' } },
        legend: { bottom: 0, textStyle: { color: '#4E5969', fontSize: 12 } },
        grid: { top: 20, right: 20, bottom: 40, left: 50, containLabel: true },
        xAxis: { type: 'category', data: trend.map(i => i.date), axisLine: { lineStyle: { color: '#E5E6EB' } }, axisLabel: { color: '#86909C' } },
        yAxis: { type: 'value', minInterval: 1, axisLine: { show: false }, axisLabel: { color: '#86909C' }, splitLine: { lineStyle: { color: '#F2F3F5', type: 'dashed' } } },
        series: [
          { name: '已批准', type: 'line', smooth: true, symbolSize: 6, lineStyle: { width: 2.5 }, data: trend.map(i => Number(i.approved || 0)) },
          { name: '已驳回', type: 'line', smooth: true, symbolSize: 6, lineStyle: { width: 2.5 }, data: trend.map(i => Number(i.rejected || 0)) }
        ]
      })
    }
  })
}

/* ========== 生命周期 ========== */
onMounted(() => {
  if (isAdmin.value) {
    getAdminDashboard().then(res => {
      adminData.value = res.data
      renderAdminCharts()
    })
  } else {
    getTeacherDashboard().then(res => {
      teacherData.value = res.data
      renderTeacherCharts()
    })
  }
  window.addEventListener('resize', handleResize)
})

onBeforeUnmount(() => {
  charts.forEach(c => c && c.dispose())
  charts = []
  window.removeEventListener('resize', handleResize)
})
</script>

<style lang="scss" scoped>
.home {
  padding: var(--space-lg, 24px);
  background: var(--bg-page, #F8FAFC);
  min-height: calc(100vh - 84px);
}

/* 统计卡片 */
.stat-row {
  margin-bottom: var(--space-md, 16px);
}

.stat-card {
  background: var(--bg-card, #FFFFFF);
  border-radius: var(--radius-lg, 12px);
  padding: 20px 24px;
  box-shadow: var(--shadow-sm, 0 1px 2px rgba(0,0,0,0.05));
  transition: all 200ms ease;
  position: relative;
  overflow: hidden;
  margin-bottom: 16px;

  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 3px;
  }

  &:hover {
    box-shadow: var(--shadow-md, 0 4px 6px rgba(0,0,0,0.1));
    transform: translateY(-2px);
  }

  &.blue::before { background: var(--stat-blue, #5B8FF9); }
  &.green::before { background: var(--stat-green, #5AD8A6); }
  &.yellow::before { background: var(--stat-yellow, #F6BD16); }
  &.red::before { background: var(--stat-red, #E86452); }
  &.cyan::before { background: var(--stat-cyan, #6DC8EC); }
  &.purple::before { background: var(--stat-purple, #945FB9); }
}

.stat-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.stat-label {
  font-size: 14px;
  color: var(--text-secondary, #86909C);
  font-weight: 500;
}

.stat-icon {
  color: var(--text-secondary, #86909C);
  opacity: 0.6;
}

.stat-value {
  font-family: var(--font-heading, 'Fira Code', monospace);
  font-size: 28px;
  font-weight: 700;
  color: var(--text-primary, #1E3A8A);
  line-height: 1.2;
  margin-bottom: 8px;
}

.stat-footer {
  display: flex;
  align-items: center;
  gap: 6px;
}

.stat-trend {
  font-size: 12px;
  font-weight: 600;

  &.up { color: var(--stat-green, #5AD8A6); }
  &.down { color: var(--stat-red, #E86452); }
}

.stat-desc {
  font-size: 12px;
  color: var(--text-secondary, #86909C);
}

/* 图表卡片 */
.chart-row {
  margin-bottom: var(--space-md, 16px);
}

.chart-card {
  border-radius: var(--radius-lg, 12px);
  border: none;
  box-shadow: var(--shadow-sm, 0 1px 2px rgba(0,0,0,0.05));
  margin-bottom: 16px;

  :deep(.el-card__header) {
    padding: 16px 20px 12px;
    border-bottom: 1px solid var(--border-color-light, #F2F3F5);
  }

  :deep(.el-card__body) {
    padding: 16px 20px;
  }
}

.card-title {
  font-size: 15px;
  font-weight: 600;
  color: var(--text-primary, #1E3A8A);
}

.chart-box {
  width: 100%;
  height: 280px;
}

/* 数据区 */
.data-row {
  margin-bottom: var(--space-md, 16px);
}

.data-card {
  border-radius: var(--radius-lg, 12px);
  border: none;
  box-shadow: var(--shadow-sm, 0 1px 2px rgba(0,0,0,0.05));
  margin-bottom: 16px;

  :deep(.el-card__header) {
    padding: 16px 20px 12px;
    border-bottom: 1px solid var(--border-color-light, #F2F3F5);
  }

  :deep(.el-card__body) {
    padding: 0;
  }

  :deep(.el-table) {
    border-radius: 0 0 var(--radius-lg, 12px) var(--radius-lg, 12px);
  }

  :deep(.el-table th.el-table__cell) {
    background: var(--bg-page, #F8FAFC);
    color: var(--text-secondary, #86909C);
    font-weight: 500;
    font-size: 13px;
  }
}

/* 快捷操作 */
.quick-row {
  margin-bottom: var(--space-md, 16px);
}

.quick-card {
  border-radius: var(--radius-lg, 12px);
  border: none;
  box-shadow: var(--shadow-sm, 0 1px 2px rgba(0,0,0,0.05));

  :deep(.el-card__header) {
    padding: 16px 20px 12px;
    border-bottom: 1px solid var(--border-color-light, #F2F3F5);
  }
}

.quick-actions {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
}

/* 无障碍 */
@media (prefers-reduced-motion: reduce) {
  .stat-card {
    transition: none;
  }
}
</style>
