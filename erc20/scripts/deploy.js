const hre = require("hardhat");

async function main() {
  const ERC20 = await hre.ethers.getContractFactory("ERC20");
  const erc20 = await ERC20.deploy("My Token", "MTKN", 18);

  await erc20.deployed();

  console.log("My Token deployed to:", erc20.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
