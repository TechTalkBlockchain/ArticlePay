

# Article Reward with Quiz Smart Contract

## Overview

The **Article Reward with Quiz** smart contract allows readers to earn ART tokens for every article they read. Users can read articles and, if required, complete a quiz to claim their rewards. This incentivizes reading and engagement with content, while ensuring that users are actively participating through quizzes.

## Features

- **ERC20 Token Rewards**: Users receive a predefined amount of tokens for reading articles.
- **Quiz Integration**: Articles can require quizzes. Users must answer correctly to claim their rewards.
- **Admin Control**: An administrator can add articles and set quiz questions.
- **Tracking**: The contract tracks articles read by each user and their claim status.

## Getting Started

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/TechTalkBlockchain/ArticlePay
    cd ArticlePay
    ```

2. Install dependencies:
    ```bash
    npm install
    ```

### Deployment

1. Update the contract with the ERC20 token address in the constructor.
2. Configure the Hardhat network settings in `hardhat.config.js`.
3. Deploy the contract:
    ```bash
    npx hardhat run scripts/deploy.js --network <network_name>
    ```

## Contract Structure

### `ArticleRewardWithQuiz`

- **Admin**: The address that has permission to add articles.
- **Articles**: Each article has an ID, reward amount, and an optional quiz.
- **Quizzes**: Each quiz consists of a question and multiple-choice answers.

### Functions

- `addArticle(...)`: Allows the admin to add a new article with its details.
- `readArticle(...)`: Allows a user to mark an article as read and check for quiz requirements.
- `submitQuizAnswer(...)`: Allows users to submit answers for articles that require quizzes.
- `claimReward(...)`: Handles the distribution of rewards based on quiz results.

## Usage

1. **Reading Articles**: Users call `readArticle(articleId)` to read an article. If a quiz is required, they can proceed to answer it.
2. **Answering Quizzes**: Users submit their answers through `submitQuizAnswer(articleId, answerIndex)`. If they answer correctly, they earn their reward.

## License

This project is licensed under the MIT License. See the (LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for discussion.
