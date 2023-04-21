/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.0",
  networks: {
    hardhat: {},
  },
  networks: {
    localhost: {
      url: "http://localhost:8545",
    },
  },
};
