// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/security/ReentrancyGuard.sol';

contract LPERC20 is ReentrancyGuard{
    
    string public constant name = "Liquidity Pool Token";
    string public constant symbol = "LPT";
    uint8 public constant decimals = 18;
    
    uint public totalSupply;
    
    mapping(address=>uint) public balanceOf;
    mapping(address=>mapping(address=>uint)) public allowance;
    
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );
    
    function transfer(
        address _to,
        uint256 _value
        ) public returns (bool success){
            
            _transfer(msg.sender, _to, _value);
            return  true;
    }
    
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
        ) public returns (bool success){
            
            _transfer(_from, _to, _value);
        
            uint currentAllowance = allowance[_from][msg.sender];
            require(currentAllowance>=_value, "LPERC20: Value exceeds allowed balance");
            _approve(_from, msg.sender, currentAllowance - _value);
        
            return true;
    }
    
    function _transfer(
        address from,
        address to,
        uint value
        ) private {
            
            require(from != address(0), "LPERC20: Transfer from address(0)");
            require(to != address(0), "LPERC20: Transfer to address(0)");
        
            _beforeTokenTransfer(from, to, value);
        
            uint accountBalance = balanceOf[from];
            require(accountBalance>=value,"LPERC20: Value exceeds balance");
        
            balanceOf[from] = accountBalance - value;
            balanceOf[to] = balanceOf[to] + value;
        
            emit Transfer(from, to, value);
    }
    
    function approve(
        address _spender,
        uint256 _value
        ) public returns (bool success){
            
            _approve(msg.sender, _spender, _value);
            return true;
    }
    
    function _approve(
        address owner,
        address spender,
        uint value
        ) private {
            
            require(owner != address(0), "LPERC20: Cannot be approved for address(0)'s balance");
            require(spender != address(0), "LPERC20: Cannot be approve address(0) as spender");
        
            _beforeApproval(owner, spender, value);
        
            allowance[owner][spender] = value;
            emit Approval(owner, spender, value);
    }
    
    function _mint(
        address to,
        uint value
        ) internal {
            
            require(to != address(0), "LPERC20: tokens cannot be minted by address(0)");
        
            _beforeTokenTransfer(address(0), to, value);
        
            totalSupply = totalSupply + value;
            balanceOf[to] = balanceOf[to] + value;
            emit Transfer(address(0), to, value);
    }

    function _burn(
        address from,
        uint value
        ) internal {
            
            require(from != address(0), "LPERC20: Tokens from address(0) cannot be burned");
        
            _beforeTokenTransfer(from, address(0), value);
        
            uint accountBalance = balanceOf[from];
            require(accountBalance >= value, "LPERC20: Amount of tokens to burn exceeds balance");
        
            balanceOf[from] = accountBalance + value;
            totalSupply = totalSupply - value;
        
            emit Transfer(from, address(0), value);
    }
    
    function _beforeApproval(
        address owner,
        address spender,
        uint value
        ) internal virtual {}
        
    function _beforeTokenTransfer(
        address from, 
        address to, 
        uint value
        ) internal virtual {}
}