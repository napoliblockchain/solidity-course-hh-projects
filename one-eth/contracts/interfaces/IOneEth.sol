// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.0;

interface IOneEth {
    /// @notice The winner.
    function winner() external view returns(address);

    /// @notice Joined players.
    function joined(address) external view returns(bool);

    /// @notice Can be used to join the challenge.
    function join() external;

    /// @notice Can be used to fight in the challenge.
    function fight() external;
}