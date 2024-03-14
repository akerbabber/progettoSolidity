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

    function testExample() public {
        console.log("Starting gas example");
        console.log("Initial gas:") ;
    }
}


// todo: arr2 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
// todo: andiamo a rimuovere l'emento con indice 1
// todo: per fare cio' andiamo a copiare il valore dell'ultimo elemento e a sovrascriverlo sull'elemento di indice 1
// todo: che è l'elemento che vogliamo rimuovere
// todo: arr2 = [1, 10, 3, 4, 5, 6, 7, 8, 9, 10]
// todo: chiamiamo la pop() per rimuovere l'ultimo elemento
// todo: arr2 = [1, 10, 3, 4, 5, 6, 7, 8, 9]
// todo: arr2 = [1, 0, 3, 4, 5, 6, 7, 8, 9, 10]
// todo:
//enum Status {
//        Pending, // 0
//        Shipped, // 1
//        Accepted, // 2
//        Rejected, // 3
//        Canceled // 4
//    }
//https://regex101.com/
//// todo:
// todo:
// todo:
// todo:
// todo:
// todo:
// todo: