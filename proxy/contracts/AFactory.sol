//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import {Clones} from "@openzeppelin/contracts/proxy/Clones.sol";

contract AFactory {
    address implementation;

    event ProxyCreated(address indexed proxy);

    constructor(address impl) {
        implementation = impl;
    } 

    function createProxy() external returns(address proxy) {
        proxy = Clones.clone(implementation);

        emit ProxyCreated(proxy);

        return proxy;
    }
}
