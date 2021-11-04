import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async ({deployments, getNamedAccounts}) => {
  const {deploy, execute} = deployments;
  const {deployer} = await getNamedAccounts();
  console.log('> creator', deployer);
  console.log('> Deploy Shared lib');

  await deploy('RequiemStableSwapLib', {
    from: deployer,
    log: true,
    args: [],
  });
};

export default func;

func.skip = async ({network}) => {
  return network.name != 'matic';
};

func.tags = ['lib'];
