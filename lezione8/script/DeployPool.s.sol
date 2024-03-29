// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../src/CPAMM.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract DeployPoolScript is Script {

    function run() public {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        vm.startBroadcast(deployerPrivateKey);
        ERC20Mock token0 = new ERC20Mock("tokenA","TKA");
        ERC20Mock token1 = new ERC20Mock("tokenB","TKB");

        console.log("Token0 address: ", address(token0));
        console.log("Token1 address: ", address(token1));


        CPAMM cpamm = new CPAMM(IERC20(address(token0)), IERC20(address(token1)));

        console.log("CPAMM address: ", address(cpamm));

        token0.approve(address(cpamm), 1000 ether);
        token1.approve(address(cpamm), 1000 ether);

        vm.stopBroadcast();
    }
}

contract ERC20Mock is ERC20 {
    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _mint(msg.sender, 1000 ether);
    }
}
