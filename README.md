# CampusCollaboration - 校园协作平台
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 项目介绍
CampusCollaboration 是基于 RuoYi 开源框架开发的**校园场景专属协作管理平台**，采用「Java 后端 + 前端（Vite 构建）」的前后端架构，聚焦校园内学生团队、社团、班级的协作需求，提供任务管理、项目协作、资源共享、成员管理等核心能力，适配校园活动策划、课程作业协作、组队招募等高频场景。

## 项目结构说明
```
CampusCollaboration/
├── LICENSE                # 项目许可证（MIT）
├── pom.xml                # 后端根Maven配置
├── campus-quartz/         # 定时任务模块（Quartz）
├── campus-common/         # 通用工具/常量/异常处理模块
├── campus-framework/      # 核心框架（基础配置、安全认证等）
├── campus-admin/          # 系统管理模块（权限、菜单、字典等）
├── campus-user/           # 用户业务模块（后端）+ 前端子模块
├── campus-system/         # 核心业务模块（项目、任务、资源等）
├── campus-ui/             # 前端主工程（Vite构建）
│   ├── vite.config.js     # 前端构建配置
│   ├── package.json       # 前端依赖
│   └── .env.*             # 前端多环境配置
├── sql/                   # 数据库脚本
├── logs/                  # 日志目录
└── uploadPath/            # 文件上传目录
```

## 环境要求
### 后端环境
- JDK 8+（推荐 JDK 8 / 11）
- Maven 3.6+
- MySQL 5.7+ / 8.0+（推荐 8.0）
- Redis 5.0+（可选，用于缓存/会话）

### 前端环境
- Node.js 16+（推荐 16/18）
- npm 8+ / yarn 1.22+ / pnpm 7+

### 可选工具
- Git（版本控制）
- IDEA/Eclipse（后端开发）
- VS Code（前端开发）
- Docker/Docker Compose（容器化部署）
- Nginx（前端静态资源部署/反向代理）

## 部署步骤
### 1. 克隆仓库
```bash
git clone https://github.com/exiey/CampusCollaboration.git
cd CampusCollaboration
```

### 2. 后端部署
#### 2.1 数据库初始化
1. 新建 MySQL 数据库（例：`campus_collab`）；
2. 执行项目根目录 `sql/` 下的数据库脚本（先执行建库脚本，再执行表/数据脚本）；
3. 修改后端模块的数据库配置（核心配置文件路径：`campus-admin/src/main/resources/application-druid.yml`）：
   ```yaml
   spring:
     datasource:
       druid:
         master:
           url: jdbc:mysql://localhost:3306/campus_collab?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8
           username: root  # 你的MySQL账号
           password: 123456  # 你的MySQL密码
   ```

#### 2.2 编译 & 启动后端
```bash
# 进入项目根目录，编译后端代码
mvn clean package -DskipTests

# 启动后端（以 campus-admin 为例，或启动聚合包）
cd campus-admin/target
java -jar campus-admin.jar
# 或指定配置文件启动
java -jar campus-admin.jar --spring.profiles.active=prod
```

### 3. 前端部署
#### 3.1 安装依赖
```bash
cd campus-ui
# 使用npm
npm install
# 或yarn
yarn install
# 或pnpm
pnpm install
```

#### 3.2 配置前端接口地址
修改 `campus-ui/.env.development`（开发环境）/ `.env.production`（生产环境）：
```env
# 后端接口基础路径
VITE_APP_BASE_API = '/prod-api'  # 生产环境
# VITE_APP_BASE_API = '/dev-api'  # 开发环境
# 后端服务地址（若跨域需配置）
VITE_APP_API_URL = 'http://localhost:8080'
```

#### 3.3 启动/打包前端
```bash
# 开发环境启动
npm run dev
# 生产环境打包
npm run build

# 打包后，将 dist/ 目录部署到 Nginx 或静态服务器
```

### 4. 访问系统
- 后端服务默认端口：`8080`（可在 `application.yml` 中修改）；
- 前端开发环境访问：`http://localhost:5173`（Vite 默认端口）；
- 生产环境：部署前端打包后的 `dist` 目录到 Nginx，配置反向代理指向后端接口。

## 使用方法
### 1. 基础登录
- 初始管理员账号：`admin`，密码：`admin123`（可在数据库 `sys_user` 表修改）；
- 普通用户需先注册（或由管理员创建账号），注册后使用账号密码登录系统。

### 2. 核心功能操作
#### 2.1 项目管理
1. 登录后进入「项目管理」模块，点击「新增项目」；
2. 填写项目名称、所属类型（社团/作业/活动）、起止时间、负责人等信息；
3. 邀请成员：通过「项目成员」功能添加用户，分配角色（管理员/普通成员）。

#### 2.2 任务协作
1. 进入指定项目，点击「任务管理」→「新增任务」；
2. 配置任务标题、截止时间、优先级、负责人，支持拆分子任务；
3. 成员可查看任务列表，更新任务状态（待处理/进行中/已完成），提交任务成果。

#### 2.3 资源共享
1. 在项目详情页进入「资源库」模块；
2. 上传/下载文档、代码、图片等协作资源，支持按标签分类检索；
3. 管理员可设置资源访问权限（仅成员/公开）。

#### 2.4 系统管理（管理员）
1. 「用户管理」：创建/禁用用户、分配角色；
2. 「菜单管理」：配置系统功能菜单；
3. 「日志管理」：查看操作日志、异常日志，定位系统问题。

### 3. 核心功能场景
| 场景                | 操作路径                                  |
|---------------------|-------------------------------------------|
| 社团活动策划        | 项目管理→新增「活动类项目」→拆分任务→分配负责人 |
| 课程作业协作        | 项目管理→新增「作业类项目」→资源库共享文件→任务验收 |
| 校园组队招募        | 首页→发布招募→筛选申请者→组建项目团队        |
| 协作数据统计        | 统计分析→项目报表→查看任务完成率/成员贡献度 |

## 常见问题（FAQ）
### Q1: 后端启动报错「数据库连接失败」？
A1: 检查：
1. MySQL 服务是否启动；
2. `application-druid.yml` 中的数据库地址、账号、密码是否正确；
3. 数据库是否已执行初始化脚本；
4. 防火墙/端口是否开放（默认 3306）。

### Q2: 前端请求接口提示「跨域」？
A2: 解决方案：
1. 后端开启跨域配置（已在框架中默认配置，可检查 `campus-framework` 中的跨域过滤器）；
2. 前端通过 Vite 代理转发（修改 `vite.config.js` 的 `proxy` 配置）：
   ```js
   server: {
     proxy: {
       '/dev-api': {
         target: 'http://localhost:8080',
         changeOrigin: true,
         rewrite: (path) => path.replace(/^\/dev-api/, '')
       }
     }
   }
   ```

### Q3: 前端安装依赖失败？
A3: 切换国内镜像源：
```bash
# npm 切换淘宝源
npm config set registry https://registry.npmmirror.com
# yarn 切换淘宝源
yarn config set registry https://registry.npmmirror.com
```

### Q4: 后端启动提示「端口被占用」？
A4: 修改 `application.yml` 中的端口配置：
```yaml
server:
  port: 8081  # 替换为未被占用的端口
```

## 开发指南
### 后端开发
1. 核心技术栈：Spring Boot + Spring Security + MyBatis-Plus + Druid；
2. 新业务模块建议基于 `campus-common` 封装的工具类开发；
3. 定时任务开发：基于 `campus-quartz` 模块扩展。

### 前端开发
1. 核心技术栈：Vue3 + Vite + Element Plus；
2. 页面开发路径：`campus-ui/src/views/`；
3. 接口请求封装：`campus-ui/src/utils/request.js`。

## 贡献指南
1. Fork 本仓库至个人 GitHub 账号；
2. 创建特性分支：`git checkout -b feature/xxx`（bug修复：`bugfix/xxx`）；
3. 提交代码：遵循「feat: 新增xx功能」「fix: 修复xx问题」的提交规范；
4. 推送分支：`git push origin feature/xxx`；
5. 提交 Pull Request 至主仓库，描述功能/修复细节。

## 许可证
本项目基于 MIT 许可证开源，版权归属 2018 RuoYi 及 CampusCollaboration 开发团队，详情请查看 [LICENSE](./LICENSE) 文件。

## 反馈与支持
- 问题反馈：[GitHub Issues](https://github.com/exiey/CampusCollaboration/issues)
- 代码贡献：提交 Pull Request 至主仓库
