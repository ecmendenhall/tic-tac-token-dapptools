// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./utils/TicTacTokenTest.sol";

contract TestTTT is TicTacTokenTest {
    uint256 internal constant EMPTY = 0;
    uint256 internal constant X = 1;
    uint256 internal constant O = 2;

    function setUp() public override {
        super.setUp();
        ttt.newGame(address(playerX), address(playerO));
    }

    function test_adds_game_to_games_by_address() public {
        ttt.newGame(address(playerX), address(playerO));

        uint256[2] memory expected = [uint256(1), uint256(2)];
        uint256[] memory playerXGames = ttt.getGamesByAddress(address(playerX));
        uint256[] memory playerOGames = ttt.getGamesByAddress(address(playerO));

        assertEq(playerXGames.length, 2);
        assertEq(playerOGames.length, 2);
        for (uint256 i = 0; i < 2; i++) {
            assertEq(playerXGames[i], expected[i]);
            assertEq(playerOGames[i], expected[i]);
        }
    }

    function test_get_board() public {
        uint256[9] memory empty = [
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
        uint256[9] memory actual = ttt.board(1);
        for (uint256 i = 0; i < 9; i++) {
            assertEq(actual[i], empty[i]);
        }
        playerX.markSpace(1, 1, X);
        playerO.markSpace(1, 0, O);
        playerO.markSpace(1, 7, X);
        playerO.markSpace(1, 3, O);
        uint256[9] memory expected = [
            O,
            X,
            EMPTY,
            O,
            EMPTY,
            EMPTY,
            EMPTY,
            X,
            EMPTY
        ];
        actual = ttt.board(1);
        for (uint256 i = 0; i < 9; i++) {
            assertEq(actual[i], expected[i]);
        }
    }

    function test_board_bitmaps_start_empty() public {
        (, , , uint16 playerXBitmap, uint16 playerOBitmap) = ttt.games(1);
        assertEq(playerXBitmap, 0);
        assertEq(playerOBitmap, 0);
    }

    function test_can_mark_space_with_X() public {
        playerX.markSpace(1, 0, X);
        assertEq(ttt.board(1)[0], X);

        (, , , uint16 playerXBitmap, ) = ttt.games(1);
        assertEq(playerXBitmap, 1);
    }

    function test_can_mark_space_with_O() public {
        playerX.markSpace(1, 1, X);
        playerO.markSpace(1, 0, O);
        assertEq(ttt.board(1)[0], O);

        (, , , , uint16 playerOBitmap) = ttt.games(1);
        assertEq(playerOBitmap, 1);
    }

    function testFail_cannot_mark_space_with_other_symbol() public {
        nonPlayer.markSpace(1, 0, 3);
    }

    function testFail_cannot_overwrite_marked_space() public {
        playerX.markSpace(1, 0, X);
        playerO.markSpace(1, 0, O);
    }

    function test_checks_for_horizontal_win() public {
        playerX.markSpace(1, 0, X);
        playerO.markSpace(1, 3, O);
        playerX.markSpace(1, 1, X);
        playerO.markSpace(1, 4, O);
        playerX.markSpace(1, 2, X);
        assertEq(ttt.winner(1), X);
    }

    function testFail_no_moves_after_game_over() public {
        playerX.markSpace(1, 0, X);
        playerO.markSpace(1, 3, O);
        playerX.markSpace(1, 1, X);
        playerO.markSpace(1, 4, O);
        playerX.markSpace(1, 2, X);
        playerX.markSpace(1, 8, O);
    }

    function test_checks_for_vertical_win() public {
        playerX.markSpace(1, 1, X);
        playerO.markSpace(1, 0, O);
        playerX.markSpace(1, 2, X);
        playerO.markSpace(1, 3, O);
        playerX.markSpace(1, 4, X);
        playerO.markSpace(1, 6, O);
        assertEq(ttt.winner(1), O);
    }

    function test_checks_for_diagonal_win() public {
        playerX.markSpace(1, 0, X);
        playerO.markSpace(1, 1, O);
        playerX.markSpace(1, 4, X);
        playerO.markSpace(1, 5, O);
        playerX.markSpace(1, 8, X);
        assertEq(ttt.winner(1), X);
    }

    function test_checks_for_antidiagonal_win() public {
        playerX.markSpace(1, 1, X);
        playerO.markSpace(1, 2, O);
        playerX.markSpace(1, 3, X);
        playerO.markSpace(1, 4, O);
        playerX.markSpace(1, 5, X);
        playerO.markSpace(1, 6, O);
        assertEq(ttt.winner(1), O);
    }

    function test_checks_for_antidiagonal_win_multiple_moves() public {
        playerX.markSpace(1, 4, X);
        playerO.markSpace(1, 7, O);
        playerX.markSpace(1, 5, X);
        playerO.markSpace(1, 8, O);
        playerX.markSpace(1, 2, X);
        playerO.markSpace(1, 3, O);
        playerO.markSpace(1, 6, X);
        assertEq(ttt.winner(1), X);
    }

    function test_returns_zero_on_no_winner() public {
        playerX.markSpace(1, 1, X);
        playerO.markSpace(1, 4, O);
        assertEq(ttt.winner(1), 0);
    }

    function test_returns_zero_on_empty_board() public {
        assertEq(ttt.winner(1), 0);
    }

    function test_tracks_current_turn() public {
        assertEq(ttt.currentTurn(1), X);
        playerX.markSpace(1, 1, X);
        assertEq(ttt.currentTurn(1), O);
        playerO.markSpace(1, 2, O);
        assertEq(ttt.currentTurn(1), X);
    }

    function testFail_cannot_mark_same_symbol_twice() public {
        assertEq(ttt.currentTurn(1), X);
        playerX.markSpace(1, 1, X);
        playerX.markSpace(1, 2, X);
    }

    function testFail_checks_valid_space() public {
        playerX.markSpace(1, 10, X);
    }

    function testFail_non_player_cannot_mark_board() public {
        nonPlayer.markSpace(1, 1, X);
    }

    function test_win_count_is_zero_by_default() public {
        assertEq(ttt.winCount(address(playerX)), 0);
    }

    function test_tracks_number_of_wins_for_x() public {
        assertEq(ttt.winCount(address(playerX)), 0);
        playerX.markSpace(1, 0, X);
        playerO.markSpace(1, 3, O);
        playerX.markSpace(1, 1, X);
        playerO.markSpace(1, 4, O);
        playerX.markSpace(1, 2, X);
        assertEq(ttt.winCount(address(playerX)), 1);
    }

    function test_tracks_number_of_wins_for_o() public {
        assertEq(ttt.winCount(address(playerO)), 0);
        playerX.markSpace(1, 0, X);
        playerO.markSpace(1, 3, O);
        playerX.markSpace(1, 1, X);
        playerO.markSpace(1, 4, O);
        playerX.markSpace(1, 7, X);
        playerO.markSpace(1, 5, O);
        assertEq(ttt.winCount(address(playerO)), 1);
    }

    function test_win_row_2() public {
        playerX.markSpace(1, 0, X);
        playerO.markSpace(1, 3, O);
        playerX.markSpace(1, 1, X);
        playerO.markSpace(1, 4, O);
        playerX.markSpace(1, 7, X);
        playerO.markSpace(1, 5, O);
        assertEq(ttt.winner(1), O);
    }

    function test_win_row_3() public {
        playerX.markSpace(1, 0, X);
        playerO.markSpace(1, 6, O);
        playerX.markSpace(1, 1, X);
        playerO.markSpace(1, 7, O);
        playerX.markSpace(1, 3, X);
        playerO.markSpace(1, 8, O);
        assertEq(ttt.winner(1), O);
    }

    function test_win_col_2() public {
        playerX.markSpace(1, 0, X);
        playerO.markSpace(1, 1, O);
        playerX.markSpace(1, 2, X);
        playerO.markSpace(1, 4, O);
        playerX.markSpace(1, 3, X);
        playerO.markSpace(1, 7, O);
        assertEq(ttt.winner(1), O);
    }

    function test_win_col_3() public {
        playerX.markSpace(1, 0, X);
        playerO.markSpace(1, 2, O);
        playerX.markSpace(1, 1, X);
        playerO.markSpace(1, 5, O);
        playerX.markSpace(1, 4, X);
        playerO.markSpace(1, 8, O);
        assertEq(ttt.winner(1), O);
    }

    function test_point_count_is_zero_by_default() public {
        assertEq(ttt.pointCount(address(playerX)), 0);
    }

    function test_tracks_number_of_points_for_x() public {
        assertEq(ttt.pointCount(address(playerX)), 0);
        playerX.markSpace(1, 0, X);
        playerO.markSpace(1, 3, O);
        playerX.markSpace(1, 1, X);
        playerO.markSpace(1, 4, O);
        playerX.markSpace(1, 2, X);
        assertEq(ttt.pointCount(address(playerX)), 300 ether);
    }

    function test_fewest_number_of_moves_nets_300_points() public {
        assertEq(ttt.pointCount(address(playerX)), 0);
        playerX.markSpace(1, 0, X);
        playerO.markSpace(1, 3, O);
        playerX.markSpace(1, 1, X);
        playerO.markSpace(1, 4, O);
        playerX.markSpace(1, 2, X);
        assertEq(ttt.pointCount(address(playerX)), 300 ether);
    }

    function test_has_token_address() public {
        assertEq(address(ttt.token()), address(token));
    }

    function test_sends_tokens_to_winner() public {
        assertEq(token.balanceOf(address(playerX)), 0);
        playerX.markSpace(1, 0, X);
        playerO.markSpace(1, 3, O);
        playerX.markSpace(1, 1, X);
        playerO.markSpace(1, 4, O);
        playerX.markSpace(1, 2, X);
        assertEq(token.balanceOf(address(playerX)), 300 ether);
    }

    function test_new_game_has_players() public {
        ttt.newGame(address(playerX), address(playerO));
        (address storedX, address storedO, , , ) = ttt.games(1);
        assertEq(address(playerX), storedX);
        assertEq(address(playerO), storedO);
    }

    function test_new_game_has_turns() public {
        ttt.newGame(address(playerX), address(playerO));
        (, , uint256 turns, , ) = ttt.games(1);
        assertEq(turns, 0);
    }

    function test_new_game_increments_id() public {
        ttt.newGame(address(playerX), address(playerO));
        ttt.newGame(address(playerX), address(playerO));
        (address storedX, address storedO, uint256 turns, , ) = ttt.games(2);
        assertEq(address(playerX), storedX);
        assertEq(address(playerO), storedO);
        assertEq(turns, 0);
    }

    function test_issues_tokens_to_players_on_new_game() public {
        assertEq(nft.balanceOf(address(playerX)), 1);
        assertEq(nft.balanceOf(address(playerO)), 1);
    }

    function test_issues_unique_tokens_to_players() public {
        ttt.newGame(address(playerX), address(playerO));
        ttt.newGame(address(playerX), address(playerO));

        assertEq(nft.ownerOf(1), address(playerX));
        assertEq(nft.ownerOf(3), address(playerX));
        assertEq(nft.ownerOf(5), address(playerX));
        assertEq(nft.ownerOf(2), address(playerO));
        assertEq(nft.ownerOf(4), address(playerO));
        assertEq(nft.ownerOf(6), address(playerO));
    }

    function test_gets_token_id_for_game() public {
        ttt.newGame(address(playerX), address(playerO));
        ttt.newGame(address(playerX), address(playerO));

        assertEq(ttt.gameIdByTokenId(1), 1);
        assertEq(ttt.gameIdByTokenId(2), 1);
        assertEq(ttt.gameIdByTokenId(3), 2);
        assertEq(ttt.gameIdByTokenId(4), 2);
        assertEq(ttt.gameIdByTokenId(5), 3);
        assertEq(ttt.gameIdByTokenId(6), 3);
    }
}
