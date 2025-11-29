# 🍼 baby-dev - Week 3 学习任务

> 参考 `all_learn.md` 的总路线，本周节奏延续 Week1/Week2 —— 以“扎实理解 → 下周实战”的方式推进。第三周不硬性要求提交代码，重点是 **系统性学习 Uniswap V2 机制、记录笔记、输出设计草稿**，为 Week4 的“手写 AMM”做准备。

---

## 🎯 本周目标
1. **吃透 Uniswap V2 理论**：理解常数乘积做市、LP 份额、手续费模型、Router ↔ Pair 的交互关系。
2. **调研实现细节**：阅读官方白皮书、核心合约（Pair/Factory/Router），弄清初始化、定价、闪兑等关键点。
3. **输出学习文档**：整理自己的理解、疑问、初步实现思路，周末前提交 Markdown 文档。

---

## 📘 必做任务
1. **阅读材料**
   - 官方文档/白皮书：《Uniswap V2 Core》（https://docs.uniswap.org/contracts/v2）
   - 核心源码：`UniswapV2Pair.sol`、`UniswapV2Factory.sol`、`UniswapV2Router02.sol`
   - 推荐补充：常数乘积 AMM 分析文章、B 站/YouTube 讲解
2. **整理笔记（提交物）**
   - 在 `week3/<your_name>/Uniswap_learning.md` 或类似文件中写明：
     - 核心概念：`x * y = k`，储备更新、LP 代币铸造/销毁、swap 逻辑
     - 重要函数流程：`addLiquidity` / `removeLiquidity` / `swap` 的参数、顺序、限制
     - Factory/Pair/Router 之间的数据流、事件
     - 手续费计算（0.3% 如何累积、如何返还给 LP）
     - 你计划在 Week4 手写实现时的模块拆分思路（例如：先写 Factory+Pair，后写 Router 等）
     - 未解答的问题或准备继续研究的点
3. **设计草稿**
   - 用文字或流程图描述你自己的 AMM 版本（无需写代码）：
     - 预期合约结构、关键状态变量
     - 函数输入/输出以及需要的安全检查
     - 需要自研的数学函数（如 sqrt、流动性计算）估算方式
   - 这份草稿会成为 Week4 编码的起点，请务必清晰。

---

## 🧪 提交规范
- 目录：`week3/<your_name>/README.md`（概述）+ `Uniswap_learning.md`（详实笔记/草稿）
- README 建议写：
  - 学习资料列表 & 阅读方式
  - 本周产出链接（Learning Doc）
  - Week4 实现计划（简要）
- 不要求提交合约或测试，但若你已经开始实验，也可以附上参考代码（不用交付质量，只做自查）。

---

## ✅ 验收清单
- [ ] 完成 Uniswap V2 学习文档（概念/函数/手续费/设计草案）
- [ ] README 中列出学习资料与 Week4 计划
- [ ] 个人周报或 `week3/demotest/demotest.md` 同步“学习进度 + 疑问”

---

## 📎 参考资料
- Uniswap V2 白皮书：https://uniswap.org/whitepaper.pdf
- Vitalik 的 AMM 文章：https://vitalik.ca/general/2018/07/21/stablecoins.html
- 视频推荐：https://www.bilibili.com/video/BV1hWdbYLEkv/?spm_id_from=333.1387.upload.video_card.click
- 数学扩展：`x*y=k` 推导、费用累积、价格 oracle（Time-Weighted Average Price）

> Week3 重点是“理解 + 记录”，请不要急于动手编码。第四周将要求“完全自行实现（不可引用官方库）”，本周的笔记和设计会直接决定你能否顺利交付。
