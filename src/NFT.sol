// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../lib/Base64.sol";

contract NFT is ERC721 {
    uint256 internal constant EMPTY = 0;
    uint256 internal constant X = 1;
    uint256 internal constant O = 2;
    constructor() ERC721("Tic Tac Token NFT", "TTT NFT") {}

    function symbolFor(uint256 sym) public returns (string memory) {
        if (sym == X) {
            return "X";
        } else if (sym == O) {
            return "O";
        } else {
            return " ";
        }
    }

    function formatRow(uint256 one, uint256 two, uint256 three) public returns (string memory) {
        return string(abi.encodePacked(
            "<text x=\"50%\" y=\"25%\" class=\"e\" dominant-baseline=\"middle\" text-anchor=\"middle\">",
            symbolFor(one),
            symbolFor(two),
            symbolFor(three),
            "</text>"
        ));
    }

    function boardSVG(uint256[9] memory board) public returns (string memory) {
        return string(abi.encodePacked(
            "<svg xmlns=\"http://www.w3.org/2000/svg\" preserveAspectRatio=\"xMinYMin meet\" viewBox=\"0 0 350 350\"><style>.e{font-size:48pt;letter-spacing:.25em}</style><rect width=\"100%\" height=\"100%\" fill=\"#303841\" />",
            formatRow(board[0], board[1], board[2]),
            formatRow(board[3], board[4], board[5]),
            formatRow(board[6], board[7], board[8]),
            "</svg>"
        ));
    }

    function imageURI(uint256[9] memory board) public returns (string memory) {
        return string(abi.encodePacked(
            "data:image/svg+xml;base64,",
            Base64.encode(boardSVG(board))
        ));
    }

}