// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "solmate/tokens/ERC1155.sol";

contract GalaxyBrain is ERC1155, Ownable {
    event Created(uint256 id, string uri, uint256 expiry);
    event Mint(uint256 id, uint256 expiry);

    struct Token {
        uint256 commit;
        string metadata;
        uint256 expiry;
    }

    //  tokenID to ipfs metadata
    mapping(uint256 => Token) public tokens;
    uint256 totalSupply = 0;

    // Create token
    function create(string memory ipfsHash, uint256 expiryTime)
        external
        onlyOwner
    {
        uint256 id = totalSupply++;
        tokens[id].metadata = ipfsHash;
        tokens[id].expiry = expiryTime;
        emit Created(id, ipfsHash, expiryTime);
    }

    function mint(uint256 id) external {
        mint(msg.sender, id);
    }

    function mint(address to, uint256 id) public {
        emit Mint(id, block.timestamp);
        require(id <= totalSupply, "token doesn't exist yet");
        require(block.timestamp <= tokens[id].expiry, "mint is over");
        _mint(to, id, 1, "");
    }

    function uri(uint256 id) public view override returns (string memory) {
        return tokens[id].metadata;
    }
}
