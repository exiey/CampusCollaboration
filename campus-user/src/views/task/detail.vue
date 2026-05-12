<template>
  <div class="task-detail-page">
    <div class="breadcrumb-bar">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/task' }">任务中心</el-breadcrumb-item>
        <el-breadcrumb-item>任务详情</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div v-loading="loading" class="detail-content">
      <div class="detail-main">
        <div class="detail-header">
          <h1 class="detail-title">{{ task.taskTitle }}</h1>
          <div class="detail-tags">
            <el-tag :type="getStatusType(task.taskStatus)" size="small">{{ getStatusLabel(task.taskStatus) }}</el-tag>
            <el-tag :type="getPriorityType(task.priority)" size="small">{{ getPriorityLabel(task.priority) }}</el-tag>
          </div>
        </div>

        <div class="detail-info-grid">
          <div class="info-item"><span class="info-label">发布教师</span><span class="info-value">{{ task.publishUserName || '-' }}</span></div>
          <div class="info-item"><span class="info-label">接收学生</span><span class="info-value">{{ task.receiveUserName || '-' }}</span></div>
          <div class="info-item"><span class="info-label">开始时间</span><span class="info-value">{{ formatDate(task.startTime) }}</span></div>
          <div class="info-item"><span class="info-label">截止时间</span><span class="info-value">{{ formatDate(task.deadlineTime) }}</span></div>
          <div class="info-item"><span class="info-label">完成时间</span><span class="info-value">{{ formatDate(task.finishTime) }}</span></div>
          <div class="info-item"><span class="info-label">评论数</span><span class="info-value">{{ task.commentCount || 0 }}</span></div>
        </div>

        <div class="detail-progress">
          <span class="progress-title">任务进度</span>
          <el-progress :percentage="task.progressPercent || 0" :stroke-width="10" :color="getProgressColor(task.progressPercent)" />
        </div>

        <el-tabs v-model="activeTab" class="detail-tabs">
          <el-tab-pane label="任务内容" name="content">
            <div class="tab-content">{{ task.taskContent || '暂无内容' }}</div>
            <div v-if="task.remark" class="tab-remark">
              <span class="remark-label">备注：</span>{{ task.remark }}
            </div>
          </el-tab-pane>
          <el-tab-pane :label="'评论 (' + commentList.length + ')'" name="comment">
            <div class="comment-section">
              <div v-if="commentList.length === 0" class="empty-comment">暂无评论，发表第一条评论吧</div>
              <div v-for="item in commentList" :key="item.commentId" class="comment-item">
                <div class="comment-header">
                  <span class="comment-user">{{ item.commentUserName }}</span>
                  <span class="comment-time">{{ item.createTime }}</span>
                </div>
                <div class="comment-body">{{ item.commentContent }}</div>
              </div>
            </div>
            <div class="comment-form">
              <el-input v-model="commentContent" type="textarea" :rows="3" placeholder="请输入评论内容" maxlength="500" show-word-limit />
              <el-button type="primary" :loading="commentLoading" style="margin-top: 12px" @click="submitComment">发表评论</el-button>
            </div>
          </el-tab-pane>
        </el-tabs>
      </div>

      <div class="detail-sidebar">
        <el-card shadow="never" class="sidebar-card">
          <template #header><span class="sidebar-title">操作</span></template>
          <div class="sidebar-actions">
            <el-button v-if="task.taskStatus === '0'" type="primary" @click="updateStatus('1')">开始任务</el-button>
            <el-button v-if="task.taskStatus === '1'" type="success" @click="updateStatus('2')">完成任务</el-button>
            <el-button @click="$router.push('/task')">返回列表</el-button>
          </div>
        </el-card>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { getTask, changeTaskStatus, listTaskComment, addTaskComment } from '@/api/task'

const route = useRoute()
const loading = ref(false)
const task = ref({})
const activeTab = ref('content')
const commentList = ref([])
const commentContent = ref('')
const commentLoading = ref(false)

const statusMap = { '0': '待处理', '1': '进行中', '2': '已完成', '3': '已取消' }
const statusTypeMap = { '0': 'info', '1': '', '2': 'success', '3': 'danger' }
const priorityMap = { '0': '低', '1': '中', '2': '高', '3': '紧急' }
const priorityTypeMap = { '0': 'info', '1': '', '2': 'warning', '3': 'danger' }

function getStatusLabel(s) { return statusMap[s] || '未知' }
function getStatusType(s) { return statusTypeMap[s] || 'info' }
function getPriorityLabel(p) { return priorityMap[p] || '未知' }
function getPriorityType(p) { return priorityTypeMap[p] || 'info' }
function getProgressColor(p) { return p >= 100 ? '#22C55E' : p >= 50 ? '#4F46E5' : '#F59E0B' }
function formatDate(d) { return d || '-' }

function loadTask() {
  loading.value = true
  getTask(route.params.id).then(res => {
    task.value = res.data || {}
  }).finally(() => { loading.value = false })
}

function loadComments() {
  listTaskComment(route.params.id).then(res => {
    commentList.value = res.data || []
  })
}

function submitComment() {
  if (!commentContent.value.trim()) {
    ElMessage.warning('请输入评论内容')
    return
  }
  commentLoading.value = true
  addTaskComment({ taskId: route.params.id, commentContent: commentContent.value }).then(() => {
    ElMessage.success('评论成功')
    commentContent.value = ''
    loadComments()
    loadTask()
  }).finally(() => { commentLoading.value = false })
}

function updateStatus(status) {
  changeTaskStatus({ taskId: task.value.taskId, taskStatus: status }).then(() => {
    ElMessage.success('状态更新成功')
    loadTask()
  })
}

onMounted(() => {
  loadTask()
  loadComments()
})
</script>

<style scoped>
.task-detail-page { padding-bottom: var(--space-xl); }

.breadcrumb-bar { margin-bottom: var(--space-lg); }

.detail-content {
  display: grid;
  grid-template-columns: 1fr 280px;
  gap: var(--space-lg);
}

.detail-main {
  background: var(--bg-card);
  border-radius: var(--radius-lg);
  padding: var(--space-xl);
  box-shadow: var(--shadow-sm);
}

.detail-header { margin-bottom: var(--space-lg); }

.detail-title {
  font-family: var(--font-heading);
  font-size: 22px;
  color: var(--text-primary);
  margin-bottom: var(--space-sm);
}

.detail-tags { display: flex; gap: var(--space-xs); }

.detail-info-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: var(--space-md);
  padding: var(--space-md);
  background: var(--bg-section);
  border-radius: var(--radius-md);
  margin-bottom: var(--space-lg);
}

.info-item { display: flex; flex-direction: column; gap: 2px; }
.info-label { font-size: 12px; color: var(--text-secondary); }
.info-value { font-size: 14px; font-weight: 500; color: var(--text-primary); }

.detail-progress { margin-bottom: var(--space-lg); }
.progress-title { font-size: 14px; font-weight: 500; color: var(--text-primary); display: block; margin-bottom: var(--space-sm); }

.detail-tabs { margin-top: var(--space-md); }

.tab-content { font-size: 14px; color: var(--text-regular); line-height: 1.8; white-space: pre-wrap; }
.tab-remark { margin-top: var(--space-md); font-size: 13px; color: var(--text-secondary); }
.remark-label { font-weight: 600; }

.comment-section { margin-bottom: var(--space-md); max-height: 400px; overflow-y: auto; }
.empty-comment { text-align: center; padding: var(--space-xl); color: var(--text-secondary); font-size: 14px; }

.comment-item { padding: 12px 0; border-bottom: 1px solid var(--border-color-light); }
.comment-item:last-child { border-bottom: none; }
.comment-header { display: flex; justify-content: space-between; margin-bottom: 4px; }
.comment-user { font-size: 14px; font-weight: 600; color: var(--text-primary); }
.comment-time { font-size: 12px; color: var(--text-secondary); }
.comment-body { font-size: 14px; color: var(--text-regular); line-height: 1.6; }

.sidebar-card {
  border-radius: var(--radius-lg);
  border: none;
  box-shadow: var(--shadow-sm);
}

.sidebar-title { font-family: var(--font-heading); font-size: 15px; font-weight: 600; color: var(--text-primary); }
.sidebar-actions { display: flex; flex-direction: column; gap: var(--space-sm); }
.sidebar-actions .el-button { width: 100%; margin-left: 0; }

@media (max-width: 1024px) {
  .detail-content { grid-template-columns: 1fr; }
  .detail-info-grid { grid-template-columns: repeat(2, 1fr); }
}

@media (max-width: 768px) {
  .detail-info-grid { grid-template-columns: 1fr; }
}
</style>
