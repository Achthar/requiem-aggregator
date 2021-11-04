import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async ({deployments, getNamedAccounts, getUnnamedAccounts, ethers}) => {
  const {deploy, execute, get} = deployments;
  const {deployer} = await getNamedAccounts();
  console.log('creator', deployer);

  const usdc = await get('USDC');

  const swapRouter = await deploy('RequiemStableSwapRouter', {
    from: deployer,
    log: true,
  });

  const feeDistributor = await deploy('FeeDistributor', {
    from: deployer,
    log: true,
  });

  await execute('FeeDistributor', {from: deployer, log: true}, 'initialize', usdc.address, swapRouter.address);
  await execute('FeeDistributor', {from: deployer, log: true}, 'toggleOperator', deployer);

  await deploy('RequiemStableSwapLib', {
    from: deployer,
    log: true,
    args: [],
  });
};

export default func;

func.tags = ['fee-distributor'];
