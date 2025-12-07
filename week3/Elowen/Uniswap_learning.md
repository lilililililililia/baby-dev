## 整理笔记（注：已涵盖内容未再次单独列出）  
### 核心概念  
- **x*y=k**:池子（指实现了 Uniswap V2 交易逻辑的 Pair 智能合约）中的两种代币数量乘积始终保持平衡不变，若其中一种币数量改变则会导致另一种币数量改变从而保证乘积数量保持不变。理论上在没有交易的情况下保持不变（交易发生后会因手续费而略微增加）。   
- **储备更新**：即将智能合约中的代币数量更新同步至最新的代币，通常发生在添加/移除流动性和交易时。  
- **Router<->Pair交互关系**：Router 负责接收用户请求然后调用目标 Pair 合约上的核心函数，处理多步交易，而 Pair 响应 Router 调用，在合约内部执行核心逻辑直接与代币进行交互并更新合约的储存状态。Router 可通过调用 Factory 来查询某个代币对的 Pair 合约地址。
- **LP 代币铸造/销毁**：  
  1.LP代币：ERC-20 标准代币，代表在智能合约中的份额。   
  2.铸造（发生在添加流动性时）：Pair 合约会根据投入资金占池子总储备的比例，计算出用户应该获得多少新的 LP Token。ps：特例首次铸造 (池子为空时)：发行的 LP Token 数量通常用公式 $\sqrt{x \cdot y}$ 决定，以防止恶意用户通过微小投入获取大量份额。Pair 合约调用内部函数，将新计算出的 LP Token 发行到用户钱包地址。   
  3.销毁（发生在移除流动性时）：用户将持有的 LP Token 发送回 Pair 合约，Pair 合约销毁这些 Token。Pair 合约根据用户销毁的 LP Token 占总发行量的比例，计算出用户应得的两种代币的数量（包含累积的手续费收益），这些代币被发送回用户钱包。
- **swap 过程中的储备更新流程**：用户发起出售代币 A（用户想要换入池子的代币）的交易，Pair 合约接收后增加合约中代币 A 的数量，0.3%的手续费从用户输入的代币中扣除，留在池子中，但不参与兑换计算。只有99.7%的代币会参与 x*y=k 的计算，合约以 x*y=k 乘积 k 值一定计算出需发送给用户的代币B的数量，并发送到用户钱包。交易结束前，合约将执行一些安全检查用于确保 x*y>=k 成立。  
- **滑点**：指用户预期获得的代币数量与实际获得代币数量之间的差异，在 Uniswap V2 中直接表现为实际获得的代币数量减少。滑点=|预期价格-实际成交价格|/预期价格。
- **定价**：在 Uniswap V2中定价由池子中的代币数量比例实时决定，但由于滑点，用户的实际成交价格将会较即时价格更高。
- **闪兑**：允许用户在无需预先拥有资金的情况下进行大额借贷和交易，用户向 Pair 合约发出借贷交易，Pair 合约在向用户转账后将会立即暂停执行并强制调用用户合约（即由用户编写和部署的用于执行闪兑操作的合约）上的回调函数，若用户未在回调函数执行完毕之前归还借贷数额和0.3%的手续费，Pair合约则会进行交易回滚。
### 重要函数流程  
- **addLiquidity**  
1.参数：address tokenA（第一个代币的地址）、address tokenB（第二个代币的地址）、uint256 amountADesired（用户期望换入池子的 tokenA 数量）、uint256 amountBDesired（用户期望的换入池子的 TokenB 数量）、uint256 amountAMin（最小需换入池子的 TokenA 数量，通常用于防止滑点）、uint256 amountBMin（最小需换入池子的 TokenB数量）、address to（接收 LP Token的地址）、uint256 deadline（交易必须完成的 Unix 时间戳——计算机用来表示时间的秒数计数器，从 1970 年开始计时，在区块链交易中用于设置交易的有效期）。
2.顺序：user（输入参数）->Router(接收参数、通过 Factory 查找 Pair 合约地址、执行代币转账)—>Pair(接收代币、通过 x*y=k 的比例计算需铸造的 LP Token 数量、铸造发送 Token 给 user 并更新储备)  。
- **removeLiquidity**  
1.参数：tokenA/B（同上）、uint256 liquidity（用户想要销毁的 LP Token 数量）、amountA/Bmin（同上，但为最小取回数量）、to（同上）、deadline（同上）。  
2.顺序：user（输入参数）->Router(接收参数、通过 Factory 查找 Pair 合约地址、执行代币转账)—>Pair(接收并销毁代币、通过 x*y=k 的比例计算需归还的 TokenA、TokenB 数量、发送 Token 给 user 并更新储备)。
- **swap**：
1.参数：uint256 amountIn(用户想要投入的代币数量)、uint256 amountOutMin（用户期望获得的代币最小数量，若低于则会导致交易失败）、address[] path（交易路径的代币地址数组，决定交易将经过哪些 Pair 合约）、to（同上）、deadline（同上）。
2.顺序：user（输入参数）->Router(接收参数、通过 Factory 查找 Pair 合约地址、执行代币转账)—>Pair(接收代币、扣除0.3%的手续费并通过 x*y=k 的比例计算需归还的 Token 数量、发送 Token 给 user 并进行安全检查然后更新储备)。
### 手续费返还
- 累计：LP Token价值=池子总储备/LP Token 总发行量，当交易发生时，池子收到0.3%的手续费使得池子总储备价值增大而 LP Token总发行量不变。
- 返还：当 LP 销毁其持有的 LP Token 时 Pair合约通过销毁 LP Token数量占总发行量的比例返还 TokenA 和 TokenB,而此时池子总储备中包含了其累计的手续费。
### Week4 手写实现时的模块拆分思路
- Pair->Factory->Router
### 未解答问题及预深挖点
- 对Uniswap V2 的理解目前都尚未浅层，很多都未达理解，例如：闪兑借贷套利偿还都发生在一个区块内的同一个交易中连续执行完成。
- 多数理解熟悉需要依靠 AI。

## 设计草稿
### 预期合约结构
- 1.Pair 合约：接收代币、swap 中扣除手续费、实现 x*y=k逻辑、LP Token铸造或销毁、储备更新、向用户发送代币。
- 2.Factory 合约：被调用查找 Pair 合约地址。
- 3.Router 合约；接收用户输入参数、调用 Factory 查找 Pair 合约地址
### 关键状态变量
- uint112 reserve0、uint112 reserve1：分别代表当前池子中两种代币的储备量。
- address token0、address token 1：分别代表 Pair 合约管理的两种代币的地址。
- uint256 totalSupply：当前 LP Token 的总供应量。
- uint256 kLast：最后一次流动性操作后的 k 值。
- uint32 blockTimestampLast： 最后一次价格更新的区块时间戳。
### 函数输入输出以及需要的安全检查
1.addLiquidity
- 输入：addLiquidity(address tokenA, address tokenB, uint amountADesired, uint amountBDesired, uint amountAMin, uint amountBMin, address to, uint deadline)。
- 输出：无直接返回值，但 Pair 会发送铸造的 LP Token 给 to 地址。
- 安全检查：确保代币投入量 > amountA(B)Min、确保交易在 deadline 时间内完成。
2.removeLiquidity
- 输入：removeLiquidity(address tokenA, address tokenB, uint liquidity, uint amountAMin, uint amountBMin, address to, uint deadline)。
- 输出：无直接返回值，但 Pair 合约会将 TokenA、TokenB 转账给 to 地址。
- 安全检查：确保代币返还值 > amountA(B)Min、确保交易在 deadline 时间内完成。
3.swap
- 输入：swap(uint amountIn, uint amountOutMin, address[] path, address to, uint deadline)
- 输出：无直接返回值，但 Pair 合约会将输出代币转账给 to 地址。
- 安全检查：最终输出代币数量 > amountOutMin、防重入检查、确保交易后x*y>=k。
### 自研函数
- sqrt函数：利用二分搜索法（即找中间值平方与目标值作大小比较）。
