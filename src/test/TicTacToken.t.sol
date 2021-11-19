// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./utils/TicTacTokenTest.sol";

contract TestTTT is TicTacTokenTest {
    uint256 internal constant EMPTY = 0;
    uint256 internal constant X = 1;
    uint256 internal constant O = 2;

    function test_has_empty_board() public {
        for (uint256 i = 0; i < 9; i++) {
            assertEq(ttt.board(i), 0);
        }
    }

    function test_get_board() public {
        uint256[9] memory expected = [
            EMPTY,
            EMPTY,
            EMPTY,
            EMPTY,
            EMPTY,
            EMPTY,
            EMPTY,
            EMPTY,
            EMPTY
        ];
        uint256[9] memory actual = ttt.getBoard();
        for (uint256 i = 0; i < 9; i++) {
            assertEq(actual[i], expected[i]);
        }
    }

    function test_can_mark_space_with_X() public {
        playerOne.markSpace(0, X);
        assertEq(ttt.board(0), X);
    }

    function test_can_mark_space_with_O() public {
        playerOne.markSpace(1, X);
        playerTwo.markSpace(0, O);
        assertEq(ttt.board(0), O);
    }

    function testFail_cannot_mark_space_with_other_symbol() public {
        playerTwo.markSpace(0, 3);
    }

    function testFail_cannot_overwrite_marked_space() public {
        playerOne.markSpace(0, X);
        playerTwo.markSpace(0, O);
    }

    function test_checks_for_horizontal_win() public {
        playerOne.markSpace(0, X);
        playerTwo.markSpace(3, O);
        playerOne.markSpace(1, X);
        playerTwo.markSpace(4, O);
        playerOne.markSpace(2, X);
        assertEq(ttt.winner(), X);
    }

    function test_checks_for_vertical_win() public {
        playerOne.markSpace(1, X);
        playerTwo.markSpace(0, O);
        playerOne.markSpace(2, X);
        playerTwo.markSpace(3, O);
        playerOne.markSpace(4, X);
        playerTwo.markSpace(6, O);
        assertEq(ttt.winner(), O);
    }

    function test_checks_for_diagonal_win() public {
        playerOne.markSpace(0, X);
        playerTwo.markSpace(1, O);
        playerOne.markSpace(4, X);
        playerTwo.markSpace(5, O);
        playerOne.markSpace(8, X);
        assertEq(ttt.winner(), X);
    }

    function test_checks_for_antidiagonal_win() public {
        playerOne.markSpace(1, X);
        playerTwo.markSpace(2, O);
        playerOne.markSpace(3, X);
        playerTwo.markSpace(4, O);
        playerOne.markSpace(5, X);
        playerTwo.markSpace(6, O);
        assertEq(ttt.winner(), O);
    }

    function test_returns_zero_on_no_winner() public {
        playerOne.markSpace(1, X);
        playerTwo.markSpace(4, O);
        assertEq(ttt.winner(), 0);
    }

    function test_returns_zero_on_empty_board() public {
        assertEq(ttt.winner(), 0);
    }

    function test_tracks_current_turn() public {
        assertEq(ttt.currentTurn(), X);
        playerOne.markSpace(1, X);
        assertEq(ttt.currentTurn(), O);
        playerTwo.markSpace(2, O);
        assertEq(ttt.currentTurn(), X);
    }

    function testFail_cannot_mark_same_symbol_twice() public {
        assertEq(ttt.currentTurn(), X);
        playerOne.markSpace(1, X);
        playerOne.markSpace(2, X);
    }

    function testFail_checks_valid_space() public {
        playerOne.markSpace(10, X);
    }

    function testFail_non_admin_cannot_reset_board() public {  
        playerOne.reset();
    }

    function test_stores_admin_address() public {
        assertEq(ttt.admin(), address(admin));
    }


    function test_stores_player_one_address() public {
        assertEq(ttt.playerOne(), address(playerOne));
    }

    function test_stores_player_two_address() public {
        assertEq(ttt.playerTwo(), address(playerTwo));
    }

    function test_admin_can_reset_board() public {
        playerOne.markSpace(1, X);
        playerTwo.markSpace(2, O);
        playerOne.markSpace(3, X);
        admin.reset();
        for (uint256 i = 0; i < 9; i++) {
            assertEq(ttt.board(i), 0);
        }
    }

    function test_playerOne_can_mark_space() public {
        playerOne.markSpace(1, X);
        assertEq(ttt.board(1), X);
    }

    function test_playerTwo_can_mark_space() public {
        playerTwo.markSpace(1, X);
        assertEq(ttt.board(1), X);
    }

    function testFail_admin_cannot_mark_space() public {
        admin.markSpace(1, X);
    }
    



}
