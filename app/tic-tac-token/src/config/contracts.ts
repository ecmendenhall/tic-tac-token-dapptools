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
        "event MarkSpace(address indexed player, uint256 indexed gameId, uint256 position, uint256 symbol)",
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
        "event MarkSpace(address indexed player, uint256 indexed gameId, uint256 position, uint256 symbol)",
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
      address: "0xAD10E738D90362Cb3f8f0ABc4df8C9014386661E",
      abi: new Interface([
        "function board(uint256 i) returns (uint256[9] memory)",
        "function currentTurn(uint256 gameId) returns (uint256)",
        "function newGame(address _playerX, address _playerO) external",
        "function markSpace(uint256 gameId, uint256 i, uint256 symbol) external",
        "function games(uint256 gameId) external returns (tuple(address, address, uint256))",
        "function winner(uint256 gameId) view returns (uint256)",
        "function getGamesByAddress(address player) view returns (uint256[])",
        "event NewGame(address indexed playerX, address indexed playerO, uint256 gameId)",
        "event MarkSpace(address indexed player, uint256 indexed gameId, uint256 position, uint256 symbol)",
        "event Win(address indexed winner, uint256 gameId)",
      ]),
    },
    token: {
      address: "0xaFb1227a8AEc8600f025B525c95b2D4b4FD9D2F5",
      abi: new Interface([]),
    },
    nft: {
      address: "0xDDBeF15325b928343a945aD943c80362D8438D25",
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
