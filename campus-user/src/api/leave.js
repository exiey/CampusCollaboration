import request from '@/utils/request'

/**
 * 查询我的请假列表
 */
export function listMyLeave(query) {
  return request({ url: '/campus/leave/list', method: 'get', params: query })
}

/**
 * 查询请假详情
 */
export function getLeave(leaveId) {
  return request({ url: '/campus/leave/' + leaveId, method: 'get' })
}

/**
 * 新增请假申请
 */
export function addLeave(data) {
  return request({ url: '/campus/leave', method: 'post', data })
}

/**
 * 撤回请假申请
 */
export function revokeLeave(leaveId) {
  return request({ url: '/campus/leave/revoke/' + leaveId, method: 'put' })
}
