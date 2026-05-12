import request from '@/utils/request'

/**
 * 查询文件列表
 */
export function listFile(query) {
  return request({ url: '/campus/file/list', method: 'get', params: query })
}

/**
 * 查询文件详情
 */
export function getFile(fileId) {
  return request({ url: '/campus/file/' + fileId, method: 'get' })
}

/**
 * 新增共享文件
 */
export function addFile(data) {
  return request({ url: '/campus/file', method: 'post', data: data })
}

/**
 * 修改共享文件
 */
export function updateFile(data) {
  return request({ url: '/campus/file', method: 'put', data: data })
}

/**
 * 删除共享文件
 */
export function delFile(fileIds) {
  return request({ url: '/campus/file/' + fileIds, method: 'delete' })
}

/**
 * 下载文件（增加下载计数）
 */
export function downloadFile(fileId) {
  return request({ url: '/campus/file/download/' + fileId, method: 'put' })
}
