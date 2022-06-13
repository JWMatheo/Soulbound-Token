// SPDX-License-Identifier: MIT
// USE ERC1155 to create different collection e.g for university purpose (new promotion each year and different class too)
pragma solidity 0.8.13;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

/// @title A SBT contract example
/// @author JWMatheo
/// @notice You can use this contract in order to create your SoulBound Token !
/// @dev Soulbound Token contract
contract SBT is ERC721URIStorage{
   using Strings for uint256;
   using Counters for Counters.Counter;
   Counters.Counter private _tokenId;
   address owner;
   string _baseCollectionURI;
   string extension;

   constructor (string memory _baseURI, string memory _extension) ERC721("Soulbound Token","SBT") {
    owner = msg.sender;
    setBaseURI(_baseURI);
    setURIExtension(_extension);
   }

   modifier onlyOwner() {
    require(msg.sender == owner, "You're not the owner");
    _;
   }

   /**
    * @dev Create SBT by minting.
    * @param _to SBT receiver address.
    *
    * Requirements:
    *
    * - Can only be called by the owner.
    */
   function mint(address _to) external onlyOwner{
    _tokenId.increment();
    uint tokenId = _tokenId.current();
    _mint(_to, tokenId);
   }

   /**
    * @dev Set SBT's base URI.
    * @param _yourBaseURI Don't put '/' at the end of base URI.
    *
    * Requirements:
    *
    * - Can only be called by the owner.
    */
   function setBaseURI(string memory _yourBaseURI) internal onlyOwner{
    _baseCollectionURI = _yourBaseURI;
   }

   /**
    * @dev Set SBT's file extension.
    * @param _yourExtension Should probably be json.
    *
    * Requirements:
    *
    * - Can only be called by the owner.
    */
   function setURIExtension(string memory _yourExtension) internal onlyOwner{
    extension = _yourExtension;
   }
   
   /**
    * @dev Return the tokenURI of a NFT.
    *
    * Requirements:
    *
    * - Cannot get the URI of unexistent tokenID.
    */
   function tokenURI(uint256 tokenId) public view override returns (string memory) {

    require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

    return (bytes(_baseCollectionURI).length > 0 ? string(abi.encodePacked(_baseCollectionURI, "/", tokenId.toString(), ".", extension)) : "No base URI set");
    }

    /**
     * @dev Override 'safeTransferFrom' function in order to revert.
     */
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) public pure override {
      revert("SBT's cannot be transfered");
    }
    
    /**
     * @dev Override 'safeTransferFrom' function in order to revert.
     */
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory _data) public pure override {
      revert("SBT's cannot be transfered");
    }

    /**
     * @dev Override 'transferFrom' function in order to revert.
     */
    function transferFrom(address _from, address _to, uint256 _tokenId) public pure override {
      revert("SBT's cannot be transfered");
    }

    /**
     * @dev Override 'approve' function in order to revert.
     */
    function approve(address _to, uint256 _tokenId) public pure override {
      revert("SBT's cannot be transfered");
    }

    /**
     * @dev Override 'setApprovalForAll' function in order to revert.
     */
    function setApprovalForAll(address _operator, bool _approved) public pure override {
      revert("SBT's cannot be transfered");
    }

    /**
     * @dev Override 'getApproved' function in order to revert.
     */
    function getApproved(uint256 _tokenId) public pure override returns (address) {
      return address(0);
    }

    /**
     * @dev Override 'isApprovedForAll' function in order to revert.
     */
    function isApprovedForAll(address _owner, address _operator) public pure override returns (bool){
      return false;
    }  
}
