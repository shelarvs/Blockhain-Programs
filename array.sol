pragma solidity ^0.8.0;

contract array{
    //static array
    uint[10] s_data;
    
    function s_array(uint a, uint _index) public{
        s_data[_index] = a;
    }
    
    function results(uint index) public view returns(uint x){
        return s_data[index];    
    }
}
