// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "ds-test/test.sol";

import "../../NFT.sol";
import "../../TicTacToken.sol";
import "../../Token.sol";
import "./Hevm.sol";

contract User {
    NFT internal nft;

    constructor(NFT _nft) {
        nft = _nft;
    }
}

abstract contract NFTTest is DSTest {
    Hevm internal constant hevm = Hevm(HEVM_ADDRESS);
    uint256 internal constant EMPTY = 0;
    uint256 internal constant X = 1;
    uint256 internal constant O = 2;

    // contracts
    TicTacToken internal ttt;
    Token internal token;
    NFT internal nft;
    User internal admin;
    User internal playerX;
    User internal playerO;

    function setUp() public virtual {
        token = new Token();
        ttt = new TicTacToken(address(admin), address(token));
        nft = new NFT(ITicTacToken(address(ttt)));
        admin = new User(nft);
        playerX = new User(nft);
        playerO = new User(nft);
    }
}
