// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./utils/TicTacTokenTest.sol";

contract TestTTT is TicTacTokenTest {
    uint256 internal X;
    uint256 internal O;

    function setUp() public override {
        super.setUp();
        X = ttt.X();
        O = ttt.O();
    }

    function test_has_empty_board() public {
        uint256[9] memory expected_board = [uint256(0), 0, 0, 0, 0, 0, 0, 0, 0];
        uint256[9] memory actual_board = ttt.getBoard();

        for (uint256 i = 0; i < 9; i++) {
            assertEq(actual_board[i], expected_board[i]);
        }
    }

    function test_set_board_with_X() public {
        ttt.set(0, X);

        assertEq(ttt.board(0), X);
    }

    function test_set_board_with_O() public {
        ttt.set(1, X);
        ttt.set(4, O);

        assertEq(ttt.board(4), O);
    }

    function testFail_set_board_with_other_mark() public {
        ttt.set(1, 5);
    }

    function testFail_space_must_be_valid() public {
        ttt.set(9, X);
    }

    function testFail_space_must_be_empty_to_mark() public {
        ttt.set(3, X);
        ttt.set(3, O);
    }

    function test_gets_current_turn() public {
        assertEq(ttt.currentTurn(), X);
        ttt.set(3, X);
        assertEq(ttt.currentTurn(), O);
        ttt.set(1, O);
        assertEq(ttt.currentTurn(), X);
    }

    function testFail_same_player_cannot_mark_twice_in_a_row() public {
        ttt.set(3, X);
        ttt.set(4, X);
    }

    function test_returns_winner_from_matching_row() public {
        ttt.set(0, X);
        ttt.set(3, O);
        ttt.set(1, X);
        ttt.set(4, O);
        ttt.set(2, X);
        assertEq(ttt.winner(), X);
    }

    function test_returns_winner_from_matching_column() public {
        ttt.set(7, X);
        ttt.set(0, O);
        ttt.set(2, X);
        ttt.set(3, O);
        ttt.set(8, X);
        ttt.set(6, O);
        assertEq(ttt.winner(), O);
    }

    function test_returns_winner_from_matching_diagonal() public {
        ttt.set(3, X);
        ttt.set(0, O);
        ttt.set(1, X);
        ttt.set(4, O);
        ttt.set(2, X);
        ttt.set(8, O);
        assertEq(ttt.winner(), O);
    }

    function test_returns_winner_from_matching_antidiagonal() public {
        ttt.set(2, X);
        ttt.set(0, O);
        ttt.set(4, X);
        ttt.set(1, O);
        ttt.set(6, X);
        assertEq(ttt.winner(), X);
    }
}
