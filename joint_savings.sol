// SPDX-License-Identifier: MIT

pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {

    // Define variables
    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    // Define the withdraw function
    function withdraw(uint amount, address payable recipient) public {
        // Check if the recipient is either accountOne or accountTwo
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

        // Check if the contract balance is sufficient for the withdrawal
        require(address(this).balance >= amount, "Insufficient funds!");

        // Check if lastToWithdraw is not equal to the recipient
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // Transfer the amount to the recipient
        recipient.transfer(amount);

        // Update lastWithdrawAmount
        lastWithdrawAmount = amount;

        // Update contractBalance
        contractBalance = address(this).balance;
    }

    // Define the deposit function
    function deposit() public payable {
        // Update contractBalance
        contractBalance = address(this).balance;
    }

    // Define the setAccounts function
    function setAccounts(address payable account1, address payable account2) public {
        accountOne = account1;
        accountTwo = account2;
    }

    // Define the fallback function
    function() external payable {
        // Update contractBalance
        contractBalance = address(this).balance;
    }
}
