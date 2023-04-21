const { ethers } = require("hardhat");

const fs = require("fs");

async function main() {
  // Get the contract factory
  const Ballot = await ethers.getContractFactory("Ballot");

  // Deploy the contract
  const ballot = await Ballot.deploy();

  // Wait for the contract to be mined
  await ballot.deployed();

  // Write the address of the contract to a file
  const addressFilePath = "./address.txt";
  fs.writeFileSync(addressFilePath, ballot.address);
  console.log(`Contract deployed to: ${ballot.address}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
