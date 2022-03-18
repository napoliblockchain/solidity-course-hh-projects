const { task } = require("hardhat/config");

require("@nomiclabs/hardhat-waffle");

task("propose", "", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigner();
}); 

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
};
