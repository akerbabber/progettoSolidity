// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {A, B, C, D} from "../src/Inheritance.sol";

contract InheritanceTest is Test {
    D public d;
    C public c;
    B public b;
    A public a;

    function setUp() public {
        d = new D();
        c = new C();
        b = new B();
        a = new A();
    }

    function test_Foo() public {
        d.foo();
    }

    function test_Bar() public {
        d.bar();
    }

    
}
