pragma solidity ^0.8.0;

interface database{
    function playerRegistration(address _player_id, uint _base_price, uint _age, string memory _player_type) external;
    function teamRegistration(address _team_id, string memory _team_name) external;
    
    function player_details(address _return_player_id) external view returns(address,uint,uint,string memory);
    function team_details(address _return_team_id) external view returns(address,uint,string memory);
}

contract Auction{
    address player_id;
    uint base_price;
    uint age;
    string player_type;
    
    uint[] player_fetched_data;
    
    address auction_manager;
    
    constructor () public payable  {
        auction_manager = msg.sender;
    }
    
    database db;
    
    function set_DB(address db_address) public returns(address){
        db=database(db_address);
        return db_address;
    }
    
    function register_player(uint _base_price, uint _age, string memory _player_type)public payable{
        db.playerRegistration(msg.sender,_base_price,_age,_player_type);
    }
    
    function register_team(string memory _team_name)public payable{
        db.teamRegistration(msg.sender,_team_name);
    }

    function get_player_details(address _player_address) public view returns(address,uint,uint,string memory){
        return db.player_details(_player_address);
    }
    
     function get_team_details(address _team_address) public view returns(address,uint,string memory){
        return db.team_details(_team_address);
    }
}
