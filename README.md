# 🚩 Challenge 1: 🔏 Decentralized Staking App

![readme-1](https://github.com/scaffold-eth/se-2-challenges/assets/80153681/a620999a-a1ff-462d-9ae3-5b49ab0e023a)


🦸 A superpower of Ethereum is allowing you, the builder, to create a simple set of rules that an adversarial group of players can use to work together. In this challenge, you create a decentralized application where users can coordinate a group funding effort. If the users cooperate, the money is collected in a second smart contract. If they defect, the worst that can happen is everyone gets their money back. The users only have to trust the code.

🏦 Build a Staker.sol contract that collects ETH from numerous addresses using a payable stake() function and keeps track of balances. After some deadline if it has at least some threshold of ETH, it sends it to an ExampleExternalContract and triggers the complete() action sending the full balance. If not enough ETH is collected, allow users to withdraw().

🎛 Building the frontend to display the information and UI is just as important as writing the contract. The goal is to deploy the contract and the app to allow anyone to stake using your app. Use a Stake(address,uint256) event to list all stakes.

[Challenge Link](https://speedrunethereum.com/challenge/decentralized-staking)!
[Live URL](https://staking-app-eta-three.vercel.app/)!
[Contract Link](https://sepolia.etherscan.io/address/0x5ace0ab274232e535c0beed7f1fe90984429cd4f)!