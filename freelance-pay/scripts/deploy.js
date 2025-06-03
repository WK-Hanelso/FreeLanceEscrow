const { ethers } = require("hardhat");

async function main() {
  const [employer] = await ethers.getSigners();

  const freelancer = "0x000000000000000000000000000000000000dEaD";

  const descriptions = ["Design", "Backend", "Frontend"];
  const amounts = [
    ethers.parseEther("0.3"),
    ethers.parseEther("0.3"),
    ethers.parseEther("0.4"),
  ];

  const FreelanceEscrow = await ethers.getContractFactory("FreelanceEscrow");

  const contract = await FreelanceEscrow.deploy(
    freelancer,
    descriptions,
    amounts,
    {
      value: ethers.parseEther("1.0"),
    }
  );

  await contract.waitForDeployment(); // ✅ v6에서 꼭 필요

  console.log(`✅ Contract deployed to: ${contract.target}`); // ✅ v6에서 contract.address → contract.target
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
