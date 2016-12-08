pragma solidity ^0.4.2;

contract UserAssets {

  address owner;
  uint public numberOfAssets;
  uint public numberOfBorrowedAssets;
  uint public numberOfBorrowingAssets;
  address[] assets;
  address[] borrowingAssets;

  struct assetstructure{
    address borrowingAssets;
    uint timestampFrom;
    uint timestampTo;
  }

  assetstructure[] borrowedAssets;

  mapping (address => uint) assetsMapping;
  mapping (address => uint) borrowingAssetsMapping; //Assets that the user borrowed TO others
  mapping (address => uint) borrowedAssetsMapping; //Assets that the user is borrowing FROM others

  function UserAssets(address _owner) {
    owner = _owner;
    numberOfAssets = 0;
  }

  function addAsset(address _asset) { assets.push(_asset); numberOfAssets++; assetsMapping[_asset] = assets.length; }
  function removeAsset(address _asset) returns (string) {
    if (assetsMapping[_asset] > 0) {
      for ( uint i = assetsMapping[_asset] ; i < assets.length - 1 ; i++){
          assets[i] = assets[i+1];
      }
      delete assets[assets.length-1];
      assets.length--;
      numberOfAssets--;
      return "";
    }
    else {
      return "Asset not found";
    }
  }
  function borrowAsset(address _asset) { borrowingAssets.push(_asset); numberOfBorrowingAssets++; borrowingAssetsMapping[_asset] = borrowingAssets.length; }
  function returnOwnership(address _asset) returns (string) {
    if (borrowingAssetsMapping[_asset] > 0) {
      for ( uint i = borrowingAssetsMapping[_asset] ; i < borrowingAssets.length - 1 ; i++){
          borrowingAssets[i] = borrowingAssets[i+1];
      }
      delete borrowingAssets[borrowingAssets.length-1];
      borrowingAssets.length--;
      numberOfBorrowingAssets--;
      return "";
    }
    else {
      return "Asset not found";
    }
  }
  function addBorrowedAsset(address _asset, uint _datefrom, uint _dateto) { borrowedAssets.push(assetstructure(_asset, _datefrom, _dateto)); numberOfBorrowedAssets++; borrowedAssetsMapping[_asset] = borrowedAssets.length; }
  function removeBorrowedAsset(address _asset) returns (string) {
    if (borrowedAssetsMapping[_asset] > 0) {
      for ( uint i = borrowedAssetsMapping[_asset] ; i < borrowedAssets.length - 1 ; i++){
          borrowedAssets[i] = borrowedAssets[i+1];
      }
      delete borrowedAssets[borrowedAssets.length-1];
      borrowedAssets.length--;
      numberOfBorrowedAssets--;
      return "";
    }
    else {
      return "Asset not found";
    }
  }
  function getOwnedAssets() constant returns (string) {
    string memory out = "";
    for(uint i = 0 ; i < assets.length; i++) {
      out = strConcat(out, toAsciiString(assets[i]), ';', '', '');
    }
    return out;
  }
  function getBorrowingAssets() constant returns (string) {
    string memory out = "";
    for(uint i = 0 ; i < borrowingAssets.length; i++) {
      out = strConcat(out, toAsciiString(borrowingAssets[i]), ';', '', '');
    }
    return out;
  }

  function getBorrowedAssets() constant returns (string) {
    string memory out = "";
    for(uint i = 0 ; i < borrowedAssets.length; i++) {
      out = strConcat(out, toAsciiString(borrowedAssets[i].borrowingAssets), bytes32ToString(uintToBytes(borrowedAssets[i].timestampFrom)), bytes32ToString(uintToBytes(borrowedAssets[i].timestampTo)),';');
    return out;
  }
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

  //Concatenates 5 strings
  function strConcat(string _a, string _b, string _c, string _d, string _e) internal returns (string){
    bytes memory _ba = bytes(_a);
    bytes memory _bb = bytes(_b);
    bytes memory _bc = bytes(_c);
    bytes memory _bd = bytes(_d);
    bytes memory _be = bytes(_e);
    string memory abcde = new string(_ba.length + _bb.length + _bc.length + _bd.length + _be.length);
    bytes memory babcde = bytes(abcde);
    uint k = 0;
    for (uint i = 0; i < _ba.length; i++) babcde[k++] = _ba[i];
    for (i = 0; i < _bb.length; i++) babcde[k++] = _bb[i];
    for (i = 0; i < _bc.length; i++) babcde[k++] = _bc[i];
    for (i = 0; i < _bd.length; i++) babcde[k++] = _bd[i];
    for (i = 0; i < _be.length; i++) babcde[k++] = _be[i];
    return string(babcde);
  }
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
}
