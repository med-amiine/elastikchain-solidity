pragma solidity ^0.4.17;

contract Elastikchain {
    
    struct Dapp {
        string DappName;
        uint value;
        address recipient;
        bool complete;
        uint votersCount;
        mapping(address => bool) voters;
    }

    Dapp[] public requests;
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

        requests.push(newDapp);
    }

    function VoteDapp(uint index) public {
        Dapp storage request = requests[index];

        //require(investors[msg.sender]);
        require(!request.voters[msg.sender]);

        request.voters[msg.sender] = true;
        request.votersCount++;

    }

    function finalizeDapp(uint index ) public restricted {
        Dapp storage request = requests[index];

        require(request.votersCount > (investorsCount / 2));
        require(!request.complete);

        request.recipient.transfer(request.value);
        request.complete = true;
     }
    }