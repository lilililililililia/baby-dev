## 🍼 baby-dev - Week 1

### 任务目标
在完成第一周的基础环境搭建与 ERC20 部署后，本周将进入更系统的智能合约开发实践，目标重点如下：
1. 深入理解并使用 OpenZeppelin 的 ERC20 / ERC721 标准库
2. 编写并部署一个带扩展功能的 ERC20 合约
3. 完成一个基于 ERC20 或 ERC721 的基础投票系统合约
4. 掌握权限控制、事件、业务逻辑等基础模式
完成本周，你将能独立完成一个小型链上应用合约。

---
### 任务内容
1. 学习 OpenZeppelin 标准库（必做）
为了编写更安全、规范的合约，本周重点学习 OpenZeppelin：
需要掌握的内容：
- ERC20.sol
- ERC721.sol
- Ownable.sol（权限控制）
- 常用扩展（Mintable、Burnable、Metadata 等）
推荐阅读：
 https://docs.openzeppelin.com/contracts/4.x/

---
2. 编写一个升级版的 ERC20 代币（必做）
本周你需要再实现一个 带扩展功能的 ERC20。
要求如下：
必做功能：
- 使用 OpenZeppelin 库编写代币
- 至少包含 1 项扩展能力：
  - mint()（仅 owner 可调用）
  - burn()
  - 最大总量 Max Supply 限制
  - 事件（Mint、Burn、Transfer 等）
提交内容：
- 合约代码
- 简短说明（例如“支持 owner mint”、“最大供应量为 X”等）
通过此任务，你将学会如何在标准合约基础上进行定制。

---
3. 基于 ERC20 / ERC721 的投票系统（必做）
本周核心项目是实现一个简单的 voting 合约。
你可以在以下两种模式中选择其一：

---
✔ 方案 A：ERC20 投票系统
功能示例：
- 用户持有你的 ERC20 即可参与投票
- 每个地址只能投一次票
- 至少包含两个候选人
- 可查询候选人的票数

---
✔ 方案 B：ERC721 投票凭证系统
功能示例：
- 持有特定 NFT 的用户才能投票
- 每个 NFT 仅能投一次
- 可查询投票记录或投票总数

---
投票系统最低要求（无论选择 A / B）：
必须包含：
1. 候选人结构或列表
2. 投票函数 vote()
3. 限制：同一用户/NFT 只能投一次
4. 记录投票的事件
5. 查询接口：例如 getVotes()
可选加分项（建议尝试）：
- 设置投票开始/结束时间
- 添加 owner 管理候选人的功能
- 创建一个更安全的权限体系

---
4. 部署两个合约到 Sepolia（必做）
本周共需部署两个合约：
1. 升级版 ERC20 合约
2. VotingSystem 投票合约
请记录以下信息（用于 README）：
- 合约地址
- 交易哈希
- 主要函数说明（1–3 行即可）

---
5. 提交作业（必做）
请查看 https://github.com/CUITBCA/baby-dev仓库下的readme文件规范提交流程

---
提交内容
1. ERC20 升级版合约代码
2. VotingSystem 合约代码
3. 部署信息：
  - 合约地址
  - 交易哈希
4. 学习笔记
  - 遇到的问题
  - 解决方法
  - 本周的小总结

---
推荐学习资源
文档
- OpenZeppelin 合约库
https://docs.openzeppelin.com/contracts/4.x/
- ERC20 标准
https://eips.ethereum.org/EIPS/eip-20
- Solidity 官方文档
https://docs.soliditylang.org/
工具
- Remix IDE
https://remix.ethereum.org

---
