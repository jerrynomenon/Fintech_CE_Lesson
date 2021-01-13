pragma solidity ^0.6.6;
contract Will {
    address owner;
    uint estate;
    uint totalInheritance;
    bool isDeceased;
    
    address payable[] beneficiaries;
    
    mapping (address => uint) inheritance;
    
    constructor() public payable {
        
        // set owner as message sender
        owner = msg.sender;
        
        // set estate as message value
        estate = msg.value;
        
        // set totalInheritance to 0
        totalInheritance = 0;
        
        // set isDeceased as false
        isDeceased = false;
    }
    
    event BeneficiaryAdded(address beneficiary, uint amount);
    
    event Paid();
    
    modifier onlyOwner {
        // message sender must be owner
        require(msg.sender == owner);
        _;
    }
    
    modifier onlyIfDeceased {
        // isDeceased is true
        require(isDeceased);
        _;
    }

    modifier onlyIfAlive {
        // isDeceased is false
        require(isDeceased == false);
        _;
    }
    
    function addNewBeneficiary(address payable beneficiary, uint amount) public onlyOwner {
        // requires that there will be sufficient amount left in estate
        require(totalInheritance + amount <= estate, "Insufficient estate!");
        
        // add the beneficiary to the beneficiaries array
        beneficiaries.push(beneficiary);
        
        // set inheritance for the beneficiary as amount
        inheritance[beneficiary] = amount;
        
        // add the amount to totalInheritance
        totalInheritance += amount;
        
        // emit BeneficiaryAdded event
        emit BeneficiaryAdded(beneficiary, amount);
    }
    
    function payout() private onlyIfDeceased {
        // for each beneficiary pay their inheritance amount
        for (uint i = 0; i < beneficiaries.length; i++) {
            beneficiaries[i].transfer(inheritance[beneficiaries[i]]);
        }
        
        // emit paid event
        emit Paid ();
    }
    
    function deceased() public onlyOwner onlyIfAlive {
        // set isDeceased to true
        isDeceased = true;
        
        // pay the beneficiaries the inheritance
        payout();
    }
    
}