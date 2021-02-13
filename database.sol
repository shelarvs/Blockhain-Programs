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
     
     function playerRegistration(address player_address,uint _base_price, uint _age, string memory _player_type) public{
        require(map_player[player_address].player_id == address(0), "Player Already Registered");
        map_player[player_address].player_id = player_address;
        map_player[player_address].base_price = _base_price;
        map_player[player_address].age = _age;
        map_player[player_address].player_type = _player_type;
     }
     
     function teamRegistration(address team_address,string memory _team_name) public{
        require(map_team[team_address].team_id == address(0), "Team Already Registered");
        map_team[team_address].team_id = team_address;
        map_team[team_address].player_count =0;
        map_team[team_address].team_name = _team_name;
     }
     
     function player_details(address _return_player_id) public view returns(address,uint,uint,string memory){
        require(map_player[_return_player_id].player_id != address(0), "No Player Found");
        return (map_player[_return_player_id].player_id, map_player[_return_player_id].base_price, map_player[_return_player_id].age, map_player[_return_player_id].player_type);
     }
     
     function team_details(address _return_team_id) public view returns(address,uint,string memory){
        require(map_team[_return_team_id].team_id != address(0), "No Team Found");
        return (map_team[_return_team_id].team_id, map_team[_return_team_id].player_count, map_team[_return_team_id].team_name);
     }
 
}
