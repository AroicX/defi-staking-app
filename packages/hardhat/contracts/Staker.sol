// SPDX-License-Identifier: MIT
pragma solidity 0.8.4; //Do not change the solidity version as it negativly impacts submission grading

import "hardhat/console.sol";
import "./ExampleExternalContract.sol";

contract Staker {
	ExampleExternalContract public exampleExternalContract;

	event Stake(address indexed sender, uint256 amount);
	bool public openForWithdraw = false;

	mapping(address => uint256) public balances;
	uint256 public constant threshold = 1 ether;
	uint256 public deadline = block.timestamp + 30000 hours;

	modifier checkThreshold() {
		require(address(this).balance >= threshold, "Target funds not met!");
		_;
	}

	modifier notCompleted() {
		require(!exampleExternalContract.completed(), "Not completed...");
		_;
	}

	modifier targetMet() {
		require(openForWithdraw, "Contract closed.");
		_;
	}

	constructor(address exampleExternalContractAddress) {
		exampleExternalContract = ExampleExternalContract(
			exampleExternalContractAddress
		);
	}

	// Collect funds in a payable `stake()` function and track individual `balances` with a mapping:
	// (Make sure to add a `Stake(address,uint256)` event and emit it for the frontend `All Stakings` tab to display)
	function stake() public payable {
		balances[msg.sender] += msg.value;
		emit Stake(msg.sender, msg.value);
	}

	// After some `deadline` allow anyone to call an `execute()` function
	// If the deadline has passed and the threshold is met, it should call `exampleExternalContract.complete{value: address(this).balance}()`
	function execute() public notCompleted {
		require(block.timestamp >= deadline, "Deadline not exceeded");

		if (address(this).balance >= threshold) {
			exampleExternalContract.complete{ value: address(this).balance }();
		} else {
			openForWithdraw = true; // Allow withdrawals if threshold not met
		}
	}

	// If the `threshold` was not met, allow everyone to call a `withdraw()` function to withdraw their balance

	function withdraw() public notCompleted targetMet {
		require(openForWithdraw, "Not open for withdrawals");
		uint256 temp = balances[msg.sender];
		balances[msg.sender] = 0;
		(bool status, ) = msg.sender.call{ value: temp }(" ");
		require(status, "Failed to withdraw");

		emit Stake(msg.sender, temp);
	}

	// Add a `timeLeft()` view function that returns the time left before the deadline for the frontend
	function timeLeft() public view returns (uint256) {
		if (block.timestamp >= deadline) {
			return 0;
		}
		return deadline - block.timestamp;
	}

	// Add the `receive()` special function that receives eth and calls stake()
	receive() external payable {
		stake();
	}
}
