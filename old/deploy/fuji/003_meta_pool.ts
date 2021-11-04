import {parseUnits} from 'ethers/lib/utils';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async ({deployments, getNamedAccounts, getUnnamedAccounts, ethers}) => {
  const {deploy, get, execute} = deployments;
  const {deployer} = await getNamedAccounts();
  console.log('deployer', deployer);

  const iron = await deploy('IRON', {
    contract: 'MockERC20',
    from: deployer,
    log: true,
    args: ['IRON Stablecoin', 'IRON', 18],
  });

  console.log('IRON', iron.address);

  const tripool = await ethers.getContract('3pool');
  const zDollarAddress = await tripool.getLpToken();

  // const zIRON = await deploy('zIRON', {
  //   contract: 'LPToken',
  //   from: deployer,
  //   log: true,
  //   args: ['zDollar_IRON LP', 'zIRON'],
  // });

  const stableSwapLib = await get('IronSwapLib');
  const feeDistributor = await get('FeeDistributor');

  const pool = await deploy('zIronPool', {
    contract: 'IronSwap',
    from: deployer,
    log: true,
    args: [],
    libraries: {
      IronSwapLib: stableSwapLib.address,
    },
  });

  await execute(
    'zIronPool',
    {from: deployer, log: true},
    'initialize',
    [zDollarAddress, iron.address], //_coins,
    [18, 18], //token decimals
    'IRON Stableswap LP',
    'zIRON',
    600, // _A
    4000000, //_fee
    5000000000, //_admin_fee,
    5e6, // 0.05% withdrawal fee
    feeDistributor.address
  );

  const basePool = await ethers.getContract('3pool');
  await execute(
    'FeeDistributor',
    {from: deployer, log: true},
    'setSwapConfig',
    iron.address,
    1,
    pool.address,
    basePool.address
  );

  await execute(
    'FeeDistributor',
    {from: deployer, log: true},
    'setSwapConfig',
    zDollarAddress,
    1,
    pool.address,
    basePool.address
  );

  const [alice, bob] = await getUnnamedAccounts();
  console.log({alice, bob});

  await execute('IRON', {from: alice, log: true}, 'mint', parseUnits('10000', 18));
  await execute('IRON', {from: bob, log: true}, 'mint', parseUnits('10000', 18));
};

export default func;

func.skip = async (hre) => {
  return hre.network.name != 'localhost' && hre.network.name != 'hardhat';
};
