<template>
  <div class="task-page">
    <div class="page-header">
      <h2 class="page-title">任务中心</h2>
      <p class="page-desc">查看分配给您的任务，跟踪进度</p>
    </div>

    <!-- 筛选栏 -->
    <div class="filter-bar">
      <el-input v-model="queryParams.taskTitle" placeholder="搜索任务标题" prefix-icon="Search" clearable style="width: 240px" @keyup.enter="handleQuery" />
      <el-select v-model="queryParams.taskStatus" placeholder="任务状态" clearable style="width: 140px" @change="handleQuery">
        <el-option label="待处理" value="0" />
        <el-option label="进行中" value="1" />
        <el-option label="已完成" value="2" />
        <el-option label="已取消" value="3" />
      </el-select>
      <el-select v-model="queryParams.priority" placeholder="优先级" clearable style="width: 140px" @change="handleQuery">
        <el-option label="低" value="0" />
        <el-option label="中" value="1" />
        <el-option label="高" value="2" />
        <el-option label="紧急" value="3" />
      </el-select>
      <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
      <el-button icon="Refresh" @click="resetQuery">重置</el-button>
    </div>

    <!-- 任务卡片网格 -->
    <div v-loading="loading" class="task-grid">
      <div v-if="taskList.length === 0 && !loading" class="empty-state">
        <el-icon :size="48" class="empty-icon"><Tickets /></el-icon>
        <p class="empty-text">暂无任务数据</p>
        <p class="empty-hint">教师分配任务后将在此显示</p>
      </div>
      <div v-for="task in taskList" :key="task.taskId" class="task-card" @click="$router.push('/task/' + task.taskId)">
        <div class="task-card-header">
          <el-tag :type="getPriorityType(task.priority)" size="small">{{ getPriorityLabel(task.priority) }}</el-tag>
          <el-tag :type="getStatusType(task.taskStatus)" size="small">{{ getStatusLabel(task.taskStatus) }}</el-tag>
        </div>
        <h3 class="task-card-title">{{ task.taskTitle }}</h3>
        <p class="task-card-content">{{ task.taskContent || '暂无描述' }}</p>
        <div class="task-card-progress">
          <span class="progress-label">进度</span>
          <el-progress :percentage="task.progressPercent || 0" :stroke-width="6" :color="getProgressColor(task.progressPercent)" />
        </div>
        <div class="task-card-footer">
          <span class="task-teacher">
            <el-icon :size="14"><User /></el-icon>
            {{ task.publishUserName }}
          </span>
          <span class="task-deadline">
            <el-icon :size="14"><Clock /></el-icon>
            {{ formatDate(task.deadlineTime) }}
          </span>
        </div>
      </div>
    </div>

    <!-- 分页 -->
    <div v-if="total > 0" class="pagination-wrap">
      <el-pagination background layout="total, prev, pager, next" :total="total" :page-size="queryParams.pageSize" v-model:current-page="queryParams.pageNum" @current-change="getList" />
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { Tickets, User, Clock } from '@element-plus/icons-vue'
import { listMyTask } from '@/api/task'

const loading = ref(false)
const total = ref(0)
const taskList = ref([])
const queryParams = reactive({ pageNum: 1, pageSize: 12, taskTitle: undefined, taskStatus: undefined, priority: undefined })

const statusMap = { '0': '待处理', '1': '进行中', '2': '已完成', '3': '已取消' }
const statusTypeMap = { '0': 'info', '1': '', '2': 'success', '3': 'danger' }
const priorityMap = { '0': '低', '1': '中', '2': '高', '3': '紧急' }
const priorityTypeMap = { '0': 'info', '1': '', '2': 'warning', '3': 'danger' }

function getStatusLabel(s) { return statusMap[s] || '未知' }
function getStatusType(s) { return statusTypeMap[s] || 'info' }
function getPriorityLabel(p) { return priorityMap[p] || '未知' }
function getPriorityType(p) { return priorityTypeMap[p] || 'info' }
function getProgressColor(p) { return p >= 100 ? '#22C55E' : p >= 50 ? '#4F46E5' : '#F59E0B' }
function formatDate(d) { return d ? d.substring(0, 10) : '-' }

function getList() {
  loading.value = true
  listMyTask(queryParams).then(res => {
    taskList.value = res.rows || []
    total.value = res.total || 0
  }).finally(() => { loading.value = false })
}

function handleQuery() { queryParams.pageNum = 1; getList() }
function resetQuery() {
  queryParams.taskTitle = undefined
  queryParams.taskStatus = undefined
  queryParams.priority = undefined
  handleQuery()
}

onMounted(() => { getList() })
</script>

<style scoped>
.task-page { padding-bottom: var(--space-xl); }

.page-header { margin-bottom: var(--space-lg); }

.page-title {
  font-family: var(--font-heading);
  font-size: 22px;
  color: var(--text-primary);
  margin-bottom: 4px;
}

.page-desc { font-size: 14px; color: var(--text-secondary); margin: 0; }

.filter-bar {
  display: flex;
  align-items: center;
  gap: var(--space-sm);
  flex-wrap: wrap;
  margin-bottom: var(--space-lg);
  padding: var(--space-md);
  background: var(--bg-card);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-sm);
}

.task-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: var(--space-md);
  min-height: 200px;
}

.empty-state {
  grid-column: 1 / -1;
  text-align: center;
  padding: var(--space-3xl) 0;
}

.empty-icon { color: var(--text-placeholder); margin-bottom: var(--space-sm); }
.empty-text { font-size: 16px; color: var(--text-secondary); margin-bottom: 4px; }
.empty-hint { font-size: 13px; color: var(--text-placeholder); }

.task-card {
  background: var(--bg-card);
  border-radius: var(--radius-lg);
  padding: var(--space-lg);
  box-shadow: var(--shadow-sm);
  cursor: pointer;
  transition: all 200ms ease;
  display: flex;
  flex-direction: column;
}

.task-card:hover {
  box-shadow: var(--shadow-md);
  transform: translateY(-2px);
}

.task-card-header {
  display: flex;
  gap: var(--space-xs);
  margin-bottom: var(--space-sm);
}

.task-card-title {
  font-size: 16px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: var(--space-xs);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.task-card-content {
  font-size: 13px;
  color: var(--text-secondary);
  line-height: 1.5;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  margin-bottom: var(--space-md);
  flex: 1;
}

.task-card-progress { margin-bottom: var(--space-md); }

.progress-label {
  font-size: 12px;
  color: var(--text-secondary);
  margin-bottom: 4px;
  display: block;
}

.task-card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 12px;
  color: var(--text-secondary);
}

.task-teacher, .task-deadline {
  display: flex;
  align-items: center;
  gap: 4px;
}

.pagination-wrap {
  display: flex;
  justify-content: center;
  margin-top: var(--space-xl);
}

@media (max-width: 1024px) { .task-grid { grid-template-columns: repeat(2, 1fr); } }
@media (max-width: 768px) { .task-grid { grid-template-columns: 1fr; } }

@media (prefers-reduced-motion: reduce) {
  .task-card { transition: none; }
}
</style>
