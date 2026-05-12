<template>
  <div class="login-page">
    <div class="login-container">
      <!-- 左侧品牌区 -->
      <div class="brand-panel">
        <div class="brand-decoration">
          <div class="deco-blob deco-blob-1"></div>
          <div class="deco-blob deco-blob-2"></div>
          <div class="deco-blob deco-blob-3"></div>
        </div>
        <div class="brand-content">
          <h1 class="brand-title">校园协同工作平台</h1>
          <p class="brand-slogan">面向高校师生的多功能协同平台</p>
          <div class="brand-features">
            <div class="feature-card">
              <el-icon :size="20" class="feature-icon"><Tickets /></el-icon>
              <div>
                <h4 class="feature-name">任务协同</h4>
                <p class="feature-desc">教师分配任务，学生实时跟进</p>
              </div>
            </div>
            <div class="feature-card">
              <el-icon :size="20" class="feature-icon"><FolderOpened /></el-icon>
              <div>
                <h4 class="feature-name">文件共享</h4>
                <p class="feature-desc">多角色权限管理，安全便捷</p>
              </div>
            </div>
            <div class="feature-card">
              <el-icon :size="20" class="feature-icon"><DocumentChecked /></el-icon>
              <div>
                <h4 class="feature-name">请假审批</h4>
                <p class="feature-desc">在线提交审批，流程透明高效</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 右侧表单区 -->
      <div class="form-panel">
        <div class="form-wrapper">
          <h2 class="form-title">欢迎登录</h2>
          <p class="form-subtitle">请输入您的账号信息</p>

          <el-form ref="loginRef" :model="loginForm" :rules="loginRules" class="login-form" @submit.prevent="handleLogin">
            <el-form-item prop="username">
              <el-input v-model="loginForm.username" size="large" placeholder="请输入账号" prefix-icon="User" />
            </el-form-item>
            <el-form-item prop="password">
              <el-input v-model="loginForm.password" size="large" type="password" placeholder="请输入密码" prefix-icon="Lock" show-password @keyup.enter="handleLogin" />
            </el-form-item>
            <el-form-item v-if="captchaEnabled" prop="code">
              <div class="captcha-row">
                <el-input v-model="loginForm.code" size="large" placeholder="请输入验证码" prefix-icon="Key" class="captcha-input" @keyup.enter="handleLogin" />
                <div class="captcha-img" @click="getCode">
                  <img v-if="codeUrl" :src="codeUrl" alt="验证码" />
                  <span v-else class="captcha-placeholder">加载中</span>
                </div>
              </div>
            </el-form-item>

            <div class="form-options">
              <el-checkbox v-model="loginForm.rememberMe">记住密码</el-checkbox>
              <router-link to="/register" class="to-register">还没有账号？立即注册</router-link>
            </div>

            <el-button type="primary" size="large" class="submit-btn" :loading="loading" @click="handleLogin">
              {{ loading ? '登录中...' : '登 录' }}
            </el-button>
          </el-form>

          <div class="form-footer">
            <span>登录即表示您同意</span>
            <a href="javascript:;">服务条款</a>
            <span>和</span>
            <a href="javascript:;">隐私政策</a>
          </div>
        </div>
      </div>
    </div>
    <div class="login-copyright">Copyright &copy; 2024-2026 校园协同工作平台 All Rights Reserved.</div>
  </div>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import Cookies from 'js-cookie'
import { getCodeImg } from '@/api/auth'
import useUserStore from '@/store/user'
import { Tickets, FolderOpened, DocumentChecked } from '@element-plus/icons-vue'

const route = useRoute()
const router = useRouter()
const userStore = useUserStore()

const loginRef = ref(null)
const loading = ref(false)
const captchaEnabled = ref(true)
const codeUrl = ref('')
const redirect = ref(undefined)

const loginForm = ref({
  username: '',
  password: '',
  rememberMe: false,
  code: '',
  uuid: ''
})

const loginRules = {
  username: [{ required: true, trigger: 'blur', message: '请输入您的账号' }],
  password: [{ required: true, trigger: 'blur', message: '请输入您的密码' }],
  code: [{ required: true, trigger: 'change', message: '请输入验证码' }]
}

watch(route, (newRoute) => {
  redirect.value = newRoute.query && newRoute.query.redirect
}, { immediate: true })

function getCode() {
  getCodeImg().then(res => {
    captchaEnabled.value = res.captchaEnabled === undefined ? true : res.captchaEnabled
    if (captchaEnabled.value) {
      codeUrl.value = 'data:image/gif;base64,' + res.img
      loginForm.value.uuid = res.uuid
    }
  })
}

function handleLogin() {
  loginRef.value.validate(valid => {
    if (!valid) return
    loading.value = true
    if (loginForm.value.rememberMe) {
      Cookies.set('campus-username', loginForm.value.username, { expires: 30 })
      Cookies.set('campus-remember', loginForm.value.rememberMe, { expires: 30 })
    } else {
      Cookies.remove('campus-username')
      Cookies.remove('campus-remember')
    }
    userStore.loginAction(loginForm.value).then(() => {
      router.push(redirect.value || '/')
    }).catch(() => {
      loading.value = false
      if (captchaEnabled.value) getCode()
    })
  })
}

function getCookie() {
  const username = Cookies.get('campus-username')
  const rememberMe = Cookies.get('campus-remember')
  loginForm.value.username = username || ''
  loginForm.value.rememberMe = rememberMe ? Boolean(rememberMe) : false
}

onMounted(() => {
  getCode()
  getCookie()
})
</script>

<style scoped>
.login-page {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: var(--bg-page);
  padding: var(--space-md);
}

.login-copyright {
  position: fixed;
  bottom: 0;
  left: 0;
  padding: 16px 24px;
  font-size: 13px;
  color: var(--text-secondary);
}

.login-container {
  display: flex;
  width: 100%;
  max-width: 960px;
  min-height: 580px;
  border-radius: var(--radius-xl);
  overflow: hidden;
  box-shadow: var(--shadow-xl);
  background: var(--bg-card);
}

.brand-panel {
  flex: 1.2;
  background: linear-gradient(135deg, var(--color-primary-lightest) 0%, #DDD6FE 50%, #C7D2FE 100%);
  padding: var(--space-2xl);
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  overflow: hidden;
}

.brand-decoration {
  position: absolute;
  inset: 0;
  pointer-events: none;
}

.deco-blob {
  position: absolute;
  border-radius: 50%;
}

.deco-blob-1 {
  width: 300px;
  height: 300px;
  top: -80px;
  right: -60px;
  background: radial-gradient(circle, rgba(79, 70, 229, 0.08) 0%, transparent 70%);
}

.deco-blob-2 {
  width: 200px;
  height: 200px;
  bottom: 40px;
  left: -40px;
  background: radial-gradient(circle, rgba(34, 197, 94, 0.06) 0%, transparent 70%);
}

.deco-blob-3 {
  width: 120px;
  height: 120px;
  top: 50%;
  right: 20%;
  background: radial-gradient(circle, rgba(245, 158, 11, 0.08) 0%, transparent 70%);
}

.brand-content {
  position: relative;
  z-index: 1;
}

.brand-title {
  font-family: var(--font-heading);
  font-size: 28px;
  font-weight: 700;
  color: var(--color-primary);
  margin-bottom: 8px;
}

.brand-slogan {
  font-size: 15px;
  color: var(--text-regular);
  margin-bottom: var(--space-xl);
}

.brand-features {
  display: flex;
  flex-direction: column;
  gap: var(--space-md);
}

.feature-card {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  padding: 14px 16px;
  background: rgba(255, 255, 255, 0.65);
  border-radius: var(--radius-md);
  backdrop-filter: blur(8px);
  transition: all 200ms ease;
}

.feature-card:hover {
  background: rgba(255, 255, 255, 0.85);
  transform: translateX(4px);
}

.feature-icon {
  color: var(--color-primary);
  flex-shrink: 0;
  margin-top: 2px;
}

.feature-name {
  font-size: 14px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 2px;
}

.feature-desc {
  font-size: 13px;
  color: var(--text-secondary);
  margin: 0;
}

.form-panel {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: var(--space-2xl);
}

.form-wrapper {
  width: 100%;
  max-width: 360px;
}

.form-title {
  font-family: var(--font-heading);
  font-size: 24px;
  color: var(--text-primary);
  margin-bottom: 4px;
}

.form-subtitle {
  font-size: 14px;
  color: var(--text-secondary);
  margin-bottom: var(--space-xl);
}

.login-form :deep(.el-input__wrapper) {
  height: 44px;
  border-radius: var(--radius-md);
}

.captcha-row {
  display: flex;
  gap: 12px;
  width: 100%;
}

.captcha-input {
  flex: 1;
}

.captcha-img {
  width: 120px;
  height: 44px;
  border-radius: var(--radius-md);
  overflow: hidden;
  cursor: pointer;
  border: 1px solid var(--border-color);
  background: var(--bg-section);
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: border-color 200ms ease;
}

.captcha-img:hover {
  border-color: var(--color-primary-light);
}

.captcha-img img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.captcha-placeholder {
  font-size: 12px;
  color: var(--text-secondary);
}

.form-options {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: var(--space-lg);
}

.to-register {
  font-size: 13px;
  color: var(--color-primary);
  text-decoration: none;
  cursor: pointer;
}

.to-register:hover {
  text-decoration: underline;
}

.submit-btn {
  width: 100%;
  height: 44px;
  font-size: 15px;
  font-weight: 600;
  border-radius: var(--radius-md);
}

.form-footer {
  text-align: center;
  margin-top: var(--space-lg);
  font-size: 12px;
  color: var(--text-secondary);
}

.form-footer a {
  color: var(--text-regular);
  text-decoration: none;
  margin: 0 2px;
}

.form-footer a:hover {
  color: var(--color-primary);
  text-decoration: underline;
}

@media (max-width: 768px) {
  .login-container {
    flex-direction: column;
    max-width: 440px;
  }

  .brand-panel {
    padding: var(--space-xl);
  }

  .brand-features {
    display: none;
  }

  .form-panel {
    padding: var(--space-xl);
  }
}

@media (prefers-reduced-motion: reduce) {
  .feature-card {
    transition: none;
  }
}
</style>
