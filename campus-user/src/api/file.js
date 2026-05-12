import request from '@/utils/request'

/**
 * 查询文件列表
 */
export function listFile(query) {
  return request({ url: '/campus/file/list', method: 'get', params: query })
}

/**
 * 下载文件（增加下载计数）
 */
export function downloadFile(fileId) {
  return request({ url: '/campus/file/download/' + fileId, method: 'put' })
}

/**
 * 新增共享文件
 */
export function addFile(data) {
  return request({ url: '/campus/file', method: 'post', data })
}
