<template>
  <div class="register-page">
    <div class="register-container">
      <div class="register-card">
        <div class="register-header">
          <router-link to="/" class="back-home">
            <el-icon :size="16"><ArrowLeft /></el-icon>
            <span>返回首页</span>
          </router-link>
          <h2 class="register-title">创建账号</h2>
          <p class="register-subtitle">注册成为校园协同工作平台用户</p>
        </div>

        <el-form ref="registerRef" :model="registerForm" :rules="registerRules" class="register-form" @submit.prevent="handleRegister">
          <el-form-item prop="username">
            <el-input v-model="registerForm.username" size="large" placeholder="请输入账号（2-20个字符）" prefix-icon="User" />
          </el-form-item>
          <el-form-item prop="password">
            <el-input v-model="registerForm.password" size="large" type="password" placeholder="请输入密码（5-20个字符）" prefix-icon="Lock" show-password />
          </el-form-item>
          <el-form-item prop="confirmPassword">
            <el-input v-model="registerForm.confirmPassword" size="large" type="password" placeholder="请再次输入密码" prefix-icon="Lock" show-password @keyup.enter="handleRegister" />
          </el-form-item>
          <el-form-item v-if="captchaEnabled" prop="code">
            <div class="captcha-row">
              <el-input v-model="registerForm.code" size="large" placeholder="请输入验证码" prefix-icon="Key" class="captcha-input" @keyup.enter="handleRegister" />
              <div class="captcha-img" @click="getCode">
                <img v-if="codeUrl" :src="codeUrl" alt="验证码" />
                <span v-else class="captcha-placeholder">加载中</span>
              </div>
            </div>
          </el-form-item>

          <el-form-item prop="agreement">
            <el-checkbox v-model="registerForm.agreement">
              我已阅读并同意
              <a href="javascript:;" class="agreement-link">服务条款</a>
              和
              <a href="javascript:;" class="agreement-link">隐私政策</a>
            </el-checkbox>
          </el-form-item>

          <el-button type="primary" size="large" class="submit-btn" :loading="loading" @click="handleRegister">
            {{ loading ? '注册中...' : '注 册' }}
          </el-button>
        </el-form>

        <div class="register-footer">
          <span>已有账号？</span>
          <router-link to="/login" class="to-login">立即登录</router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { register, getCodeImg } from '@/api/auth'
import { ArrowLeft } from '@element-plus/icons-vue'

const router = useRouter()
const registerRef = ref(null)
const loading = ref(false)
const captchaEnabled = ref(true)
const codeUrl = ref('')

const registerForm = ref({
  username: '',
  password: '',
  confirmPassword: '',
  code: '',
  uuid: '',
  agreement: false
})

const equalToPassword = (rule, value, callback) => {
  if (registerForm.value.password !== value) {
    callback(new Error('两次输入的密码不一致'))
  } else {
    callback()
  }
}

const checkAgreement = (rule, value, callback) => {
  if (!value) {
    callback(new Error('请阅读并同意服务条款'))
  } else {
    callback()
  }
}

const registerRules = {
  username: [
    { required: true, trigger: 'blur', message: '请输入您的账号' },
    { min: 2, max: 20, message: '账号长度必须介于 2 和 20 之间', trigger: 'blur' }
  ],
  password: [
    { required: true, trigger: 'blur', message: '请输入您的密码' },
    { min: 5, max: 20, message: '密码长度必须介于 5 和 20 之间', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, trigger: 'blur', message: '请再次输入您的密码' },
    { validator: equalToPassword, trigger: 'blur' }
  ],
  code: [{ required: true, trigger: 'change', message: '请输入验证码' }],
  agreement: [{ validator: checkAgreement, trigger: 'change' }]
}

function getCode() {
  getCodeImg().then(res => {
    captchaEnabled.value = res.captchaEnabled === undefined ? true : res.captchaEnabled
    if (captchaEnabled.value) {
      codeUrl.value = 'data:image/gif;base64,' + res.img
      registerForm.value.uuid = res.uuid
    }
  })
}

function handleRegister() {
  registerRef.value.validate(valid => {
    if (!valid) return
    loading.value = true
    register(registerForm.value).then(() => {
      ElMessage.success('注册成功，请登录')
      router.push('/login')
    }).catch(() => {
      loading.value = false
      if (captchaEnabled.value) getCode()
    })
  })
}

onMounted(() => {
  getCode()
})
</script>

<style scoped>
.register-page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--bg-page);
  padding: var(--space-md);
}

.register-container {
  width: 100%;
  max-width: 480px;
}

.register-card {
  background: var(--bg-card);
  border-radius: var(--radius-xl);
  padding: var(--space-2xl);
  box-shadow: var(--shadow-lg);
}

.register-header {
  margin-bottom: var(--space-xl);
}

.back-home {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  font-size: 13px;
  color: var(--text-secondary);
  text-decoration: none;
  margin-bottom: var(--space-md);
  transition: color 200ms ease;
  cursor: pointer;
}

.back-home:hover {
  color: var(--color-primary);
}

.register-title {
  font-family: var(--font-heading);
  font-size: 24px;
  color: var(--text-primary);
  margin-bottom: 4px;
}

.register-subtitle {
  font-size: 14px;
  color: var(--text-secondary);
}

.register-form :deep(.el-input__wrapper) {
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

.agreement-link {
  color: var(--color-primary);
  text-decoration: none;
}

.agreement-link:hover {
  text-decoration: underline;
}

.submit-btn {
  width: 100%;
  height: 44px;
  font-size: 15px;
  font-weight: 600;
  border-radius: var(--radius-md);
}

.register-footer {
  text-align: center;
  margin-top: var(--space-lg);
  font-size: 14px;
  color: var(--text-secondary);
}

.to-login {
  color: var(--color-primary);
  text-decoration: none;
  font-weight: 500;
  cursor: pointer;
}

.to-login:hover {
  text-decoration: underline;
}

@media (prefers-reduced-motion: reduce) {
  .back-home, .captcha-img {
    transition: none;
  }
}
</style>
