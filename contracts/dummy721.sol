pragma solidity ^0.5.0;
import 'openzeppelin-solidity/contracts/token/ERC721/ERC721.sol';

contract dummy721 is ERC721{
	event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
	event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
	event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
    event minted(uint256 _tokenId);
    /**
    * Custom accessor to create a unique token
    */

    uint256 public nextTokenId = 1;

    function mintUniqueTokenTo(address _to) public
    {
        uint256 _tokenId = nextTokenId;
        super._mint(_to, _tokenId);
        emit minted(_tokenId);
        nextTokenId = nextTokenId + 1;
    }
}