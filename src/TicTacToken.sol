// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

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
    uint256 internal turns;
    address internal owner;
    address internal playerX;
    address internal playerO;

    constructor(
        address _admin,
        address _playerX,
        address _playerO
    ) {
        admin = _admin;
        playerX = _playerX;
        playerO = _playerO;
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

    function getBoard() public view returns (uint256[9] memory) {
        return board;
    }

    function currentTurn() public view returns (uint256) {
        return (turns % 2 == 0) ? X : O;
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
