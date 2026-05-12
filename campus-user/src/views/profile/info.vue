<template>
  <div class="profile-info">
    <h3 class="section-title">基本资料</h3>
    <el-form ref="formRef" :model="form" :rules="rules" label-width="90px" style="max-width: 480px">
      <el-form-item label="用户昵称" prop="nickName">
        <el-input v-model="form.nickName" placeholder="请输入昵称" maxlength="30" />
      </el-form-item>
      <el-form-item label="手机号码" prop="phonenumber">
        <el-input v-model="form.phonenumber" placeholder="请输入手机号码" maxlength="11" />
      </el-form-item>
      <el-form-item label="邮箱" prop="email">
        <el-input v-model="form.email" placeholder="请输入邮箱" maxlength="50" />
      </el-form-item>
      <el-form-item label="性别" prop="sex">
        <el-radio-group v-model="form.sex">
          <el-radio value="0">男</el-radio>
          <el-radio value="1">女</el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" :loading="loading" @click="submitForm">保存修改</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { getUserProfile, updateUserProfile } from '@/api/profile'
import useUserStore from '@/store/user'

const userStore = useUserStore()
const formRef = ref(null)
const loading = ref(false)
const form = ref({ nickName: '', phonenumber: '', email: '', sex: '0' })

const rules = {
  nickName: [{ required: true, message: '昵称不能为空', trigger: 'blur' }],
  email: [{ type: 'email', message: '请输入正确的邮箱地址', trigger: 'blur' }],
  phonenumber: [{ pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号码', trigger: 'blur' }]
}

onMounted(() => {
  getUserProfile().then(res => {
    const user = res.data
    form.value = {
      nickName: user.nickName || '',
      phonenumber: user.phonenumber || '',
      email: user.email || '',
      sex: user.sex || '0'
    }
  })
})

function submitForm() {
  formRef.value.validate(valid => {
    if (!valid) return
    loading.value = true
    updateUserProfile(form.value).then(() => {
      ElMessage.success('修改成功')
      userStore.getInfoAction()
    }).finally(() => { loading.value = false })
  })
}
</script>

<style scoped>
.section-title { font-family: var(--font-heading); font-size: 17px; color: var(--text-primary); margin-bottom: var(--space-lg); }
</style>
