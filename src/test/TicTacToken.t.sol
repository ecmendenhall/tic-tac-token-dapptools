// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./utils/TicTacTokenTest.sol";

contract TestTTT is TicTacTokenTest {

    uint256 X;
    uint256 O;

    function setUp() public override {
        super.setUp();
        X = ttt.X();
        O = ttt.O();
    }

    function test_create_board_of_9() public {
        uint256[9] memory board = ttt.getBoard();
        assertEq(board.length, 9);
    }

    function test_empty_array_index() public {
        uint256[9] memory board = ttt.getBoard();
        assertEq(board[3], 0);
    }

    function test_empty_board() public {
        uint256[9] memory emptyBoard;
        assertTrue(assertBoardsEq(ttt.getBoard(), emptyBoard));
    }

    function test_marks_board() public {
        ttt.markBoard(0, X);
        assertEq(ttt.getBoard()[0], X);
    }

    function assertBoardsEq(uint[9] memory array1, uint[9] memory array2) private pure returns (bool) {
        for (uint256 index = 0; index < array2.length; index++) {
            if (array2[index] != array1[index]) {
                return false;
            }
        }
        return true;
    }

}
