import request from '@/utils/request'

/**
 * 获取管理员仪表盘数据
 */
export function getAdminDashboard() {
  return request({ url: '/campus/dashboard/admin', method: 'get' })
}

/**
 * 获取教师仪表盘数据
 */
export function getTeacherDashboard() {
  return request({ url: '/campus/dashboard/teacher', method: 'get' })
}
