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
    uint public winnerIndex;
    bool public contractOpen;


    modifier restricted() {
        require(msg.sender == sponsor);
        _;
    }

    constructor(uint minimum, address creator) public {
        sponsor = creator;
        minimumContribution = minimum;
        contractOpen = true;
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
        require(!request.complete == true);
        require(!contractOpen == true);

        request.voters[msg.sender] = true;
        request.votersCount++;
    }

    function getWinner() public restricted {
         //get the high votersCount Dapp and send to finalize
        // Dapp storage request = projects[index]
        uint256 largest = 0; 
        uint256 i;

        for(i = 0; i < projects.length ; i++){
            if(projects[i].votersCount > largest) {
                largest = projects[i].votersCount;
                winnerIndex = i;
            } 
        }
        finalizeDapp(winnerIndex);
    }
    
    // after milestone validation sponsors can send money
    function milestoneValidation(uint index) public restricted{
            Dapp storage request = projects[index];
            request.recipient.transfer(request.value);
    }
    
    

    function finalizeDapp(uint index ) public restricted {
        require(!contractOpen == true);
        Dapp storage request = projects[index];

        //require(request.votersCount > 2));
        require(!request.complete);
        // only half the cash is sent to the wineer
        request.recipient.transfer(request.value / 2);
        request.complete = true;
        contractOpen == false;
        //mark all project as complete function completeAll() or just close the contract
        //add reset all projects code here
     }

    }