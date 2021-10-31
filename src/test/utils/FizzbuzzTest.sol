// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "ds-test/test.sol";

import "../../Fizzbuzz.sol";
import "./Hevm.sol";

abstract contract FizzbuzzTest is DSTest {
    Hevm internal constant hevm = Hevm(HEVM_ADDRESS);

    // contracts
    Fizzbuzz internal fizzbuzz;

    function setUp() public virtual {
        fizzbuzz = new Fizzbuzz();
    }
}
