// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "ds-test/test.sol";

import "../../Token.sol";
import "./Hevm.sol";

contract User {
    Token internal token;

    constructor(Token _token) {
        token = _token;
    }

    function mint(address to, uint256 amount) public {
        token.mint(to, amount);
    }

    function transfer(address to, uint256 amount) public {
        token.transfer(to, amount);
    }
}

abstract contract TokenTest is DSTest {
    Hevm internal constant hevm = Hevm(HEVM_ADDRESS);

    // contracts
    Token internal token;
    User internal user1;
    User internal user2;

    function setUp() public virtual {
        token = new Token();
        user1 = new User(token);
        user2 = new User(token);
    }
}
