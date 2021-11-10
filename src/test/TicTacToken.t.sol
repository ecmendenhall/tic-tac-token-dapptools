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

        for(uint256 i=0; i < 9; i++) {
           assertEq(actual_board[i], expected_board[i]);
        }
    }

    function test_set_board_with_X() public {
        uint256 spot = 0;

        ttt.set(spot, X);

        assertEq(ttt.board(spot), X);
    }

    function test_set_board_with_O() public {
        uint256 spot = 4;

        ttt.set(spot, O);
        
        assertEq(ttt.board(spot), O);
    }

    function testFail_set_board_with_other_mark() public {
      uint256 spot = 1;

      ttt.set(spot, 5);
    }

}
