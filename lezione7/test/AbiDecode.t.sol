// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {AbiDecode} from "../src/AbiDecode.sol";

contract AbiDecodeTest is Test {
    AbiDecode public abiDecode;

    function setUp() public {
        abiDecode = new AbiDecode();
    }

    function testEncode() public {
        uint256 x = 42;
        address addr = address(uint160(uint256(keccak256("lezione"))));
        uint256[] memory arr = new uint256[](2);
        arr[0] = 1;
        arr[1] = 2;
        AbiDecode.MyStruct memory myStruct;
        myStruct.name = "testtesttesttesttest";
        myStruct.nums[0] = 3;
        myStruct.nums[1] = 4;

        bytes memory data = abiDecode.encode(x, addr, arr, myStruct);

        (uint256 _x, address _addr, uint256[] memory _arr, AbiDecode.MyStruct memory _myStruct) = abiDecode.decode(data);

        console.log("x: ");
        console.log( _x);
        console.log("addr: ");
        console.log( _addr);
        console.log("arr: ");
        console.log( _arr[0]);
        console.log( _arr[1]);
        console.log("myStruct: ");
        console.log( _myStruct.name);
        console.log("nums: ");
        console.log( _myStruct.nums[0]);
        console.log( _myStruct.nums[1]);
        console.logBytes(data);

        data = abi.encodeCall(abiDecode.encode, (x, addr, arr, myStruct));
        console.log("encode call: ");
        console.logBytes(data);
        (bool check, bytes memory res) = address(abiDecode).call(data);
        console.log("encode call result: ");
        console.log(check);
        console.logBytes(res);

        console.logBytes32(keccak256("lezione"));
        console.logBytes32(keccak256("lezione "));

        console.logBytes32(keccak256("meloni54687439857"));

        console.logBytes(abi.encode("lez","ione"));
        console.logBytes(abi.encode("le","zione"));
        assertTrue(keccak256(abi.encode("lez","one")) != keccak256(abi.encode("le","zione")));
      
        console.logBytes(abi.encodePacked("lez","ione"));
        console.logBytes(abi.encodePacked("le","zione"));
        assertEq(keccak256(abi.encodePacked("lez","ione")), keccak256(abi.encodePacked("le","zione")));

    }
}
