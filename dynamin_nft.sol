// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
contract Token is ERC20 {
    constructor() ERC20("WomenWhoCode Token", "WWC") {
        _mint(msg.sender, 1_000_000 * 10 ** decimals());
    }
}

contract WomenWhoCode is ERC721 {
    address public tokenAddress;


    constructor() ERC721("WomenWhoCode NFT", "WWC") {
        Token token = new Token();
        tokenAddress = address(token);
    }

}