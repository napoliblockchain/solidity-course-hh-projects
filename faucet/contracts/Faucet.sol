//SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

/// @title Faucet
/// @notice A simple faucet, everybody can fund or withdraw from it.
/// @dev Withdraw is limited to 0.1 ether.
contract Faucet {

    /// @notice Withdraw some ethers from this contract.
    /// @param amount The desired amount.
    function withdraw(uint256 amount) external {
        require(amount <= 0.1 ether);
        payable(msg.sender).transfer(amount);
    }

    receive() external payable { }
}
