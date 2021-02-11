pragma solidity ^0.8.0;

contract dBank{

    // state variables

    address owner;

    struct User{

        string name;
        uint balance;
        address adrs;
        uint trxCounter;

    }
    mapping( address => User ) users;

    mapping(address => bool) kyc;
    
    mapping(address => bool) hold;

    // Constructor
    constructor () public {
        owner = msg.sender;
        require(users[msg.sender].adrs == address(0), "Account already exists");
        User memory user = User("Owner", 0, msg.sender, 0);
        users[msg.sender] = user;
        kyc[msg.sender] = true;
        hold[msg.sender] = false;
    }

    // Functional Declaration

    function register(string memory _name) public payable{

        require(users[msg.sender].adrs == address(0), "Account already exists");
        require(msg.value >= 2 ether, "You need to deposit atleast 2 ether to open account.");
        User memory user = User(_name, msg.value, msg.sender, 1);
        users[msg.sender] = user;

    }

    function getKycStatus() public view returns(bool){
        return kyc[msg.sender];
    }

    function completeKyc(address _adrs) public {
        
        require( msg.sender == owner, "You are not the Owner." );
        require( kyc[_adrs] == false, "KYC already completed." );
        kyc[_adrs] = true;

    }

    function deposit() public payable{
        
        require( hold[msg.sender] == false, "Account on HOLD" );
        require(kyc[msg.sender], "KYC not completed yet.");
        users[msg.sender].balance += msg.value;
        users[msg.sender].trxCounter += 1;

    }

    function withdraw(uint _amt) public{
        
        require( hold[msg.sender] == false, "Account on HOLD" );
        require( kyc[msg.sender] == true, "KYC not completed." );
        require( users[msg.sender].balance >= _amt , "Low Balance" );
        users[msg.sender].balance -= _amt;
        users[msg.sender].trxCounter += 1;
        payable(msg.sender).transfer(_amt);

    }

    function transferTo(address payable _to, uint _amt) public{
        
        require( hold[msg.sender] == false, "Account on HOLD" );
        require( kyc[msg.sender] == true, "KYC not completed." );
        require( users[msg.sender].balance >= _amt , "Low Balance" );
        users[msg.sender].balance -= _amt;
        users[msg.sender].trxCounter += 1;
        _to.transfer(_amt);

    }

    function closeAccount() public{

        require(msg.sender != owner, "Owner cannot close account.");
        uint balance = users[msg.sender].balance;
        delete users[msg.sender];
        kyc[msg.sender] = false;
        payable(msg.sender).transfer(balance);

    }

    function checkBalance() public view returns(uint) {
        require( hold[msg.sender] == false, "Account on HOLD" );
        return users[msg.sender].balance;

    }

    function getDBankBalance() public view returns(uint) {

        require(msg.sender == owner, "You are not the owner." );
        return address(this).balance;
    }
    
      function holdAccount(address _adrs) public {

        require( msg.sender == owner, "You are not the Owner." );
        require( hold[_adrs] == false, "Account is now on HOLD" );
        hold[_adrs] = true;

    } 
    
        function getHoldStatus() public view returns(bool){
        return hold[msg.sender];
    }

}
