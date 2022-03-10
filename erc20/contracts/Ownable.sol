// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Ownable
/// @notice An ownable contract.
contract Ownable {
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function transferOwnership(address newOwner) external onlyOwner {
        owner = newOwner;
    }
}