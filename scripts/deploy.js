const main = async () => {
  const petContractFactory = await hre.ethers.getContractFactory('PetPortal');
  const petContract = await petContractFactory.deploy({
    value: hre.ethers.utils.parseEther('0.001'),
  });

  await petContract.deployed();

  console.log('PetPortal address: ', petContract.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
};

runMain();