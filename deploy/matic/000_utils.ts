import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async ({deployments, getNamedAccounts}) => {
  const {deploy, execute} = deployments;
  const {deployer} = await getNamedAccounts();
  console.log('> creator', deployer);
  console.log('> Deploy fee distributor and swap router');

  const swapRouter = await deploy('RequiemStableSwapRouter', {
    from: deployer,
    log: true,
  });

  await deploy('FeeDistributor', {
    from: deployer,
    log: true,
  });

  await execute(
    'FeeDistributor',
    {from: deployer, log: true},
    'initialize',
    'wellknown.addresses.usdc',
    swapRouter.address
  );
};

export default func;

func.skip = async ({network}) => {
  return network.name != 'matic';
};

func.tags = ['utils'];
