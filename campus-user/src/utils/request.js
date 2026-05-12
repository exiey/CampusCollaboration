import axios from 'axios'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getToken } from '@/utils/auth'
import router from '@/router'

const service = axios.create({
  baseURL: import.meta.env.VITE_APP_BASE_API,
  timeout: 10000
})

service.interceptors.request.use(
  config => {
    const token = getToken()
    if (token) {
      config.headers['Authorization'] = 'Bearer ' + token
    }
    return config
  },
  error => {
    return Promise.reject(error)
  }
)

service.interceptors.response.use(
  res => {
    const code = res.data.code || 200
    const msg = res.data.msg || '系统错误'
    if (code === 401) {
      ElMessageBox.confirm('登录状态已过期，请重新登录', '系统提示', {
        confirmButtonText: '重新登录',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        router.push('/login')
      }).catch(() => {})
      return Promise.reject(new Error('无效的会话'))
    } else if (code === 500) {
      ElMessage({ message: msg, type: 'error' })
      return Promise.reject(new Error(msg))
    } else if (code !== 200) {
      ElMessage({ message: msg, type: 'error' })
      return Promise.reject(new Error(msg))
    } else {
      return res.data
    }
  },
  error => {
    let message = error.message
    if (message === 'Network Error') {
      message = '网络连接异常，请检查网络'
    } else if (message.includes('timeout')) {
      message = '请求超时，请稍后重试'
    }
    ElMessage({ message: message, type: 'error', duration: 5000 })
    return Promise.reject(error)
  }
)

export default service
