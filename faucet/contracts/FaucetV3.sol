// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import {Ownable} from "./Ownable.sol";

/// @title FaucetV3
/// @notice A simple faucet, everybody can fund or withdraw from it.
/// @dev Withdraw is limited to 0.1 ether.
contract FaucetV3 is Ownable {

    /// @notice Mapping for withdrawal timestamps of addresses.
    mapping(address => uint64) public withdraws;

    /// @notice The ether withdraw limit.
    uint256 public etherLimit = 0.1 ether;

    /// @notice The time withdraw limit.
    uint64 public timeLimit = 1 days;

    /// @notice Boolean indicating if the contract is paused or not.
    bool paused;

    /// @notice Withdraw some ethers from this contract.
    /// @dev Checks if last withdraw was done within one day.
    /// @param amount The desired amount.
    function withdraw(uint256 amount) external {
        require(!paused);
        require(amount <= etherLimit);
        
        uint64 last = withdraws[msg.sender];
        require(block.timestamp - last > timeLimit);

        withdraws[msg.sender] = uint64(block.timestamp);
        payable(msg.sender).transfer(amount);
    }

    /// @notice Sets limits.
    /// @dev Callable only by contract owner (see `onlyOwner`).
    function setLimits(uint256 _etherLimit, uint64 _timeLimit) external onlyOwner {
        etherLimit = _etherLimit;
        timeLimit = _timeLimit;
    }

    /// @notice Pause the contract.
    /// @dev Callable only by contract owner (see `onlyOwner`).
    function pause(bool trigger) external onlyOwner {
        paused = trigger;
    }

    receive() external payable { }
}
