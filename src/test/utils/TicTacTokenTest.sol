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

    function setTTT(address _ttt) public {
        ttt = TicTacToken(_ttt);
    }

    function markSpace(
        uint256 gameId,
        uint256 i,
        uint256 symbol
    ) public {
        ttt.markSpace(gameId, i, symbol);
    }
}

abstract contract TicTacTokenTest is DSTest {
    Hevm internal constant hevm = Hevm(HEVM_ADDRESS);

    // contracts
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
        nonAdmin = new User();

        playerX = new User();
        newPlayerX = new User();
        playerO = new User();
        newPlayerO = new User();
        nonPlayer = new User();

        nft = new NFT();
        token = new Token();
        ttt = new TicTacToken(address(token), address(nft));
        nft.setTTT(ITicTacToken(address(ttt)));
        nft.transferOwnership(address(ttt));
        token.transferOwnership(address(ttt));

        admin.setTTT(address(ttt));
        nonAdmin.setTTT(address(ttt));
        playerX.setTTT(address(ttt));
        newPlayerX.setTTT(address(ttt));
        playerO.setTTT(address(ttt));
        newPlayerO.setTTT(address(ttt));
        nonPlayer.setTTT(address(ttt));
    }
}
