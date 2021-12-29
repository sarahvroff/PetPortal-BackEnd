//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract PetPortal { 
    uint256 totalPets;
    uint256 private seed;
    
    event NewPet(address indexed from, uint256 timestamp, string message);

    struct Pet {
        address petOwner; 
        string message; 
        uint256 timestamp; 
    }

    Pet[] pets;

    mapping(address => uint256) public lastSentImage;

    constructor() payable {
          console.log("We have been constructed!");
          seed = (block.timestamp + block.difficulty) % 100;
    }

    function pet(string memory _message) public {
        
        require(lastSentImage[msg.sender] + 30 seconds < block.timestamp, "Must wait 30 seconds before waving again.");
        
        lastSentImage[msg.sender] = block.timestamp;

        totalPets += 1;
        console.log("%s has sent a pet photo!", msg.sender, _message);
       
        pets.push(Pet(msg.sender, _message, block.timestamp));
       
        uint256 randomNumber = (block.difficulty + block.timestamp + seed) %
            100;
        console.log("Random # generated: %s", randomNumber);
        
        seed = randomNumber;

        if (randomNumber <= 50) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

        emit NewPet(msg.sender, block.timestamp, _message);
    }

    function getAllPets() public view returns (Pet[] memory) {
        return pets;
    }

    function getTotalPets() public view returns (uint256) {
        return totalPets;
    }
    
}