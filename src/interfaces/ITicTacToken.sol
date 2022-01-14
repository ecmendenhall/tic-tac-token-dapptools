// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface ITicTacToken {
    function gameIdByTokenId(uint256 tokenId) external view returns (uint256);

    function board(uint256 gameId) external view returns (uint256[9] memory);
}
