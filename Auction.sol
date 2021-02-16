pragma solidity ^0.8.0;

interface database{
    function playerRegistration(address _player_id, uint _base_price, uint _age, string memory _player_type) external;
    function teamRegistration(address _team_id, string memory _team_name) external;
    
    function player_details(address _return_player_id) external view returns(address,uint,uint,string memory);
    function team_details(address _return_team_id) external view returns(address,uint,string memory);
    
    function get_player_id(address _return_player_id) external view returns(address);
    function get_player_base_price(address _return_player_id) external view returns(uint);
    function get_player_age(address _return_player_id) external view returns(uint);
    function get_player_type(address _return_player_id) external view returns(string memory);
    
    function get_team_id(address _return_team_id) external view returns(address);
    function get_player_count(address _return_team_id) external view returns(uint);
    function get_team_name(address _return_team_id) external view returns(string memory);
    function get_team_players_selected(address _return_team_id) external view returns(address);
    
    function set_selected_player(address team_id ,address _selected_player_id) external;
    
}

contract Auction{
    address player_id_on_bid;
    
    uint bid_up_by=0;
    
    address bidder_data;
    
    address bidder_prev_data;
    uint bidder_prev_amount;
    
    uint bidder_amount;
    uint bidder_count=0;
    bool isBidOn=false;
    
    uint previous_bid_value=0;
    
    address auction_manager;
    
    constructor () public  {
        auction_manager = msg.sender;
    }
    
    database db;
    
    function set_DB(address db_address) public returns(address){
        require(msg.sender==auction_manager,"You are not Auction manager");
        db=database(db_address);
        return db_address;
    }
    
    function register_player(uint _base_price, uint _age, string memory _player_type)public{
        db.playerRegistration(msg.sender,_base_price,_age,_player_type);
    }
    
    function register_team(string memory _team_name)public{
        db.teamRegistration(msg.sender,_team_name);
    }

    function get_player_details(address _player_address) public view returns(address,uint,uint,string memory){
        return db.player_details(_player_address);
    }
    
     function get_team_details(address _team_address) public view returns(address,uint,string memory){
        return db.team_details(_team_address);
    }
    
    function start_bid(address _player_id_on_bid) public{
        require(msg.sender==auction_manager,"You are not Auction manager");
        require(bid_up_by>0,"Setup Bid Up Value");
        player_id_on_bid = _player_id_on_bid;
        isBidOn=true;
    }
    
    function bid_up(uint _bid_up_by) public{
        bid_up_by = _bid_up_by*(1 ether);
    }
    
    function bid()public payable{
        require(isBidOn==true,"No Player on Bid");
        
        bidder_prev_data = bidder_data;
        bidder_prev_amount = bidder_amount;
        
        if(bidder_count<5){
            if(previous_bid_value<msg.value){
                payable(bidder_data).transfer(bidder_amount);
                
                bidder_data = msg.sender;
                bidder_amount = msg.value;
                bidder_count +=1;
                previous_bid_value=msg.value + bid_up_by;   
            }
        }
        else{
            db.set_selected_player(bidder_data, player_id_on_bid);
            payable(player_id_on_bid).transfer(bidder_amount);
            payable(bidder_prev_data).transfer(bidder_prev_amount);
            bidder_count=0;
            isBidOn=false;
        }
    }
    
    function players_selected(address _team_address) public view returns(address){
        return db.get_team_players_selected(_team_address);
    }
    
    function Last_bid() public view returns(address,uint){
        return (bidder_data,previous_bid_value);
    }
    
    function player_on_bid_id() public view returns(address){
         return player_id_on_bid;
    }
}
