pragma solidity >=0.4.22 <0.8.0;

contract Elastik is StandardToken {
    string public name = "Elastikchain";
    string public symbol = "ECH";
    unit8 public decimals = 2;
    unit public INITIAL_SUPPLY = 5000;

    constructor() public {
        totalSupply_ = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
        emit Transfer(0x0, msg.sender, totalSupply_);
    }
}