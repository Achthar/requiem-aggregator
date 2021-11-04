import {BigNumber, constants, Contract} from 'ethers';
import {formatUnits, parseUnits} from 'ethers/lib/utils';
import {ethers} from 'hardhat';
import {range} from 'underscore';
import fs from 'fs';

const writeFile = (path: string, data: string) => {
  return new Promise<void>((resolve, reject) => {
    fs.writeFile(path, data, (err) => {
      if (err) {
        reject(err);
      } else {
        resolve();
      }
    });
  });
};

const dec18 = (x: number) => parseUnits(x.toFixed(18), 18);
const dec6 = (x: number) => parseUnits(x.toFixed(6), 6);

const tokens = ['USDC', 'USDT', 'DAI'];
const decimals = [6, 6, 18];
const deadline = () => Math.floor(Date.now() / 1000 + 3600);

const main = async () => {
  const deployer = await ethers.getSigner('0x10E38dFfFCfdBaaf590D5A9958B01C9cfcF6A63B')
  const user = await ethers.getSigner('0xf67c17F9eB5CB0eB71628714E2bA0bDe8d92d5CC') 
  
  const swapRouter = await ethers.getContract('RequiemStableSwapRouter');
  const triPool = await ethers.getContract('3pool');
  const zRequiemStablePool = await ethers.getContract('zRequiemStablePool');
  const zRequiemStableAddress: string = await zRequiemStablePool.getLpToken();
  const zRequiemStableLP = await ethers.getContractAt('LPToken', zRequiemStableAddress);

  const usdt = await ethers.getContract('USDT');
  const usdc = await ethers.getContract('USDC');
  const iron = await ethers.getContract('IRON');

  await (await usdc.connect(user).approve(swapRouter.address, constants.MaxUint256)).wait();
  await (await usdt.connect(user).approve(swapRouter.address, constants.MaxUint256)).wait();
  await (await iron.connect(user).approve(swapRouter.address, constants.MaxUint256)).wait();

  const logPoolBalances = async () => {
    const balances = (await triPool.getTokenBalances()) as BigNumber[];
    console.log(':: Pool balances ::');
    console.log(balances.map((t, i) => '\t' + `${tokens[i]}: ${formatUnits(t, decimals[i])}`).join('\n'));
  };

  // const calculateSwap = async () => {
  //   for (let i = 0; i < tokens.length; i++) {
  //     for (let j = 0; j < tokens.length; j++) {
  //       if (i === j) {
  //         continue;
  //       }

  //       const expected = await triPool.calculateSwap(i, j, parseUnits('1', decimals[i]));
  //       console.log(tokens[i], '=>', tokens[j]);
  //       console.log('\tEstimate:', formatUnits(expected, decimals[j]));
  //     }
  //   }
  // };

  const calculateSwap = async (i: number, j: number) => {
    const ret = {} as Record<number, string>;
    for (let k of range(1, 2000000, 10000)) {
      const dx = parseUnits(k.toFixed(0), decimals[i]);
      const expected = await triPool.calculateSwap(i, j, dx);
      const price = expected.mul(parseUnits('1', decimals[i])).div(dx);
      ret[k] = formatUnits(price, decimals[j]);
    }

    await writeFile(
      `${tokens[i]}-${tokens[j]}.csv`,
      Object.entries(ret)
        .map(([k, v]) => `${k}, ${v}`)
        .join('\n')
    );
  };

  console.log('========== A: 800 =============');
  console.log(':: Route 3 - real, high liquidity ::');
  let tx = await triPool.connect(user).addLiquidity(
    // [dec6(1e5), dec6(1e5), dec18(1e5)],
    // [dec6(5e6), dec6(6e6), dec18(45e5)],
    ['2236815929551', '2343616438518', '1285147862462937266069626'],
    0, // min output,
    deadline()
  );
  tx.wait();
  await logPoolBalances();
  // await calculateSwap(0, 1);
  // await calculateSwap(1, 0);
  await calculateSwap(1, 2);
  await calculateSwap(2, 1);
};

main().catch(console.error);
