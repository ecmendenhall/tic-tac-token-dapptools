// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract TicTacToken {

    uint256 public constant X = 1;
    uint256 public constant O = 2;
    uint256 public constant EMPTY = 0;
    uint256 public currentTurn = X; 
    
    uint256[9] board;

    function getBoard() public view returns (uint256[9] memory) {
        return board;
    }

    function _switchTurn() private {
        uint256 nextTurn = (currentTurn == X) ? O : X;
        currentTurn = nextTurn;
    }

    function markBoard(uint index, uint mark) public {
        require(mark == X || mark == O, "Mark invalid");
        require(index < 9, "Out of bounds");
        require(board[index] == EMPTY, "Already marked");
        require(currentTurn == mark, "Don't cheat");
        board[index] = mark;
        _switchTurn();
    }

}