// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {FunctionModifier} from "../src/FunctionModifier.sol";

contract FunctionModifierTest is Test {
    FunctionModifier public functionModifier;

    function setUp() public {
        functionModifier = new FunctionModifier();
    }

    function test_Decrement() public {
        functionModifier.decrement(1);
    }

    function test_DecrementWithoutGuard2() public {
        functionModifier.decrement(2);
    }

    function test_DecrementWithoutGuard4() public {
        functionModifier.decrement(4);
    }

    function  test_Decrement2() public {
        // this test will fail
        functionModifier.decrement(2);
    }

    function test_Decrement4() public {
        // this test will fail
        functionModifier.decrement(4);
    }
}
