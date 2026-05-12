<template>
  <div class="home-page">
    <!-- 欢迎区 -->
    <div class="welcome-section">
      <div class="welcome-content">
        <h1 class="welcome-title">{{ greeting }}，{{ userStore.nickName || '同学' }}</h1>
        <p class="welcome-desc">欢迎使用校园协同工作平台，以下是您的工作概览</p>
      </div>
    </div>

    <!-- 统计卡片 -->
    <div class="stat-grid">
      <div class="stat-card stat-blue" @click="$router.push('/task')">
        <div class="stat-icon-wrap blue">
          <el-icon :size="24"><Tickets /></el-icon>
        </div>
        <div class="stat-info">
          <span class="stat-value">{{ stats.taskTotal || 0 }}</span>
          <span class="stat-label">我的任务</span>
        </div>
      </div>
      <div class="stat-card stat-yellow" @click="$router.push('/leave')">
        <div class="stat-icon-wrap yellow">
          <el-icon :size="24"><Clock /></el-icon>
        </div>
        <div class="stat-info">
          <span class="stat-value">{{ stats.pendingLeave || 0 }}</span>
          <span class="stat-label">待审批请假</span>
        </div>
      </div>
      <div class="stat-card stat-green" @click="$router.push('/file')">
        <div class="stat-icon-wrap green">
          <el-icon :size="24"><FolderOpened /></el-icon>
        </div>
        <div class="stat-info">
          <span class="stat-value">{{ stats.fileTotal || 0 }}</span>
          <span class="stat-label">共享文件</span>
        </div>
      </div>
      <div class="stat-card stat-purple" @click="$router.push('/notice')">
        <div class="stat-icon-wrap purple">
          <el-icon :size="24"><Bell /></el-icon>
        </div>
        <div class="stat-info">
          <span class="stat-value">{{ stats.noticeTotal || 0 }}</span>
          <span class="stat-label">系统公告</span>
        </div>
      </div>
    </div>

    <!-- 内容板块 -->
    <div class="content-grid">
      <!-- 待办任务 -->
      <el-card shadow="never" class="content-card">
        <template #header>
          <div class="card-header">
            <span class="card-title">待办任务</span>
            <el-button link type="primary" @click="$router.push('/task')">查看全部</el-button>
          </div>
        </template>
        <div v-if="recentTasks.length === 0" class="empty-state">
          <el-icon :size="40" class="empty-icon"><Tickets /></el-icon>
          <p class="empty-text">暂无待办任务</p>
          <el-button type="primary" plain size="small" @click="$router.push('/task')">前往任务中心</el-button>
        </div>
        <div v-else class="task-list">
          <div v-for="task in recentTasks" :key="task.taskId" class="task-item" @click="$router.push('/task/' + task.taskId)">
            <div class="task-info">
              <span class="task-title">{{ task.taskTitle }}</span>
              <span class="task-meta">{{ task.publishUserName }} | 截止 {{ formatDate(task.deadlineTime) }}</span>
            </div>
            <el-tag :type="getStatusType(task.taskStatus)" size="small">{{ getStatusLabel(task.taskStatus) }}</el-tag>
          </div>
        </div>
      </el-card>

      <!-- 最新公告 -->
      <el-card shadow="never" class="content-card">
        <template #header>
          <div class="card-header">
            <span class="card-title">最新公告</span>
            <el-button link type="primary" @click="$router.push('/notice')">查看全部</el-button>
          </div>
        </template>
        <div v-if="recentNotices.length === 0" class="empty-state">
          <el-icon :size="40" class="empty-icon"><Bell /></el-icon>
          <p class="empty-text">暂无公告通知</p>
        </div>
        <div v-else class="notice-list">
          <div v-for="notice in recentNotices" :key="notice.noticeId" class="notice-item">
            <el-tag :type="notice.noticeType === '1' ? '' : 'warning'" size="small" class="notice-tag">
              {{ notice.noticeType === '1' ? '通知' : '公告' }}
            </el-tag>
            <span class="notice-title">{{ notice.noticeTitle }}</span>
            <span class="notice-time">{{ formatDate(notice.createTime) }}</span>
          </div>
        </div>
      </el-card>
    </div>

    <!-- 快捷操作 -->
    <div class="quick-section">
      <h3 class="section-title">快捷操作</h3>
      <div class="quick-grid">
        <div class="quick-item" @click="$router.push('/task')">
          <el-icon :size="28" class="quick-icon"><Tickets /></el-icon>
          <span class="quick-label">查看任务</span>
        </div>
        <div class="quick-item" @click="$router.push('/file')">
          <el-icon :size="28" class="quick-icon"><FolderOpened /></el-icon>
          <span class="quick-label">文件中心</span>
        </div>
        <div class="quick-item" @click="$router.push('/leave')">
          <el-icon :size="28" class="quick-icon"><DocumentChecked /></el-icon>
          <span class="quick-label">请假申请</span>
        </div>
        <div class="quick-item" @click="$router.push('/profile/info')">
          <el-icon :size="28" class="quick-icon"><UserFilled /></el-icon>
          <span class="quick-label">个人中心</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { Tickets, Clock, FolderOpened, Bell, DocumentChecked, UserFilled } from '@element-plus/icons-vue'
import useUserStore from '@/store/user'
import { listMyTask } from '@/api/task'
import { listNotice } from '@/api/notice'
import { listFile } from '@/api/file'
import { listMyLeave } from '@/api/leave'

const userStore = useUserStore()

const stats = ref({ taskTotal: 0, pendingLeave: 0, fileTotal: 0, noticeTotal: 0 })
const recentTasks = ref([])
const recentNotices = ref([])

const greeting = computed(() => {
  const hour = new Date().getHours()
  if (hour < 6) return '夜深了'
  if (hour < 12) return '上午好'
  if (hour < 14) return '中午好'
  if (hour < 18) return '下午好'
  return '晚上好'
})

const statusMap = { '0': '待处理', '1': '进行中', '2': '已完成', '3': '已取消' }
const statusTypeMap = { '0': 'info', '1': '', '2': 'success', '3': 'danger' }

function getStatusLabel(status) { return statusMap[status] || '未知' }
function getStatusType(status) { return statusTypeMap[status] || 'info' }

function formatDate(dateStr) {
  if (!dateStr) return '-'
  return dateStr.substring(0, 10)
}

onMounted(async () => {
  try {
    const [taskRes, leaveRes, fileRes, noticeRes] = await Promise.all([
      listMyTask({ pageNum: 1, pageSize: 5 }),
      listMyLeave({ pageNum: 1, pageSize: 1, leaveStatus: '0' }),
      listFile({ pageNum: 1, pageSize: 1 }),
      listNotice({ pageNum: 1, pageSize: 5 })
    ])
    recentTasks.value = taskRes.rows || []
    stats.value.taskTotal = taskRes.total || 0
    stats.value.pendingLeave = leaveRes.total || 0
    stats.value.fileTotal = fileRes.total || 0
    recentNotices.value = noticeRes.rows || []
    stats.value.noticeTotal = noticeRes.total || 0
  } catch (e) {
    /* 静默处理 */
  }
})
</script>

<style scoped>
.home-page {
  padding-bottom: var(--space-xl);
}

.welcome-section {
  background: linear-gradient(135deg, var(--color-primary-lightest) 0%, #DDD6FE 100%);
  border-radius: var(--radius-lg);
  padding: var(--space-xl) var(--space-2xl);
  margin-bottom: var(--space-lg);
}

.welcome-title {
  font-family: var(--font-heading);
  font-size: 22px;
  color: var(--color-primary);
  margin-bottom: 4px;
}

.welcome-desc {
  font-size: 14px;
  color: var(--text-regular);
  margin: 0;
}

.stat-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: var(--space-md);
  margin-bottom: var(--space-lg);
}

.stat-card {
  display: flex;
  align-items: center;
  gap: var(--space-md);
  background: var(--bg-card);
  border-radius: var(--radius-lg);
  padding: var(--space-lg);
  box-shadow: var(--shadow-sm);
  cursor: pointer;
  transition: all 200ms ease;
}

.stat-card:hover {
  box-shadow: var(--shadow-md);
  transform: translateY(-2px);
}

.stat-icon-wrap {
  width: 48px;
  height: 48px;
  border-radius: var(--radius-md);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.stat-icon-wrap.blue { background: #EEF2FF; color: #4F46E5; }
.stat-icon-wrap.yellow { background: #FEF9C3; color: #CA8A04; }
.stat-icon-wrap.green { background: #DCFCE7; color: #16A34A; }
.stat-icon-wrap.purple { background: #F3E8FF; color: #9333EA; }

.stat-info {
  display: flex;
  flex-direction: column;
}

.stat-value {
  font-family: var(--font-heading);
  font-size: 24px;
  font-weight: 700;
  color: var(--text-primary);
  line-height: 1.2;
}

.stat-label {
  font-size: 13px;
  color: var(--text-secondary);
  margin-top: 2px;
}

.content-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: var(--space-md);
  margin-bottom: var(--space-lg);
}

.content-card {
  border-radius: var(--radius-lg);
  border: none;
  box-shadow: var(--shadow-sm);
}

.content-card :deep(.el-card__header) {
  padding: var(--space-md) var(--space-lg);
  border-bottom: 1px solid var(--border-color-light);
}

.content-card :deep(.el-card__body) {
  padding: var(--space-md) var(--space-lg);
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-title {
  font-family: var(--font-heading);
  font-size: 15px;
  font-weight: 600;
  color: var(--text-primary);
}

.empty-state {
  text-align: center;
  padding: var(--space-xl) 0;
}

.empty-icon {
  color: var(--text-placeholder);
  margin-bottom: var(--space-sm);
}

.empty-text {
  font-size: 14px;
  color: var(--text-secondary);
  margin-bottom: var(--space-md);
}

.task-list {
  display: flex;
  flex-direction: column;
}

.task-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 0;
  border-bottom: 1px solid var(--border-color-light);
  cursor: pointer;
  transition: background 200ms ease;
}

.task-item:last-child { border-bottom: none; }

.task-item:hover {
  background: var(--bg-card-hover);
  margin: 0 calc(-1 * var(--space-lg));
  padding-left: var(--space-lg);
  padding-right: var(--space-lg);
}

.task-info {
  display: flex;
  flex-direction: column;
  gap: 2px;
  min-width: 0;
  flex: 1;
  margin-right: var(--space-sm);
}

.task-title {
  font-size: 14px;
  font-weight: 500;
  color: var(--text-primary);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.task-meta {
  font-size: 12px;
  color: var(--text-secondary);
}

.notice-list {
  display: flex;
  flex-direction: column;
}

.notice-item {
  display: flex;
  align-items: center;
  gap: var(--space-sm);
  padding: 10px 0;
  border-bottom: 1px solid var(--border-color-light);
}

.notice-item:last-child { border-bottom: none; }

.notice-tag { flex-shrink: 0; }

.notice-title {
  flex: 1;
  font-size: 14px;
  color: var(--text-primary);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.notice-time {
  font-size: 12px;
  color: var(--text-secondary);
  flex-shrink: 0;
}

.quick-section {
  margin-bottom: var(--space-lg);
}

.section-title {
  font-family: var(--font-heading);
  font-size: 16px;
  color: var(--text-primary);
  margin-bottom: var(--space-md);
}

.quick-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: var(--space-md);
}

.quick-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: var(--space-sm);
  padding: var(--space-lg);
  background: var(--bg-card);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-sm);
  cursor: pointer;
  transition: all 200ms ease;
}

.quick-item:hover {
  box-shadow: var(--shadow-md);
  transform: translateY(-2px);
}

.quick-icon {
  color: var(--color-primary);
}

.quick-label {
  font-size: 14px;
  font-weight: 500;
  color: var(--text-primary);
}

@media (max-width: 1024px) {
  .stat-grid { grid-template-columns: repeat(2, 1fr); }
  .content-grid { grid-template-columns: 1fr; }
}

@media (max-width: 768px) {
  .stat-grid { grid-template-columns: 1fr 1fr; }
  .quick-grid { grid-template-columns: repeat(2, 1fr); }
}

@media (prefers-reduced-motion: reduce) {
  .stat-card, .quick-item, .task-item {
    transition: none;
  }
}
</style>
