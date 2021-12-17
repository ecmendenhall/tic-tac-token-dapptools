// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC20, Ownable {
    constructor() ERC20("Triple T Token", "TTT") {}

    function mintTTT(uint256 amount) public onlyOwner {
        _mint(msg.sender, amount);
    }
}
