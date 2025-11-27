// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RoaeToken {
    address public admin;
    string public name = "Root Of All Evil Token";
    string public symbol = "ROAE";
    uint8 public decimals = 18;
    uint public WaitingTime = 1 days;
    uint256 public totalSupply;
    mapping(address => uint256) public LastBorrowingTime;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    modifier onlyOwner() {
        require(msg.sender == admin, "Only admin can do this!");
        _;
    }

    constructor(uint256 initialSupply) {
        totalSupply = initialSupply * (10 ** uint256(decimals));
        admin = msg.sender;
        _balances[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

        function mint(uint256 amount) public onlyOwner {
        _balances[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        uint256 currentAllowance = _allowances[from][msg.sender];
        require(currentAllowance >= amount, "insufficient authorization limit");
        _approve(from, msg.sender, currentAllowance - amount);
        _transfer(from, to, amount);
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "Cannot transfer from a dead wallet");
        require(recipient != address(0), "Cannot transfer to a dead wallet");
        require(_balances[sender] >= amount, "Not enough money");
        _balances[sender] = _balances[sender] - amount;
        _balances[recipient] = _balances[recipient] + amount;
        emit Transfer(sender, recipient, amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "Invalid Owner");
        require(spender != address(0), "Unauthorized person");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
    
    function burn(uint256 amount) public {
        require(_balances[msg.sender] >= amount, "Not enough money to spend!");
        _balances[msg.sender] = _balances[msg.sender] - amount;
        totalSupply = totalSupply - amount;
        emit Transfer(msg.sender, address(0), amount);
    }

    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "Cannot printing tokens for a dead wallet");
        totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    function FreeTokenDaily() public {
        require(block.timestamp > LastBorrowingTime[msg.sender] + WaitingTime, "It's not the time yet!");
        _mint(msg.sender, 100 * 10**decimals);
        LastBorrowingTime[msg.sender] = block.timestamp;
    }
}