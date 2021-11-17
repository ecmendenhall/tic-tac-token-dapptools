// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "ds-test/test.sol";

import "../../TicTacToken.sol";
import "./Hevm.sol";

contract User {
    TicTacToken internal ttt;

    function setTTT(address _ticTacToken) public {
        ttt = TicTacToken(_ticTacToken);
    }

    function reset() public {
        ttt.reset();
    }
}

abstract contract TicTacTokenTest is DSTest {
    Hevm internal constant hevm = Hevm(HEVM_ADDRESS);

    // contracts
    User internal admin;
    User internal player;
    TicTacToken internal ttt;

    function setUp() public virtual {
        admin = new User();
        player = new User();
        ttt = new TicTacToken(address(admin));
        admin.setTTT(address(ttt));
        player.setTTT(address(ttt));
    }
}
