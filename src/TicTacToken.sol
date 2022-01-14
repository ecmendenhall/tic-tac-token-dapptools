// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./interfaces/IToken.sol";
import "./interfaces/INFT.sol";

contract TicTacToken {
    address public admin;
    address public playerX;
    address public playerO;
    uint256 public totalGames;

    uint256[9] public board;
    mapping(address => uint256) public totalWins;
    mapping(address => uint256) public totalPoints;

    uint256 internal constant EMPTY = 0;
    uint256 internal constant X = 1;
    uint256 internal constant O = 2;
    uint256 internal constant POINTS_PER_WIN = 300;
    uint256 internal nextGameId;
    address internal owner;
    mapping(address => uint256) internal winCountByAddress;
    mapping(address => uint256) internal pointCountByAddress;

    constructor(
        address _admin,
        address _playerX,
        address _playerO
    ) {
        admin = _admin;
        playerX = _playerX;
        playerO = _playerO;
        token = IToken(_token);
        nft = INFT(_nft);
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Must be admin");
        _;
    }

    modifier onlyPlayer() {
        require(_validPlayer(msg.sender), "Unauthorized");
        _;
    }

    function markSpace(uint256 i) public {
        require(_validTurn(msg.sender), "Not your turn");
        require(_validSpace(i), "Invalid space");
        require(_emptySpace(i), "Already marked");
        turns++;
        board[i] = _getSymbol(msg.sender);
        if (winner() != 0) {
            totalGames += 1;
            address winnerAddress = _getAddress(winner());
            totalWins[winnerAddress] += 1;
            totalPoints[winnerAddress] += _pointsEarned();
        }
    }

    function board(uint256 gameId) public view returns (uint256[9] memory) {
        return games[gameId].board;
    }

    function currentTurn(uint256 gameID) public view returns (uint256) {
        return (_game(gameID).turns % 2 == 0) ? X : O;
    }

    function reset() public onlyAdmin {
        delete board;
    }

    function winner() public view returns (uint256) {
        return _checkWins();
    }

    function _pointsEarned() internal view returns (uint256) {
        uint256 moves;
        if (winner() == X) {
            moves = (turns + 1) / 2;
        }
        if (winner() == O) {
            moves = turns / 2;
        }
        return 600 - (moves * 100);
    }

    function _getAddress(uint256 symbol) internal view returns (address) {
        if (symbol == X) return playerX;
        if (symbol == O) return playerO;
        return address(0);
    }

    function _getSymbol(address player) internal view returns (uint256) {
        if (player == playerX) return X;
        if (player == playerO) return O;
        return EMPTY;
    }

    function _validPlayer(address caller) internal view returns (bool) {
        return caller == playerX || caller == playerO;
    }

    function _validSpace(uint256 i) internal pure returns (bool) {
        return i < 9;
    }

    function _validTurn(address player) internal view returns (bool) {
        return currentTurn() == _getSymbol(player);
    }

    function _emptySpace(uint256 gameId, uint256 i)
        internal
        view
        returns (bool)
    {
        return _game(gameId).board[i] == 0;
    }

    function _validSymbol(uint256 symbol) internal pure returns (bool) {
        return symbol == X || symbol == O;
    }

    function _checkWins(uint256 gameId) internal view returns (uint256) {
        uint256[8] memory wins = [
            _row(gameId, 0),
            _row(gameId, 1),
            _row(gameId, 2),
            _col(gameId, 0),
            _col(gameId, 1),
            _col(gameId, 2),
            _diag(gameId),
            _antiDiag(gameId)
        ];
        for (uint256 i = 0; i < wins.length; i++) {
            if (wins[i] == 1) {
                return X;
            } else if (wins[i] == 8) {
                return O;
            }
        }
        return 0;
    }

    function _row(uint256 gameId, uint256 row) internal view returns (uint256) {
        require(row <= 2, "Invalid row");
        uint256 pos = row * 3;
        return
            _game(gameId).board[pos] *
            _game(gameId).board[pos + 1] *
            _game(gameId).board[pos + 2];
    }

    function _col(uint256 gameId, uint256 col) internal view returns (uint256) {
        require(col <= 2, "Invalid col");
        return
            _game(gameId).board[col] *
            _game(gameId).board[col + 3] *
            _game(gameId).board[col + 6];
    }

    function _diag(uint256 gameId) internal view returns (uint256) {
        return
            _game(gameId).board[0] *
            _game(gameId).board[4] *
            _game(gameId).board[8];
    }

    function _antiDiag(uint256 gameId) internal view returns (uint256) {
        return
            _game(gameId).board[2] *
            _game(gameId).board[4] *
            _game(gameId).board[6];
    }

    function winCount(address playerAddress) public view returns (uint256) {
        return winCountByAddress[playerAddress];
    }

    function pointCount(address playerAddress) public view returns (uint256) {
        return pointCountByAddress[playerAddress];
    }

    function _incrementWinCount(address playerAddress) private {
        winCountByAddress[playerAddress]++;
    }

    function _incrementPointCount(address playerAddress) private {
        pointCountByAddress[playerAddress] += POINTS_PER_WIN;
    }

    function _getPlayerAddress(uint256 gameId, uint256 playerSymbol)
        private
        view
        returns (address)
    {
        if (playerSymbol == X) {
            return _game(gameId).playerX;
        } else if (playerSymbol == O) {
            return _game(gameId).playerO;
        } else {
            return address(0);
        }
    }

    function _game(uint256 gameId) private view returns (Game storage) {
        return games[gameId];
    }
}
