pragma solidity ^0.8.0;


// ArtworkInterface
// State Variables:-
// 1) Name
// 2) Onwer Name
// 3) hash 
// 4) Type 
// 5) URL
// 6) Owner - Address 
// 7) registeredOn

// Functions:-
// constructor
// checkOwnership
// checkArtwork
// transferOwnership
// biSell (optional)
contract ArtworkInterface{
    
    // State Variables
    string artName;
    string ownerName;
    address owner;
    bytes32 hash;
    uint artType;
    string url;
    uint registeredOn;
    
    // Events
    event VerifyOwner(string _result);
    event VerifyArt(string _result);
    event OwnershipTransfered(address _prev, address _new);
    event GetArtwork(
            string _artName,
            string _ownerName,
            address _owner,
            bytes32 _hash,
            uint _artType,
            string _url,
            uint _registeredOn
            );
    
    // Constructor 
    constructor (
        string memory _artName,
        string memory _ownerName,
        address _owner,
        bytes32 _hash,
        uint _artType,
        string memory _url
        ) {
        artName = _artName;
        ownerName = _ownerName;
        owner = _owner;
        hash = _hash;
        artType = _artType;
        url = _url;
        registeredOn = block.timestamp;
    }
    
    modifier onlyOwner  {
        require(msg.sender == owner, "You are not the owner");
        _;
    }
    
    function checkOwner(address _owner) public {
        require(_owner == owner, "Not the owner");
        emit VerifyOwner("Verified");
    }
    
    function checkArtwork(string memory _art) public {
        require(keccak256(abi.encode(_art)) == hash, "This contract is not for above mentioned art");
        emit VerifyArt("Verified");
        
    }
    
    function transferOwnership(address _owner) public onlyOwner{
        owner = _owner;
        emit OwnershipTransfered(msg.sender, owner);
    }
    
    function getArtwork() public{
        emit GetArtwork(artName, ownerName, owner, hash, artType, url, registeredOn);
    }
    
    
}