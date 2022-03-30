// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./utils/NFTTest.sol";

contract TestNFT is NFTTest {
    function test_has_name() public {
        assertEq(nft.name(), "Tic Tac Token NFT (Genesis Block)");
    }

    function test_has_symbol() public {
        assertEq(nft.symbol(), "TTT.0 NFT");
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
            nft.metadataJSON(1, board),
            '{"name":"Game #1","description":"Tic Tac Token NFT (Genesis Block)","image":"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaW5ZTWluIG1lZXQiIHZpZXdCb3g9IjAgMCAzNTAgMzUwIj48c3R5bGU+LmV7Zm9udC1mYW1pbHk6bW9ub3NwYWNlO2ZvbnQtc2l6ZTo0OHB0O2xldHRlci1zcGFjaW5nOi4yNWVtO2ZpbGw6d2hpdGV9PC9zdHlsZT48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSIjMzAzODQxIi8+PHRleHQgeD0iNTAlIiB5PSIyNSUiIGNsYXNzPSJlIiBkb21pbmFudC1iYXNlbGluZT0ibWlkZGxlIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj5YT088L3RleHQ+PHRleHQgeD0iNTAlIiB5PSI1MCUiIGNsYXNzPSJlIiBkb21pbmFudC1iYXNlbGluZT0ibWlkZGxlIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj5PWE88L3RleHQ+PHRleHQgeD0iNTAlIiB5PSI3NSUiIGNsYXNzPSJlIiBkb21pbmFudC1iYXNlbGluZT0ibWlkZGxlIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj5PX188L3RleHQ+PC9zdmc+"}'
        );
    }

    function test_encoded_metadata() public {
        assertEq(
            nft.metadataURI(1),
            "data:application/json;base64,eyJuYW1lIjoiR2FtZSAjMSIsImRlc2NyaXB0aW9uIjoiVGljIFRhYyBUb2tlbiBORlQgKEdlbmVzaXMgQmxvY2spIiwiaW1hZ2UiOiJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0OGMzUjViR1UrTG1WN1ptOXVkQzFtWVcxcGJIazZiVzl1YjNOd1lXTmxPMlp2Ym5RdGMybDZaVG8wT0hCME8yeGxkSFJsY2kxemNHRmphVzVuT2k0eU5XVnRPMlpwYkd3NmQyaHBkR1Y5UEM5emRIbHNaVDQ4Y21WamRDQjNhV1IwYUQwaU1UQXdKU0lnYUdWcFoyaDBQU0l4TURBbElpQm1hV3hzUFNJak16QXpPRFF4SWk4K1BIUmxlSFFnZUQwaU5UQWxJaUI1UFNJeU5TVWlJR05zWVhOelBTSmxJaUJrYjIxcGJtRnVkQzFpWVhObGJHbHVaVDBpYldsa1pHeGxJaUIwWlhoMExXRnVZMmh2Y2owaWJXbGtaR3hsSWo1ZlgxODhMM1JsZUhRK1BIUmxlSFFnZUQwaU5UQWxJaUI1UFNJMU1DVWlJR05zWVhOelBTSmxJaUJrYjIxcGJtRnVkQzFpWVhObGJHbHVaVDBpYldsa1pHeGxJaUIwWlhoMExXRnVZMmh2Y2owaWJXbGtaR3hsSWo1ZlgxODhMM1JsZUhRK1BIUmxlSFFnZUQwaU5UQWxJaUI1UFNJM05TVWlJR05zWVhOelBTSmxJaUJrYjIxcGJtRnVkQzFpWVhObGJHbHVaVDBpYldsa1pHeGxJaUIwWlhoMExXRnVZMmh2Y2owaWJXbGtaR3hsSWo1ZlgxODhMM1JsZUhRK1BDOXpkbWMrIn0="
        );
    }

    function test_has_tic_tac_token_contract_address() public {
        assertEq(address(nft.ttt()), address(ttt));
    }

    function mints_token_to_address() public {
        nft.mint(address(playerX), 1);
        assertEq(nft.ownerOf(1), address(playerX));
    }

    function testFail_only_owner_can_mint() public {
        playerX.mint(address(playerX), 1);
    }

    function testFail_only_owner_can_set_tt() public {
        playerX.setTTT(ITicTacToken(address(ttt)));
    }

    function test_token_renders_empty_board_for_new_game() public {
        ttt.newGame(address(playerX), address(playerO));
        assertEq(
            nft.tokenURI(1),
            "data:application/json;base64,eyJuYW1lIjoiR2FtZSAjMSIsImRlc2NyaXB0aW9uIjoiVGljIFRhYyBUb2tlbiBORlQgKEdlbmVzaXMgQmxvY2spIiwiaW1hZ2UiOiJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0OGMzUjViR1UrTG1WN1ptOXVkQzFtWVcxcGJIazZiVzl1YjNOd1lXTmxPMlp2Ym5RdGMybDZaVG8wT0hCME8yeGxkSFJsY2kxemNHRmphVzVuT2k0eU5XVnRPMlpwYkd3NmQyaHBkR1Y5UEM5emRIbHNaVDQ4Y21WamRDQjNhV1IwYUQwaU1UQXdKU0lnYUdWcFoyaDBQU0l4TURBbElpQm1hV3hzUFNJak16QXpPRFF4SWk4K1BIUmxlSFFnZUQwaU5UQWxJaUI1UFNJeU5TVWlJR05zWVhOelBTSmxJaUJrYjIxcGJtRnVkQzFpWVhObGJHbHVaVDBpYldsa1pHeGxJaUIwWlhoMExXRnVZMmh2Y2owaWJXbGtaR3hsSWo1ZlgxODhMM1JsZUhRK1BIUmxlSFFnZUQwaU5UQWxJaUI1UFNJMU1DVWlJR05zWVhOelBTSmxJaUJrYjIxcGJtRnVkQzFpWVhObGJHbHVaVDBpYldsa1pHeGxJaUIwWlhoMExXRnVZMmh2Y2owaWJXbGtaR3hsSWo1ZlgxODhMM1JsZUhRK1BIUmxlSFFnZUQwaU5UQWxJaUI1UFNJM05TVWlJR05zWVhOelBTSmxJaUJrYjIxcGJtRnVkQzFpWVhObGJHbHVaVDBpYldsa1pHeGxJaUIwWlhoMExXRnVZMmh2Y2owaWJXbGtaR3hsSWo1ZlgxODhMM1JsZUhRK1BDOXpkbWMrIn0="
        );
        assertEq(
            nft.tokenURI(2),
            "data:application/json;base64,eyJuYW1lIjoiR2FtZSAjMSIsImRlc2NyaXB0aW9uIjoiVGljIFRhYyBUb2tlbiBORlQgKEdlbmVzaXMgQmxvY2spIiwiaW1hZ2UiOiJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0OGMzUjViR1UrTG1WN1ptOXVkQzFtWVcxcGJIazZiVzl1YjNOd1lXTmxPMlp2Ym5RdGMybDZaVG8wT0hCME8yeGxkSFJsY2kxemNHRmphVzVuT2k0eU5XVnRPMlpwYkd3NmQyaHBkR1Y5UEM5emRIbHNaVDQ4Y21WamRDQjNhV1IwYUQwaU1UQXdKU0lnYUdWcFoyaDBQU0l4TURBbElpQm1hV3hzUFNJak16QXpPRFF4SWk4K1BIUmxlSFFnZUQwaU5UQWxJaUI1UFNJeU5TVWlJR05zWVhOelBTSmxJaUJrYjIxcGJtRnVkQzFpWVhObGJHbHVaVDBpYldsa1pHeGxJaUIwWlhoMExXRnVZMmh2Y2owaWJXbGtaR3hsSWo1ZlgxODhMM1JsZUhRK1BIUmxlSFFnZUQwaU5UQWxJaUI1UFNJMU1DVWlJR05zWVhOelBTSmxJaUJrYjIxcGJtRnVkQzFpWVhObGJHbHVaVDBpYldsa1pHeGxJaUIwWlhoMExXRnVZMmh2Y2owaWJXbGtaR3hsSWo1ZlgxODhMM1JsZUhRK1BIUmxlSFFnZUQwaU5UQWxJaUI1UFNJM05TVWlJR05zWVhOelBTSmxJaUJrYjIxcGJtRnVkQzFpWVhObGJHbHVaVDBpYldsa1pHeGxJaUIwWlhoMExXRnVZMmh2Y2owaWJXbGtaR3hsSWo1ZlgxODhMM1JsZUhRK1BDOXpkbWMrIn0="
        );
    }
}
