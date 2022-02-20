const { hexDataSlice } = require("ethers/lib/utils");
const { task } = require("hardhat/config");

require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

task("block", "Prints informations about a given block")
  .addParam("number", "The block number")
  .setAction(async (taskArgs, hre) => {
    const block = await hre.ethers.provider.getBlock(parseInt(taskArgs.number));
    console.log(block);
  })

task("transaction", "Prints informations about a given transaction")
  .addParam("hash", "The transaction hash")
  .setAction(async (taskArgs, hre) => {
    const tx = await hre.ethers.provider.getTransaction(taskArgs.hash);
    console.log(tx);
  })

task("new-account", "Creates a new account and shows address and private key")
  .setAction(async (taskArgs, hre) => {
    const account = hre.ethers.Wallet.createRandom();
    const hashedPubKey = hre.ethers.utils.keccak256(hexDataSlice(account.publicKey, 1));

    console.log(`Address: ${account.address}`);
    console.log(`Public key: ${account.publicKey}`);
    console.log(`keccak256(pubkey): ${hashedPubKey}`)
    console.log(`Private key: ${account.privateKey}`);
  })

task("code", "Get the contract's code")
  .addParam("address", "The contract address")
  .setAction(async (taskArgs, hre) => {
    const code = await hre.ethers.provider.getCode(taskArgs.address);
    console.log(code);
  })

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  defaultNetwork: "goerli",
  networks: {
    hardhat: {},
    goerli: {
      url: `https://eth-goerli.alchemyapi.io/v2/${process.env.ALCHEMY_KEY_GOERLI}`
    },
    mainnet: {
      url: `https://eth-mainnet.alchemyapi.io/v2/${process.env.ALCHEMY_KEY_MAINNET}`
    }
  },
  solidity: "0.8.4",
};
