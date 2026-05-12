import request from '@/utils/request'

/**
 * 查询请假列表
 */
export function listLeave(query) {
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
  return request({ url: '/campus/leave', method: 'post', data: data })
}

/**
 * 修改请假申请
 */
export function updateLeave(data) {
  return request({ url: '/campus/leave', method: 'put', data: data })
}

/**
 * 删除请假申请
 */
export function delLeave(leaveIds) {
  return request({ url: '/campus/leave/' + leaveIds, method: 'delete' })
}

/**
 * 审批请假
 */
export function approveLeave(data) {
  return request({ url: '/campus/leave/approve', method: 'put', data: data })
}

/**
 * 撤回请假
 */
export function revokeLeave(leaveId) {
  return request({ url: '/campus/leave/revoke/' + leaveId, method: 'put' })
}
