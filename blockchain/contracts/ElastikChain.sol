pragma solidity ^0.4.17;

/**
 * @title Elastikchain
 * @notice This is the main contract that will manage other part of the Dapp`.
 */

contract Elastikchain{
    address[] public deployedChallenges;
    
    function creatChallenge(uint minimum) public{
        address newChallenge = new Elastik(minimum, msg.sender, true);
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
        uint investorsCount;
        mapping(address => bool) voters;
        mapping(address => bool) investors;
    }

    Dapp[] public projects;
    address public sponsor;
    uint public minimumContribution;
    
    
    uint public winnerIndex;
    bool public contractStatus;


    modifier restricted() {
        require(msg.sender == sponsor);
        _;
    }

    constructor(uint minimum, address creator, bool status) public {
        sponsor = creator;
        minimumContribution = minimum;
        contractStatus = status;
    }

    function fund(uint index) public payable {
        Dapp storage request = projects[index];
        require(!contractStatus == false);
        require (msg.value > minimumContribution);

       request.investors[msg.sender] = true;
       if(msg.sender != sponsor){
            request.investorsCount++;
       }
    }

    function createDapp(string DappName, uint value, address recipient)
    public restricted
    {
        Dapp memory newDapp = Dapp({
           DappName: DappName,
           value: value,
           recipient: recipient,
           complete: false,
           votersCount: 0,
           investorsCount:0
        });

        projects.push(newDapp);
    }

    function VoteDapp(uint index) public {
        Dapp storage request = projects[index];

        //require(investors[msg.sender]);
        require(!contractStatus == false);
        require(!request.voters[msg.sender]);
        require(!request.complete == true);
        

        request.voters[msg.sender] = true;
        request.votersCount++;
    }

    function getWinner() public restricted {
        require(!contractStatus == false);
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
        require(!contractStatus == false);
        Dapp storage request = projects[index];

        //require(request.votersCount > 2));
        require(!request.complete);
        // only half the cash is sent to the wineer
        request.recipient.transfer(request.value / 2);
        request.complete = true;
        contractStatus == false;
        //mark all project as complete function completeAll() or just close the contract
        //add reset all projects code here
        //return winner index
     }

    }
