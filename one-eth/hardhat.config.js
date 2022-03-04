require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
 module.exports = {
  defaultNetwork: "goerli",
  networks: {
    hardhat: {
      forking: {
        url: `https://eth-goerli.alchemyapi.io/v2/${process.env.ALCHEMY_KEY_GOERLI}`
      }
    },
    goerli: {
      url: `https://eth-goerli.alchemyapi.io/v2/${process.env.ALCHEMY_KEY_GOERLI}`
    },
    mainnet: {
      url: `https://eth-mainnet.alchemyapi.io/v2/${process.env.ALCHEMY_KEY_MAINNET}`
    }
  },
  solidity: "0.8.4",
};

