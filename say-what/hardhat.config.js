require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("set-what", "Set What")
  .addParam('address')
  .addParam('what')
  .setAction(async (taskArgs, hre) => {
    const SayWhat = await hre.ethers.getContractFactory("SayWhat");
    const saywhat = SayWhat.attach(taskArgs.address);
    const tx = await saywhat.setWhat(taskArgs.what);

    console.log(tx);
  });

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
 module.exports = {
  networks: {
    hardhat: {},
    goerli: {
      url: `https://eth-goerli.alchemyapi.io/v2/${process.env.ALCHEMY_KEY_GOERLI}`,
      accounts: [process.env.PRIVATE_KEY]
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY
  },
  solidity: "0.8.4",
};

