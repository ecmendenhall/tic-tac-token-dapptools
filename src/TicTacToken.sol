// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface UnicornToken is IERC20 {
    function mint(address receiver, uint256 amount) external;
}

contract TicTacToken {
    uint256[9] public board;

    uint256 internal constant X = 1;
    uint256 internal constant O = 2;
    uint256 internal turns;
    UnicornToken internal token;
    address internal owner;
    address internal playerX;
    address internal playerO;

    mapping(address => uint256) internal winsByAddress;

    constructor(UnicornToken _token, address _owner, address _playerX, address _playerO) {
        token = _token;
        owner = _owner;
        playerX = _playerX;
        playerO = _playerO;
    }

    modifier requireAdmin() {
        require(msg.sender == owner, "Unauthorized");
        _;
    }

    modifier requirePlayers() {
        require(msg.sender == playerX || msg.sender == playerO, "Must be authorized player");
        _;
    }

    function markSpace(uint256 i, uint256 symbol) public requirePlayers {
        require(_validTurn(symbol), "Not your turn");
        require(_validSpace(i), "Invalid space");
        require(_validSymbol(symbol), "Invalid symbol");
        require(_emptySpace(i), "Already marked");
        turns++;
        board[i] = symbol;
        _updateScore();
    }

    function getBoard() public view returns (uint256[9] memory) {
        return board;
    }

    function currentTurn() public view returns (uint256) {
        return (turns % 2 == 0) ? X : O;
    }

    function reset(address _playerX, address _playerO) public requireAdmin {
        playerX = _playerX;
        playerO = _playerO;
        turns = 0;
        delete board;
    }

    function winCount(address player) public view returns (uint256) {
        return winsByAddress[player];
    }
    
    function pointScore(address player) public view returns (uint256) {
        if (_hasAnyoneWonIfSoWhoWasIt() == player) {
            return 300;
            // uint256 moves = turns / 2;
            // if(moves == 3) return 300;
            // if(moves == 4) return 200;
            // if(moves == 5) return 100;            
        }
        return 0; // loser
    }

    function winner() public view returns (uint256) {
        return _checkWins();
    }

    function _updateScore() internal {
        address winningPlayer = _hasAnyoneWonIfSoWhoWasIt();
        if (winningPlayer != address(0)) {
            winsByAddress[winningPlayer]++;
            token.mint(winningPlayer, 300);
        }
    }

    function _hasAnyoneWonIfSoWhoWasIt() internal view returns (address) {
        if (_checkWins() == X) return playerX;
        if (_checkWins() == O) return playerO;
        return address(0);
    }

    function _validSpace(uint256 i) internal pure returns (bool) {
        return i < 9;
    }

    function _validTurn(uint256 symbol) internal view returns (bool) {
        return currentTurn() == symbol;
    }

    function _emptySpace(uint256 i) internal view returns (bool) {
        return board[i] == 0;
    }

    function _validSymbol(uint256 symbol) internal pure returns (bool) {
        return symbol == X || symbol == O;
    }

    function _checkWins() internal view returns (uint256) {
        uint256[8] memory wins = [
            _row(0),
            _row(1),
            _row(2),
            _col(0),
            _col(1),
            _col(2),
            _diag(),
            _antiDiag()
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

    function _row(uint256 row) internal view returns (uint256) {
        require(row <= 2, "Invalid row");
        return board[row] * board[row + 1] * board[row + 2];
    }

    function _col(uint256 col) internal view returns (uint256) {
        require(col <= 2, "Invalid col");
        return board[col] * board[col + 3] * board[col + 6];
    }

    function _diag() internal view returns (uint256) {
        return board[0] * board[4] * board[8];
    }

    function _antiDiag() internal view returns (uint256) {
        return board[2] * board[4] * board[6];
    }
}
