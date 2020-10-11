pragma solidity >=0.4.22 <0.6.0;

contract Lottery {
    address public manager;
    address[] public players;

    constructor() public{
        manager = msg.sender;
    }
    
    function enter() public payable {
        require(msg.value > .01 ether);
        players.push(msg.sender);   
    }
    function random() private view returns (unit){
        return uint(keccak256(abi.encodePacked(block.difficulty,now,players)));
    }
    function pickWinner() public onlyManager {
        //require(msg.sender == manager); we added restricted already
        uint index = random() % players.lenght;
        players[index].transfer(this.balance);
        players = new address[](0);
    }

    function returnEntries(){ 
    }
    modifier onlyManager(){
        required(msg.sender == manager);
        _;
    }
    function getPlayers() public view returns (address[]){
        return players;
    }
}