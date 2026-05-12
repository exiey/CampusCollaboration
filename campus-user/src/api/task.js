import request from '@/utils/request'

/**
 * 查询我的任务列表
 */
export function listMyTask(query) {
  return request({ url: '/campus/task/list', method: 'get', params: query })
}

/**
 * 查询任务详情
 */
export function getTask(taskId) {
  return request({ url: '/campus/task/' + taskId, method: 'get' })
}

/**
 * 更新任务状态
 */
export function changeTaskStatus(data) {
  return request({ url: '/campus/task/status', method: 'put', data })
}

/**
 * 查询任务评论列表
 */
export function listTaskComment(taskId) {
  return request({ url: '/campus/task/comment/' + taskId, method: 'get' })
}

/**
 * 新增任务评论
 */
export function addTaskComment(data) {
  return request({ url: '/campus/task/comment', method: 'post', data })
}
