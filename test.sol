pragma solidity ^0.8.0;
// SPDX-License-Identifier: UNLICENSED

// Test 1 
// sample transaction terkait preventing reentrancy attack

contract Test1 {
    mapping(address => uint) public balances;
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // made modifier to prevent reentrancy attack
    bool internal locked;
    modifier noReentrant() {
        require(!locked, "No reentrancy allowed");
        locked = true;
        _;
        locked = false;
    }

    function withdraw(uint _amount) public noReentrant {
        require(_amount <= balances[msg.sender]);
        
        // move this code in to function to prevent reentrancy attack
        balances[msg.sender] -= _amount;

        (bool sent, ) = msg.sender.call{value: _amount}("");
        require(sent, "failed to send");

    }

    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }
}

// Test 2
// melakukan concat string dengan parameter function
contract Test2 {
    // concat string and string
    function concatenateString(string calldata a, string calldata b) public pure returns (string memory) {
        return string(abi.encodePacked(a, b));
    }

    // convert uint to string
    function uintToString(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (_i != 0) {
            k = k-1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }

    // concat string and uint
    function concatStringAndUint(string calldata a, uint b) public pure returns (string memory) {
        return string(abi.encodePacked(a, uintToString(b)));
    }

    // concat all the data in struct
    struct ConcatAllStruct {
        string one;
        string two;
        uint three;
    }

    ConcatAllStruct wordStruct;

    function setStruct(string memory _one, string memory _two, uint _three) public {
        wordStruct.one = _one;
        wordStruct.two = _two;
        wordStruct.three = _three;
        
    }

    function concatStruct() public view returns (string memory) {
        string memory stringNumber = uintToString(wordStruct.three);
        return string(abi.encodePacked(wordStruct.one, wordStruct.two, stringNumber));
    }
}

// Test 3
// membuat smart contract
contract Test3 {
    struct User {
        address walletAddress;
        string name;
        string email;
        string password;
    }

    mapping(address => User) userMapping;

    // register function add user
    function registration(string memory _name, string memory _email, string memory _password) public {
        require(userMapping[msg.sender].walletAddress == address(0x0000000000000000000000000000000000000000), "Already Registered");
        User memory neuUser = User({
            walletAddress: msg.sender,
            name: _name,
            email: _email,
            password: _password
        });
        userMapping[msg.sender] = neuUser;
    }

    // get status user is registered not
    function getStatusUser() public view returns (string memory) {
        if (userMapping[msg.sender].walletAddress != address(0x0000000000000000000000000000000000000000)) {
            return "Your account is Registered";
        } else {
            return "Your account is not Registered";
        }
    }

    // delete the data user that already registered
    function Leave() public {
        require(userMapping[msg.sender].walletAddress != address(0x0000000000000000000000000000000000000000), "Not Registered");
        userMapping[msg.sender].walletAddress = address(0x0000000000000000000000000000000000000000);
    }
}

// Test 4
// sample transaction transfer menggunakan ERC20, misal transfer weth, transfer dari sender ke user lain
interface ERC20 {
    function totalSupply() external view returns (uint);
    function balance(address _owner) external view returns (uint);
    function transfer(address _to, uint _value) external returns (bool);
    function transferFrom(address _from, address _to, uint _value) external returns (bool);
    function approve(address _from, uint _value) external returns (bool);
    function allow(address _owner, address _spender) external view returns (uint);

    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
}

contract Test4 is ERC20 {
    uint public _totalSupply;
    
    mapping (address => uint) balancesOf;
    mapping (address => mapping (address => uint)) allowance;

    string public name = "Test4";
    string public symbol = "T4";
    uint public decimals = 18;

    constructor() {
        name = "Test Token";
        symbol = "TTKN";
        decimals = 18;
        _totalSupply = 100000000000000000000000000;

        balancesOf[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }
    
    function transfer(address _to, uint _value) external override returns (bool) {
        require(_to != address(0));
        require(_value <= balancesOf[msg.sender]);
        balancesOf[msg.sender] -= _value;
        balancesOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint _value) external override returns (bool) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint _value) external override returns (bool) {
        require(_value <= balancesOf[_from]);
        require(_value <= allowance[_from][msg.sender]);
        allowance[_from][msg.sender] -= _value;
        balancesOf[_from] -= _value;
        balancesOf[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function totalSupply() external override view returns (uint) {
        return balancesOf[msg.sender];
    }

    function balance(address _owner) external override view returns (uint) {
        return balancesOf[_owner];
    }

    function allow(address _owner, address _spender) external view override returns (uint) {
        return allowance[_owner][_spender];
    }
} 