import { Interface } from "ethers/lib/utils";

const contracts = {
  game: {
    address: "0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0",
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
    address: "0x5FbDB2315678afecb367f032d93F642f64180aa3",
    abi: new Interface([]),
  },
  nft: {
    address: "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512",
    abi: new Interface([]),
  },
};

export default contracts;
