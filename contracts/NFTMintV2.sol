// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMintV2 is ERC721, Ownable {
    uint256 public constant MAX_SUPPLY = 120;
    uint256 public constant mintDeadline = 1798664399;
    uint256 public totalMinted;
    bool public mintPaused;

    constructor() ERC721("TestNFT", "TNFT") Ownable(msg.sender) {}

    function mint() external {
        require(!mintPaused, "Minting paused by owner");
        require(block.timestamp <= mintDeadline, "Mint deadline passed");
        require(totalMinted < MAX_SUPPLY, "Max supply reached");

        totalMinted++;
        _safeMint(msg.sender, totalMinted);
    }

    function setPaused(bool paused) external onlyOwner {
        mintPaused = paused;
    }
}
