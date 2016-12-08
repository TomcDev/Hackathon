pragma solidity ^0.4.2;

contract UserAssetMapping
{
	  mapping (address => address) dataMapping; // User => UserAssets

	  function addAddress(address _user, address _userAssets) { dataMapping[_user] = _userAssets; }
	  function getAddress(address _user) constant returns (address) {
	    if (dataMapping[_user] != 0x0) {
	      return dataMapping[_user];
	    }
	    else {
	      return 0x0;
	    }
	  }
}
