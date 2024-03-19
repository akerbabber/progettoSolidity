// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {console2} from "forge-std/Console2.sol";

contract Loop  {
    function loop() public {
        // for loop
        uint i;
        for (i = 0; i < 10; i++) { // i++ equivale a i = i + 1
            
            if (i == 3) {
                // Skip to next iteration with continue
                continue;
            }
            console2.log("i:", i);
        }

        // while loop
        uint256 j=10;
        do {
            j++;
            //console2.log("j:", j);
        }
        while (j < 10);
    }
}