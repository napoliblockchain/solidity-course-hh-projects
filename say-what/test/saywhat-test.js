const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SayWhat", function () {
  it("Should return the new what once it's changed", async function () {
    const SayWhat = await ethers.getContractFactory("SayWhat");
    const saywhat = await SayWhat.deploy("gm");
    await saywhat.deployed();

    expect(await saywhat.say()).to.equal("gm");

    const setWhatTx = await saywhat.setWhat("gm world");

    // wait until the transaction is mined
    await setWhatTx.wait();

    expect(await saywhat.say()).to.equal("gm world");
  });
});