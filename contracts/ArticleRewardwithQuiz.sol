// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ArticleRewardWithQuiz {
    IERC20 public articleToken;
    address public admin; 

    struct Quiz {
        string question;           
        string[] options;          
        uint8 correctAnswerIndex; 
    }

    struct Article {
        uint256 id;
        uint256 rewardAmount; 
        bool quizRequired;     
        Quiz quiz;            
    }

    mapping(uint256 => Article) public articles; // Store articles by ID
    mapping(address => mapping(uint256 => bool)) public hasClaimed; // Track claims per article
    mapping(address => uint256) public articlesRead; // Track how many articles each user has read

    event ArticleRead(address indexed reader, uint256 articleId, uint256 rewardTokens);

    constructor(address tokenAddress) {
        articleToken = IERC20(tokenAddress);
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not the admin");
        _;
    }

    function addArticle(
        uint256 articleId,
        uint256 rewardAmount,
        bool quizRequired,
        string memory question,
        string[] memory options,
        uint8 correctAnswerIndex
    ) external onlyAdmin {
        articles[articleId] = Article({
            id: articleId,
            rewardAmount: rewardAmount,
            quizRequired: quizRequired,
            quiz: Quiz({
                question: question,
                options: options,
                correctAnswerIndex: correctAnswerIndex
            })
        });
    }

    function readArticle(uint256 articleId) external {
        Article storage article = articles[articleId];

        require(article.id != 0, "Article does not exist");
        require(!hasClaimed[msg.sender][articleId], "Reward already claimed for this article");

        articlesRead[msg.sender] += 1;

        if (article.quizRequired) {
            return;
        }

        claimReward(articleId, false);
    }

    function submitQuizAnswer(uint256 articleId, uint8 answerIndex) external {
        Article storage article = articles[articleId];

        require(article.id != 0, "Article does not exist");
        require(article.quizRequired, "This article does not require a quiz");
        require(!hasClaimed[msg.sender][articleId], "Reward already claimed for this article");

        bool passed = (answerIndex == article.quiz.correctAnswerIndex);

        claimReward(articleId, passed);
    }

    function claimReward(uint256 articleId, bool quizPassed) internal {
        Article storage article = articles[articleId];

        require(!hasClaimed[msg.sender][articleId], "Reward already claimed for this article");
        
    
        if (!article.quizRequired || quizPassed) {
            require(articleToken.balanceOf(address(this)) >= article.rewardAmount, "Not enough tokens in contract");

            articleToken.transfer(msg.sender, article.rewardAmount);
            hasClaimed[msg.sender][articleId] = true;

            emit ArticleRead(msg.sender, articleId, article.rewardAmount);
        } else {
            revert("Quiz failed, reward not granted");
        }
    }
}
