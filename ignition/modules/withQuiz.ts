import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";


const ArticleToken = '0x31343Dcbc15A03eeE4A61DB4A1696E0415C9688d'
const rewardWithQuizModule = buildModule("rewardWithQuizModule", (m) => {

    const rewardQuiz = m.contract("ArticleReward", [ArticleToken]);

    return { rewardQuiz };
});

export default rewardWithQuizModule;
