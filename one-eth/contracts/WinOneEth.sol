// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.0;

import {IOneEth} from "./interfaces/IOneEth.sol";

/// @title WinOneEth
/// @notice Make your move.
contract WinOneEth {
    /// @notice The EOA to send the earned ETH to.
    address public winner;

    constructor() {
        winner = msg.sender;
    }

    /// @notice Let's win this tournament.
    function win(address[] memory challenges) external {
        for (uint256 i = 0; i < challenges.length; i++) {
            IOneEth challenge = IOneEth(challenges[i]);

            if (challenge.winner() == address(0)) {
                challenge.join();
                challenge.fight();
            }
        }
    }

    function withdraw() external {
        payable(winner).transfer(address(this).balance);
    }

    receive() external payable { }
}
