// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./utils/TokenTest.sol";

contract TestToken is TokenTest {
    function test_has_name() public {
        assertEq(token.name(), "Triple T Token");
    }

    function test_has_symbol() public {
        assertEq(token.symbol(), "TTT");
    }

    function test_has_decimals() public {
        assertEq(token.decimals(), 18);
    }

    function test_initial_total_supply_is_zero() public {
        assertEq(token.totalSupply(), 0);
    }

    function test_owner_can_increase_total_supply() public {
        uint256 amountToIncrease = 10;

        assertEq(token.totalSupply(), 0);
        owner.mintTTT(amountToIncrease);

        assertEq(token.totalSupply(), amountToIncrease);
    }

    function testFail_nonowner_cannot_increase_total_supply() public {
        uint256 amountToIncrease = 10;

        assertEq(token.totalSupply(), 0);
        user.mintTTT(amountToIncrease);
    }

    function test_minting_increases_account_balance() public {
        uint256 amountToIncrease = 10;

        assertEq(token.balanceOf(address(owner)), 0);
        owner.mintTTT(amountToIncrease);

        assertEq(token.balanceOf(address(owner)), amountToIncrease);
    }

    function test_transferring_amount_increases_recipient_account_balance() public {
        uint256 amountToTransfer = 5;

        assertEq(token.balanceOf(address(user)), 0);
        owner.mintTTT(10);
        owner.transfer(address(user), amountToTransfer);

        assertEq(token.balanceOf(address(user)), amountToTransfer);
    }


    function test_transfer_by_a_third_party_contract() public {
        uint256 amountToTransfer = 5;

        assertEq(token.balanceOf(address(user)), 0);
        owner.mintTTT(10);
        owner.approve(address(this), amountToTransfer);
        token.transferFrom(address(owner), address(user), amountToTransfer);

        assertEq(token.balanceOf(address(user)), amountToTransfer);
    }



}
