// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./utils/NFTTest.sol";

contract TestNFT is NFTTest {
    
    uint256[9] public board = [X, O, X, X, O, O, X, EMPTY, EMPTY];

    function test_has_name() public {
        assertEq(nft.name(), "Tic Tac Token NFT");
    }

    function test_has_symbol() public {
        assertEq(nft.symbol(), "TTT NFT");
    }

    function test_formats_row() public {
        assertEq(nft.formatRow(X, O, O), "<text x=\"50%\" y=\"25%\" class=\"e\" dominant-baseline=\"middle\" text-anchor=\"middle\">XOO</text>");
        assertEq(nft.formatRow(EMPTY, EMPTY, O), "<text x=\"50%\" y=\"25%\" class=\"e\" dominant-baseline=\"middle\" text-anchor=\"middle\">  O</text>");
    }

    function test_formats_board() public {
        string memory expectedBoard = "<svg xmlns=\"http://www.w3.org/2000/svg\" preserveAspectRatio=\"xMinYMin meet\" viewBox=\"0 0 350 350\"><style>.e{font-size:48pt;letter-spacing:.25em}</style><rect width=\"100%\" height=\"100%\" fill=\"#303841\" /><text x=\"50%\" y=\"25%\" class=\"e\" dominant-baseline=\"middle\" text-anchor=\"middle\">XOX</text><text x=\"50%\" y=\"25%\" class=\"e\" dominant-baseline=\"middle\" text-anchor=\"middle\">XOO</text><text x=\"50%\" y=\"25%\" class=\"e\" dominant-baseline=\"middle\" text-anchor=\"middle\">X  </text></svg>";
        assertEq(nft.boardSVG(board), expectedBoard);
    }

    function test_returns_image_data_uri() public {
        string memory expectedDataURI = "data:image/svg+xml;base64,PHN2ZwogIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJ4TWluWU1pbiBtZWV0IgogIHZpZXdCb3g9IjAgMCAzNTAgMzUwIgo+CjxzdHlsZT4uZXtmb250LXNpemU6NDhwdDtsZXR0ZXItc3BhY2luZzouMjVlbX08L3N0eWxlPgo8cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSIjMzAzODQxIiAvPgo8dGV4dAogICAgeD0iNTAlIgogICAgeT0iMjUlIgogICAgY2xhc3M9ImUiCiAgICBkb21pbmFudC1iYXNlbGluZT0ibWlkZGxlIgogICAgdGV4dC1hbmNob3I9Im1pZGRsZSIKICA+WE9YPC90ZXh0Pgo8dGV4dAogICAgeD0iNTAlIgogICAgeT0iNTAlIgogICAgY2xhc3M9ImUiCiAgICBkb21pbmFudC1iYXNlbGluZT0ibWlkZGxlIgogICAgdGV4dC1hbmNob3I9Im1pZGRsZSIKICA+WE9PPC90ZXh0Pgo8dGV4dAogICAgeD0iNTAlIgogICAgeT0iNzUlIgogICAgY2xhc3M9ImUiCiAgICBkb21pbmFudC1iYXNlbGluZT0ibWlkZGxlIgogICAgdGV4dC1hbmNob3I9Im1pZGRsZSIKICA+WCAgPC90ZXh0Pgo8L3N2Zz4K";
        assertEq(nft.imageURI(board), expectedDataURI);
    }
}
