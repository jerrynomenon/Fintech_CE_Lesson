pragma solidity ^0.6.6;
contract Will {
    address owner;
    uint estate;
    uint totalInheritance;
    bool isDeceased;
    
    address payable[] beneficiaries;
    
    mapping (address => uint) inheritance;
    
    constructor() public payable {
        
        // @TODO: set owner as message sender
        
        // @TODO: set estate as message value
        
        // @TODO: set totalInheritance to 0
        
        // @TODO: set isDeceased as false
    }
    
    event BeneficiaryAdded(address beneficiary, uint amount);
    
    event Paid();
    
    modifier onlyOwner {
        // @TODO: message sender must be owner

        _; // this underscore sends us back to the function that called this modifier
    }
    
    modifier onlyIfDeceased {
        // @TODO: isDeceased is true
        
        _; // this underscore sends us back to the function that called this modifier
    }
    
    modifier onlyIfAlive {
        // @TODO: isDeceased is false
        _; // this underscore sends us back to the function that called this modifier
    }
        
    function addNewBeneficiary(address payable beneficiary, uint amount) public onlyOwner {
        // @TODO: requires that there will be sufficient amount left in estate
        
        // @TODO: add the beneficiary to the beneficiaries array
        
        // @TODO: set inheritance for the beneficiary as amount
        
        // @TODO: add the amount to totalInheritance
        
        // @TODO: emit BeneficiaryAdded event
    }
    
    function payout() private onlyIfDeceased {
        // @TODO: for each beneficiary pay their inheritance amount
        for (uint i = 0; i < beneficiaries.length; i++) {
            beneficiaries[i].transfer(inheritance[beneficiaries[i]]);
        }
        
        // @TODO: emit paid event
    }
    
    function deceased() public onlyOwner onlyIfAlive {
        // @TODO: set isDeceased to true
        
        // @TODO: pay the beneficiaries the inheritance
    }
    
}