// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "ds-test/test.sol";

import "../../Token.sol";
import "../../TicTacToken.sol";
import "./Hevm.sol";

contract User {
    TicTacToken internal ttt;

    function setTTT(address _ttt) public {
        ttt = TicTacToken(_ttt);
    }

    function reset(address playerX, address playerO) public {
        ttt.reset(playerX, playerO);
    }

    function markSpace(uint256 i, uint256 symbol) public {
        ttt.markSpace(i, symbol);
    }
}

abstract contract TicTacTokenTest is DSTest {
    Hevm internal constant hevm = Hevm(HEVM_ADDRESS);

    uint256 internal constant EMPTY = 0;
    uint256 internal constant X = 1;
    uint256 internal constant O = 2;

    // contracts
    Token internal token;
    TicTacToken internal ttt;
    User internal admin;
    User internal nonAdmin;

    User internal playerX;
    User internal newPlayerX;
    User internal playerO;
    User internal newPlayerO;
    User internal nonPlayer;

    function setUp() public virtual {
        admin = new User();
        nonAdmin = new User();

        playerX = new User();
        newPlayerX = new User();
        playerO = new User();
        newPlayerO = new User();
        nonPlayer = new User();

        token = new Token();
        ttt = new TicTacToken(
            UnicornToken(address(token)),
            address(admin),
            address(playerX),
            address(playerO)
        );

        admin.setTTT(address(ttt));
        nonAdmin.setTTT(address(ttt));
        playerX.setTTT(address(ttt));
        newPlayerX.setTTT(address(ttt));
        playerO.setTTT(address(ttt));
        newPlayerO.setTTT(address(ttt));
        nonPlayer.setTTT(address(ttt));
    }

    function playGameOWin() public virtual {
        playerX.markSpace(1, X);
        playerO.markSpace(0, O);
        playerX.markSpace(2, X);
        playerO.markSpace(3, O);
        playerX.markSpace(4, X);
        playerO.markSpace(6, O);
    }
}
