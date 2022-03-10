//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import {IERC20} from "./interfaces/IERC20.sol";
import {Ownable} from "./Ownable.sol";

contract ERC20 is IERC20, Ownable {

    //////// contract state ///////////

    string public name;
    string public symbol;
    uint256 public decimals = 0;
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    /////////////////////////

    constructor(string memory _name, string memory _symbol, uint256 _decimals) Ownable() {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;

        _mint(msg.sender, 10_000 * (10 ** _decimals));
    }

    // transfer
    function transfer(address to, uint256 amount) external returns(bool) {
        balanceOf[msg.sender] -= amount;

        unchecked {
            balanceOf[to] += amount; // uint256 
        }

        emit Transfer(msg.sender, to, amount);

        return true;
    }

    // transferFrom
    function transferFrom(address from, address to, uint256 amount) external returns(bool) {
        allowance[from][msg.sender] -= amount;

        balanceOf[from] -= amount;
        balanceOf[to] += amount;

        emit Transfer(from, to, amount);

        return true;
    }

    // approve
    function approve(address spender, uint256 amount) external returns(bool) {
        allowance[msg.sender][spender] += amount;

        emit Approval(msg.sender, spender, amount);

        return true;
    }

    // mint tokens
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }

    // burn tokens
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    // internal mint function
    function _mint(address to, uint256 amount) internal onlyOwner {
        balanceOf[to] += amount;
        totalSupply += amount;

        emit Transfer(address(0), to, amount);
    }

    // internal burn function
    function _burn(address from, uint256 amount) internal {
        balanceOf[from] -= amount;
        totalSupply -= amount;

        emit Transfer(from, address(0), amount);
    }
}
