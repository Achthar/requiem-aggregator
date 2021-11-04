import { ethers } from 'hardhat';
import { parseUnits } from 'ethers/lib/utils';
import { DeployFunction } from 'hardhat-deploy/types';
import { constants } from 'ethers';
import { getContractFactory } from '@nomiclabs/hardhat-ethers/dist/src/types';

const getBalance = async (token: string, address: string) => {
  const contract = await ethers.getContractAt('MockERC20', token);
  const balance = await contract.balanceOf(address);
  return balance.toString();
};

const deadline = Math.floor(Date.now() / 1000 + 7200);

const func: DeployFunction = async ({ deployments, getNamedAccounts, getUnnamedAccounts, ethers }) => {
  const { deploy, execute, get } = deployments;
  const { deployer, user } = await getNamedAccounts();
  console.log('deployer', deployer);



  const aggregator = await deploy('aggregator', {
    contract: 'RequiemAggregator',
    from: deployer,
    log: true,
    args: [
      '0x2a90276992ddC21C3585FE50f5B43D0Cf62aDe03',
      '0x9067e2C2bf8531283AB97C34EaA74599E0004842'
    ],
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
   */
  const stables = [
    '0xca9ec7085ed564154a9233e1e7d8fef460438eea',// USDC
    '0xffb3ed4960cac85372e6838fbc9ce47bcf2d073e', // USDT
    '0xaea51e4fee50a980928b4353e852797b54deacd8', // DAI
  ]

  const wavax = '0xd00ae08403B9bbb9124bB305C09058E32C39A48c'


  // const aggregatorContract = await ethers.getContract('aggregator');

  // console.log('trade swapExactTokensForTokens');

  // await execute(
  //   'aggregator',
  //   { from: user, gasLimit: 2e6 },
  //   'swapExactTokensForTokens',
  //   [stables[1], stables[0], wavax],
  //   ethers.BigNumber.from(100000000), // amount in
  //   ethers.BigNumber.from(10), //min out
  //   '0xf67c17F9eB5CB0eB71628714E2bA0bDe8d92d5CC',//to
  //   ethers.BigNumber.from('900000000000000000000000000'), //deadline 
  //   [0], // stable index
  // );

  const inAmountReqt = ethers.BigNumber.from('1000');
  const inAmountUSDC = ethers.BigNumber.from('10');
  const inAmountUSDT = ethers.BigNumber.from('100')
  const inToken = await ethers.getContractAt('MockERC20', stables[1], deployer);
  const token2 = await ethers.getContractAt('MockERC20', stables[0], deployer);
  const token3 = await ethers.getContractAt('MockERC20', wavax, deployer);
  const reqt = '0x78e418385153177cB1c49e58eAB5997192998bf7';

  const tokenReqt = await ethers.getContractAt('MockERC20', reqt, deployer);
  // await execute('USDC', {from: user}, 'approve', aggregator.address, ethers.constants.MaxInt256);
  // await execute('USDT', {from: user}, 'approve', aggregator.address, ethers.constants.MaxInt256);
  // await execute('DAI', {from: user}, 'approve', aggregator.address, ethers.constants.MaxInt256);

  await inToken.approve(aggregator.address, ethers.constants.MaxInt256);
  await token2.approve(aggregator.address,  ethers.constants.MaxInt256);

  await tokenReqt.approve(aggregator.address,  ethers.constants.MaxInt256);
  await token3.approve(aggregator.address,  ethers.constants.MaxInt256);
  // console.log('transfer test');
  // await execute(
  //   'aggregator',
  //   { from: deployer, gasLimit: 2e6 },
  //   'transferToSwapTest',
  //   [stables[1], stables[0], wavax],
  //   inAmount, // amount in
  // );

  // console.log('trade multiSwap');

  // await execute(
  //   'aggregator',
  //   { from: deployer, gasLimit: 2e6 },
  //   'multiSwap',
  //   [stables[1], stables[0], wavax],
  //   inAmount, // amount in
  //   ethers.BigNumber.from(10), //min out
  //   ethers.BigNumber.from('900000000000000000000000000'), //deadline
  // );

  console.log("--- multiSwap struct----");


  await execute(
    'aggregator',
    { from: deployer, gasLimit: 8e6 },
    'multiSwapExactTokensForETH',
    [[ stables[0],wavax]],
    [1],
    ethers.BigNumber.from('100'), // amount in
    ethers.BigNumber.from(0), //min out
    ethers.BigNumber.from('900000000000000000000000000'), //deadline
  );
  console.log("--- 1 succssful ---")

  await execute(
    'aggregator',
    { from: deployer, gasLimit: 8e6 },
    'multiSwapExactTokensForETH',
    [[stables[0], stables[1]], [stables[1], reqt, wavax]],
    [0, 1],
    inAmountUSDC, // amount in
    ethers.BigNumber.from(0), //min out
    ethers.BigNumber.from('900000000000000000000000000'), //deadline
  );
  console.log("--- 01 succssful ---")

  await execute(
    'aggregator',
    { from: deployer, gasLimit: 8e6 },
    'multiSwapExactTokensForETH',
    [[stables[0], stables[1]], [stables[1], reqt, wavax, stables[2]], [stables[2], stables[0]],[stables[0], wavax]],
    [0, 1, 0, 1],
    ethers.BigNumber.from(10000), // amount in
    ethers.BigNumber.from(0), //min out
    ethers.BigNumber.from('900000000000000000000000000'), //deadline
  );

  console.log("--- 0101 successful ---")


  await execute(
    'aggregator',
    { from: deployer, gasLimit: 8e6 },
    'multiSwapExactTokensForETH',
    [[reqt, wavax, stables[0]], [stables[0], stables[1]], [stables[1], reqt, wavax]],
    [1, 0, 1],
    inAmountReqt, // amount in
    ethers.BigNumber.from(0), //min out
    ethers.BigNumber.from('900000000000000000000000000'), //deadline
  );

  console.log("--- 101 successful ---")

  await execute(
    'aggregator',
    { from: deployer, gasLimit: 8e6 },
    'multiSwapExactTokensForETH',
    [[reqt, wavax, stables[0]], [stables[0], stables[1]], [stables[1], reqt, wavax, stables[0]], [stables[0], stables[1]], [stables[1], reqt, wavax]],
    [1, 0, 1, 0, 1],
    inAmountReqt, // amount in
    ethers.BigNumber.from(0), //min out
    ethers.BigNumber.from('900000000000000000000000000'), //deadline
  );

  console.log("--- 10101 successful ---")

  console.log("--- multiswap struct test---")


};



export default func;

func.tags = ['aggregatorETHout'];
