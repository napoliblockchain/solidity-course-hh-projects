//SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

/// @title FaucetV2
/// @notice A simple faucet, everybody can fund or withdraw from it.
/// @dev Withdraw is limited to 0.1 ether.
contract FaucetV2 {

    /// @notice Mapping for withdrawal timestamps of addresses.
    mapping(address => uint64) public withdraws;

    /// @notice Withdraw some ethers from this contract.
    /// @dev Checks if last withdraw was done within one day.
    /// @param amount The desired amount.
    function withdraw(uint256 amount) external {
        require(amount <= 0.1 ether);
        
        uint64 last = withdraws[msg.sender];
        require(block.timestamp - last > 1 days);

        withdraws[msg.sender] = uint64(block.timestamp);
        payable(msg.sender).transfer(amount);
    }

    receive() external payable { }
}
