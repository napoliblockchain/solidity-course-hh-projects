//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// ---> msg.data = funA.selector + bool
contract ProxyA {
    address public immutable implementation;

    constructor(address impl) {
        implementation = impl;
    }

    function _delegate(address impl) internal returns (bytes memory) {
        assembly {
            // Copy msg.data.
            calldatacopy(0, 0, calldatasize())

            // Call the implementation.
            let result := delegatecall(gas(), impl, 0, calldatasize(), 0, 0)

            // Copy the returned data.
            returndatacopy(0, 0, returndatasize())

            switch result
            // delegatecall returns 0 on error.
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    } 

    fallback() external payable { _delegate(implementation); }

    receive() external payable { _delegate(implementation); } 

}
