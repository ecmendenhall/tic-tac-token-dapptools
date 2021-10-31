// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";

contract Fizzbuzz {
    using Strings for uint256;

    function fizzbuzz(uint256 n) public pure returns (string memory) {
        bool factorOfThree = (n % 3 == 0);
        bool factorOfFive = (n % 5 == 0);

        if (factorOfThree && factorOfFive) {
            return "fizzbuzz";
        }
        if (factorOfThree) {
            return "fizz";
        }
        if (factorOfFive) {
            return "buzz";
        }
        return n.toString();
    }
}
