const path = require("path");
const fs = require("fs");
const solc = require("solc");

// Read the source code from the file
const filePath = path.resolve(__dirname, "Ballot.sol");
const source = fs.readFileSync(filePath, "utf8");

// Compile the source code
const input = {
  language: "Solidity",
  sources: {
    "Ballot.sol": {
      content: source,
    },
  },
  settings: {
    outputSelection: {
      "*": {
        "*": ["*"],
      },
    },
  },
};
const output = JSON.parse(solc.compile(JSON.stringify(input)));

// Extract the bytecode and ABI from the compiled output
const bytecode = output.contracts["Ballot.sol"]["Ballot"].evm.bytecode.object;
const abi = output.contracts["Ballot.sol"]["Ballot"].abi;

// Write the bytecode and ABI to separate files
const outputPath = path.resolve(__dirname, "build");
