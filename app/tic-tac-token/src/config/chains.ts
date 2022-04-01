import { ChainId, Hardhat, Rinkeby, Mumbai, Polygon } from "@usedapp/core";

export const SUPPORTED_CHAINS = [
  Hardhat.chainId,
  Rinkeby.chainId,
  Mumbai.chainId,
  Polygon.chainId,
];

export const supportedChain = (chainId: ChainId) => {
  console.log(chainId);
  return SUPPORTED_CHAINS.includes(chainId);
};
