<template>
  <div class="error-page">
    <div class="error-content">
      <h1 class="error-code">404</h1>
      <p class="error-message">抱歉，您访问的页面不存在</p>
      <el-button type="primary" @click="$router.push('/')">返回首页</el-button>
    </div>
  </div>
</template>

<style scoped>
.error-page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--bg-page);
}

.error-content {
  text-align: center;
}

.error-code {
  font-family: var(--font-heading);
  font-size: 96px;
  font-weight: 700;
  color: var(--color-primary-lighter);
  line-height: 1;
  margin-bottom: var(--space-md);
}

.error-message {
  font-size: 18px;
  color: var(--text-secondary);
  margin-bottom: var(--space-xl);
}
</style>
