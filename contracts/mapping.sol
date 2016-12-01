pragma solidity ^0.4.2;

contract Mapping
{
	mapping (bytes32 => address ) private RefugeesByIris; //Given the Iris, obtain the address of the Refugee contract

	function addRefugee(bytes32 _Iris, address _RefugeeContract) { RefugeesByIris[_Iris] = _RefugeeContract; }
	function getRefugeeByIris(bytes32 _Iris) constant returns (address) {
		return RefugeesByIris[_Iris];
	}
}
