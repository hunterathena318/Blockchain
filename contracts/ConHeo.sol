pragma solidity 0.5.2;

contract ERC20Interface {
  function totalSupply() public view returns (uint);

  function balanceOf(address tokenOwner) public view returns (uint balance);

  function allowance(address tokenOwner, address spender) public view returns (uint remaining);

  function transfer(address to, uint tokens) public returns (bool success);

  function approve(address spender, uint tokens) public returns (bool success);

  function transferFrom(address from, address to, uint tokens) public returns (bool success);

  event Transfer(address indexed from, address indexed to, uint tokens);
  event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

contract ConHeo {
  address public owner;
  uint releaseTime;

  mapping(address => uint256) tokenBalances;
  mapping(address => uint256) ethBalances;
  mapping(address => mapping (address => uint)) tokens;

  event Deposit(address token, address sender, uint amount);
  event Withdraw(address token, address sender, uint amount);

  constructor() public {
    //0x4de0EE5879ff666760366F8eC65776019F5343C5 ConHeoContract
    //Pig token : 0x41665ed27f42e8e29bc701cb28e73ea3b2715105
    owner = msg.sender;
    releaseTime = now + 5 minutes;
  }

  function () external payable {
    require(msg.value >= 0, "not enough ether");
    ethBalances[msg.sender] += msg.value;
  }

  function deposit(address tokenAddress, uint amount) public {
    ERC20Interface token = ERC20Interface(tokenAddress);
    // todo: token.approve(address(this), token amount);
    require(token.allowance(msg.sender, address(this)) >= amount, "token not allow transfer");
    (bool success) = token.transferFrom(msg.sender, address(this), amount);
    require(success, "transfer not success");
    tokenBalances[msg.sender] += amount;
  }

  function balanceOf(address tokenAddress, address tkOwner) public view returns (uint balance) {
    ERC20Interface token = ERC20Interface(tokenAddress);
    return token.balanceOf(tkOwner);
  }

  function withdraw(uint amount) public {
    require(amount > 0 && amount <= ethBalances[msg.sender], "amount not valid");
    ethBalances[msg.sender] -= amount;
    (msg.sender).transfer(amount);
  }

  function withdrawERC(address tokenAddress, uint amount) public {
    ERC20Interface token = ERC20Interface(tokenAddress);
    require(releaseTime < now, "time invalid");
    require(amount <= tokenBalances[msg.sender], "not enough amount");
    tokenBalances[msg.sender] -= amount;
    (bool success) =  token.transfer(msg.sender, amount);
    require(success, "transfer not success");
  }

}
