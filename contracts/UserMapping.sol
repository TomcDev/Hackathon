pragma solidity ^0.4.2;

contract UserMapping
{
	mapping (string => address) private userAccountsByEmail; //Given the email, obtain the address of the User contract
	mapping (address => address) private userAccountsByAddress; //Given the public key, obtain the address of the User contract

	function addUser(string _email, address _publicKey, address _userContract) { userAccountsByEmail[_email] = _userContract; userAccountsByAddress[_publicKey] = _userContract; }
	function getUserByEmail(string _email) constant returns (address) {
		return userAccountsByEmail[_email];
	}
	function getUserByPublicKey(address _pubKey) constant returns (address) {
		return userAccountsByAddress[_pubKey];
	}
}
