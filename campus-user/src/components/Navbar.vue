<template>
  <header class="navbar" :class="{ 'navbar-scrolled': isScrolled }">
    <div class="navbar-inner">
      <router-link to="/" class="navbar-brand">
        <el-icon :size="24" class="brand-icon"><School /></el-icon>
        <span class="brand-text">校园协同工作平台</span>
      </router-link>

      <nav class="navbar-nav" v-if="!isMobile">
        <router-link v-for="item in navItems" :key="item.path" :to="item.path" class="nav-link" active-class="nav-link-active">
          <el-icon :size="16"><component :is="item.icon" /></el-icon>
          <span>{{ item.label }}</span>
        </router-link>
      </nav>

      <div class="navbar-actions">
        <template v-if="isLoggedIn">
          <el-dropdown trigger="hover" @command="handleCommand">
            <div class="user-trigger">
              <el-avatar :size="32" :src="userStore.avatar || undefined">
                <el-icon :size="16"><User /></el-icon>
              </el-avatar>
              <span class="user-name">{{ userStore.nickName }}</span>
              <el-icon :size="12"><ArrowDown /></el-icon>
            </div>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item command="profile" :icon="UserFilled">个人中心</el-dropdown-item>
                <el-dropdown-item command="password" :icon="Lock">修改密码</el-dropdown-item>
                <el-dropdown-item divided command="logout" :icon="SwitchButton">退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </template>
        <template v-else>
          <router-link to="/login" class="auth-link login-link">登录</router-link>
          <router-link to="/register" class="auth-link register-link">注册</router-link>
        </template>

        <el-icon v-if="isMobile" class="mobile-menu-btn" :size="24" @click="mobileMenuOpen = !mobileMenuOpen">
          <Fold v-if="mobileMenuOpen" />
          <Expand v-else />
        </el-icon>
      </div>
    </div>

    <transition name="slide-down">
      <div v-if="isMobile && mobileMenuOpen" class="mobile-menu">
        <router-link v-for="item in navItems" :key="item.path" :to="item.path" class="mobile-nav-link" @click="mobileMenuOpen = false">
          <el-icon :size="18"><component :is="item.icon" /></el-icon>
          <span>{{ item.label }}</span>
        </router-link>
      </div>
    </transition>
  </header>
</template>

<script setup>
import { ref, computed, onMounted, onBeforeUnmount } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessageBox } from 'element-plus'
import { User, ArrowDown, UserFilled, Lock, SwitchButton, Fold, Expand, House, Tickets, FolderOpened, DocumentChecked, Bell } from '@element-plus/icons-vue'
import useUserStore from '@/store/user'

const School = House

const router = useRouter()
const userStore = useUserStore()

const isLoggedIn = computed(() => !!userStore.token)
const isScrolled = ref(false)
const isMobile = ref(false)
const mobileMenuOpen = ref(false)

const navItems = [
  { path: '/home', label: '首页', icon: House },
  { path: '/task', label: '任务中心', icon: Tickets },
  { path: '/file', label: '文件中心', icon: FolderOpened },
  { path: '/leave', label: '请假申请', icon: DocumentChecked },
  { path: '/notice', label: '公告通知', icon: Bell }
]

function handleCommand(command) {
  switch (command) {
    case 'profile':
      router.push('/profile/info')
      break
    case 'password':
      router.push('/profile/password')
      break
    case 'logout':
      ElMessageBox.confirm('确定退出登录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        userStore.logoutAction().then(() => {
          router.push('/login')
        })
      }).catch(() => {})
      break
  }
}

function handleScroll() {
  isScrolled.value = window.scrollY > 10
}

function handleResize() {
  isMobile.value = window.innerWidth < 768
  if (!isMobile.value) mobileMenuOpen.value = false
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
  window.addEventListener('resize', handleResize)
  handleResize()
})

onBeforeUnmount(() => {
  window.removeEventListener('scroll', handleScroll)
  window.removeEventListener('resize', handleResize)
})
</script>

<style scoped>
.navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1000;
  background: rgba(255, 255, 255, 0.92);
  backdrop-filter: blur(12px);
  border-bottom: 1px solid var(--border-color-light);
  transition: all 200ms ease;
}

.navbar-scrolled {
  box-shadow: var(--shadow-sm);
}

.navbar-inner {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 64px;
  padding: 0 var(--space-md);
}

.navbar-brand {
  display: flex;
  align-items: center;
  gap: var(--space-sm);
  text-decoration: none;
  cursor: pointer;
}

.brand-icon {
  color: var(--color-primary);
}

.brand-text {
  font-family: var(--font-heading);
  font-size: 18px;
  font-weight: 600;
  color: var(--text-primary);
}

.navbar-nav {
  display: flex;
  align-items: center;
  gap: var(--space-xs);
}

.nav-link {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 8px 14px;
  border-radius: var(--radius-md);
  font-size: 14px;
  font-weight: 500;
  color: var(--text-regular);
  text-decoration: none;
  transition: all 200ms ease;
  cursor: pointer;
}

.nav-link:hover {
  color: var(--color-primary);
  background: var(--color-primary-lightest);
}

.nav-link-active {
  color: var(--color-primary);
  background: var(--color-primary-lightest);
  font-weight: 600;
}

.navbar-actions {
  display: flex;
  align-items: center;
  gap: var(--space-sm);
}

.user-trigger {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 4px 8px;
  border-radius: var(--radius-md);
  cursor: pointer;
  transition: background 200ms ease;
}

.user-trigger:hover {
  background: var(--bg-card-hover);
}

.user-name {
  font-size: 14px;
  font-weight: 500;
  color: var(--text-primary);
  max-width: 100px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.auth-link {
  display: inline-flex;
  align-items: center;
  padding: 8px 20px;
  border-radius: var(--radius-md);
  font-size: 14px;
  font-weight: 500;
  text-decoration: none;
  transition: all 200ms ease;
  cursor: pointer;
}

.login-link {
  color: var(--color-primary);
}

.login-link:hover {
  background: var(--color-primary-lightest);
}

.register-link {
  background: var(--color-primary);
  color: #FFFFFF;
}

.register-link:hover {
  background: var(--color-primary-dark);
}

.mobile-menu-btn {
  cursor: pointer;
  color: var(--text-regular);
  padding: 4px;
}

.mobile-menu {
  background: rgba(255, 255, 255, 0.98);
  border-top: 1px solid var(--border-color-light);
  padding: var(--space-sm) var(--space-md);
}

.mobile-nav-link {
  display: flex;
  align-items: center;
  gap: var(--space-sm);
  padding: 12px var(--space-md);
  border-radius: var(--radius-md);
  font-size: 15px;
  color: var(--text-regular);
  text-decoration: none;
  transition: all 200ms ease;
}

.mobile-nav-link:hover {
  background: var(--color-primary-lightest);
  color: var(--color-primary);
}

.slide-down-enter-active,
.slide-down-leave-active {
  transition: all 200ms ease;
}

.slide-down-enter-from,
.slide-down-leave-to {
  opacity: 0;
  transform: translateY(-8px);
}

@media (max-width: 768px) {
  .navbar-inner {
    height: 56px;
  }

  .brand-text {
    font-size: 16px;
  }
}
</style>
