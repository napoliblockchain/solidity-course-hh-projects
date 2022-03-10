// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.0;

interface IERC20 {

    // events ////

    event Transfer(address from, address to, uint256 amount);

    event Approval(address owner, address spender, uint256 amount);

    ////////////

    // name
    function name() external view returns(string memory);

    // symbol
    function symbol() external view returns(string memory);

    // decimals
    function decimals() external view returns(uint256);
 
    // allowance
    function allowance(address owner, address spender) external view returns(uint256);

    // balanceOf
    function balanceOf(address account) external view returns(uint256);

    // totalSupply
    function totalSupply() external view returns(uint256);

    // transfer
    function transfer(address to, uint256 amount) external returns(bool);

    // transferFrom
    function transferFrom(address from, address to, uint256 amount) external returns(bool);

    // approve
    function approve(address spender, uint256 amount) external returns(bool);

}