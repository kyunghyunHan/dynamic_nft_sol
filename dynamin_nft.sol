// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
contract Token is ERC20 {
    //새로운 토큰
    constructor() ERC20("WomenWhoCode Token", "WWC") {
        //1_000_000 * 10 개 발행
        _mint(msg.sender, 1_000_000 * 10 ** decimals());
    }
}


contract WomenWhoCode is ERC721 {
    //token Address
    address public tokenAddress;
    //token ID
    uint public tokenId;

    //isAlien인지 아닌지 mapping
    mapping(uint => bool) public isAlien;
   //ERC721
    constructor() ERC721("WomenWhoCode NFT", "WWC") {
        Token token = new Token();
        tokenAddress = address(token);
    }
    //토큰전송
    function earnTokens() public {
        IERC20(tokenAddress).transfer(msg.sender,100e18);
    }
    //minting
    function mint() public {
        //토큰 id가 1000이 되면 발행이 안댐
        require(tokenId < 1000, "All 1000 tokens have been minted");
        _safeMint(msg.sender, tokenId);
        tokenId = tokenId + 1;
    }
    //
    function makeAlien(uint _tokenId) public {
        uint balance = IERC20(tokenAddress).balanceOf(msg.sender);
        require(balance >= 100e18, "You don't have enough tokens");
        require(ownerOf(_tokenId) ==  msg.sender, "You do not own this NFT");
        isAlien[_tokenId] = true;
    }
    //
    function tokenURI(uint256 _tokenId) override public view returns (string memory) {
        string memory json1 = '{"name": "WomenWhoCode", "description": "A dynamic NFT for WWC", "image": "https://cloudflare-ipfs.com/ipfs/';
        string memory json2;
        // Upload images to IPFS at https://nft.storage
        if (isAlien[_tokenId] == false) json2 = 'bafybeidrcvkt63y4ananxegwleuo43dddt5zhcvtuaiv2bfv2ge7o73ibi"}'; // avatar.png
        if (isAlien[_tokenId] == true) json2 = 'bafybeibyecyp6lxb3p4g27gwsijr5txx72bnfigetwoswhfnrbejla7gcm"}'; // alien.png
        string memory json = string.concat(json1, json2);
        string memory encoded = Base64.encode(bytes(json));
        return string(abi.encodePacked('data:application/json;base64,', encoded));
    }

}