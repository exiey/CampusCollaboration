import { defineStore } from 'pinia'
import { login, logout, getInfo } from '@/api/auth'
import { getToken, setToken, removeToken } from '@/utils/auth'

const useUserStore = defineStore('user', {
  state: () => ({
    token: getToken(),
    nickName: '',
    avatar: '',
    roles: [],
    permissions: []
  }),
  actions: {
    /** 登录 */
    loginAction(userInfo) {
      return new Promise((resolve, reject) => {
        login(userInfo).then(res => {
          setToken(res.token)
          this.token = res.token
          resolve()
        }).catch(error => {
          reject(error)
        })
      })
    },
    /** 获取用户信息 */
    getInfoAction() {
      return new Promise((resolve, reject) => {
        getInfo().then(res => {
          const user = res.user
          this.nickName = user.nickName || ''
          this.avatar = user.avatar ? (user.avatar.startsWith('http') ? user.avatar : import.meta.env.VITE_APP_BASE_API + user.avatar) : ''
          this.roles = res.roles || []
          this.permissions = res.permissions || []
          resolve(res)
        }).catch(error => {
          reject(error)
        })
      })
    },
    /** 退出登录 */
    logoutAction() {
      return new Promise((resolve, reject) => {
        logout().then(() => {
          this.token = ''
          this.roles = []
          this.permissions = []
          this.nickName = ''
          this.avatar = ''
          removeToken()
          resolve()
        }).catch(error => {
          reject(error)
        })
      })
    },
    /** 前端登出（不调接口） */
    fedLogout() {
      this.token = ''
      this.roles = []
      this.permissions = []
      removeToken()
    }
  }
})

export default useUserStore
