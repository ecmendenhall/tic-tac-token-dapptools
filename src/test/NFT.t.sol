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
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.e{font-family:monospace;font-size:48pt;letter-spacing:.25em;fill:white}</style><rect width="100%" height="100%" fill="#303841"/><text x="50%" y="25%" class="e" dominant-baseline="middle" text-anchor="middle">XOO</text><text x="50%" y="50%" class="e" dominant-baseline="middle" text-anchor="middle">OXO</text><text x="50%" y="75%" class="e" dominant-baseline="middle" text-anchor="middle">O__</text></svg>'
        );
    }

    function test_image_uri() public {
        uint256[9] memory board = [X, O, O, O, X, O, O, EMPTY, EMPTY];
        assertEq(
            nft.imageURI(board),
            "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaW5ZTWluIG1lZXQiIHZpZXdCb3g9IjAgMCAzNTAgMzUwIj48c3R5bGU+LmV7Zm9udC1mYW1pbHk6bW9ub3NwYWNlO2ZvbnQtc2l6ZTo0OHB0O2xldHRlci1zcGFjaW5nOi4yNWVtO2ZpbGw6d2hpdGV9PC9zdHlsZT48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSIjMzAzODQxIi8+PHRleHQgeD0iNTAlIiB5PSIyNSUiIGNsYXNzPSJlIiBkb21pbmFudC1iYXNlbGluZT0ibWlkZGxlIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj5YT088L3RleHQ+PHRleHQgeD0iNTAlIiB5PSI1MCUiIGNsYXNzPSJlIiBkb21pbmFudC1iYXNlbGluZT0ibWlkZGxlIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj5PWE88L3RleHQ+PHRleHQgeD0iNTAlIiB5PSI3NSUiIGNsYXNzPSJlIiBkb21pbmFudC1iYXNlbGluZT0ibWlkZGxlIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj5PX188L3RleHQ+PC9zdmc+"
        );
    }

    function test_metadata_JSON() public {
        uint256[9] memory board = [X, O, O, O, X, O, O, EMPTY, EMPTY];
        assertEq(
            nft.metadataJSON(board),
            '{"name":"TTT NFT","description":"Tic Tac Token NFT","image":"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaW5ZTWluIG1lZXQiIHZpZXdCb3g9IjAgMCAzNTAgMzUwIj48c3R5bGU+LmV7Zm9udC1mYW1pbHk6bW9ub3NwYWNlO2ZvbnQtc2l6ZTo0OHB0O2xldHRlci1zcGFjaW5nOi4yNWVtO2ZpbGw6d2hpdGV9PC9zdHlsZT48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSIjMzAzODQxIi8+PHRleHQgeD0iNTAlIiB5PSIyNSUiIGNsYXNzPSJlIiBkb21pbmFudC1iYXNlbGluZT0ibWlkZGxlIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj5YT088L3RleHQ+PHRleHQgeD0iNTAlIiB5PSI1MCUiIGNsYXNzPSJlIiBkb21pbmFudC1iYXNlbGluZT0ibWlkZGxlIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj5PWE88L3RleHQ+PHRleHQgeD0iNTAlIiB5PSI3NSUiIGNsYXNzPSJlIiBkb21pbmFudC1iYXNlbGluZT0ibWlkZGxlIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj5PX188L3RleHQ+PC9zdmc+"}'
        );
    }

    function test_encoded_metadata() public {
        uint256[9] memory board = [X, O, O, O, X, O, O, EMPTY, EMPTY];
        assertEq(
            nft.metadataURI(board),
            "data:application/json;base64,eyJuYW1lIjoiVFRUIE5GVCIsImRlc2NyaXB0aW9uIjoiVGljIFRhYyBUb2tlbiBORlQiLCJpbWFnZSI6ImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlIQnlaWE5sY25abFFYTndaV04wVW1GMGFXODlJbmhOYVc1WlRXbHVJRzFsWlhRaUlIWnBaWGRDYjNnOUlqQWdNQ0F6TlRBZ016VXdJajQ4YzNSNWJHVStMbVY3Wm05dWRDMW1ZVzFwYkhrNmJXOXViM053WVdObE8yWnZiblF0YzJsNlpUbzBPSEIwTzJ4bGRIUmxjaTF6Y0dGamFXNW5PaTR5TldWdE8yWnBiR3c2ZDJocGRHVjlQQzl6ZEhsc1pUNDhjbVZqZENCM2FXUjBhRDBpTVRBd0pTSWdhR1ZwWjJoMFBTSXhNREFsSWlCbWFXeHNQU0lqTXpBek9EUXhJaTgrUEhSbGVIUWdlRDBpTlRBbElpQjVQU0l5TlNVaUlHTnNZWE56UFNKbElpQmtiMjFwYm1GdWRDMWlZWE5sYkdsdVpUMGliV2xrWkd4bElpQjBaWGgwTFdGdVkyaHZjajBpYldsa1pHeGxJajVZVDA4OEwzUmxlSFErUEhSbGVIUWdlRDBpTlRBbElpQjVQU0kxTUNVaUlHTnNZWE56UFNKbElpQmtiMjFwYm1GdWRDMWlZWE5sYkdsdVpUMGliV2xrWkd4bElpQjBaWGgwTFdGdVkyaHZjajBpYldsa1pHeGxJajVQV0U4OEwzUmxlSFErUEhSbGVIUWdlRDBpTlRBbElpQjVQU0kzTlNVaUlHTnNZWE56UFNKbElpQmtiMjFwYm1GdWRDMWlZWE5sYkdsdVpUMGliV2xrWkd4bElpQjBaWGgwTFdGdVkyaHZjajBpYldsa1pHeGxJajVQWDE4OEwzUmxlSFErUEM5emRtYysifQ=="
        );
    }

    function test_has_tic_tac_token_contract_address() public {
        assertEq(address(nft.ttt()), address(ttt));
    }
}
