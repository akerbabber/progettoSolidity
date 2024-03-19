pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Loop} from "../src/Loop.sol";

contract LoopTest is Test {

    Loop public loop;

    function setUp() public {
        loop = new Loop();
    }

    function testLoop() public {
        loop.loop();
    }
}