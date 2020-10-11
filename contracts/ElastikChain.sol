pragma solidity >=0.4.22 <0.8.0;


contract ElastikChain {
    struct Funds {
        string milestoneName;
        address reciepient;
        bool processed;
    }
    Funds[] public releaseFunds;
    uint public prize;
    uint public minimumInvestment;
    address public teamLead;
    address[] public sponsors;
    address[] public investors;
    address[] public users;

     modifier restricted() {
        require(msg.sender == teamLead);
        _;
     }  
        

    constructor (uint prize, uint investment) public{
        teamLead = msg.sender;
        categoryPrize = prize;
        minimumInvestment = investment;
    }

    function invest() public public payable {
        require(msg.value > minimumInvestment, "We know you can invest more that :)");
        investors.push(msg.sender);
    }

   function completedMilestone(string milestoneName, address reciepient) public restricted {
       Funds newFunds = Funds({
           milestoneName : milestoneName,
           recipient : recipient,
           processed : false
       });

        //Funds(milestoneName, recipient, false) une autre façon pour declarer le struct
       releaseFunds.push(newFunds);
   }
}