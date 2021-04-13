pragma solidity ^0.6.0;

import "./ItemManager.sol";

contract Item{
    uint priceInWei;
    uint pricePaid;
    uint index;

    ItemManager parentManager;

    constructor(ItemManager _parentManager, uint _priceInWei, uint _index) public{
        parentManager = _parentManager;
        priceInWei = _priceInWei;
        index = _index;
    }

    receive() external payable{
        require(pricePaid==0,"Payment Already Done");
        require(msg.value==priceInWei,"Please Pay the Exact Amount");
        pricePaid+=msg.value;
        (bool success,)=address(parentManager).call.value(msg.value)(abi.encodeWithSignature("placeOrder(uint256)",index));
        require(success,"Payment not processed, Reverting Back");
    }
}