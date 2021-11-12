// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract TicTacToken {
    uint256[9] public board;

    uint256 public constant X = 1;
    uint256 public constant O = 2;
    uint256 public constant EMPTY = 0;

    uint256 public currentTurn = X;

    uint256[3][8] public winningSequences = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ];

    function getBoard() public view returns (uint256[9] memory) {
        return board;
    }

    function set(uint256 space, uint256 piece) public {
        require(space < 9, "Invalid space");
        require(piece == X || piece == O, "Invalid piece");
        require(board[space] == EMPTY, "Space is taken!");
        require(piece == currentTurn, "It's not your turn!");
        board[space] = piece;
        _toggleTurn();
    }

    function _toggleTurn() private {
        currentTurn = (currentTurn == X) ? O : X;
    }

    function winner() public view returns (uint256) {
        for (uint256 i = 0; i < winningSequences.length; i++) {
            uint256 check = _checkSequence(winningSequences[i]);
            if (check != EMPTY) {
                return check;
            }
        }
        return EMPTY;
    }

    function _checkSequence(uint256[3] memory sequence)
        private
        view
        returns (uint256)
    {
        uint256 product = board[sequence[0]] *
            board[sequence[1]] *
            board[sequence[2]];
        if (product == 1) {
            return X;
        } else if (product == 8) {
            return O;
        }
        return EMPTY;
    }
}
