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
        return uint(keccak256(block.difficulty,now,players));
    }
    function pickWinner() public {
        require(msg.sender == manager);
        uint index = random() % players.lenght;
        players[index].transfer(this.balance);
        players = new address[](0);
    }
}