// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface ITicTacToken {
    function board() external view returns (uint256[9] memory);
}
