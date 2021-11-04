import { ethers } from 'hardhat';
import { parseUnits } from 'ethers/lib/utils';
import { DeployFunction } from 'hardhat-deploy/types';
import { constants } from 'ethers';

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
  const stables = [
    '0xca9ec7085ed564154a9233e1e7d8fef460438eea',// USDC
    '0xffb3ed4960cac85372e6838fbc9ce47bcf2d073e', // USDT
    '0xaea51e4fee50a980928b4353e852797b54deacd8', // DAI
  ]

  const wavax = '0xd00ae08403B9bbb9124bB305C09058E32C39A48c'


  const aggregatorContract = await ethers.getContract('aggregator');

  console.log('trade swapExactTokensForTokens');

  await execute(
    'aggregator',
    { from: user, gasLimit: 2e6 },
    'swapExactTokensForTokens',
    [stables[1], stables[0], wavax],
    ethers.BigNumber.from(100000000), // amount in
    ethers.BigNumber.from(10), //min out
    '0xf67c17F9eB5CB0eB71628714E2bA0bDe8d92d5CC',//to
    ethers.BigNumber.from('900000000000000000000000000'), //deadline 
    [0], // stable index
  );

  console.log('trade multiSwap');
  
  await execute(
    'aggregator',
    { from: user, gasLimit: 2e6 },
    'multiSwap',
    [stables[1], stables[0], wavax],
    ethers.BigNumber.from(100000000), // amount in
    ethers.BigNumber.from(10), //min out
    ethers.BigNumber.from('900000000000000000000000000'), //deadline 
  );

};

export default func;

func.tags = ['aggregator'];
