// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

import "ds-test/test.sol";
import "src/GalaxyBrain.sol";

contract ContractTest is DSTest {
    GalaxyBrain c = new GalaxyBrain();

    function setUp() public {}

    function testMint() public {
        c.hash("testing");
        c.create(
            "ipfsHash",
            0x5f16f4c7f149ac4f9510d9cf8cf384038ad348b3bcdc01915f95de12df9d1b02,
            100
        );
        c.mint(0, "testing");
        assert(
            keccak256(abi.encodePacked(c.uri(0))) ==
                keccak256(abi.encodePacked("ipfsHash"))
        );
    }

    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes calldata
    ) external virtual returns (bytes4) {
        return ERC1155TokenReceiver.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address,
        address,
        uint256[] calldata,
        uint256[] calldata,
        bytes calldata
    ) external virtual returns (bytes4) {
        return ERC1155TokenReceiver.onERC1155BatchReceived.selector;
    }
}
