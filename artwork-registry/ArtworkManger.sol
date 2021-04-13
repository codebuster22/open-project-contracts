pragma solidity ^0.8.0;

// ArtworkManager
// State Variables:-
// 1) mapping for mapping user to deployed ArtworkInterface Contract
// 2) Enum => for different types of Artwork 

// Functions:-
// 1) Deploy Artwork Interface Instance && Map user to it's artwork.
// 2) User can get Artworks

import './ArtworkInterface.sol';

contract ArtworkManager {
    
    // State Variables
    mapping(address => ArtworkInterface[]) userArt;
    mapping(bytes32 => address) artOwners;
    
    // Events
    event NewArtRegistration(address, string);
    event ArtRegistered(address _artAdrs, address _owner, string _art);
    
    // Modifiers
    modifier checkIfRegistered(string memory _art){
        require(artOwners[keccak256(abi.encode(_art))]==address(0), "Already Registered");
        _;
    }
    
    // Functions
    function registerArtwork(string memory _art ,string memory _artUrl, string memory _owner, uint _type) public checkIfRegistered(_artUrl) {
        emit NewArtRegistration(msg.sender, _artUrl);
        bytes32 hash = keccak256(abi.encode(_artUrl));
        ArtworkInterface art = new ArtworkInterface(_art,
        _owner,
        msg.sender,
        hash,
        _type,
        _artUrl);
        userArt[msg.sender].push(art);
        artOwners[hash] = msg.sender;
        emit ArtRegistered(address(art), msg.sender, _art);
    }
    
    function getArtworkByOwner(address _owner) public view returns(ArtworkInterface[] memory) {
        return userArt[_owner];
    }
    
    function getOwnerByArtwork(string memory _art) public view returns(address _owner){
        return artOwners[keccak256(abi.encode(_art))];
    }
    
    function isRegistered(string memory _art) public view checkIfRegistered(_art){}
}