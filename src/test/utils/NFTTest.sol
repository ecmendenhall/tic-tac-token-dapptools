// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "ds-test/test.sol";

import "../../NFT.sol";
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
    NFT internal nft;
    User internal user1;
    User internal user2;

    function setUp() public virtual {
        nft = new NFT();
        user1 = new User(nft);
        user2 = new User(nft);
    }
}
