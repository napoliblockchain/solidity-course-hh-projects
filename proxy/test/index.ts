import { expect } from "chai";
import { ethers } from "hardhat";

describe("ProxyA", function () {
  it("Should call ImplementationA", async function () {

    const ImplementationA = await ethers.getContractFactory("ImplementationA");    
    const implementationA = await ImplementationA.deploy();
    
    const ProxyA = await ethers.getContractFactory("ProxyA");
    const proxyA = await ProxyA.deploy(implementationA.address);

    await proxyA.deployed();
    await implementationA.deployed();

    const A = ImplementationA.attach(proxyA.address);
    expect(await A.funA(false)).to.equal('funA was called and did not revert');
    expect(A.funA(true)).to.be.revertedWith('reverting from ImplementationA!');
  });
});

describe("AFactory", function () {
  it("Should call ImplementationA", async function () {

    const ImplementationA = await ethers.getContractFactory("ImplementationA");    
    const implementationA = await ImplementationA.deploy();
    
    const AFactory = await ethers.getContractFactory("AFactory");
    const aFactory = await AFactory.deploy(implementationA.address);
    
    const tx = await aFactory.createProxy();
    const txReceipt = await tx.wait();
    const creationEvent = txReceipt.events?.find(e => e.event === 'ProxyCreated');
    const proxyAddress = creationEvent?.args?.find(val => val !== undefined);

    const A = ImplementationA.attach(proxyAddress);
    expect(await A.funA(false)).to.equal('funA was called and did not revert');
    expect(A.funA(true)).to.be.revertedWith('reverting from ImplementationA!');
  });
});

describe("ProxyUpgradeable", function () {
  it("", async function () {

    const ImplementationA = await ethers.getContractFactory("ImplementationA");    
    const implementationA = await ImplementationA.deploy();
    
    const ProxyUpgradeable = await ethers.getContractFactory("ProxyUpgradeable");
    const proxyUpgradeable = await ProxyUpgradeable.deploy(implementationA.address);

    await proxyUpgradeable.deployed();
    await implementationA.deployed();

    const A = ImplementationA.attach(proxyUpgradeable.address);
    expect(await A.funA(false)).to.equal('funA was called and did not revert');
    expect(A.funA(true)).to.be.revertedWith('reverting from ImplementationA!');

    const ImplementationB = await ethers.getContractFactory("ImplementationB");
    const implementationB = await ImplementationB.deploy();

    await proxyUpgradeable.setImplementation(implementationB.address);
    const B = ImplementationB.attach(proxyUpgradeable.address);
    expect(await B.funB(false)).to.equal('funB was called and did not revert');
    expect(B.funB(true)).to.be.revertedWith('reverting from ImplementationB!');
  });
});

describe("ImplementationStorageBug", function () {
  it("there is a bug!", async function () {

    const ImplementationStorageBug = await ethers.getContractFactory("ImplementationStorageBug");    
    const implementationStorageBug = await ImplementationStorageBug.deploy();
    
    const ImplementationB = await ethers.getContractFactory("ImplementationB");    
    const implementationB = await ImplementationB.deploy();

    const ProxyUpgradeable = await ethers.getContractFactory("ProxyUpgradeable");
    const proxyUpgradeable = await ProxyUpgradeable.deploy(implementationStorageBug.address);

    await proxyUpgradeable.deployed();
    await implementationStorageBug.deployed();

    const A = ImplementationStorageBug.attach(proxyUpgradeable.address);
    expect(await A.funA(false)).to.equal('funA was called and did not revert');
    expect(A.funA(true)).to.be.revertedWith('reverting from ImplementationA!');

    await A.setAddressInStorage(implementationB.address);

    expect(await A.funA(false)).to.equal('funA was called and did not revert');
    expect(A.funA(true)).to.be.revertedWith('reverting from ImplementationA!');
  });
});

