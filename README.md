# CampusCollaboration - 校园协作平台
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 项目介绍
CampusCollaboration 是一款面向校园场景的协作管理平台，旨在解决校园内学生团队、社团、班级的协作沟通、任务管理、资源共享等核心需求。平台轻量化、易部署，适配校园场景的高频协作场景（如项目组队、活动策划、作业协作等），帮助校园用户高效完成协作任务。

## 环境要求
### 基础环境
- 操作系统：Windows/macOS/Linux
- 编程语言/运行时：
  - Python 3.8+（若为后端项目）/ Node.js 16+（若为前端项目，根据实际栈调整）
- 数据库：MySQL 8.0+ / SQLite 3（轻量部署可选）
- 依赖管理：pip / npm/yarn/pnpm

### 可选工具
- Git（版本控制）
- Docker/Docker Compose（容器化部署）
- Nginx（反向代理，生产环境）

## 安装步骤
### 1. 克隆仓库
```bash
# 克隆项目到本地
git clone https://github.com/exiey/CampusCollaboration.git
cd CampusCollaboration
```

### 2. 安装依赖
#### 若为Python/后端项目
```bash
# 创建虚拟环境（推荐）
python -m venv venv

# 激活虚拟环境
# Windows
venv\Scripts\activate
# macOS/Linux
source venv/bin/activate

# 安装依赖
pip install -r requirements.txt
```

#### 若为前端项目（Vue/React等）
```bash
# 使用npm
npm install
# 或yarn
yarn install
# 或pnpm
pnpm install
```

### 3. 配置环境
1. 复制项目根目录的环境配置模板（如`.env.example`），并重命名为`.env`；
2. 根据实际需求修改`.env`文件中的配置项（如数据库连接、端口、密钥等）：
   ```env
   # 数据库配置示例（MySQL）
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_USER=root
   DB_PASSWORD=your_password
   DB_NAME=campus_collab

   # 服务端口
   PORT=8000

   # 密钥（随机生成，用于安全验证）
   SECRET_KEY=your_random_secret_key
   ```

### 4. 初始化数据库
```bash
# Python/Flask/Django示例
# Flask
flask db init  # 首次初始化迁移（若用Flask-Migrate）
flask db migrate -m "initial migration"
flask db upgrade

# Django
python manage.py makemigrations
python manage.py migrate

# 可选：导入测试数据
python manage.py loaddata test_data.json  # Django示例
```

### 5. 启动项目
#### 开发环境
```bash
# 后端（Flask示例）
flask run --debug
# 后端（Django示例）
python manage.py runserver

# 前端（Vue/React示例）
npm run dev
# 或
yarn dev
```

#### 生产环境
```bash
# 后端：使用Gunicorn/uWSGI部署（Flask/Django）
gunicorn app:app --bind 0.0.0.0:8000  # Flask示例

# 前端：打包静态文件
npm run build
# 部署静态文件到Nginx/Apache
```

## 使用方法
### 1. 基础操作
#### 注册/登录
- 启动项目后，访问`http://localhost:8000`（后端）或`http://localhost:5173`（前端）；
- 点击「注册」按钮，填写校园邮箱/手机号、密码等信息完成注册；
- 用注册的账号密码登录系统。

#### 创建协作项目
1. 登录后，点击「创建项目」，填写项目名称、描述、起止时间、协作类型（如社团活动、课程作业）；
2. 邀请成员：通过学号/邮箱邀请同学加入项目，分配角色（管理员/普通成员）。

#### 任务管理
1. 在项目详情页点击「新建任务」，填写任务名称、负责人、截止时间、优先级；
2. 成员可查看任务列表，标记任务「进行中」「已完成」，并上传任务相关文件/笔记。

#### 资源共享
- 在项目「资源库」模块上传/下载文档、图片、代码等协作资源；
- 对资源添加标签，方便检索。

### 2. 核心功能场景
| 场景                | 操作路径                                  |
|---------------------|-------------------------------------------|
| 社团活动策划        | 项目→新建「活动类项目」→拆分任务→分配负责人 |
| 课程作业协作        | 项目→新建「作业类项目」→共享代码/文档→互评 |
| 校园组队招募        | 发布「招募帖」→筛选申请者→组建团队        |
| 协作进度统计        | 项目→「统计面板」→查看任务完成率/成员贡献 |

## 功能模块
| 模块         | 核心能力                                  |
|--------------|-------------------------------------------|
| 用户管理     | 注册、登录、权限控制、个人信息管理        |
| 项目管理     | 项目创建、成员管理、状态跟踪、归档        |
| 任务管理     | 任务拆分、分配、进度更新、提醒            |
| 资源共享     | 文件上传/下载、版本管理、标签检索          |
| 消息通知     | 任务提醒、成员操作、评论回复通知          |
| 数据统计     | 项目进度、成员贡献、任务完成率可视化      |

## 常见问题（FAQ）
### Q1: 启动项目时提示“数据库连接失败”？
A1: 检查`.env`文件中的数据库配置是否正确，确保数据库服务已启动，且账号密码有对应权限。

### Q2: 前端页面空白/接口请求失败？
A2: 确认后端服务已启动，且前端`.env`中的接口地址与后端端口一致；检查浏览器控制台的网络/报错信息。

### Q3: 依赖安装失败？
A3: 升级pip/npm版本，或切换国内镜像源（如pip使用清华源、npm使用淘宝源）。

## 贡献指南
1. Fork 本仓库到个人账号；
2. 创建特性分支：`git checkout -b feature/your-feature-name`；
3. 提交代码：`git commit -m "feat: 新增XX功能"`；
4. 推送分支：`git push origin feature/your-feature-name`；
5. 提交 Pull Request 到主仓库的`main`分支，描述功能/修复内容。

## 许可证
本项目基于 MIT 许可证开源，详情请查看 [LICENSE](./LICENSE) 文件。

## 联系与反馈
若使用过程中遇到问题，可通过以下方式反馈：
- 提交 Issue：[GitHub Issues](https://github.com/exiey/CampusCollaboration/issues)
- 邮件：xxx@example.com（可替换为项目维护者邮箱）

---
**注**：本README基于“校园协作平台”通用场景编写，若项目有特殊技术栈/功能，可根据仓库内实际代码补充/调整（如前端框架、后端框架、专属功能等）。
