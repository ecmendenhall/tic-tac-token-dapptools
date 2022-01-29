import { Interface } from "ethers/lib/utils";

const contracts = {
  game: {
    address: "0x460b3323fd339ebC4c53e9AeB6161c5889F5eB07",
    abi: new Interface([
      "function board(uint256 i) returns (uint256[9] memory)",
      "function currentTurn(uint256 gameId) returns (uint256)",
      "function newGame(address _playerX, address _playerO) external",
      "function markSpace(uint256 gameId, uint256 i, uint256 symbol) external",
    ]),
  },
  token: {
    address: "0x61487d9F293eeeD1607c8049243d946Ed61621Fb",
    abi: new Interface([]),
  },
  nft: {
    address: "0xB798d7715aB74F0141815fA27Db7445f67806018",
    abi: new Interface([]),
  },
};

export default contracts;
