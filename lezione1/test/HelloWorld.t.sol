// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {HelloWorld} from "../src/HelloWorld.sol";

contract HelloWorldTest is Test {
    HelloWorld helloWorld;

    function setUp() public {
        helloWorld = new HelloWorld();
    }

    function testGreet() public {
        console.log("greet:", helloWorld.greet());
        assertEq(helloWorld.greet(), "Hello World!");
    }

   
}
