// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";

contract SimpleStorageTest is Test {
    SimpleStorage public simpleStorage;

    function setUp() public {
        simpleStorage = new SimpleStorage();
    }

    function testSet() public {
        simpleStorage.set(42);
    }

    function testGet() public {
        uint num = simpleStorage.get();
        console.log("num:", num);
    }

    function testSet2() public {
        simpleStorage.set(12);
        uint num = simpleStorage.get();
        assertEq(num, 12);
    }

    function testSet3() public {
        simpleStorage.set(12);
        simpleStorage.set(42);
        uint num = simpleStorage.get();
        assertEq(num, 42);
    }
}
