// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract TicTacToken {

    uint256 public constant X = 1;
    uint256 public constant O = 2;
    uint256 public constant EMPTY = 0;
    
    uint256[9] board;

    function getBoard() public returns (uint256[9] memory) {
        return board;
    }

    function markBoard(uint index, uint mark) public {
        board[index] = mark;
    }

}
