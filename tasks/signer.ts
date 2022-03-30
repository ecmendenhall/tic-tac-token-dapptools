import { HardhatUserConfig, task } from "hardhat/config";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import "@nomiclabs/hardhat-ethers";
import { NFT, TicTacToken, Token, Multicall } from "../typechain";

interface Args {}

interface Contracts {
    token: Token;
    nft: NFT;
    ticTacToken: TicTacToken;
    multicall: Multicall;
}

export async function signer(args: Args, hre: HardhatRuntimeEnvironment) {
  const { ethers } = hre;
  const [signer] = await ethers.getSigners();
  console.log("Signer address:", signer.address);
}

export default task("signer", "Print configured signer").setAction(signer);