// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";

import "./utils/FizzbuzzTest.sol";

contract TestFizzbuzz is FizzbuzzTest {
    using Strings for uint256;

    function test_returns_fizz_when_divisible_by_three(uint256 n) public {
        if (n % 3 != 0) return;
        if (n % 3 == 0 && n % 5 == 0) return;
        assertEq(fizzbuzz.fizzbuzz(n), "fizz");
    }

    function test_returns_buzz_when_divisible_by_five(uint256 n) public {
        if (n % 5 != 0) return;
        if (n % 3 == 0 && n % 5 == 0) return;
        assertEq(fizzbuzz.fizzbuzz(n), "buzz");
    }

    function test_returns_fizzbuzz_when_divisible_by_three_and_five(uint256 n)
        public
    {
        if ((n % 3 != 0) || (n % 5 != 0)) return;
        assertEq(fizzbuzz.fizzbuzz(n), "fizzbuzz");
    }

    function test_returns_number_otherwise(uint256 n) public {
        if ((n % 3 == 0) || (n % 5 == 0)) return;
        assertEq(fizzbuzz.fizzbuzz(n), n.toString());
    }

    function prove_returns_fizz_when_divisible_by_three(uint256 n) public {
        if (n % 3 != 0) return;
        if (n % 3 == 0 && n % 5 == 0) return;
        assertEq(fizzbuzz.fizzbuzz(n), "fizz");
    }

    function prove_returns_buzz_when_divisible_by_five(uint256 n) public {
        if (n % 5 != 0) return;
        if (n % 3 == 0 && n % 5 == 0) return;
        assertEq(fizzbuzz.fizzbuzz(n), "buzz");
    }

    function prove_returns_fizzbuzz_when_divisible_by_three_and_five(uint256 n)
        public
    {
        if ((n % 3 != 0) || (n % 5 != 0)) return;
        assertEq(fizzbuzz.fizzbuzz(n), "fizzbuzz");
    }
}
