// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Assignment6 {
    // 1. Declare an event called `FundsDeposited` with parameters: `sender` and `amount`
    event FundsDeposited(address indexed sender, uint amount);

    // 2. Declare an event called `FundsWithdrawn` with parameters: `receiver` and `amount`
    event FundsWithdrawn(address indexed receiver, uint amount);

    // 3. Create a public mapping called `balances` to track users' balances
    mapping(address => uint) public balances;

    // Modifier to check if sender has enough balance
    modifier hasEnoughBalance(uint amount) {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        _;
    }

    // Function to deposit Ether
    // - External and payable
    // - Emits `FundsDeposited` event
    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");

        // Increment user balance in balances mapping
        balances[msg.sender] += msg.value;

        // Emit the event
        emit FundsDeposited(msg.sender, msg.value);
    }

    // Function to withdraw Ether
    // - External
    // - Takes `amount` as a parameter
    // - Uses `hasEnoughBalance` modifier
    // - Emits `FundsWithdrawn` event
    function withdraw(uint _amount) external hasEnoughBalance(_amount) {
        // Decrement user balance from balances mapping
        balances[msg.sender] -= _amount;

        // Send tokens to the caller
        payable(msg.sender).transfer(_amount);

        // Emit the event
        emit FundsWithdrawn(msg.sender, _amount);
    }

    // Function to check the contract balance
    // - Public and view
    // - Returns the contract's balance
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}
