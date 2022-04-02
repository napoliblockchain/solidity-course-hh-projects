//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// slot0: addressInStorage = 0x2
// slot1: ...
// slot2: ...
// slot3: ...

contract ImplementationStorageBug {
    address private addressInStorage;

    function setAddressInStorage(address a) external {
        addressInStorage = a;
    }

    function funA(bool rev) external pure returns(string memory) {
        require(!rev, "reverting from ImplementationA!");

        return "funA was called and did not revert";
    }
}
