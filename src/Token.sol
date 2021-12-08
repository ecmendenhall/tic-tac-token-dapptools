// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {

    constructor() ERC20("Unicorn Token", "UCORN") {}

    function mint(uint256 amount) public {
        _mint(address(msg.sender), amount);
    }
  
}