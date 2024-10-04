import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";


const ArticleToken = '0x31343Dcbc15A03eeE4A61DB4A1696E0415C9688d'
const rewardTokenModule = buildModule("rewardTokenModule", (m) => {

    const rewardArticle = m.contract("ArticleRewardWithQuiz", [ArticleToken]);

    return { rewardArticle };
});

export default rewardTokenModule;
