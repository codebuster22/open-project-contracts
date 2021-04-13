pragma solidity ^0.6.0;

import "./Item.sol";
import "./Ownable.sol";

contract  ItemManager is Ownable {

    address payable private _Owner;
    
    constructor() public{
    _Owner = msg.sender;
    }
    
    enum itemState{Created,PaymentDone,InTransit,Delivered}
    
    struct S_Item{
        Item item;
        uint id;
        uint itemPrice;
        mapping(uint=>uint) Item_Timeline;
        ItemManager.itemState state;
    }
    
    mapping(uint=>S_Item) itemList;
    uint itemIndex;
    uint itemTimelineIndex;
    
    event itemStep(uint index, uint itemId, uint state,uint date, address itemContract);
    
    function createItem(uint _itemID, uint _itemPrice) public onlyOwner{
        Item item = new Item(this, _itemPrice, itemIndex);
        itemList[itemIndex].item = item;
        itemList[itemIndex].id = _itemID;
        itemList[itemIndex].itemPrice = _itemPrice;
        itemList[itemIndex].Item_Timeline[itemTimelineIndex] = now;
        itemList[itemIndex].state = itemState.Created;
    
        emit itemStep(itemIndex,_itemID,uint(itemList[itemIndex].state),itemList[itemIndex].Item_Timeline[itemTimelineIndex],address(item));
    
        itemIndex++;
        itemTimelineIndex++;
    }
    
    function getItem(uint _index) view public returns(uint, uint,uint,uint,uint,address){
        return (_index, itemList[_index].id,itemList[_index].itemPrice,itemList[_index].Item_Timeline[itemTimelineIndex-1],uint(itemList[_index].state),address(itemList[_index].item));
    }
    
    function placeOrder(uint _index) public payable{
        require(uint(itemList[_index].state)<1,"Item Not available");
        itemList[_index].state=itemState.PaymentDone;
        itemList[_index].Item_Timeline[itemTimelineIndex]=now;
        emit itemStep(_index, itemList[_index].id, uint(itemList[_index].state), itemList[_index].Item_Timeline[itemTimelineIndex],address(itemList[_index].item));
        itemTimelineIndex++;
    }
    
    function startDelivery(uint _index) public onlyOwner{
        require(uint(itemList[_index].state)>0,"Order not Placed");
        require(uint(itemList[_index].state)<2,"Already in Transit");
        itemList[_index].state=itemState.InTransit;
        itemList[_index].Item_Timeline[itemTimelineIndex]=now;
        emit itemStep(_index,itemList[_index].id, uint(itemList[_index].state), itemList[_index].Item_Timeline[itemTimelineIndex],address(itemList[_index].item));
        itemTimelineIndex++;
    }
    
    function makeDelivery(uint _index) public onlyOwner{
        require(uint(itemList[_index].state)>0,"Order not Placed");
        require(uint(itemList[_index].state)>1,"Not yet Shipped");
        require(uint(itemList[_index].state)<3,"Already Delivered");
        itemList[_index].state=itemState.Delivered;
        itemList[_index].Item_Timeline[itemTimelineIndex]=now;
        emit itemStep(_index,itemList[_index].id, uint(itemList[_index].state), itemList[_index].Item_Timeline[itemTimelineIndex],address(itemList[_index].item));
        itemTimelineIndex++;
    }
    
    function withdraw() public onlyOwner{
        _Owner.transfer(getBalance());
    }
    
    function getBalance() public view onlyOwner returns(uint){
        return address(this).balance;
    }
}