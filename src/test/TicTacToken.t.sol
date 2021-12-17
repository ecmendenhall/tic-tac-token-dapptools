// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./utils/TicTacTokenTest.sol";

contract TestTTT is TicTacTokenTest {
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
        playerO.markSpace(0, X);
        assertEq(ttt.board(0), X);
    }

    function test_can_mark_space_with_O() public {
        playerX.markSpace(1, X);
        playerO.markSpace(0, O);
        assertEq(ttt.board(0), O);
    }

    function testFail_cannot_mark_space_with_other_symbol() public {
        nonPlayer.markSpace(0, 3);
    }

    function testFail_cannot_overwrite_marked_space() public {
        playerX.markSpace(0, X);
        playerO.markSpace(0, O);
    }

    function test_checks_for_horizontal_win() public {
        playerX.markSpace(0, X);
        playerO.markSpace(3, O);
        playerX.markSpace(1, X);
        playerO.markSpace(4, O);
        playerX.markSpace(2, X);
        assertEq(ttt.winner(), X);
    }

    function test_checks_for_vertical_win() public {
        playerX.markSpace(1, X);
        playerO.markSpace(0, O);
        playerX.markSpace(2, X);
        playerO.markSpace(3, O);
        playerX.markSpace(4, X);
        playerO.markSpace(6, O);
        assertEq(ttt.winner(), O);
    }

    function test_checks_for_diagonal_win() public {
        playerX.markSpace(0, X);
        playerO.markSpace(1, O);
        playerX.markSpace(4, X);
        playerO.markSpace(5, O);
        playerX.markSpace(8, X);
        assertEq(ttt.winner(), X);
    }

    function test_checks_for_antidiagonal_win() public {
        playerX.markSpace(1, X);
        playerO.markSpace(2, O);
        playerX.markSpace(3, X);
        playerO.markSpace(4, O);
        playerX.markSpace(5, X);
        playerO.markSpace(6, O);
        assertEq(ttt.winner(), O);
    }

    function test_returns_zero_on_no_winner() public {
        playerX.markSpace(1, X);
        playerO.markSpace(4, O);
        assertEq(ttt.winner(), 0);
    }

    function test_returns_zero_on_empty_board() public {
        assertEq(ttt.winner(), 0);
    }

    function test_tracks_current_turn() public {
        assertEq(ttt.currentTurn(), X);
        playerX.markSpace(1, X);
        assertEq(ttt.currentTurn(), O);
        playerO.markSpace(2, O);
        assertEq(ttt.currentTurn(), X);
    }

    function testFail_cannot_mark_same_symbol_twice() public {
        assertEq(ttt.currentTurn(), X);
        playerX.markSpace(1, X);
        playerX.markSpace(2, X);
    }

    function testFail_checks_valid_space() public {
        playerX.markSpace(10, X);
    }

    function test_admin_can_reset_board() public {
        playerX.markSpace(1, X);
        playerO.markSpace(2, O);
        playerX.markSpace(3, X);
        admin.reset(address(newPlayerX), address(newPlayerO));
        for (uint256 i = 0; i < 9; i++) {
            assertEq(ttt.board(i), 0);
        }
    }

    function testFail_non_admin_cannot_reset_board() public {
        nonAdmin.reset(address(newPlayerX), address(newPlayerO));
    }

    function testFail_non_player_cannot_mark_board() public {
        nonPlayer.markSpace(1, X);
    }

    function test_wins_start_at_zero_by_default() public {
        assertEq(ttt.winCount(address(playerX)), 0);
    }

    function test_wins_increments_on_win() public {
        playerX.markSpace(0, X);
        playerO.markSpace(3, O);
        playerX.markSpace(1, X);
        playerO.markSpace(4, O);
        playerX.markSpace(2, X);

        admin.reset(address(playerX), address(playerO));

        playerX.markSpace(1, X);
        playerO.markSpace(0, O);
        playerX.markSpace(2, X);
        playerO.markSpace(3, O);
        playerX.markSpace(4, X);
        playerO.markSpace(6, O);

        assertEq(ttt.winCount(address(playerX)), 1);
        assertEq(ttt.winCount(address(playerO)), 1);
    }

    function test_reset_internal_turns() public {
        playerX.markSpace(0, X);
        assertEq(ttt.currentTurn(), O);

        admin.reset(address(playerX), address(playerO));
        assertEq(ttt.currentTurn(), X);
    }

    function test_winner_receives_token() public {
        assertEq(token.balanceOf(address(playerO)), 0);

        playGameOWin();

        assertEq(token.balanceOf(address(playerO)), 300);
    }

    function test_scores_300_points_for_3_moves() public {
        playGameOWin();

        assertEq(ttt.pointScore(address(playerX)), 0);
        assertEq(ttt.pointScore(address(playerO)), 300);
    }

    // function test_scores_200_points_for_4_moves() public {
    //     // O|X|X
    //     // O|X|.
    //     // O|.|.
    //     playerX.markSpace(1, X);
    //     playerO.markSpace(0, O);
    //     playerX.markSpace(2, X);
    //     playerO.markSpace(3, O);
    //     playerX.markSpace(4, X);
    //     playerO.markSpace(7, O);
    //     playerX.markSpace(5, X);
    //     playerO.markSpace(6, O);

    //     assertEq(ttt.pointScore(address(playerX)), 0);
    //     assertEq(ttt.pointScore(address(playerO)), 200);
    // }

    // function test_scores_100_points_for_5_moves() public {
    //     // O|X|X
    //     // O|X|X
    //     // X|O|O
    //     playerX.markSpace(1, X);
    //     playerO.markSpace(0, O);
    //     playerX.markSpace(2, X);
    //     playerO.markSpace(3, O);
    //     playerX.markSpace(4, X);
    //     playerO.markSpace(7, O);
    //     playerX.markSpace(5, X);
    //     playerO.markSpace(8, O);
    //     playerX.markSpace(6, X);

    //     assertEq(ttt.pointScore(address(playerX)), 100);
    //     assertEq(ttt.pointScore(address(playerO)), 0);
    // }
}
