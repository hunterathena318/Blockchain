//pragma solidity 0.5.2;
pragma solidity >=0.4.22 <0.9.0;

contract SafeMath {
  function safeAdd(uint a, uint b) public pure returns (uint c) {
    c = a + b;
    require(c >= a);
  }
  function safeSub(uint a, uint b) public pure returns (uint c) {
    require(b <= a);
    c = a - b;
  }
  function safeMul(uint a, uint b) public pure returns (uint c) {
    c = a * b;
    require(a == 0 || c / a == b);
  }
  function safeDiv(uint a, uint b) public pure returns (uint c) {
    require(b > 0);
    c = a / b;
  }
}


// ----------------------------------------------------------------------------
// ERC Token Standard #20 Interface
// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md
// ----------------------------------------------------------------------------
contract ERC20Interface {
  function totalSupply() public view returns (uint256);
  function balanceOf(address tokenOwner) public view returns (uint balance);
  function allowance(address tokenOwner, address spender) public view returns (uint remaining);
  function transfer(address to, uint tokens) public returns (bool success);
  function approve(address spender, uint tokens) public returns (bool success);
  function transferFrom(address from, address to, uint tokens) public returns (bool success);

  event Transfer(address indexed from, address indexed to, uint tokens);
  event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}


// ----------------------------------------------------------------------------
// Contract function to receive approval and execute function in one call
//
// Borrowed from MiniMeToken
// ----------------------------------------------------------------------------
contract ApproveAndCallFallBack {
  function receiveApproval(address from, uint256 tokens, address token, bytes memory data) public;
}


// ----------------------------------------------------------------------------
// Owned contract
// ----------------------------------------------------------------------------
contract Owned {
  address public owner;
  address public newOwner;

  event OwnershipTransferred(address indexed _from, address indexed _to);

  constructor() public {
    owner = msg.sender;
  }

  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }

  function transferOwnership(address _newOwner) public onlyOwner {
    newOwner = _newOwner;
  }
  function acceptOwnership() public onlyOwner{
    require(msg.sender == newOwner);
    emit OwnershipTransferred(owner, newOwner);
    owner = newOwner;
    newOwner = address(0);
  }
}

contract Deployer {
  address public owner;
  address public admin;
  uint releaseTime;
  constructor() public {
    owner = msg.sender;
    admin = 0x93775bFF50178feafeFb7bf6E474b6274d2E6393;
    releaseTime = now + 2 minutes;
  }
  modifier onlyBy
  {
    require(
      msg.sender == owner ||
      msg.sender == admin, "unAuthorized"
    );
    _;
    require(now > releaseTime);
    _;
  }
}

contract PigERC20 is ERC20Interface, SafeMath, Owned, Deployer {
  string public symbol;
  string public  name;
  uint8 public decimals;

  address targetToken = 0xB4DCDbe054350c6D6Cce280CB520346E16953F80;
  ERC20Interface token;

  address public deployer;
  address public owner;
  uint public _totalSupply;

  mapping(address => uint) balances;
  mapping(address => mapping(address => uint)) allowed;

  // ------------------------------------------------------------------------
  // Constructor
  // ------------------------------------------------------------------------
  constructor() public {
    symbol = "PIG";
    name = "PigToken";
    decimals = 18;
    deployer = msg.sender;
    _totalSupply = 100000000000000000000000000;
    balances[msg.sender] = _totalSupply;
    token = ERC20Interface(targetToken);
    emit Transfer(address(0), msg.sender, _totalSupply);
  }

  function totalSupply() public view returns (uint) {
    require(msg.sender == deployer);
    return _totalSupply  - balances[address(this)];
  }

  function balanceOf(address tokenOwner) public view returns (uint balance) {
    return balances[tokenOwner];
  }

  function transfer(address to, uint tokens) public returns (bool success) {
    require(balances[msg.sender] >= tokens);
    balances[msg.sender] = safeSub(balances[msg.sender], tokens);
    balances[to] = safeAdd(balances[to], tokens);
    emit Transfer(address(this), to, tokens);
    return true;
  }

  function approve(address spender, uint tokens) public returns (bool success) {
    allowed[msg.sender][spender] = tokens;
    emit Approval(address(this), spender, tokens);
    return true;
  }

  function transferFrom(address from, address to, uint tokens) public returns (bool success) {
    balances[from] = safeSub(balances[from], tokens);
    allowed[from][msg.sender] = safeSub(allowed[from][msg.sender], tokens);
    balances[to] = safeAdd(balances[to], tokens);
    emit Transfer(from, to, tokens);
    return true;
  }

  function allowance(address tokenOwner, address spender) public view returns (uint remaining) {
    return allowed[tokenOwner][spender];
  }

  function approveAndCall(address spender, uint tokens, bytes memory data) public returns (bool success) {
    allowed[msg.sender][spender] = tokens;
    emit Approval(msg.sender, spender, tokens);
    ApproveAndCallFallBack(spender).receiveApproval(msg.sender, tokens, address(this), data);
    return true;
  }

  function () external payable {
    revert();
  }

  function transferAnyERC20Token(address tokenAddress, uint tokens) public onlyOwner returns (bool success) {
    return ERC20Interface(tokenAddress).transfer(owner, tokens);
  }

  function withdraw(address payable beneficiary) public onlyBy {
    beneficiary.transfer(address(this).balance);
  }

// TODO
//  function sendToETH(uint ETH) public returns(bool success) {
//    require(ETH > 0);
//    balancesETH[msg.sender] -= ETH;
//    return true;
//  }
//
//  function sendToERC20(uint tokens) public returns (bool success) {
//    balancesERC20[msg.sender] -= tokens;
////    emit Transfer(msg.sender, to, tokens);
//    return true;
//  }
//
//  function getETH() public view returns(uint){
//    require(msg.sender == Admin || msg.sender == deployer);
//    return address(this).balance;
//  }
//
//  function getERC20(address caller) public view returns (uint) {
//    require(msg.sender == caller);
//    return balancesERC20[caller];
//  }
//
//  function depositETH(uint256 amount) payable public {
//    require(msg.value == amount);
//    balancesETH[msg.sender] += msg.value;
//    emit transferETH(msg.sender, address(this), amount);
//  }
//
//  function getBalanceETH() public view returns (uint256) {
//    require(msg.sender == deployer);
//    // TODO check time after deployed : 356 days
//    return address(this).balance;
//  }
//
//  function updateAdmin(address change) public returns(bool success) {
//    Admin = change;
//    return true;
//  }

}

