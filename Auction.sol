pragma solidity ^0.8.0;

contract auction{
   
    address manager;
   
    //TEAM DATA
    uint bidCounter;  
    string playerType;
    uint budget;
    bool playerSelectedFlagVal;
    
    uint count=0;
   
    //PLAYER DATA
    uint bidUpBy;
    address temp_player_id;

   
    struct Player{
         address p_id;
         uint basePrice;
         uint rating;
         string playerType;
    }
   
    struct Team{
         address t_id;
         string teamName;
         address[15] playerSelected;
    }
   Team teamData;

   
    struct manageBidData{
        address teamAddress;
        uint bidAmount;
    }

    constructor () public {
        manager = msg.sender;
    }
   
    mapping(address=>Team)team;
    mapping(address=>Player)player;
    mapping(address=>bool) userType;
    mapping(address=>manageBidData)manage;
   
   
    function PlayerRegistration(uint _baseprice, uint _rating, string memory _playerType) public {
        require(manager!=msg.sender, "Manager Cannot Be Team");
        require(player[msg.sender].p_id == address(0), "Player already Registered");
        Player memory playerData = Player(msg.sender, _baseprice, _rating, _playerType);
       
        userType[msg.sender] = true;
       
    }
   
    function TeamRegistration(string memory _teamName) public {
        
        require(manager!=msg.sender, "Manager Cannot Be Team");    
        require(team[msg.sender].t_id == address(0), "Team already Registered");
        teamData.t_id=msg.sender;
        teamData.teamName = _teamName;
        
        userType[msg.sender] = false;
       
    }
   
    function startBid(address playerID) public{
        require(msg.sender==manager,"You are not Auction manager");
        temp_player_id = playerID;
        playerSelectedFlagVal=false;
        bidCounter=0;
    }
   
    function setBidUpBy(uint _bidUpBy) public {
        require(msg.sender==manager,"You are not Auction manager");
        bidUpBy=_bidUpBy;
    }
   
    function BID(uint _amount)public{
        require(userType[msg.sender] == false, "Team Not Registered to BID");
        require(playerSelectedFlagVal==false, "Bid is Over On This Player...PLAYER SELECTED");
        
        require(_amount>=player[temp_player_id].basePrice,"Amount is less than base price");
        require(bidUpBy > 0,"Set Bid Up Value Greater than 0");
        manage[msg.sender].teamAddress = msg.sender;
        manage[msg.sender].bidAmount = _amount;
        bidCounter+=1;
        
        if(bidCounter==5)
        {
            teamData.playerSelected[count];
            count+=1;
            playerSelectedFlag();
        }
    }
    
    function playerSelectedFlag() private{
        playerSelectedFlagVal=!playerSelectedFlagVal;
    }

}
