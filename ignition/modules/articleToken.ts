import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const ArticleTokenModule = buildModule("ArticleTokenModule", (m) => {

    const articleToken = m.contract("ArticleToken");

    return { articleToken };
});

export default ArticleTokenModule;
