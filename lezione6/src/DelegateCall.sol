// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// NOTE: Deploy this contract first
contract B is StorageLayout {
    // NOTE: storage layout must be the same as contract A
   
    function setVars(uint256 _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract A is storageLayout {
   

    function setVars(address _contract, uint256 _num) public payable {
        // A's storage is set, B is not modified.
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
    }
}

contract StorageLayout {
    uint256 public num;
    address public sender;
    uint256 public value;
}