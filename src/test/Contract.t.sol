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
        assert(keccak256(abi.encodePacked(c.uri(0))) == keccak256(abi.encodePacked( "ipfsHash")));
    }
}
