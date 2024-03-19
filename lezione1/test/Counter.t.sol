// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter counter;

    function setUp() public {
        counter = new Counter();
        console.log("Counter address:", address(counter));
    }

    function testInc() public {
        counter.inc();
        assertEq(counter.get(), 1);
    }

    function testDec() public {
        vm.expectRevert();
        counter.dec();
    }

     function testIncDec() public {
        counter.inc();
        counter.dec();
    }

}
