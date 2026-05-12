<template>
  <footer class="site-footer">
    <div class="footer-inner">
      <div class="footer-grid">
        <div class="footer-brand">
          <h3 class="footer-title">校园协同工作平台</h3>
          <p class="footer-desc">面向高校师生的多功能协同平台，整合任务协同、文件共享、请假审批等功能。</p>
        </div>
        <div class="footer-links">
          <h4 class="footer-heading">快速链接</h4>
          <router-link to="/home" class="footer-link">首页</router-link>
          <router-link to="/task" class="footer-link">任务中心</router-link>
          <router-link to="/file" class="footer-link">文件中心</router-link>
          <router-link to="/leave" class="footer-link">请假申请</router-link>
          <router-link to="/notice" class="footer-link">公告通知</router-link>
        </div>
        <div class="footer-contact">
          <h4 class="footer-heading">联系方式</h4>
          <p class="footer-text">
            <el-icon :size="14"><Message /></el-icon>
            <span>support@campus.edu.cn</span>
          </p>
          <p class="footer-text">
            <el-icon :size="14"><Phone /></el-icon>
            <span>0755-12345678</span>
          </p>
          <p class="footer-text">
            <el-icon :size="14"><Location /></el-icon>
            <span>广东省深圳市南山区</span>
          </p>
        </div>
      </div>
      <div class="footer-bottom">
        <span>Copyright &copy; 2024-2026 校园协同工作平台 All Rights Reserved.</span>
      </div>
    </div>
  </footer>
</template>

<script setup>
import { Message, Phone, Location } from '@element-plus/icons-vue'
</script>

<style scoped>
.site-footer {
  background: #E8ECF8;
  border-top: 1px solid var(--border-color-light);
  margin-top: auto;
}

.footer-inner {
  max-width: 1200px;
  margin: 0 auto;
  padding: var(--space-2xl) var(--space-md) var(--space-lg);
}

.footer-grid {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr;
  gap: var(--space-2xl);
  margin-bottom: var(--space-xl);
}

.footer-title {
  font-family: var(--font-heading);
  font-size: 18px;
  color: var(--text-primary);
  margin-bottom: var(--space-sm);
}

.footer-desc {
  font-size: 14px;
  color: var(--text-secondary);
  line-height: 1.6;
  max-width: 320px;
}

.footer-heading {
  font-family: var(--font-heading);
  font-size: 15px;
  color: var(--text-primary);
  margin-bottom: var(--space-md);
}

.footer-link {
  display: block;
  font-size: 14px;
  color: var(--text-regular);
  text-decoration: none;
  padding: 4px 0;
  transition: color 200ms ease;
  cursor: pointer;
}

.footer-link:hover {
  color: var(--color-primary);
}

.footer-text {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  color: var(--text-regular);
  margin-bottom: 8px;
}

.footer-bottom {
  border-top: 1px solid var(--border-color);
  padding-top: var(--space-lg);
  text-align: center;
  font-size: 13px;
  color: var(--text-secondary);
}

@media (max-width: 768px) {
  .footer-grid {
    grid-template-columns: 1fr;
    gap: var(--space-xl);
  }
}
</style>
