import { expect } from "chai";
import hre from "hardhat";

import { deploy } from "../tasks/deploy";

describe("Deployment", function () {

  it("Deploys the Tic Tac Token contracts", async function () {
    const { token, nft, ticTacToken} = await deploy({}, hre);

    expect(await ticTacToken.token()).to.equal(token.address);
    expect(await ticTacToken.nft()).to.equal(nft.address);
  });

});
