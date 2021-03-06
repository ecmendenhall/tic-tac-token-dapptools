import { HardhatUserConfig, task } from "hardhat/config";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import "@nomiclabs/hardhat-ethers";
import { NFT, TicTacToken, Token, Multicall } from "../typechain";

interface Args {}

interface Contracts {
    token: Token;
    nft: NFT;
    ticTacToken: TicTacToken;
    multicall?: Multicall;
}

export async function deploy(args: Args, hre: HardhatRuntimeEnvironment) : Promise<Contracts> {
  const { ethers, network } = hre;

  let multicall;
  if (["hardhat", "localhost"].includes(network.name)) {
    const Multicall = await ethers.getContractFactory("Multicall");
    multicall = await Multicall.deploy();
    await multicall.deployed();
    console.log("Multicall deployed to: ", multicall.address);
  }

  const Token = await ethers.getContractFactory("Token");
  const token = await Token.deploy();
  await token.deployed();
  console.log("Token deployed to: ", token.address);

  const NFT = await ethers.getContractFactory("NFT");
  const nft = await NFT.deploy();
  await nft.deployed();
  console.log("NFT deployed to: ", nft.address);

  const TicTacToken = await ethers.getContractFactory("TicTacToken");
  const ticTacToken = await TicTacToken.deploy(token.address, nft.address);
  await ticTacToken.deployed();
  console.log("Tic Tac Token deployed to: ", ticTacToken.address);

  console.log("Setting TTT...");
  await nft.setTTT(ticTacToken.address);

  console.log("Transferring owner...");
  await token.transferOwnership(ticTacToken.address);
  await nft.transferOwnership(ticTacToken.address);

  if (["hardhat", "localhost"].includes(network.name)) {
    const [owner] = await ethers.getSigners();
    await owner.sendTransaction({
      to: "0xe979054eB69F543298406447D8AB6CBBc5791307",
      value: ethers.utils.parseEther("1000"),
    });
  }

  return { multicall, token, nft, ticTacToken }
}

export default task("deploy", "Deploys Tic Tac Token contracts").setAction(deploy);