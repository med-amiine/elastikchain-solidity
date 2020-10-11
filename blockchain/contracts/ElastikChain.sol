pragma solidity ^0.4.17;

contract Elastikchain{
    address[] public deployedChallenges;
    
    function creatChallenge(uint minimum) public{
        address newChallenge = new Elastik(minimum, msg.sender);
        deployedChallenges.push(newChallenge);
    }
    
    function getDeployedChallenges() public view returns (address[]){
        return deployedChallenges;
    }
}

contract Elastik {
    
    struct Dapp {
        string DappName;
        uint value;
        address recipient;
        bool complete;
        uint votersCount;
        mapping(address => bool) voters;
    }

    Dapp[] public projects;
    address public sponsor;
    uint public minimumContribution;
    mapping(address => bool) public investors;
    uint investorsCount;

    modifier restricted() {
        require(msg.sender == sponsor);
        _;
    }

    constructor(uint minimum, address creator) public {
        sponsor = creator;
        minimumContribution = minimum;
    }

    function fund() public payable {
        require (msg.value > minimumContribution);

       investors[msg.sender] = true;
       investorsCount++;
    }

    function createDapp(string DappName, uint value, address recipient)
    public restricted
    {
        Dapp memory newDapp = Dapp({
           DappName: DappName,
           value: value,
           recipient: recipient,
           complete: false,
           votersCount: 0
        });

        projects.push(newDapp);
    }

    function VoteDapp(uint index) public {
        Dapp storage request = projects[index];

        //require(investors[msg.sender]);
        require(!request.voters[msg.sender]);

        request.voters[msg.sender] = true;
        request.votersCount++;
    }

    //  function getWinner() private view returns (unit){
    //      get the high votersCount Dapp and send to finalize
    //      finalizeDapp(uint index );
    // }
    
    // after milestone validation sponsors can send money
    function milestoneValidation(uint index) public restricted{
            Dapp storage request = projects[index];
            request.recipient.transfer(request.value);
    }

    function finalizeDapp(uint index ) public restricted {
        Dapp storage request = projects[index];

        //require(request.votersCount > 2));
        require(!request.complete);
        // only half the cash is sent to the wineer
        request.recipient.transfer(request.value / 2);
        request.complete = true;
        //add reset all projects code here
     }

    }