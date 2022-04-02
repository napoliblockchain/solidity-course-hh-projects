//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract ImplementationB {
    function funB(bool rev) external pure returns(string memory) {
        require(!rev, "reverting from ImplementationB!");

        return "funB was called and did not revert";
    }
}
