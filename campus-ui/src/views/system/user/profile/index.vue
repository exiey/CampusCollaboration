<template>
  <div class="profile-container">
    <!-- 顶部个人信息区 -->
    <div class="profile-header">
      <div class="header-left">
        <userAvatar />
        <div class="user-info">
          <h2 class="user-name">{{ state.user.nickName || state.user.userName }}</h2>
          <p class="user-account">@{{ state.user.userName }}</p>
        </div>
      </div>
      <div class="header-right">
        <el-tag v-if="state.roleGroup">{{ state.roleGroup }}</el-tag>
        <el-tag v-if="state.user.dept" type="info">{{ state.user.dept.deptName }}</el-tag>
      </div>
    </div>

    <!-- 主体内容区 -->
    <div class="profile-body">
      <!-- 左侧信息展示 -->
      <div class="info-panel">
        <div class="panel-section">
          <h3 class="section-title">基本信息</h3>
          <div class="info-list">
            <div class="info-row">
              <span class="label">用户名称</span>
              <span class="value">{{ state.user.userName }}</span>
            </div>
            <div class="info-row">
              <span class="label">用户昵称</span>
              <span class="value">{{ state.user.nickName || '-' }}</span>
            </div>
            <div class="info-row">
              <span class="label">性别</span>
              <span class="value">{{ state.user.sex === '0' ? '男' : state.user.sex === '1' ? '女' : '-' }}</span>
            </div>
          </div>
        </div>

        <div class="panel-section">
          <h3 class="section-title">联系方式</h3>
          <div class="info-list">
            <div class="info-row">
              <span class="label">手机号码</span>
              <span class="value">{{ state.user.phonenumber || '-' }}</span>
            </div>
            <div class="info-row">
              <span class="label">邮箱</span>
              <span class="value">{{ state.user.email || '-' }}</span>
            </div>
          </div>
        </div>

        <div class="panel-section">
          <h3 class="section-title">组织信息</h3>
          <div class="info-list">
            <div class="info-row">
              <span class="label">所属部门</span>
              <span class="value">{{ state.user.dept?.deptName || '-' }}</span>
            </div>
            <div class="info-row">
              <span class="label">岗位</span>
              <span class="value">{{ state.postGroup || '-' }}</span>
            </div>
            <div class="info-row">
              <span class="label">角色</span>
              <span class="value">{{ state.roleGroup || '-' }}</span>
            </div>
          </div>
        </div>

        <div class="panel-section">
          <h3 class="section-title">账户信息</h3>
          <div class="info-list">
            <div class="info-row">
              <span class="label">创建时间</span>
              <span class="value">{{ state.user.createTime || '-' }}</span>
            </div>
          </div>
        </div>
      </div>

      <!-- 右侧操作区 -->
      <div class="action-panel">
        <el-tabs v-model="activeTab" class="profile-tabs">
          <el-tab-pane label="基本资料" name="info">
            <userInfo :user="state.user" />
          </el-tab-pane>
          <el-tab-pane label="修改密码" name="password">
            <resetPwd />
          </el-tab-pane>
        </el-tabs>
      </div>
    </div>
  </div>
</template>

<script setup name="Profile">
import userAvatar from "./userAvatar"
import userInfo from "./userInfo"
import resetPwd from "./resetPwd"
import { getUserProfile } from "@/api/system/user"

const route = useRoute()
const activeTab = ref("info")
const state = reactive({
  user: {},
  roleGroup: '',
  postGroup: ''
})

function getUser() {
  getUserProfile().then(response => {
    state.user = response.data
    state.roleGroup = response.roleGroup
    state.postGroup = response.postGroup
  })
}

onMounted(() => {
  const activeTabParam = route.params && route.params.activeTab
  if (activeTabParam === 'resetPwd') {
    activeTab.value = 'password'
  }
  getUser()
})
</script>

<style lang="scss" scoped>
.profile-container {
  padding: 20px;
}

// 顶部区域
.profile-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  background: #fff;
  border-radius: 4px;
  margin-bottom: 16px;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.user-info {
  .user-name {
    margin: 0 0 4px;
    font-size: 18px;
    font-weight: 500;
    color: #303133;
  }
  
  .user-account {
    margin: 0;
    font-size: 13px;
    color: #909399;
  }
}

.header-right {
  display: flex;
  gap: 8px;
}

// 主体区域
.profile-body {
  display: flex;
  gap: 16px;
}

// 左侧信息面板
.info-panel {
  width: 280px;
  flex-shrink: 0;
  background: #fff;
  border-radius: 4px;
  padding: 16px;
}

.panel-section {
  padding-bottom: 14px;
  margin-bottom: 14px;
  border-bottom: 1px solid #ebeef5;
  
  &:last-child {
    padding-bottom: 0;
    margin-bottom: 0;
    border-bottom: none;
  }
}

.section-title {
  margin: 0 0 10px;
  font-size: 13px;
  font-weight: 500;
  color: #303133;
}

.info-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.info-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 13px;
  line-height: 1.5;
  
  .label {
    color: #909399;
    flex-shrink: 0;
  }
  
  .value {
    color: #606266;
    text-align: right;
    word-break: break-all;
  }
}

// 右侧操作面板
.action-panel {
  flex: 1;
  background: #fff;
  border-radius: 4px;
  padding: 16px 20px;
  min-width: 0;
}

.profile-tabs {
  :deep(.el-tabs__header) {
    margin-bottom: 16px;
  }
  
  :deep(.el-tabs__nav-wrap::after) {
    height: 1px;
  }
  
  :deep(.el-tabs__item) {
    font-size: 14px;
    height: 36px;
    line-height: 36px;
  }
}

// 响应式
@media (max-width: 768px) {
  .profile-body {
    flex-direction: column;
  }
  
  .info-panel {
    width: 100%;
  }
  
  .profile-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }
}
</style>
