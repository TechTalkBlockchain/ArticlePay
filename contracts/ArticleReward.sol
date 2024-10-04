// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ArticleReward {
    IERC20 public articleToken;
    mapping(address => uint256) public articlesRead;
    mapping(address => mapping(uint256 => bool)) public hasClaimed;

    event ArticleRead(address indexed reader, uint256 articleId, uint256 rewardTokens);

    constructor(address tokenAddress) {
        articleToken = IERC20(tokenAddress);
    }

    function readArticle(uint256 articleId) external {
        require(!hasClaimed[msg.sender][articleId], "Reward already claimed for this article");
        
        articlesRead[msg.sender] += 1;

        uint256 rewardAmount = 10 * 10**18; 
        require(articleToken.balanceOf(address(this)) >= rewardAmount, "Not enough tokens in contract");

        // Transfer tokens to the reader
        articleToken.transfer(msg.sender, rewardAmount);
        hasClaimed[msg.sender][articleId] = true;

        emit ArticleRead(msg.sender, articleId, rewardAmount);
    }
}
