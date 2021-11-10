// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract TicTacToken {
    uint256[9] public board;
    uint256 public X = 1;
    uint256 public O = 2;
    
    function getBoard() public view returns (uint256[9] memory) {
        return board;
    }

    function set(uint256 index, uint256 val) public {
        require(val == X || val == O, "Invalid mark");
        board[index] = val;
    }
}