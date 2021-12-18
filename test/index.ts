import { expect } from "chai";
import { ethers } from "hardhat";
import { Signer } from "ethers";

describe("Fidelity", function () {

  let signers: Signer[];
  let owner: Signer;
  let user2: Signer;

  beforeEach(async function () {
    // Get the ContractFactory and Signers here.
    const Fidelity = await ethers.getContractFactory("Fidelity");
    signers = await ethers.getSigners();
    [owner, user2] = signers;
  
    const fidelity = await Fidelity.deploy();
    await fidelity.deployed();
  });

  it("Should return the number of tokens for user", async function () {
    const Fidelity = await ethers.getContractFactory("Fidelity");
    const fidelity = await Fidelity.deploy();

    const myAddress = await owner.getAddress();
    const user2Address = await user2.getAddress();

    fidelity.addFidel(myAddress, 1413874800);
    
    let balance1a = (await fidelity.balanceOf(myAddress)).toNumber();
    expect(balance1a).to.greaterThan(261500);
    expect((await fidelity.totalSupply()).toNumber()).to.equal(balance1a);

    fidelity.addFidel(user2Address, 1639090800);

    const balance1b = (await fidelity.balanceOf(myAddress)).toNumber();
    const balance2a = (await fidelity.balanceOf(user2Address)).toNumber();
    const totala = (await fidelity.totalSupply()).toNumber();
    expect(balance1b).to.equal(balance1a);
    expect(balance2a).to.greaterThan(850);
    expect(totala).to.equal(balance1b + balance2a);

    fidelity.removeFidel(myAddress);

    const balance2b = (await fidelity.balanceOf(user2Address)).toNumber();
    expect(await fidelity.balanceOf(myAddress)).to.equal(0);
    expect(balance2b).to.equal(balance2a);
    expect(await fidelity.totalSupply()).to.equal(balance2b);

    fidelity.addFidel(myAddress, 1639350000);

    const balance1c = (await fidelity.balanceOf(myAddress)).toNumber();
    const balance2c = (await fidelity.balanceOf(user2Address)).toNumber();
    expect(balance1c).to.greaterThan(550);
    expect(balance2c).to.equal(balance2b);
    expect(await fidelity.totalSupply()).to.equal(balance1c + balance2c);
  });
});
