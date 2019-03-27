pragma solidity ^0.5.0;

interface IAssetTokenizationContract{
    function setERC20(string calldata _erc20Name, string calldata _erc20Symbol, uint8 _erc20Decimals) external;
    function setMainInfo(address _paymentAddress, address _taxAddress, uint256 _minimumShares, uint256 _taxRate) external;
    function setDistributionInfo(address _distributionAddress, uint256 _erc20Supply, bytes calldata _deploymentData) external returns (string memory);
}