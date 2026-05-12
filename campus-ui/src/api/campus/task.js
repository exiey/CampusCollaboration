import request from '@/utils/request'

/**
 * 查询任务列表
 */
export function listTask(query) {
  return request({ url: '/campus/task/list', method: 'get', params: query })
}

/**
 * 查询任务详情
 */
export function getTask(taskId) {
  return request({ url: '/campus/task/' + taskId, method: 'get' })
}

/**
 * 新增任务
 */
export function addTask(data) {
  return request({ url: '/campus/task', method: 'post', data: data })
}

/**
 * 修改任务
 */
export function updateTask(data) {
  return request({ url: '/campus/task', method: 'put', data: data })
}

/**
 * 删除任务
 */
export function delTask(taskIds) {
  return request({ url: '/campus/task/' + taskIds, method: 'delete' })
}

/**
 * 更新任务状态
 */
export function changeTaskStatus(data) {
  return request({ url: '/campus/task/status', method: 'put', data: data })
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
  return request({ url: '/campus/task/comment', method: 'post', data: data })
}

/**
 * 删除任务评论
 */
export function delTaskComment(commentId) {
  return request({ url: '/campus/task/comment/' + commentId, method: 'delete' })
}
