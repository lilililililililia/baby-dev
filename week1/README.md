## 🍼 baby-dev - Week 1

### 📘 一、本周任务

* Fork 本仓库到自己的 GitHub 账户。
* Clone 仓库到本地。
* 学习 ERC20 和 ERC721 的基本原理。
* 编写属于自己的 ERC20 代币合约，代币命名为自己的英文名
* 将代码部署到测试网，同时在readme中
* 提交pr至仓库。

---

### 🧱 二、仓库结构

```
baby-dev/
│
│
├── week1/                # 第一周作业
│   └── your_name/        # 使用你的英文名命名
│       ├── README.md     # 学习笔记（可选） + 部署的哈希
│       └── ERC20_code/   # 代码
│
└── README.md
```

---

### 🚀 三、提交步骤

1. Fork 本仓库。
2. Clone 到本地：

   ```bash
   git clone https://github.com/<你的GitHub用户名>/baby-dev.git
   cd baby-dev
   ```
4. 在 `week1/` 下新建个人文件夹，添加README以及task代码：

   ```
   week1/Alice/README.md
   ```
5. 提交并推送：

   ```bash
   git add .
   git commit -m "week1: 部署我的 ERC20 合约"
   git push origin main
   ```
6. 发起 Pull Request：
   标题格式示例：

   ```
   [Week1] Alice - 提交 ERC20 作业
   ```

---

### 🧩 四、命名规范

| 类型        | 命名示例                   |
| --------- | ---------------------- |
| 合约文件      | `MyToken.sol`          |
| 笔记文件      | `ERC20_week1.md`            |
| 成员文件夹     | `Alice`（使用英文名）         |
| Commit 信息 | `week1: 完成 ERC20 合约部署` |
