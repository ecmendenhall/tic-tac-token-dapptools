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

    function test_win_count_is_zero_by_default() public {
        assertEq(ttt.winCount(address(playerX)), 0);
    }

    function test_tracks_number_of_wins_for_x() public {
        assertEq(ttt.winCount(address(playerX)), 0);
        playerX.markSpace(0, X);
        playerO.markSpace(3, O);
        playerX.markSpace(1, X);
        playerO.markSpace(4, O);
        playerX.markSpace(2, X);
        assertEq(ttt.winCount(address(playerX)), 1);
    }

    function test_tracks_number_of_wins_for_o() public {
        assertEq(ttt.winCount(address(playerO)), 0);
        playerX.markSpace(0, X);
        playerO.markSpace(3, O);
        playerX.markSpace(1, X);
        playerO.markSpace(4, O);
        playerX.markSpace(7, X);
        playerO.markSpace(5, O);
        assertEq(ttt.winCount(address(playerO)), 1);
    }

    function test_win_row_2() public {
        playerX.markSpace(0, X);
        playerO.markSpace(3, O);
        playerX.markSpace(1, X);
        playerO.markSpace(4, O);
        playerX.markSpace(7, X);
        playerO.markSpace(5, O);
        assertEq(ttt.winner(), O);
    }

    function test_win_row_3() public {
        playerX.markSpace(0, X);
        playerO.markSpace(6, O);
        playerX.markSpace(1, X);
        playerO.markSpace(7, O);
        playerX.markSpace(3, X);
        playerO.markSpace(8, O);
        assertEq(ttt.winner(), O);
    }

    function test_win_col_2() public {
        playerX.markSpace(0, X);
        playerO.markSpace(1, O);
        playerX.markSpace(2, X);
        playerO.markSpace(4, O);
        playerX.markSpace(3, X);
        playerO.markSpace(7, O);
        assertEq(ttt.winner(), O);
    }

    function test_win_col_3() public {
        playerX.markSpace(0, X);
        playerO.markSpace(2, O);
        playerX.markSpace(1, X);
        playerO.markSpace(5, O);
        playerX.markSpace(4, X);
        playerO.markSpace(8, O);
        assertEq(ttt.winner(), O);
    }

    function test_point_count_is_zero_by_default() public {
        assertEq(ttt.pointCount(address(playerX)), 0);
    }
    function test_tracks_number_of_points_for_x() public {
        assertEq(ttt.pointCount(address(playerX)), 0);
        playerX.markSpace(0, X);
        playerO.markSpace(3, O);
        playerX.markSpace(1, X);
        playerO.markSpace(4, O);
        playerX.markSpace(2, X);
        assertEq(ttt.pointCount(address(playerX)), 300);
    }

    function test_fewest_number_of_moves_nets_300_points() public {
        assertEq(ttt.pointCount(address(playerX)), 0);
        playerX.markSpace(0, X);
        playerO.markSpace(3, O);
        playerX.markSpace(1, X);
        playerO.markSpace(4, O);
        playerX.markSpace(2, X);
        assertEq(ttt.pointCount(address(playerX)), 300);
    }

    function test_four_move_win_nets_200_points() public {
        assertEq(ttt.pointCount(address(playerO)), 0);
        // X|O|X
        // X|O|X
        // O|O|.
        playerX.markSpace(0, X);
        playerO.markSpace(1, O);
        playerX.markSpace(2, X);
        playerO.markSpace(4, O);
        playerX.markSpace(3, X);
        playerO.markSpace(6, O);
        playerX.markSpace(5, X);
        playerO.markSpace(7, O);
        assertEq(ttt.pointCount(address(playerO)), 200);
    }
}
