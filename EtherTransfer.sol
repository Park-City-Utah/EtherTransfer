pragma solidity ^0.4.0;

contract EtherTransferTo {
     //fallback - accepts payment
    function () public payable {       
    }
    //return balance of To address
    function getBalance() public returns (uint) {
        return address(this).balance;
    }
}

contract EtherTransferFrom {
    //Instantiate creates an instance of this, so it has an address
    EtherTransferTo private _instance;
    
    //Constructor
    function EtherTransferFrom() public{
        //_instance = EtherTransferTo(address(this));   //if you know address, pre-existing
        _instance = new EtherTransferTo();              //creates new To instance
    }
    
    //Get balance of 
    function getBalance() public returns(uint){
        return address(this).balance;
    }
    
    //
    function getBalanceOfInstance() public returns (uint){
        //return address(_instance).balance;
        return _instance.getBalance();
    }
    
    //Anytime ether sent to From, sends half on to instance of To, From will retain half
    function () public payable {
        address(_instance).send(msg.value/2);  //msg knows how much sent(value)
    }
}