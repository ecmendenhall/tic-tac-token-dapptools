// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract TicTacToken {
    uint256[9] public board;

    uint256 internal constant X = 1;
    uint256 internal constant O = 2;

    function getBoard() public view returns (uint256[9] memory) {
        return board;
    }

    function markSpace(uint256 i, uint256 symbol) public {
        require(_validSymbol(symbol), "Invalid symbol");
        require(_emptySpace(i), "Already marked");
        board[i] = symbol;
    }

    function _emptySpace(uint256 i) internal view returns (bool) {
        return board[i] == 0;
    }

    function _validSymbol(uint256 symbol) internal pure returns (bool) {
        return symbol == X || symbol == O;
    }
}
