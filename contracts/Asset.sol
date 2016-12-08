pragma solidity ^0.4.2;

contract Asset {

  enum AssetType { Wallet, Tangible, Intangible }
  enum AssetState { Locked, Unlocked }
  enum AssetStatus { OwnerChange, SubOwnerChange, Updated }

  struct LogEntry {
    uint24 status;
    uint timestamp;
    string updatedValue;
    string previousValue;
    string newValue;
  }

  string private assetID;
  string private assetName;
  string private assetDescription;
  uint24 private assetType;
  uint private createdOn;
  uint private updatedOn;
  uint24 state;
  LogEntry[] private historyLog;

  function Asset(address _owner, string _assetID, string _assetName, string _assetDescription, uint24 _assetType) {
    assetID = _assetID;
    assetName = _assetName;
    assetDescription = _assetDescription;
    assetType = _assetType;
    createdOn = now;
    updatedOn = now;
    state = uint24(AssetState.Locked);
    historyLog.push(LogEntry(uint24(AssetStatus.OwnerChange), now, "Owner", toAsciiString(0x0), toAsciiString(_owner)));
  }

  //Set Methods
  function setID(string _assetID) { addEntryToLog(uint24(AssetStatus.Updated), "ID", assetID, _assetID); assetID = _assetID; updatedOn = now; }
  function setName(string _assetName) { addEntryToLog(uint24(AssetStatus.Updated), "Name", assetName, _assetName); assetName = _assetName; updatedOn = now; }
  function setDescription(string _assetDescription) { addEntryToLog(uint24(AssetStatus.Updated), "Description", assetDescription, _assetDescription); assetDescription = _assetDescription; updatedOn = now; }
  function setType(uint24 _assetType) { addEntryToLog(uint24(AssetStatus.Updated), "Type", bytes32ToString(bytes32(assetType)), bytes32ToString(bytes32(_assetType))); assetType = _assetType; updatedOn = now; }

  //Get methods
  function getID() constant returns (string) { return assetID; }
  function getName() constant returns (string) { return assetName; }
  function getDescription() constant returns (string) { return assetDescription; }
  function getType() constant returns (uint24) { return assetType; }
  function getCreationDate() constant returns (uint) { return createdOn; }
  function getUpdatedDate() constant returns (uint) { return updatedOn; }

  //Methods to update/access the history log
  function addEntryToLog(uint24 _status, string _updatedVal, string _prevValue, string _newValue) {
    historyLog.push(LogEntry(_status, now, _updatedVal, _prevValue, _newValue));
  }
  function getHistoryLogSize() constant returns (uint) { return historyLog.length; }
  function getLogStatusEntryByIndex(uint _index) constant returns (int) {
    if(_index > historyLog.length) {
      return -1;
    }
    else {
      return historyLog[_index].status;
    }
  }
  function getLogDateEntryByIndex(uint _index) constant returns (uint) {
    if(_index > historyLog.length) {
      return 0;
    }
    else {
      return historyLog[_index].timestamp;
    }
  }
  function getLogUpdatedValueEntryByIndex(uint _index) constant returns (string) {
    if(_index > historyLog.length) {
      return "Entry not found";
    }
    else {
      return historyLog[_index].updatedValue;
    }
  }
  function getLogPreviousValueEntryByIndex(uint _index) constant returns (string) {
    if(_index > historyLog.length) {
      return "Entry not found";
    }
    else {
      return historyLog[_index].previousValue;
    }
  }
  function getLogNewValueEntryByIndex(uint _index) constant returns (string) {
    if(_index > historyLog.length) {
      return "Entry not found";
    }
    else {
      return historyLog[_index].newValue;
    }
  }
  //Helpers
  function toAsciiString(address x) returns (string) {
      bytes memory s = new bytes(40);
      for (uint i = 0; i < 20; i++) {
          byte b = byte(uint8(uint(x) / (2**(8*(19 - i)))));
          byte hi = byte(uint8(b) / 16);
          byte lo = byte(uint8(b) - 16 * uint8(hi));
          s[2*i] = char(hi);
          s[2*i+1] = char(lo);
      }
      return string(s);
  }
  function char(byte b) returns (byte c) {
      if (b < 10) return byte(uint8(b) + 0x30);
      else return byte(uint8(b) + 0x57);
  }
  function uintToBytes(uint v) constant returns (bytes32 ret) {
    if (v == 0) {
        ret = '0';
    }
    else {
        while (v > 0) {
            ret = bytes32(uint(ret) / (2 ** 8));
            ret |= bytes32(((v % 10) + 48) * 2 ** (8 * 31));
            v /= 10;
        }
    }
    return ret;
  }
  function bytes32ToString (bytes32 data) returns (string) {
    bytes memory bytesString = new bytes(32);
    for (uint j=0; j<32; j++) {
        byte char = byte(bytes32(uint(data) * 2 ** (8 * j)));
        if (char != 0) {
            bytesString[j] = char;
        }
    }
    return string(bytesString);
  }
}
