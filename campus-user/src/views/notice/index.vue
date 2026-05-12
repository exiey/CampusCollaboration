<template>
  <div class="notice-page">
    <div class="page-header">
      <h2 class="page-title">公告通知</h2>
      <p class="page-desc">查看系统公告和通知</p>
    </div>

    <div v-loading="loading" class="notice-list">
      <div v-if="noticeList.length === 0 && !loading" class="empty-state">
        <el-icon :size="48" class="empty-icon"><Bell /></el-icon>
        <p class="empty-text">暂无公告通知</p>
      </div>
      <div v-for="item in noticeList" :key="item.noticeId" class="notice-card" @click="openDetail(item)">
        <div class="notice-card-header">
          <el-tag :type="item.noticeType === '1' ? '' : 'warning'" size="small">
            {{ item.noticeType === '1' ? '通知' : '公告' }}
          </el-tag>
          <span class="notice-time">{{ item.createTime }}</span>
        </div>
        <h3 class="notice-title">{{ item.noticeTitle }}</h3>
        <p class="notice-preview">{{ stripHtml(item.noticeContent) }}</p>
        <div class="notice-author">发布者：{{ item.createBy }}</div>
      </div>
    </div>

    <div v-if="total > 0" class="pagination-wrap">
      <el-pagination background layout="total, prev, pager, next" :total="total" :page-size="queryParams.pageSize" v-model:current-page="queryParams.pageNum" @current-change="getList" />
    </div>

    <el-dialog v-model="detailVisible" :title="detailData.noticeTitle" width="680px" append-to-body>
      <div class="detail-meta">
        <el-tag :type="detailData.noticeType === '1' ? '' : 'warning'" size="small">
          {{ detailData.noticeType === '1' ? '通知' : '公告' }}
        </el-tag>
        <span>发布者：{{ detailData.createBy }}</span>
        <span>{{ detailData.createTime }}</span>
      </div>
      <div class="detail-content" v-html="detailData.noticeContent"></div>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { Bell } from '@element-plus/icons-vue'
import { listNotice, getNotice } from '@/api/notice'

const loading = ref(false)
const total = ref(0)
const noticeList = ref([])
const detailVisible = ref(false)
const detailData = ref({})
const queryParams = reactive({ pageNum: 1, pageSize: 10 })

function stripHtml(html) {
  if (!html) return '暂无内容'
  return html.replace(/<[^>]+>/g, '').substring(0, 120) + '...'
}

function getList() {
  loading.value = true
  listNotice(queryParams).then(res => {
    noticeList.value = res.rows || []
    total.value = res.total || 0
  }).finally(() => { loading.value = false })
}

function openDetail(item) {
  getNotice(item.noticeId).then(res => {
    detailData.value = res.data || {}
    detailVisible.value = true
  })
}

onMounted(() => { getList() })
</script>

<style scoped>
.notice-page { padding-bottom: var(--space-xl); }
.page-header { margin-bottom: var(--space-lg); }
.page-title { font-family: var(--font-heading); font-size: 22px; color: var(--text-primary); margin-bottom: 4px; }
.page-desc { font-size: 14px; color: var(--text-secondary); margin: 0; }

.notice-list { display: flex; flex-direction: column; gap: var(--space-sm); min-height: 200px; }

.empty-state { text-align: center; padding: var(--space-3xl) 0; }
.empty-icon { color: var(--text-placeholder); margin-bottom: var(--space-sm); }
.empty-text { font-size: 16px; color: var(--text-secondary); }

.notice-card {
  background: var(--bg-card); border-radius: var(--radius-lg); padding: var(--space-lg);
  box-shadow: var(--shadow-sm); cursor: pointer; transition: all 200ms ease;
}

.notice-card:hover { box-shadow: var(--shadow-md); transform: translateY(-1px); }

.notice-card-header { display: flex; align-items: center; gap: var(--space-sm); margin-bottom: var(--space-sm); }
.notice-time { font-size: 12px; color: var(--text-secondary); }
.notice-title { font-size: 17px; font-weight: 600; color: var(--text-primary); margin-bottom: var(--space-xs); }
.notice-preview { font-size: 14px; color: var(--text-regular); line-height: 1.5; margin-bottom: var(--space-sm); display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
.notice-author { font-size: 12px; color: var(--text-secondary); }

.pagination-wrap { display: flex; justify-content: center; margin-top: var(--space-xl); }

.detail-meta { display: flex; align-items: center; gap: var(--space-md); font-size: 13px; color: var(--text-secondary); margin-bottom: var(--space-lg); padding-bottom: var(--space-md); border-bottom: 1px solid var(--border-color-light); }
.detail-content { font-size: 15px; color: var(--text-primary); line-height: 1.8; }

@media (prefers-reduced-motion: reduce) { .notice-card { transition: none; } }
</style>
