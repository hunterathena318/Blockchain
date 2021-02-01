pragma solidity 0.5.2;
import  "./Mytoken.sol";
//
//contract ERC20Interface {
//  function totalSupply() public view returns (uint);
//
//  function balanceOf(address tokenOwner) public view returns (uint balance);
//
//  function allowance(address tokenOwner, address spender) public view returns (uint remaining);
//
//  function transfer(address to, uint tokens) public returns (bool success);
//
//  function approve(address spender, uint tokens) public returns (bool success);
//
//  function transferFrom(address from, address to, uint tokens) public returns (bool success);
//
//  event Transfer(address indexed from, address indexed to, uint tokens);
//  event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
//}
//
//
//contract ERC20 is ERC20Interface {
//
//  string private _name;
//  string private _symbol;
//  uint8 private _decimals;
//
//  uint256 private _totalSupply;
//
//  mapping (address => uint256) private balances;
//
//  mapping (address => mapping (address => uint256)) private allowed;
//
//
//  uint256 totalSupply_ = 10 ether;
//
//  using SafeMath for uint256;
//
//  constructor (string memory name_, string memory symbol_) public {
//    _name = name_;
//    _symbol = symbol_;
//    _decimals = 18;
//  }
//
//
//  function totalSupply() public  view returns (uint256) {
//    return totalSupply_;
//  }
//
//  function balanceOf(address tokenOwner) public view returns (uint256) {
//    return balances[tokenOwner];
//  }
//
//  function transfer(address receiver, uint256 numTokens) public returns (bool) {
//    require(numTokens <= balances[msg.sender]);
//    balances[msg.sender] = balances[msg.sender].sub(numTokens);
//    balances[receiver] = balances[receiver].add(numTokens);
//    emit Transfer(msg.sender, receiver, numTokens);
//    return true;
//  }
//
//  function approve(address delegate, uint256 numTokens) public returns (bool) {
//    allowed[msg.sender][delegate] = numTokens;
//    emit Approval(msg.sender, delegate, numTokens);
//    return true;
//  }
//
//  function allowance(address owner, address delegate) public view returns (uint) {
//    return allowed[owner][delegate];
//  }
//
//  function transferFrom(address owner, address buyer, uint256 numTokens) public returns (bool) {
//    require(numTokens <= balances[owner]);
//    require(numTokens <= allowed[owner][msg.sender]);
//
//    balances[owner] = balances[owner].sub(numTokens);
//    allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
//    balances[buyer] = balances[buyer].add(numTokens);
//    emit Transfer(owner, buyer, numTokens);
//    return true;
//  }
//}
//
//library SafeMath {
//  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
//    assert(b <= a);
//    return a - b;
//  }
//
//  function add(uint256 a, uint256 b) internal pure returns (uint256) {
//    uint256 c = a + b;
//    assert(c >= a);
//    return c;
//  }
//}

contract ConHeo {
  address public owner;
  uint releaseTime;
  event Deposit(uint256 amount);
  event Sold(uint256 amount);

  mapping(address => uint256) balances;
  mapping(address => mapping (address => uint)) tokens;

  IERC20 public tk;

  event Deposit(address token, address sender, uint amount);
  event Withdraw(address token, address sender, uint amount);

  constructor() public {
    tk = new Mytoken();
    owner = msg.sender;
    releaseTime = now + 5 minutes;
  }

  function deposit(uint amount) public {
    tk.approve(address(this), amount);
    require(tk.balanceOf(msg.sender) > amount, "not enough amount");
    tk.transferFrom(msg.sender ,address(this), amount);
//    tokens[address(this)][msg.sender] += amount;
    emit Deposit(amount);
  }

  function transfer(address _to, uint amount ) public returns (bool success) {
    tk.transfer(_to, amount);
    return true;
  }

  function approve(uint amount) public {
    tk.approve(address(this), amount);
  }

  function balanceOf(address tkOwner) public view returns (uint balance) {
    return tk.balanceOf(tkOwner);
  }

  function buy() payable public {
    require(msg.value > 0, "not enough");
    tk.transfer(msg.sender, msg.value);
  }

  function withdraw(address payable beneficiary) public returns (bool success) {
    beneficiary.transfer(address(this).balance);
    return true;
  }

  function withdrawERC(uint amount) public {
    uint256 allowance = tk.allowance(msg.sender, address(this));
    tk.transfer(msg.sender, amount);
    tokens[address(this)][msg.sender] -= amount;
//    emit Withdraw(token, msg.sender, amount);
  }

}