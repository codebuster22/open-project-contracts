// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract LPPair{
    
    //Event emitter each time liquidity tokens are minted
    event Mint(
        address indexed sender,
        uint amount0,
        uint amount1
        );
        
    //Event emitted each time liquidity tokens are burned
    event Burn(
        address indexed sender,
        uint amount0,
        uint amount1,
        address indexed to
        );
    
    //Emitted each time swap occures via swap
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
        );
        
    //Emitted each time reserves updated via mint, burn swap or sync
    event Sync(
        uint112 reserve0,
        uint112 reserve1
        );
        
    // Returns 1000 for all pairs
    uint public MINIMUM_LIQUIDITY;
    
    // returns the factory address
    address public factory;
    
    // Returns the address of token with low sort order
    address public token0;
    
    // Returns the address of token with high sort order
    address public token1;
    
    // priceCumulative = prevPriceCumulative + currentBlockPrice*timeElapsed 
    //                      where timeElapsed is the time between end of prevBlock and start of currentBlock
    uint public price0CumulativeLast;
    uint public price1CumulativeLast;
    
    // returns the product of reserves as of the most recent liquidity event
    uint public kLast;
    
    // Returns reserves of token0 and token1 used to price trades and distribute liquidity. Also returns block.timestamp
    function getReserves() external view 
        returns(
            uint112 reserve0,
            uint112 reserve1,
            uint32 blockTimestampLast
        ){
        
    }
    
    
    // Creates Pool Tokens - Emits Mint, Sync, Transfer
    function mint(address to) external returns(uint liquidity){
        
    }
    
    // Destroys pool token - Emits Burn, Sync, Transfer
    function burn(address to) external returns(uint amount0, uint amount1){
        
    }
    
    // Swap tokens. for regular swaps data.length = 0. - Emits Sync, Swap
    function swap(
        uint amount0Out,
        uint amount1Out,
        address to,
        bytes calldata data
        ) external{
        
    }
    
    // read from whitepaper
    function skim(address to) external{
        
    }
    
    // read from whitepaper - Emits Sync
    function sync() external{
        
    }
    
}