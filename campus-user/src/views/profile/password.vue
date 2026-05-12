<template>
  <div class="profile-password">
    <h3 class="section-title">修改密码</h3>
    <el-form ref="formRef" :model="form" :rules="rules" label-width="90px" style="max-width: 480px">
      <el-form-item label="旧密码" prop="oldPassword">
        <el-input v-model="form.oldPassword" type="password" placeholder="请输入旧密码" show-password />
      </el-form-item>
      <el-form-item label="新密码" prop="newPassword">
        <el-input v-model="form.newPassword" type="password" placeholder="请输入新密码" show-password />
      </el-form-item>
      <el-form-item label="确认密码" prop="confirmPassword">
        <el-input v-model="form.confirmPassword" type="password" placeholder="请再次输入新密码" show-password />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" :loading="loading" @click="submitForm">保存修改</el-button>
        <el-button @click="resetForm">重置</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { ElMessage } from 'element-plus'
import { updateUserPwd } from '@/api/profile'

const formRef = ref(null)
const loading = ref(false)
const form = ref({ oldPassword: '', newPassword: '', confirmPassword: '' })

const equalToPassword = (rule, value, callback) => {
  if (form.value.newPassword !== value) {
    callback(new Error('两次输入的密码不一致'))
  } else {
    callback()
  }
}

const rules = {
  oldPassword: [{ required: true, message: '旧密码不能为空', trigger: 'blur' }],
  newPassword: [
    { required: true, message: '新密码不能为空', trigger: 'blur' },
    { min: 5, max: 20, message: '密码长度必须介于 5 和 20 之间', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '确认密码不能为空', trigger: 'blur' },
    { validator: equalToPassword, trigger: 'blur' }
  ]
}

function submitForm() {
  formRef.value.validate(valid => {
    if (!valid) return
    loading.value = true
    updateUserPwd(form.value.oldPassword, form.value.newPassword).then(() => {
      ElMessage.success('密码修改成功')
      resetForm()
    }).finally(() => { loading.value = false })
  })
}

function resetForm() {
  form.value = { oldPassword: '', newPassword: '', confirmPassword: '' }
  formRef.value?.resetFields()
}
</script>

<style scoped>
.section-title { font-family: var(--font-heading); font-size: 17px; color: var(--text-primary); margin-bottom: var(--space-lg); }
</style>
