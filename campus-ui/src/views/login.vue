<template>
  <div class="login-container">
    <!-- 左侧品牌区域 -->
    <div class="brand-section">
      <div class="brand-content">
        <div class="brand-decoration">
          <div class="deco-circle deco-circle-1"></div>
          <div class="deco-circle deco-circle-2"></div>
          <div class="deco-circle deco-circle-3"></div>
          <div class="deco-dots">
            <span v-for="i in 12" :key="i" class="dot"></span>
          </div>
        </div>
        <h1 class="brand-title">{{ title }}</h1>
        <p class="brand-subtitle">面向高校师生的多功能协同平台</p>
        <div class="brand-divider"></div>
        <div class="brand-features">
          <div class="feature-item">
            <el-icon class="feature-icon" :size="18"><Connection /></el-icon>
            <span class="feature-text">任务协同 - 教师分配任务，学生实时跟进</span>
          </div>
          <div class="feature-item">
            <el-icon class="feature-icon" :size="18"><FolderOpened /></el-icon>
            <span class="feature-text">文件共享 - 多角色权限管理，安全便捷</span>
          </div>
          <div class="feature-item">
            <el-icon class="feature-icon" :size="18"><DocumentChecked /></el-icon>
            <span class="feature-text">请假审批 - 在线提交审批，流程透明高效</span>
          </div>
        </div>
      </div>
      <div class="brand-footer">
        <span>Copyright &copy; 2024-2026 校园协同工作平台 All Rights Reserved.</span>
      </div>
    </div>

    <!-- 右侧登录区域 -->
    <div class="login-section">
      <div class="login-wrapper">
        <div class="login-header">
          <h2 class="login-title">欢迎登录</h2>
          <p class="login-desc">请输入您的账号信息</p>
        </div>

        <el-form ref="loginRef" :model="loginForm" :rules="loginRules" class="login-form">
          <el-form-item prop="username">
            <label class="form-label">账号</label>
            <el-input
              v-model="loginForm.username"
              type="text"
              size="large"
              auto-complete="off"
              placeholder="请输入账号"
              class="custom-input"
            >
              <template #prefix>
                <el-icon><User /></el-icon>
              </template>
            </el-input>
          </el-form-item>

          <el-form-item prop="password">
            <label class="form-label">密码</label>
            <el-input
              v-model="loginForm.password"
              type="password"
              size="large"
              auto-complete="off"
              placeholder="请输入密码"
              show-password
              class="custom-input"
              @keyup.enter="handleLogin"
            >
              <template #prefix>
                <el-icon><Lock /></el-icon>
              </template>
            </el-input>
          </el-form-item>

          <el-form-item prop="code" v-if="captchaEnabled">
            <label class="form-label">验证码</label>
            <div class="captcha-row">
              <el-input
                v-model="loginForm.code"
                size="large"
                auto-complete="off"
                placeholder="请输入验证码"
                class="custom-input captcha-input"
                @keyup.enter="handleLogin"
              >
                <template #prefix>
                  <el-icon><Key /></el-icon>
                </template>
              </el-input>
              <div class="captcha-img" @click="getCode">
                <img :src="codeUrl" alt="验证码" />
              </div>
            </div>
          </el-form-item>

          <div class="form-options">
            <el-checkbox v-model="loginForm.rememberMe">记住密码</el-checkbox>
            <router-link v-if="register" class="register-link" :to="'/register'">
              立即注册
            </router-link>
          </div>

          <el-form-item class="login-btn-wrapper">
            <el-button
              :loading="loading"
              size="large"
              class="login-btn"
              @click.prevent="handleLogin"
            >
              {{ loading ? '登录中...' : '登 录' }}
            </el-button>
          </el-form-item>
        </el-form>

        <div class="login-footer">
          <span class="footer-text">登录即表示您同意</span>
          <a href="javascript:;" class="footer-link">服务条款</a>
          <span class="footer-text">和</span>
          <a href="javascript:;" class="footer-link">隐私政策</a>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { getCodeImg } from "@/api/login"
import Cookies from "js-cookie"
import { encrypt, decrypt } from "@/utils/jsencrypt"
import useUserStore from '@/store/modules/user'
import { Connection, FolderOpened, DocumentChecked, User, Lock, Key } from '@element-plus/icons-vue'

const title = import.meta.env.VITE_APP_TITLE
const userStore = useUserStore()
const route = useRoute()
const router = useRouter()
const { proxy } = getCurrentInstance()

const loginForm = ref({
  username: "admin",
  password: "admin123",
  rememberMe: false,
  code: "",
  uuid: ""
})

const loginRules = {
  username: [{ required: true, trigger: "blur", message: "请输入您的账号" }],
  password: [{ required: true, trigger: "blur", message: "请输入您的密码" }],
  code: [{ required: true, trigger: "change", message: "请输入验证码" }]
}

const codeUrl = ref("")
const loading = ref(false)
const captchaEnabled = ref(true)
const register = ref(true)
const redirect = ref(undefined)

watch(route, (newRoute) => {
  redirect.value = newRoute.query && newRoute.query.redirect
}, { immediate: true })

function handleLogin() {
  proxy.$refs.loginRef.validate(valid => {
    if (valid) {
      loading.value = true
      if (loginForm.value.rememberMe) {
        Cookies.set("username", loginForm.value.username, { expires: 30 })
        Cookies.set("password", encrypt(loginForm.value.password), { expires: 30 })
        Cookies.set("rememberMe", loginForm.value.rememberMe, { expires: 30 })
      } else {
        Cookies.remove("username")
        Cookies.remove("password")
        Cookies.remove("rememberMe")
      }
      userStore.login(loginForm.value).then(() => {
        const query = route.query
        const otherQueryParams = Object.keys(query).reduce((acc, cur) => {
          if (cur !== "redirect") {
            acc[cur] = query[cur]
          }
          return acc
        }, {})
        router.push({ path: redirect.value || "/", query: otherQueryParams })
      }).catch(() => {
        loading.value = false
        if (captchaEnabled.value) {
          getCode()
        }
      })
    }
  })
}

function getCode() {
  getCodeImg().then(res => {
    captchaEnabled.value = res.captchaEnabled === undefined ? true : res.captchaEnabled
    if (captchaEnabled.value) {
      codeUrl.value = "data:image/gif;base64," + res.img
      loginForm.value.uuid = res.uuid
    }
  })
}

function getCookie() {
  const username = Cookies.get("username")
  const password = Cookies.get("password")
  const rememberMe = Cookies.get("rememberMe")
  loginForm.value = {
    username: username === undefined ? loginForm.value.username : username,
    password: password === undefined ? loginForm.value.password : decrypt(password),
    rememberMe: rememberMe === undefined ? false : Boolean(rememberMe)
  }
}

getCode()
getCookie()
</script>

<style lang="scss" scoped>
.login-container {
  display: flex;
  min-height: 100vh;
  background: var(--bg-page, #F8FAFC);
}

/* 左侧品牌区域 - 亮色主题 */
.brand-section {
  flex: 1.5;
  background: linear-gradient(135deg, #EFF6FF 0%, #DBEAFE 50%, #E0E7FF 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 80px;
  position: relative;
  overflow: hidden;
}

.brand-decoration {
  position: absolute;
  inset: 0;
  pointer-events: none;
}

.deco-circle {
  position: absolute;
  border-radius: 50%;
  border: 1px solid rgba(30, 64, 175, 0.08);
}

.deco-circle-1 {
  width: 400px;
  height: 400px;
  top: -100px;
  right: -80px;
  background: radial-gradient(circle, rgba(30, 64, 175, 0.04) 0%, transparent 70%);
}

.deco-circle-2 {
  width: 260px;
  height: 260px;
  bottom: 60px;
  left: -60px;
  background: radial-gradient(circle, rgba(59, 130, 246, 0.05) 0%, transparent 70%);
}

.deco-circle-3 {
  width: 160px;
  height: 160px;
  top: 40%;
  right: 15%;
  background: radial-gradient(circle, rgba(245, 158, 11, 0.06) 0%, transparent 70%);
}

.deco-dots {
  position: absolute;
  top: 60px;
  left: 60px;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 12px;
}

.dot {
  width: 4px;
  height: 4px;
  border-radius: 50%;
  background: rgba(30, 64, 175, 0.12);
}

.brand-content {
  max-width: 520px;
  position: relative;
  z-index: 1;
}

.brand-title {
  font-family: var(--font-heading, 'Fira Code', monospace);
  font-size: 36px;
  font-weight: 700;
  color: var(--el-color-primary, #1E40AF);
  margin: 0 0 12px 0;
  letter-spacing: 1px;
}

.brand-subtitle {
  font-size: 16px;
  color: var(--text-regular, #4E5969);
  margin: 0 0 32px 0;
  font-weight: 400;
  line-height: 1.6;
}

.brand-divider {
  width: 48px;
  height: 3px;
  background: var(--el-color-primary, #1E40AF);
  border-radius: 2px;
  margin-bottom: 32px;
  opacity: 0.6;
}

.brand-features {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.feature-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px 16px;
  background: rgba(255, 255, 255, 0.6);
  border-radius: var(--radius-md, 8px);
  backdrop-filter: blur(8px);
  transition: all 200ms ease;
}

.feature-item:hover {
  background: rgba(255, 255, 255, 0.85);
  transform: translateX(4px);
}

.feature-icon {
  color: var(--el-color-primary, #1E40AF);
  flex-shrink: 0;
}

.feature-text {
  font-size: 14px;
  color: var(--text-primary, #1E3A8A);
  line-height: 1.5;
}

.brand-footer {
  position: absolute;
  bottom: 24px;
  left: 32px;
  color: var(--text-secondary, #86909C);
  font-size: 12px;
}

/* 右侧登录区域 */
.login-section {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 60px;
  background: #FFFFFF;
}

.login-wrapper {
  width: 100%;
  max-width: 380px;
}

.login-header {
  margin-bottom: 36px;
}

.login-title {
  font-family: var(--font-heading, 'Fira Code', monospace);
  font-size: 24px;
  font-weight: 600;
  color: var(--text-primary, #1E3A8A);
  margin: 0 0 8px 0;
}

.login-desc {
  font-size: 14px;
  color: var(--text-secondary, #86909C);
  margin: 0;
}

.login-form {
  :deep(.el-form-item) {
    margin-bottom: 20px;
  }

  :deep(.el-form-item__error) {
    padding-top: 4px;
    font-size: 12px;
  }
}

.form-label {
  display: block;
  font-size: 13px;
  font-weight: 500;
  color: var(--text-primary, #1E3A8A);
  margin-bottom: 8px;
}

.custom-input {
  :deep(.el-input__wrapper) {
    padding: 0 14px;
    height: 44px;
    border-radius: var(--radius-md, 8px);
    box-shadow: none;
    border: 1px solid var(--border-color, #E2E8F0);
    background: #FFFFFF;
    transition: all 200ms ease;

    &:hover {
      border-color: var(--el-color-primary-light-5, #6E8BD4);
    }

    &.is-focus {
      border-color: var(--el-color-primary, #1E40AF);
      box-shadow: 0 0 0 3px rgba(30, 64, 175, 0.08);
    }
  }

  :deep(.el-input__inner) {
    height: 44px;
    font-size: 14px;
    color: var(--text-primary, #1E3A8A);

    &::placeholder {
      color: var(--text-placeholder, #C9CDD4);
    }
  }

  :deep(.el-input__prefix) {
    color: var(--text-secondary, #86909C);
  }
}

.captcha-row {
  display: flex;
  gap: 12px;
}

.captcha-input {
  flex: 1;
}

.captcha-img {
  width: 110px;
  height: 44px;
  border-radius: var(--radius-md, 8px);
  overflow: hidden;
  cursor: pointer;
  border: 1px solid var(--border-color, #E2E8F0);
  background: #FAFBFC;
  flex-shrink: 0;
  transition: all 200ms ease;

  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  &:hover {
    border-color: var(--el-color-primary-light-5, #6E8BD4);
  }
}

.form-options {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;

  :deep(.el-checkbox__label) {
    color: var(--text-regular, #4E5969);
    font-size: 13px;
  }

  :deep(.el-checkbox__input.is-checked .el-checkbox__inner) {
    background-color: var(--el-color-primary, #1E40AF);
    border-color: var(--el-color-primary, #1E40AF);
  }

  :deep(.el-checkbox__input.is-checked + .el-checkbox__label) {
    color: var(--el-color-primary, #1E40AF);
  }
}

.register-link {
  font-size: 13px;
  color: var(--el-color-primary, #1E40AF);
  text-decoration: none;
  transition: opacity 200ms ease;

  &:hover {
    opacity: 0.8;
    text-decoration: underline;
  }
}

.login-btn-wrapper {
  margin-bottom: 20px;

  :deep(.el-form-item__content) {
    width: 100%;
  }
}

.login-btn {
  width: 100%;
  height: 44px;
  font-size: 15px;
  font-weight: 600;
  border-radius: var(--radius-md, 8px);
  background: var(--el-color-primary, #1E40AF);
  border-color: var(--el-color-primary, #1E40AF);
  color: #FFFFFF;
  transition: all 200ms ease;

  &:hover {
    background: var(--el-color-primary-light-3, #4B6BC4);
    border-color: var(--el-color-primary-light-3, #4B6BC4);
  }

  &:active {
    background: var(--el-color-primary-dark-2, #18338C);
    border-color: var(--el-color-primary-dark-2, #18338C);
  }
}

.login-footer {
  text-align: center;
  font-size: 12px;
}

.footer-text {
  color: var(--text-secondary, #86909C);
}

.footer-link {
  color: var(--text-regular, #4E5969);
  text-decoration: none;
  margin: 0 2px;
  transition: color 200ms ease;

  &:hover {
    color: var(--el-color-primary, #1E40AF);
    text-decoration: underline;
  }
}

/* 响应式适配 */
@media (max-width: 1024px) {
  .brand-section {
    display: none;
  }

  .login-section {
    flex: 1;
  }
}

@media (max-width: 480px) {
  .login-section {
    padding: 40px 24px;
  }

  .login-title {
    font-size: 22px;
  }
}

/* 无障碍：减少动画 */
@media (prefers-reduced-motion: reduce) {
  .feature-item,
  .captcha-img,
  .login-btn,
  .custom-input :deep(.el-input__wrapper) {
    transition: none;
  }
}
</style>
