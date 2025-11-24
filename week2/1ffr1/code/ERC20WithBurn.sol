// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 只导入必需的 2 个合约：ERC20（发币）+ Ownable（管理员权限）
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleVotingToken is ERC20, Ownable {
    // 1. 提案结构体（只留核心字段）
    struct Proposal {
        string description; // 提案描述（比如“销毁10%总供应量”）
        uint256 voteEnd;    // 投票截止时间
        uint256 forVotes;   // 同意票数
        uint256 againstVotes;// 反对票数
        bool executed;      // 是否已执行
    }

    // 2. 存储提案和投票记录
    Proposal[] public proposals; // 所有提案列表
    mapping(address => mapping(uint256 => boo)) public hasVoted; // 防止重复投票

    // 3. 核心参数（固定值，简化配置）
    uint256 public constant VOTE_DURATION = 180; // 投票时长：24小时（秒）
    uint256 public constant MIN_PROPOSAL_BALANCE = 5 * 10 ** 18; // 创建提案需持有5个代币
    uint256 public constant QUORUM = 10; // 投票通过门槛：参与率≥10% + 同意票>反对票

    // 4. 构造函数：部署时发币（核心发币逻辑）
    constructor() ERC20("SimpleVote", "SVT") Ownable(msg.sender) {
        // 初始铸造 1000 个完整代币给部署者（你）
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    // -------------------------- 核心功能（3个关键函数） --------------------------
    /**
     * 1. 创建提案（任何人持有≥5个代币都能创建）
     * @param description 提案描述（比如“销毁10%总供应量”）
     */
    function createProposal(string calldata description) external {
        require(balanceOf(msg.sender) >= MIN_PROPOSAL_BALANCE, unicode"持有代币不足5个，无法创建提案");
        
        proposals.push(Proposal({
            description: description,
            voteEnd: block.timestamp + VOTE_DURATION, // 现在+24小时截止
            forVotes: 0,
            againstVotes: 0,
            executed: false
        }));
    }

    /**
     * 2. 投票（持币者可投同意/反对，1个代币=1票）
     * @param proposalId 提案编号（从0开始，第一个提案是0，第二个是1...）
     * @param support true=同意，false=反对
     */
    function vote(uint256 proposalId, bool support) external {
        Proposal storage proposal = proposals[proposalId];
        require(proposalId < proposals.length, unicode"提案不存在"); // 防输入错误编号
        require(block.timestamp <= proposal.voteEnd, unicode"投票已结束"); // 只能在24小时内投
        require(!hasVoted[msg.sender][proposalId], unicode"已投过票，不能重复投"); // 防刷票

        uint256 voterPower = balanceOf(msg.sender); // 投票权=当前持币量（简单直接）
        if (support) {
            proposal.forVotes += voterPower; // 同意票累加
        } else {
            proposal.againstVotes += voterPower; // 反对票累加
        }

        hasVoted[msg.sender][proposalId] = true; // 标记已投票
    }

    /**
     * 3. 执行提案（投票结束后，任何人都能触发执行）
     * @param proposalId 提案编号
     */
    function executeProposal(uint256 proposalId) external {
        Proposal storage proposal = proposals[proposalId];
        require(proposalId < proposals.length, unicode"提案不存在");
        require(block.timestamp > proposal.voteEnd, unicode"投票未结束");
        require(!proposal.executed, unicode"提案已执行");

        // 计算是否满足通过条件：参与率≥10% + 同意票>反对票
        uint256 totalVoted = proposal.forVotes + proposal.againstVotes;
        uint256 totalSupply = totalSupply(); // 总票数=总代币数
        require(
            (totalVoted * 100) / totalSupply >= QUORUM && proposal.forVotes > proposal.againstVotes,
            unicode"提案未通过"
        );

        // 执行提案核心逻辑（固定为“销毁10%总供应量”，简单易测试）
        uint256 burnAmount = totalSupply / 10;
        _burn(owner(), burnAmount); // 从管理员（部署者）地址销毁代币

        proposal.executed = true; // 标记已执行
    }
}