pragma solidity ^0.8.0;

contract database{
    struct player{
        address player_id;
        uint base_price;
        uint age;
        string player_type;
    }
    player mp;
    
    struct team{
        address team_id;
        uint player_count;
        string team_name;
    }
    team mt;
    
     mapping(address=>player) map_player;
     mapping(address=>team) map_team;
     
     function playerRegistration(uint _base_price, uint _age, string memory _player_type) public{
        
        map_player[msg.sender].player_id = msg.sender;
        map_player[msg.sender].base_price = _base_price;
        map_player[msg.sender].age = _age;
        map_player[msg.sender].player_type = _player_type;
     }
     
     function teamRegistration(string memory _team_name) public{
        
        map_team[msg.sender].team_id = msg.sender;
        map_team[msg.sender].player_count =0;
        map_team[msg.sender].team_name = _team_name;
     }
     
     function player_details(address _return_player_id) public view returns(address,uint,uint,string memory){
        return (map_player[_return_player_id].player_id, map_player[_return_player_id].base_price, map_player[_return_player_id].age, map_player[_return_player_id].player_type);
     }
     
     function team_details(address _return_team_id) public view returns(address,uint,string memory){
        return (map_team[_return_team_id].team_id, map_team[_return_team_id].player_count, map_team[_return_team_id].team_name);
     }
 
}
