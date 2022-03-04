// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");
const readline = require("readline");

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
})

async function main() {
  const provider = hre.ethers.provider;
  const utils = hre.ethers.utils;
  const [account] = await hre.ethers.getSigners();

  const challenge = await hre.ethers.getContractAt("IOneEth", '0x588aD4e236A6E58996cb42EB8878A8A66B16bC95');

  const balanceBefore = await provider.getBalance(account.address);

  await challenge.join();
  await challenge.fight();

  const balanceAfter = await provider.getBalance(account.address);

  console.log(`you won ${utils.formatEther(balanceAfter.sub(balanceBefore))} ether`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});
