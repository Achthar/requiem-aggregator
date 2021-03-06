import {ethers} from 'hardhat';
import {parseUnits} from 'ethers/lib/utils';
import {DeployFunction} from 'hardhat-deploy/types';
import {constants} from 'ethers';

const getBalance = async (token: string, address: string) => {
  const contract = await ethers.getContractAt('MockERC20', token);
  const balance = await contract.balanceOf(address);
  return balance.toString();
};

const deadline = Math.floor(Date.now() / 1000 + 7200);

const func: DeployFunction = async ({deployments, getNamedAccounts, getUnnamedAccounts, ethers}) => {
  const {deploy, execute, get} = deployments;
  const {deployer, user} = await getNamedAccounts();
  console.log('deployer', deployer);

  const usdc = await get('USDC');
  const usdt = await get('USDT');
  const dai = await get('DAI');
  const tusd = await get('TUSD');
  const feeDistributor = await get('FeeDistributor');
  const stableSwapLib = await get('RequiemStableSwapLib');

  const pool = await deploy('4pool', {
    contract: 'RequiemStableSwap',
    from: deployer,
    log: true,
    args: [],
    libraries: {
      RequiemStableSwapLib: stableSwapLib.address,
    },
  });
/*
  await execute(
    '4pool',
    {from: deployer, log: true},
    'initialize',
    [usdc.address, usdt.address, dai.address, tusd.address], //_coins,
    [6, 6, 18, 18], //token decimals
    'Requiem Stableswap LP', // pool token name
    'zDollar', //_pool_token
    600, // _A
    1e6, //_fee = 0.01%
    5e9, //_admin_fee, 50%,
    5e7, //withdraw fee = 0.5%
    feeDistributor.address
  );

  // await execute('zDollar', {from: deployer, log: true}, 'setMinter', pool.address);

  await execute(
    'FeeDistributor',
    {from: deployer, log: true},
    'setSwapConfig',
    usdt.address,
    0,
    pool.address,
    constants.AddressZero
  );

  await execute(
    'FeeDistributor',
    {from: deployer, log: true},
    'setSwapConfig',
    dai.address,
    0,
    pool.address,
    constants.AddressZero
  ); */

  const poolContract = await ethers.getContract('4pool');
  const lpContract = await ethers.getContractAt('LPToken', await poolContract.getLpToken());


  await execute('USDC', {from: user}, 'approve', pool.address, ethers.constants.MaxInt256);
  await execute('USDT', {from: user}, 'approve', pool.address, ethers.constants.MaxInt256);
  await execute('DAI', {from: user}, 'approve', pool.address, ethers.constants.MaxInt256);
  await execute('TUSD', {from: user}, 'approve', pool.address, ethers.constants.MaxInt256);

  console.log('add_liquidity');
  const tokenAmount = await poolContract.calculateTokenAmount(
    [parseUnits('10', 6), parseUnits('10', 6), parseUnits('10', 18), parseUnits('10', 18)],
    true
  );
  console.log('Estimated LP', tokenAmount.toString());

  await execute(
    '4pool',
    {from: user, gasLimit: 2e6},
    'addLiquidity',
    [parseUnits('10', 6), parseUnits('10', 6), parseUnits('10', 18), parseUnits('10', 18)],
    0,
    deadline
  );

  console.log('add_liquidity_success');
  console.log('USDC balance', await getBalance(usdc.address, user));
  console.log('USDT balance', await getBalance(usdt.address, user));
  console.log('DAI balance', await getBalance(dai.address, user));
  console.log('TUSD balance', await getBalance(tusd.address, user));
  console.log('Curve balance', await getBalance(lpContract.address, user));
  await execute(
    '4pool',
    {from: user, gasLimit: 2e6},
    'addLiquidity',
    [parseUnits('10', 6), parseUnits('20', 6), parseUnits('10', 18), parseUnits('0', 18)],
    0,
    deadline
  );
  console.log('USDC balance', await getBalance(usdc.address, user));
  console.log('USDT balance', await getBalance(usdt.address, user));
  console.log('DAI balance', await getBalance(dai.address, user));
  console.log('TUSD balance', await getBalance(tusd.address, user));
  console.log('Curve balance', await getBalance(lpContract.address, user));
    console.log("--- calculate swap ---")
  const expected = await poolContract.calculateSwap(0, 2, parseUnits('1', 6));
  console.log('expected', expected.toString());

  console.log("--- connect to pool contract ---")
  const tx = await poolContract
    .connect(await ethers.getSigner(user))
    .swap(0, 2, parseUnits('1', 6), 0, deadline);

  const receipt = await tx.wait();

  console.log(receipt.events.find((t: any) => t.event === 'TokenExchange').args.tokensBought.toString());
};

export default func;

func.tags = ['4pool'];
