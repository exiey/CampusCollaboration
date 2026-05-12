<template>
  <div class="profile-page">
    <div class="page-header">
      <h2 class="page-title">个人中心</h2>
    </div>
    <div class="profile-layout">
      <div class="profile-sidebar">
        <div class="user-card">
          <el-avatar :size="64" :src="userStore.avatar || undefined">
            <el-icon :size="28"><User /></el-icon>
          </el-avatar>
          <h3 class="user-name">{{ userStore.nickName || '用户' }}</h3>
          <p class="user-role">{{ userStore.roles.includes('teacher') ? '教师' : '学生' }}</p>
        </div>
        <nav class="profile-nav">
          <router-link to="/profile/info" class="profile-nav-item" active-class="active">
            <el-icon :size="16"><UserFilled /></el-icon>
            <span>基本资料</span>
          </router-link>
          <router-link to="/profile/password" class="profile-nav-item" active-class="active">
            <el-icon :size="16"><Lock /></el-icon>
            <span>修改密码</span>
          </router-link>
          <router-link to="/task" class="profile-nav-item">
            <el-icon :size="16"><Tickets /></el-icon>
            <span>我的任务</span>
          </router-link>
          <router-link to="/leave" class="profile-nav-item">
            <el-icon :size="16"><DocumentChecked /></el-icon>
            <span>我的请假</span>
          </router-link>
          <router-link to="/file" class="profile-nav-item">
            <el-icon :size="16"><FolderOpened /></el-icon>
            <span>我的文件</span>
          </router-link>
          <router-link to="/notice" class="profile-nav-item">
            <el-icon :size="16"><Bell /></el-icon>
            <span>公告通知</span>
          </router-link>
        </nav>
      </div>
      <div class="profile-content">
        <router-view />
      </div>
    </div>
  </div>
</template>

<script setup>
import { User, UserFilled, Lock, Tickets, DocumentChecked, FolderOpened, Bell } from '@element-plus/icons-vue'
import useUserStore from '@/store/user'
const userStore = useUserStore()
</script>

<style scoped>
.profile-page { padding-bottom: var(--space-xl); }
.page-header { margin-bottom: var(--space-lg); }
.page-title { font-family: var(--font-heading); font-size: 22px; color: var(--text-primary); }

.profile-layout { display: grid; grid-template-columns: 240px 1fr; gap: var(--space-lg); }

.profile-sidebar {
  background: var(--bg-card); border-radius: var(--radius-lg); padding: var(--space-lg);
  box-shadow: var(--shadow-sm); height: fit-content; position: sticky; top: 88px;
}

.user-card { text-align: center; padding-bottom: var(--space-lg); border-bottom: 1px solid var(--border-color-light); margin-bottom: var(--space-md); }
.user-name { font-family: var(--font-heading); font-size: 16px; color: var(--text-primary); margin-top: var(--space-sm); margin-bottom: 2px; }
.user-role { font-size: 13px; color: var(--text-secondary); }

.profile-nav { display: flex; flex-direction: column; gap: 2px; }

.profile-nav-item {
  display: flex; align-items: center; gap: var(--space-sm); padding: 10px 12px;
  border-radius: var(--radius-md); font-size: 14px; color: var(--text-regular);
  text-decoration: none; transition: all 200ms ease; cursor: pointer;
}

.profile-nav-item:hover { background: var(--color-primary-lightest); color: var(--color-primary); }
.profile-nav-item.active { background: var(--color-primary-lightest); color: var(--color-primary); font-weight: 600; }

.profile-content {
  background: var(--bg-card); border-radius: var(--radius-lg); padding: var(--space-xl);
  box-shadow: var(--shadow-sm); min-height: 400px;
}

@media (max-width: 768px) {
  .profile-layout { grid-template-columns: 1fr; }
  .profile-sidebar { position: static; }
}
</style>
