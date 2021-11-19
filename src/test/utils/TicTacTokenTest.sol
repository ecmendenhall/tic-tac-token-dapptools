// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "ds-test/test.sol";

import "../../TicTacToken.sol";
import "./Hevm.sol";

contract User {

    TicTacToken internal ttt;

    function reset() public {
        ttt.reset();
    }

    function markSpace(uint256 i, uint256 symbol) public {
        ttt.markSpace(i, symbol);
    }

    function setTTT(address _ttt) public {
        ttt = TicTacToken(_ttt);
    }

}

abstract contract TicTacTokenTest is DSTest {
    Hevm internal constant hevm = Hevm(HEVM_ADDRESS);

    // contracts
    TicTacToken internal ttt;
    User internal admin;
    User internal playerOne;
    User internal playerTwo;

    function setUp() public virtual {
        admin = new User();
        playerOne = new User();
        playerTwo = new User();
        ttt = new TicTacToken(address(admin), address(playerOne), address(playerTwo));
        admin.setTTT(address(ttt));
        playerOne.setTTT(address(ttt));
        playerTwo.setTTT(address(ttt));
    }
}
