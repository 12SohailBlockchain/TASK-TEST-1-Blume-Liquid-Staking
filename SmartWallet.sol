/*

███████ ███    ███  █████  ██████  ████████ ██     ██  █████  ██      ██      ███████ ████████ 
██      ████  ████ ██   ██ ██   ██    ██    ██     ██ ██   ██ ██      ██      ██         ██    
███████ ██ ████ ██ ███████ ██████     ██    ██  █  ██ ███████ ██      ██      █████      ██    
     ██ ██  ██  ██ ██   ██ ██   ██    ██    ██ ███ ██ ██   ██ ██      ██      ██         ██    
███████ ██      ██ ██   ██ ██   ██    ██     ███ ███  ██   ██ ███████ ███████ ███████    ██    
                                                                                               
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract SmartWallet is Ownable {

    // Event to notify when a deposit has been made
    event Deposit(address indexed sender, uint amount);
    // Event to notify when a withdrawal has been made
    event Withdrawal(address indexed to, uint amount);

    // Function to deposit Ether into the contract
    function deposit() public payable onlyOwner {
        emit Deposit(msg.sender, msg.value);
    }

    // Function to withdraw Ether from the contract
    function withdraw(uint _amount) public onlyOwner {
        require(address(this).balance >= _amount, "Insufficient balance in the smart wallet");
        payable(owner()).transfer(_amount);
        emit Withdrawal(msg.sender, _amount);
    }

    // Function to check the balance of the contract
    function balance() public view returns (uint) {
        return address(this).balance;
    }
}
