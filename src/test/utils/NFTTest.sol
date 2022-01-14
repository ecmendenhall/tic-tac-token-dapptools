// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "ds-test/test.sol";

import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "../../NFT.sol";
import "../../TicTacToken.sol";
import "../../Token.sol";
import "./Hevm.sol";

contract User is ERC721Holder {
    NFT internal nft;

    constructor(NFT _nft) {
        nft = _nft;
    }

    function mint(address to, uint256 tokenId) public {
        nft.mint(to, tokenId);
    }

    function setTTT(ITicTacToken ttt) public {
        nft.setTTT(ttt);
    }
}

abstract contract NFTTest is DSTest {
    Hevm internal constant hevm = Hevm(HEVM_ADDRESS);
    uint256 internal constant EMPTY = 0;
    uint256 internal constant X = 1;
    uint256 internal constant O = 2;

    // contracts
    TicTacToken internal ttt;
    NFT internal nft;
    Token internal token;
    User internal admin;
    User internal playerX;
    User internal playerO;

    function setUp() public virtual {
        nft = new NFT();
        token = new Token();
        ttt = new TicTacToken(address(token), address(nft));
        nft.setTTT(ITicTacToken(address(ttt)));
        nft.transferOwnership(address(ttt));
        admin = new User(nft);
        playerX = new User(nft);
        playerO = new User(nft);
    }
}
