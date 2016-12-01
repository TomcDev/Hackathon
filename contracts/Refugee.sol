pragma solidity ^0.4.2;

contract Refugee {

  string public name;
  string public gender;
  uint public birthdate;
  bytes32 public irisscan;

  struct logstruct {
    string signer;
    string location;
    string reasoncontact;
    uint timestamp;
  }

  logstruct[] public log;

  function Refugee(string _name, string _gender, uint _birthdate, bytes32 _irisscan) {
    name = _name;
    gender = _gender;
    birthdate = _birthdate;
    irisscan = _irisscan;
  }

  function getperson() constant returns (string n, string g, uint b) {
    n = name;
    g = gender;
    b = birthdate;
    }

  function addlog( string _signer, string _location, string _reasoncontact ) returns (bool a){
    uint i = log.length;
    log[i].signer = _signer;
    log[i].location = _location;
    log[i].reasoncontact = _reasoncontact;
    log[i].timestamp = block.timestamp;
    a = true;
  }
}
