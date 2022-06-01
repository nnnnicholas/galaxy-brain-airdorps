// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "solmate/tokens/ERC1155.sol";

contract GalaxyBrain is ERC1155, Ownable {
    event Created(uint256 id, string uri, bytes32 commit, uint256 expiry);
    event Mint(uint256 id, uint256 expiry);

    struct Token {
        bytes32 commit;
        string metadata;
        uint256 expiry;
    }

    //  tokenID to ipfs metadata
    mapping(uint256 => Token) public tokens;
    uint256 nextTokenId = 0;

    // Create token
    function create(
        string memory ipfsHash,
        bytes32 commit,
        uint256 expiryTime
    ) external onlyOwner {
        uint256 id = nextTokenId++;
        tokens[id].metadata = ipfsHash;
        tokens[id].commit = commit;
        tokens[id].expiry = expiryTime;
        emit Created(id, ipfsHash, commit, expiryTime);
    }

    function hash(string calldata secret) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(secret));
    }

    function mint(uint256 id, string calldata secret) external {
        require(id < nextTokenId, "token doesn't exist");
        require(
            tokens[id].commit == keccak256(abi.encodePacked(secret)),
            "incorrect secret"
        );
        mint(msg.sender, id);
    }

    function mint(address to, uint256 id) public {
        emit Mint(id, block.timestamp);
        require(id < nextTokenId, "token doesn't exist yet");
        require(block.timestamp <= tokens[id].expiry, "mint is over");
        _mint(to, id, 1, "");
    }

    function uri(uint256 id) public view override returns (string memory) {
        return tokens[id].metadata;
    }
}
