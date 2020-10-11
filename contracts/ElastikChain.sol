pragma solidity >=0.4.22 <0.8.0;


contract ElastikChain {
     
    struct Funds
    {
        string milestoneName;
        address recipient;
        bool processed;
    }
    struct Voters
    {
        string startup;
        address dappName;
        bool isVoted;
        uint voteCount;
        mapping(address => bool) votes;
    }
    Funds[] public releaseFund;
    Voters[] public voter;
    uint public categoryPrize;
    uint public minimumInvestment;
    uint public voteCount;
    address public teamLead;
    address[] public sponsors;
    address[] public investors;
    mapping(address=>bool) voters;

    modifier restricted() {
        require(msg.sender == teamLead);
        _;
    }  
    modifier onlySponsors(){
        // for the purpos of this hackathon a single sponsor can validate the milstone
        require(msg.sender == sponsors[0]);
        _;
    }

    constructor (uint prize, uint investment) public {
        teamLead = msg.sender;
        categoryPrize = prize;
        minimumInvestment = investment;
    }

    function vote() public {
        voters[msg.sender] = true;
        voteCount = voteCount + 1;
    }

    // function pickWinner() public onlySponsors {
    //     //require(msg.sender == sponsors); we added onlySponsors 
    //     uint index = 10;
    // }

    function invest() public payable {
        require(msg.value > minimumInvestment, "We know you can invest more that :)");
        investors.push(msg.sender);
    }

    function addVote(string dappName, address startup) public {
        require(voters[msg.sender]);
        Voters memory newVoters = Voters({
            dappName:dappName,
            startup:startup,
            isVoted:false,
            voteCount : 0
            });
        voter.push(newVoters);
    }

   function getFunded(string milestoneName, address recipient) public restricted 
    {
        //Funds(milestoneName, recipient, false) une autre façon pour declarer le struct
        Funds memory newFunds = Funds({
            milestoneName:milestoneName,
            recipient:recipient,
            processed:false
            // approvalCount: 0
            });
    }
    // function approveRequest(uint index) public {

    //     require(approvers[msg.sender]);
    //     require(!requests[index].approvals[msg.sender]);

    //     requests[index].approvals[msg.sender]=true;
    //     requests[index].approvalCount++;
    // }
}