pragma solidity ^0.4.17;

contract Inbox {
    string public message;

    function Inbox(string initialMessage) public {
        message = initialMessage;
    }
    function setMessage(string newMessage) public{
        message = newMessage;
    }

    // not necessary since we can call the variable to get our message
    // function getMessage(string newMessage) public view returns {
    //     return newMessage;
    // }
}