pragma solidity ^0.5.0;
import 'openzeppelin-solidity/contracts/token/ERC721/ERC721Holder.sol';
import "./asset-tokenization-contract.sol";


contract TokenizeCore is ERC721Holder {

	//state variables
	TokenToLock[] locked721Tokens;

	//structs
	struct TokenToLock{
		address tokenToLockAddress;
		uint tokenToLockId;
	}

	mapping(address => TokenToLock) public ERC20ToToken;
	mapping(bytes32 => address) tokenToERC20;

	function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes calldata _data) external returns(bytes4){
		(address _distributionAddress, 
			address _paymentAddress,
			address _taxAddress, 
			uint256 _erc20Supply,
			string memory _erc20Name, 
			string memory _erc20Symbol, 
			uint _erc20Decimals,
			uint _minimumShares, 
			bytes memory _deploymentData) = abi.decode(_data, (
				address, 
				address,
				address, 
				uint256, 
				string, 
				string, 
				uint, 
				uint,
				bytes));
		require(lock721Token(_operator, _distributionAddress, _paymentAddress, _taxAddress, _tokenId, _erc20Supply, _erc20Name, _erc20Symbol, _erc20Decimals, _minimumShares, _deploymentData) == true);
		return bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));
	}

	function lock721Token (
		address _tokenToLockAddress, 
		address _distributionAddress, 
		address _paymentAddress,
		address _taxAddress,
		uint256 _tokenToLockId, 
		uint256 _erc20Supply, 
		string memory _erc20Name, 
		string memory _erc20Symbol, 
		uint _erc20Decimals,
		uint _minimumShares,   
		bytes memory _deploymentData) private returns(bool)
	{
		TokenToLock memory _tokenToLock = TokenToLock(_tokenToLockAddress, _tokenToLockId);
		locked721Tokens.push(_tokenToLock); //need to think about if this will cause space issues
		AssetTokenizationContract newAssetTokenizationContract = new AssetTokenizationContract(_tokenToLockAddress, _distributionAddress, _paymentAddress, _taxAddress, _tokenToLockId, _erc20Supply, _erc20Name, _erc20Symbol, _erc20Decimals, _minimumShares, _deploymentData);
		ERC20ToToken[address(newAssetTokenizationContract)] = _tokenToLock;

		bytes32 _tokenToLockHash = abi.encode(keccak256(addressToString(_tokenToLockAddress), _tokenToLockId));
		tokenToERC20[_tokenToLockHash] = address(newAssetTokenizationContract);
		return true;
	}


	function getERC20Address(address _tokenToLockAddress, uint _tokenToLockId) public view returns(address){
		bytes32 _tokenToLockHash = abi.encode(keccak256(_tokenToLockAddress, _tokenToLockId));
		return tokenToERC20[_tokenToLockHash];
	}


	function unlockToken  (address _tokenToUnlockAddress, uint _tokenToUnlockId, address _claimant) public {
		require (msg.sender == tokenToERC20[abi.encode(keccak256(addressToString(_tokenToUnlockAddress), _tokenToUnlockId))]);
		_tokenToUnlockAddress.safeTransferFrom(address(this), _claimant, _tokenToUnlockId);
	}

	function addressToString(address _addr) public pure returns(string memory ) {
    bytes32 value = bytes32(uint256(_addr));
    bytes memory alphabet = "0123456789abcdef";

    bytes memory str = new bytes(42);
    str[0] = '0';
    str[1] = 'x';
    for (uint i = 0; i < 20; i++) {
        str[2+i*2] = alphabet[uint(value[i + 12] >> 4)];
        str[3+i*2] = alphabet[uint(value[i + 12] & 0x0f)];
    }
    return string(str);
}

}
