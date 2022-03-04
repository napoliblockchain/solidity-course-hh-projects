// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  const provider = hre.ethers.provider;
  const utils = hre.ethers.utils;

  const WinOneEth = await hre.ethers.getContractFactory("WinOneEth");
  const winOneEth = await WinOneEth.deploy();

  await winOneEth.deployed();

  console.log("WinOneEth deployed to:", winOneEth.address);  

  await winOneEth.win([
    '0x2437fB4e5f0B3F9A3bC682976bc0c89331138514', 
    '0x588aD4e236A6E58996cb42EB8878A8A66B16bC95',
    '0x8c097B8640fa4796a0Ab03d425e87E4E93469893',
    '0x355586C10E740c84bCE29aDb1b87299d001Ebc52',
    '0xaB0e46A3356B3871ad173cd7b038c8eCC5ACEC8D'
  ]);

  const balanceAfter = await provider.getBalance(winOneEth.address)
  console.log(`you won ${utils.formatEther(balanceAfter)} ether`);

  await winOneEth.withdraw()
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});
