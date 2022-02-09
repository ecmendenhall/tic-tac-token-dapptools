// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "../../../lib/ds-test/src/test.sol";

import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "../../Token.sol";
import "../../NFT.sol";
import "../../TicTacToken.sol";
import "./Hevm.sol";

contract User is ERC721Holder {
    TicTacToken internal ttt;

    function setTTT(address _ticTacToken) public {
        ttt = TicTacToken(_ticTacToken);
    }

    function markSpace(uint256 i) public {
        ttt.markSpace(i);
    }

    function reset() public {
        ttt.reset();
    }
}

abstract contract TicTacTokenTest is DSTest {
    Hevm internal constant hevm = Hevm(HEVM_ADDRESS);

    // contracts
    User internal admin;
    User internal playerX;
    User internal playerO;
    User internal other;
    TicTacToken internal ttt;
    NFT internal nft;
    Token internal token;
    User internal admin;
    User internal nonAdmin;

    User internal playerX;
    User internal newPlayerX;
    User internal playerO;
    User internal newPlayerO;
    User internal nonPlayer;

    function setUp() public virtual {
        admin = new User();
        playerX = new User();
        playerO = new User();
        other = new User();
        ttt = new TicTacToken(
            address(admin),
            address(playerX),
            address(playerO)
        );
        admin.setTTT(address(ttt));
        playerX.setTTT(address(ttt));
        playerO.setTTT(address(ttt));
        other.setTTT(address(ttt));
    }
}
