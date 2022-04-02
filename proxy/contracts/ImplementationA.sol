//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract ImplementationA {
    function funA(bool rev) external pure returns(string memory) {
        require(!rev, "reverting from ImplementationA!");

        return "funA was called and did not revert";
    }
}
