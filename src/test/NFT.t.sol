// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./utils/NFTTest.sol";

contract TestNFT is NFTTest {
  function test_has_name() public {
    assertEq(nft.name(), "Tic Tac Token NFT");
  }

  function test_has_symbol() public {
    assertEq(nft.symbol(), "TTT NFT");
  }

  function test_formats_row() public {
    assertEq(
      nft.formatRow(X, O, O, "25"),
      '<text x="50%" y="25%" class="e" dominant-baseline="middle" text-anchor="middle">XOO</text>'
    );
    assertEq(
      nft.formatRow(O, X, O, "50"),
      '<text x="50%" y="50%" class="e" dominant-baseline="middle" text-anchor="middle">OXO</text>'
    );
    assertEq(
      nft.formatRow(O, EMPTY, EMPTY, "75"),
      '<text x="50%" y="75%" class="e" dominant-baseline="middle" text-anchor="middle">O__</text>'
    );
  }

  function test_formats_board() public {
    uint256[9] memory board = [X, O, O, O, X, O, O, EMPTY, EMPTY];
    assertEq(
      nft.boardSVG(board),
      '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.e{font-family:monospace;font-size:48pt;letter-spacing:.25em;fill:white}</style><rect width="100%" height="100%" fill="#303841" /><text x="50%" y="25%" class="e" dominant-baseline="middle" text-anchor="middle">XOO</text><text x="50%" y="50%" class="e" dominant-baseline="middle" text-anchor="middle">OXO</text><text x="50%" y="75%" class="e" dominant-baseline="middle" text-anchor="middle">O__</text></svg>'
    );
  }

  function test_image_uri() public {
    uint256[9] memory board = [X, O, O, O, X, O, O, EMPTY, EMPTY];
    assertEq(
      nft.imageURI(board),
      "data:image/svg+xml;base64,data:image/svg+xml;base64,PHN2ZwogIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJ4TWluWU1pbiBtZWV0IgogIHZpZXdCb3g9IjAgMCAzNTAgMzUwIgo+PHN0eWxlCiAgPi5le2ZvbnQtZmFtaWx5Om1vbm9zcGFjZTtmb250LXNpemU6NDhwdDtsZXR0ZXItc3BhY2luZzouMjVlbTtmaWxsOndoaXRlfTwvc3R5bGU+PHJlY3QKICAgIHdpZHRoPSIxMDAlIgogICAgaGVpZ2h0PSIxMDAlIgogICAgZmlsbD0iIzMwMzg0MSIKICAvPjx0ZXh0CiAgICB4PSI1MCUiCiAgICB5PSIyNSUiCiAgICBjbGFzcz0iZSIKICAgIGRvbWluYW50LWJhc2VsaW5lPSJtaWRkbGUiCiAgICB0ZXh0LWFuY2hvcj0ibWlkZGxlIgogID5YT088L3RleHQ+PHRleHQKICAgIHg9IjUwJSIKICAgIHk9IjUwJSIKICAgIGNsYXNzPSJlIgogICAgZG9taW5hbnQtYmFzZWxpbmU9Im1pZGRsZSIKICAgIHRleHQtYW5jaG9yPSJtaWRkbGUiCiAgPk9YTzwvdGV4dD48dGV4dAogICAgeD0iNTAlIgogICAgeT0iNzUlIgogICAgY2xhc3M9ImUiCiAgICBkb21pbmFudC1iYXNlbGluZT0ibWlkZGxlIgogICAgdGV4dC1hbmNob3I9Im1pZGRsZSIKICA+T19fPC90ZXh0Pjwvc3ZnPgo="
    );
  }
}
