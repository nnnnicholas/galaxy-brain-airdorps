// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

import "ds-test/test.sol";
import "src/GalaxyBrain.sol";

contract ContractTest is DSTest {
    GalaxyBrain c = new GalaxyBrain();

    function setUp() public {}

    function testMint() public {
        c.create("ipfsHash", 100);
        c.mint(1);
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
