// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./utils/TokenTest.sol";

contract TestToken is TokenTest {
    function test_has_name() public {
        assertEq(token.name(), "Unicorn Token");
    }

    function test_has_symbol() public {
        assertEq(token.symbol(), "UCORN");
    }

    function test_has_total_supply() public {
        assertEq(token.totalSupply(), 0);
    }

    function test_has_decimals() public {
        assertEq(token.decimals(), 18);
    }

    function test_has_balance() public {
        assertEq(token.balanceOf(address(user1)), 0);
    }

    function test_user_can_mint() public {
        user1.mint(address(user1), 1000 ether);
        assertEq(token.balanceOf(address(user1)), 1000 ether);
    }

    function test_user_can_transfer() public {
        user1.mint(address(user1), 1000 ether);
        user1.transfer(address(user2), 5 ether);

        assertEq(token.balanceOf(address(user1)), 995 ether);
        assertEq(token.balanceOf(address(user2)), 5 ether);
    }
}
