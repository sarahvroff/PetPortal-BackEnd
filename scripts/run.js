const main = async () => {
  const petContractFactory = await hre.ethers.getContractFactory('PetPortal');
  const petContract = await petContractFactory.deploy({
    value: hre.ethers.utils.parseEther('0.1'),
  });
  await petContract.deployed();
  console.log('Contract Address:', petContract.address);

  let contractBalance = await hre.ethers.provider.getBalance(
    petContract.address
  );
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );
  
  let petTxn = await petContract.pet('Pet Image #1');
  await petTxn.wait();

  let petTxn2 = await petContract.pet('Pet Image #2');
  await petTxn2.wait();

  contractBalance = await hre.ethers.provider.getBalance(petContract.address);
  console.log(
    'Contract balance:',
    hre.ethers.utils.formatEther(contractBalance)
  );

  let allPets = await petContract.getAllPets();
  console.log(allPets);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
