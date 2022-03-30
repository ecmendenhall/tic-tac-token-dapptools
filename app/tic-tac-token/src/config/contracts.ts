import { Interface } from "ethers/lib/utils";
import { ChainId, Hardhat, Rinkeby, Mumbai, Polygon } from "@usedapp/core";

const contracts = {
  [Hardhat.chainId]: {
    game: {
      address: "0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9",
      abi: new Interface([
        "function board(uint256 i) returns (uint256[9] memory)",
        "function currentTurn(uint256 gameId) returns (uint256)",
        "function newGame(address _playerX, address _playerO) external",
        "function markSpace(uint256 gameId, uint256 i, uint256 symbol) external",
        "function games(uint256 gameId) external returns (tuple(address, address, uint256))",
        "function winner(uint256 gameId) view returns (uint256)",
        "function getGamesByAddress(address player) view returns (uint256[])",
        "event NewGame(address indexed playerX, address indexed playerO, uint256 gameId)",
        "event MarkSpace(address indexed player, uint256 indexed gameId, uint256 position, uint256 symbol, uint256[9] board)",
        "event Win(address indexed winner, uint256 gameId)",
      ]),
    },
    token: {
      address: "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512",
      abi: new Interface([]),
    },
    nft: {
      address: "0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0",
      abi: new Interface([]),
    },
  },
  [Polygon.chainId]: {
    game: {
      address: "0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9",
      abi: new Interface([
        "function board(uint256 i) returns (uint256[9] memory)",
        "function currentTurn(uint256 gameId) returns (uint256)",
        "function newGame(address _playerX, address _playerO) external",
        "function markSpace(uint256 gameId, uint256 i, uint256 symbol) external",
        "function games(uint256 gameId) external returns (tuple(address, address, uint256))",
        "function winner(uint256 gameId) view returns (uint256)",
        "function getGamesByAddress(address player) view returns (uint256[])",
        "event NewGame(address indexed playerX, address indexed playerO, uint256 gameId)",
        "event MarkSpace(address indexed player, uint256 indexed gameId, uint256 position, uint256 symbol, uint256[9] board)",
        "event Win(address indexed winner, uint256 gameId)",
      ]),
    },
    token: {
      address: "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512",
      abi: new Interface([]),
    },
    nft: {
      address: "0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0",
      abi: new Interface([]),
    },
  },
  [Mumbai.chainId]: {
    game: {
      address: "0xC3F580d358ba51b73f153aEaa51A34363D9A4da3",
      abi: new Interface([
        "function board(uint256 i) returns (uint256[9] memory)",
        "function currentTurn(uint256 gameId) returns (uint256)",
        "function newGame(address _playerX, address _playerO) external",
        "function markSpace(uint256 gameId, uint256 i, uint256 symbol) external",
        "function games(uint256 gameId) external returns (tuple(address, address, uint256))",
        "function winner(uint256 gameId) view returns (uint256)",
        "function getGamesByAddress(address player) view returns (uint256[])",
        "event NewGame(address indexed playerX, address indexed playerO, uint256 gameId)",
        "event MarkSpace(address indexed player, uint256 indexed gameId, uint256 position, uint256 symbol, uint256[9] board)",
        "event Win(address indexed winner, uint256 gameId)",
      ]),
    },
    token: {
      address: "0xAA318059640f0f96ba9112AB5Bdf9F06Fe6dC155",
      abi: new Interface([]),
    },
    nft: {
      address: "0xBcB5e45567e30083BD7eA645D1Ce93a5A1A5c0b9",
      abi: new Interface([]),
    },
  },
  [Rinkeby.chainId]: {
    game: {
      address: "0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9",
      abi: new Interface([
        "function board(uint256 i) returns (uint256[9] memory)",
        "function currentTurn(uint256 gameId) returns (uint256)",
        "function newGame(address _playerX, address _playerO) external",
        "function markSpace(uint256 gameId, uint256 i, uint256 symbol) external",
        "function games(uint256 gameId) external returns (tuple(address, address, uint256))",
        "function winner(uint256 gameId) view returns (uint256)",
      ]),
    },
    token: {
      address: "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512",
      abi: new Interface([]),
    },
    nft: {
      address: "0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0",
      abi: new Interface([]),
    },
  },
};

export function getContracts(chainId: ChainId | undefined) {
  if(chainId === undefined) {
    return contracts[Hardhat.chainId];
  } else {
  return contracts[chainId];
  }
}

export default contracts;
