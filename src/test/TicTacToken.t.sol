// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./utils/TicTacTokenTest.sol";

contract TestTTT is TicTacTokenTest {

    uint256 X;
    uint256 O;
    uint256 constant Z = 3;

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

    function test_marks_board_with_X() public {
        ttt.markBoard(0, X);
        assertEq(ttt.getBoard()[0], X);
    }

    function test_marks_board_with_O() public {
        ttt.markBoard(1, X);
        ttt.markBoard(0, O);
        assertEq(ttt.getBoard()[0], O);
    }

    function testFail_cannot_mark_board_with_other_symbol() public {
        ttt.markBoard(0, Z);
    }

    function testFail_cannot_mark_used_square() public {
        ttt.markBoard(0, X);
        ttt.markBoard(0, O);
    }

    function testFail_cannot_mark_out_of_range() public {
        ttt.markBoard(9, X);
    }   

    function testFail_cannot_mark_same_symbol_twice() public {
        ttt.markBoard(0, X);
        ttt.markBoard(1, X);
    }

    function test_get_current_turn() public {
        assertEq(ttt.currentTurn(), X);
        ttt.markBoard(0, X);
        assertEq(ttt.currentTurn(), O);
        ttt.markBoard(1, O);
        assertEq(ttt.currentTurn(), X);
        ttt.markBoard(2, X);
        assertEq(ttt.currentTurn(), O);
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
