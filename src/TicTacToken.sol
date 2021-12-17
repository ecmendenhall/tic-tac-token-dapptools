// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IToken is IERC20 {
    function mintTTT(uint256 amount) external;
}

contract TicTacToken {
    uint256[9] public board;

    uint256 internal constant X = 1;
    uint256 internal constant O = 2;
    uint256 internal constant POINTS_PER_WIN = 300;
    uint256 internal turns;
    address internal owner;
    address internal playerX;
    address internal playerO;
    mapping(address => uint256) internal winCountByAddress;
    mapping(address => uint256) internal pointCountByAddress;
    IToken public token;

    constructor(
        address _owner,
        address _playerX,
        address _playerO,
        address _token
    ) {
        owner = _owner;
        playerX = _playerX;
        playerO = _playerO;
        token = IToken(_token);
    }

    modifier requireAdmin() {
        require(msg.sender == owner, "Unauthorized");
        _;
    }

    modifier requirePlayers() {
        require(
            msg.sender == playerX || msg.sender == playerO,
            "Must be authorized player"
        );
        _;
    }

    function markSpace(uint256 i, uint256 symbol) public requirePlayers {
        require(_validTurn(symbol), "Not your turn");
        require(_validSpace(i), "Invalid space");
        require(_validSymbol(symbol), "Invalid symbol");
        require(_emptySpace(i), "Already marked");
        turns++;
        board[i] = symbol;

        uint256 winningSymbol = winner();
        if (winningSymbol != 0) {
            address winnerAddress = _getPlayerAddress(winningSymbol);
            _incrementWinCount(winnerAddress);
            _incrementPointCount(winnerAddress);
            token.mintTTT(POINTS_PER_WIN / 100);
            token.transfer(winnerAddress, POINTS_PER_WIN / 100);
        }
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
        delete board;
    }

    function winner() public view returns (uint256) {
        return _checkWins();
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
        uint256 pos = row * 3;
        return board[pos] * board[pos + 1] * board[pos + 2];
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

    function _getPlayerAddress(uint256 playerSymbol)
        private
        view
        returns (address)
    {
        if (playerSymbol == X) {
            return playerX;
        } else if (playerSymbol == O) {
            return playerO;
        } else {
            return address(0);
        }
    }
}
