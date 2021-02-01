pragma solidity 0.5.2;

contract calculator {
  function add(uint a, uint b) public view returns (uint);
  function sub(uint a, uint b) public view returns (uint);
}

contract TestInheritance is calculator {
  uint public c;
  function add(uint x, uint y) public view returns(uint) {
    return x +y;
  }
  function sub(uint x, uint y) public view returns(uint) {
    return x - y;
  }
}

//contract owned {
//  address owner;
//  constructor() public {
//    owner = msg.sender;
//  }
//}
//
//contract mortal is owned {
//  function kill() public {
////    if (msg.sender == owner)
//  }
//}
//
//contract Config {
//  function lookup(uint id) public returns (address adr);
//}
//
//contract NameReg {
//  function register(bytes32 name) public;
//  function unregister() public;
//}
//
//contract named is owned, mortal {
//  constructor(bytes32 name) public {
//    Config config = Config(0xD5f9D8D94886E70b06E474c3fB14Fd43E2f23970);
//    NameReg(config.lookup(1)).register(name);
//  }
//
//  function kill() public {
//    if (msg.sender == owner) {
//      Config config = Config(0xD5f9D8D94886E70b06E474c3fB14Fd43E2f23970);
//      NameReg(config.lookup(1)).unregister();
//      mortal.kill();
//    }
//  }
//}
//
//contract PriceFeed is owned, mortal, named("GoldFeed") {
//  function updateInfo(uint newInfo) public {
//    if (msg.sender == owner) info = newInfo;
//  }
//
//  function get() public view returns(uint r) { return info; }
//
//  uint info;
//}