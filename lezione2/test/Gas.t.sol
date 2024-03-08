// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Gas} from "../src/Gas.sol";

contract GasTest is Test {
    Gas public gas;

    function setUp() public {
        gas = new Gas();
    }

    function testForever() public {
        vm.expectRevert();
        gas.forever{gas: 30_000_000}(); // 30_000_000 gas è lo stesso che scrivere 30000000 in solidity
    }
}