pragma solidity ^0.8.0;

contract calculator{
    
    function Add (uint a, uint b) public view returns(uint x){
        uint c = a + b;
        return c;
    }
    
    function substract(uint a, uint b) public view returns(uint x){
        uint c=a-b;
        return c;
    }
    
    function divide(uint a,uint b)public view returns(uint x){
        if(b==0){
            return b;
        }
        else {
            uint c=a/b;
            return c;
        }
    }
    
    function multiply(uint a,uint b) public view returns(uint x){
        uint c= a*b;
        return c;
    }
    
}
