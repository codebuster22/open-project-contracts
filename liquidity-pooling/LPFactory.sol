// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract LPFactory{
    
    address public feeTo;
    address public feeToSetter;
    
    // token0 < token1 always
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint pairId
        );
    
    // tokenA and tokenB are interchangeable
    function getPair(
        address tokenA, 
        address tokenB
        ) external view returns(address pair){
        
    }
    
    // returns the Pair contract ID
    function allPairs(uint pairId) external view returns(address pair){
        
    }
    
    // returns total pairs created by the factory
    function allPairsLength() external view returns (uint totalPairs){
        
    }
    
    function createPair() external returns (address pair){
        
    }
    
}