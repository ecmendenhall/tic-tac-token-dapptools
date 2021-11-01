// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract TicTacToken {
    uint8[9] public board;

    uint8 internal constant X = 1;
    uint8 internal constant O = 2;

    function getBoard() public view returns (uint8[9] memory) {
        return board;
    }

    function markSpace(uint8 i, uint8 symbol) public {
        require(_validSymbol(symbol), "Invalid symbol");
        require(_emptySpace(i), "Already marked");
        board[i] = symbol;
    }

    function winner() public view returns (uint8) {
        return _checkWins();
    }

    function _emptySpace(uint8 i) internal view returns (bool) {
        return board[i] == 0;
    }

    function _validSymbol(uint8 symbol) internal pure returns (bool) {
        return symbol == X || symbol == O;
    }

    function _checkWins() internal view returns (uint8) {
        uint8[8] memory wins = [
            _row(0),
            _row(1),
            _row(2),
            _col(0),
            _col(1),
            _col(2),
            _diag(),
            _antiDiag()
        ];
        for (uint8 i = 0; i < wins.length; i++) {
            if (wins[i] == 1) {
                return X;
            } else if (wins[i] == 8) {
                return O;
            }
        }
        return 0;
    }

    function _row(uint8 row) internal view returns (uint8) {
        require(row <= 2, "Invalid row");
        return board[row] * board[row + 1] * board[row + 2];    }

    function _col(uint8 col) internal view returns (uint8) {
        require(col <= 2, "Invalid col");
        return board[col] * board[col + 3] * board[col + 6];
    }

    function _diag() internal view returns (uint8) {
        return board[0] * board[4] * board[8];
    }

    function _antiDiag() internal view returns (uint8) {
        return board[2] * board[4] * board[6];
    }
}
