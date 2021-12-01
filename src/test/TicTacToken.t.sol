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
        playerX.markSpace(0);
        assertEq(ttt.board(0), X);
    }

    function test_can_mark_space_with_O() public {
        playerX.markSpace(1);
        playerO.markSpace(0);
        assertEq(ttt.board(0), O);
    }

    function testFail_cannot_overwrite_marked_space() public {
        playerX.markSpace(0);
        playerO.markSpace(0);
    }

    function test_checks_for_horizontal_win() public {
        playerX.markSpace(0);
        playerO.markSpace(3);
        playerX.markSpace(1);
        playerO.markSpace(4);
        playerX.markSpace(2);
        assertEq(ttt.winner(), X);
    }

    function test_checks_for_vertical_win() public {
        playerX.markSpace(1);
        playerO.markSpace(0);
        playerX.markSpace(2);
        playerO.markSpace(3);
        playerX.markSpace(4);
        playerO.markSpace(6);
        assertEq(ttt.winner(), O);
    }

    function test_checks_for_diagonal_win() public {
        playerX.markSpace(0);
        playerO.markSpace(1);
        playerX.markSpace(4);
        playerO.markSpace(5);
        playerX.markSpace(8);
        assertEq(ttt.winner(), X);
    }

    function test_checks_for_antidiagonal_win() public {
        playerX.markSpace(1);
        playerO.markSpace(2);
        playerX.markSpace(3);
        playerO.markSpace(4);
        playerX.markSpace(5);
        playerO.markSpace(6);
        assertEq(ttt.winner(), O);
    }

    function test_returns_zero_on_no_winner() public {
        playerX.markSpace(1);
        playerO.markSpace(4);
        assertEq(ttt.winner(), 0);
    }

    function test_returns_zero_on_empty_board() public {
        assertEq(ttt.winner(), 0);
    }

    function test_tracks_current_turn() public {
        assertEq(ttt.currentTurn(), X);
        playerX.markSpace(1);
        assertEq(ttt.currentTurn(), O);
        playerO.markSpace(2);
        assertEq(ttt.currentTurn(), X);
    }

    function testFail_cannot_mark_same_symbol_twice() public {
        assertEq(ttt.currentTurn(), X);
        ttt.markSpace(1);
        ttt.markSpace(2);
    }

    function testFail_checks_valid_space() public {
        playerX.markSpace(10);
    }

    function testFail_non_admin_cannot_reset_board() public {
        playerX.reset();
    }

    function test_resets_board() public {
        playerX.markSpace(1);
        playerO.markSpace(2);
        playerX.markSpace(3);
        admin.reset();
        for (uint256 i = 0; i < 9; i++) {
            assertEq(ttt.board(i), 0);
        }
    }

    function testFail_non_player_cannot_call_mark_space() public {
        other.markSpace(1);
    }

    function test_stores_playerX_address() public {
        assertEq(ttt.playerX(), address(playerX));
    }

    function test_stores_playerO_address() public {
        assertEq(ttt.playerO(), address(playerO));
    }

    function test_playerX_wins_start_at_zero() public {
        assertEq(ttt.totalWins(address(playerX)), 0);
    }

    function test_playerO_wins_start_at_zero() public {
        assertEq(ttt.totalWins(address(playerO)), 0);
    }

    function test_increments_playerX_win_count_on_win() public {
        playerX.markSpace(0);
        playerO.markSpace(3);
        playerX.markSpace(1);
        playerO.markSpace(4);
        playerX.markSpace(2);
        assertEq(ttt.totalWins(address(playerX)), 1);
    }

    function test_increments_playerO_win_count_on_win() public {
        playerX.markSpace(1);
        playerO.markSpace(0);
        playerX.markSpace(2);
        playerO.markSpace(3);
        playerX.markSpace(4);
        playerO.markSpace(6);
        assertEq(ttt.totalWins(address(playerO)), 1);
    }

    function test_total_games_starts_at_zero() public {
        assertEq(ttt.totalGames(), 0);
    }

    function test_increments_total_games_count_on_win() public {
        playerX.markSpace(0);
        playerO.markSpace(3);
        playerX.markSpace(1);
        playerO.markSpace(4);
        playerX.markSpace(2);
        assertEq(ttt.totalGames(), 1);
    }

    function test_three_move_win_X() public {
        // x | x | x
        // o | o | .
        // . | . | .
        playerX.markSpace(0);
        playerO.markSpace(3);
        playerX.markSpace(1);
        playerO.markSpace(4);
        playerX.markSpace(2);
        assertEq(ttt.totalPoints(address(playerX)), 300);
    }

    function test_four_move_win_X() public {
        // x | x | x
        // o | o | .
        // x | o | .
        playerX.markSpace(0);
        playerO.markSpace(3);
        playerX.markSpace(1);
        playerO.markSpace(4);
        playerX.markSpace(6);
        playerO.markSpace(7);
        playerX.markSpace(2);
        assertEq(ttt.totalPoints(address(playerX)), 200);
    }

    function test_five_move_win_X() public {
        // x | x | x
        // o | o | x
        // x | o | o
        playerX.markSpace(0);
        playerO.markSpace(3);
        playerX.markSpace(1);
        playerO.markSpace(4);
        playerX.markSpace(6);
        playerO.markSpace(7);
        playerX.markSpace(5);
        playerO.markSpace(8);
        playerX.markSpace(2);
        assertEq(ttt.totalPoints(address(playerX)), 100);
    }

    function test_three_move_win_O() public {
        // o | x | x
        // o | x | .
        // o | . | .
        playerX.markSpace(1);
        playerO.markSpace(0);
        playerX.markSpace(2);
        playerO.markSpace(3);
        playerX.markSpace(4);
        playerO.markSpace(6);
        assertEq(ttt.totalPoints(address(playerO)), 300);
    }

    function test_four_move_win_O() public {
        // o | x | x
        // o | x | x
        // o | . | o
        playerX.markSpace(1);
        playerO.markSpace(0);
        playerX.markSpace(2);
        playerO.markSpace(3);
        playerX.markSpace(4);
        playerO.markSpace(8);
        playerX.markSpace(5);
        playerO.markSpace(6);
        assertEq(ttt.totalPoints(address(playerO)), 200);
    }
}
