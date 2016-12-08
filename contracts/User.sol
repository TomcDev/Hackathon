pragma solidity ^0.4.2;

contract User
{
	string email;
	address account;
	string name;
	uint lastLoginDate;
	uint accountCreationDate;

	function User(string _email, address _account, string _name) {
		email = _email;
		account = _account;
		name = _name;
		lastLoginDate = 0;
		accountCreationDate = now;
	}

	function getEmail() constant returns (string) { return email; }
	function getAccount() constant returns (address) { return account; }
	function getName() constant returns (string) { return name; }
	function getLastLoginDate() constant returns (uint) { return lastLoginDate; }
	function getAccountCreationDate() constant returns (uint) { return accountCreationDate; }

	function setEmail(string _email) { email = _email; }
	function setAccount(address _account) { account = _account; }
	function setName(string _name) { name = _name; }
	function setLastLoginDate(uint _lastLoginDate) {lastLoginDate = _lastLoginDate; }
	function setAccountCreationDate(uint _accountCreationDate) {accountCreationDate = _accountCreationDate; }
}
