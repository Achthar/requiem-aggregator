/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import {
  ethers,
  EventFilter,
  Signer,
  BigNumber,
  BigNumberish,
  PopulatedTransaction,
  BaseContract,
  ContractTransaction,
  PayableOverrides,
  CallOverrides,
} from "ethers";
import { BytesLike } from "@ethersproject/bytes";
import { Listener, Provider } from "@ethersproject/providers";
import { FunctionFragment, EventFragment, Result } from "@ethersproject/abi";
import type { TypedEventFilter, TypedEvent, TypedListener } from "./common";

interface RequiemAggregatorRECENTInterface extends ethers.utils.Interface {
  functions: {
    "multiSwapETHForExactTokens(address[][],uint256[],uint256,uint256,uint256)": FunctionFragment;
    "multiSwapExactETHForTokens(address[][],uint256[],uint256,uint256)": FunctionFragment;
    "multiSwapExactTokensForETH(address[][],uint256[],uint256,uint256,uint256)": FunctionFragment;
    "multiSwapExactTokensForTokens(address[][],uint256[],uint256,uint256,uint256)": FunctionFragment;
    "multiSwapStructTest(address[],uint256[],uint256,uint256,uint256)": FunctionFragment;
    "multiSwapStructView(address[][],uint256[],uint256,uint256,uint256)": FunctionFragment;
    "multiSwapTokensForExactETH(address[][],uint256[],uint256,uint256,uint256)": FunctionFragment;
    "multiSwapTokensForExactTokens(address[][],uint256[],uint256,uint256,uint256)": FunctionFragment;
    "multiSwapTokensForExactTokensTest(address[][],uint256[],uint256,uint256,uint256)": FunctionFragment;
    "pairRouter()": FunctionFragment;
    "stableRouter()": FunctionFragment;
  };

  encodeFunctionData(
    functionFragment: "multiSwapETHForExactTokens",
    values: [
      string[][],
      BigNumberish[],
      BigNumberish,
      BigNumberish,
      BigNumberish
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "multiSwapExactETHForTokens",
    values: [string[][], BigNumberish[], BigNumberish, BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "multiSwapExactTokensForETH",
    values: [
      string[][],
      BigNumberish[],
      BigNumberish,
      BigNumberish,
      BigNumberish
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "multiSwapExactTokensForTokens",
    values: [
      string[][],
      BigNumberish[],
      BigNumberish,
      BigNumberish,
      BigNumberish
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "multiSwapStructTest",
    values: [string[], BigNumberish[], BigNumberish, BigNumberish, BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "multiSwapStructView",
    values: [
      string[][],
      BigNumberish[],
      BigNumberish,
      BigNumberish,
      BigNumberish
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "multiSwapTokensForExactETH",
    values: [
      string[][],
      BigNumberish[],
      BigNumberish,
      BigNumberish,
      BigNumberish
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "multiSwapTokensForExactTokens",
    values: [
      string[][],
      BigNumberish[],
      BigNumberish,
      BigNumberish,
      BigNumberish
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "multiSwapTokensForExactTokensTest",
    values: [
      string[][],
      BigNumberish[],
      BigNumberish,
      BigNumberish,
      BigNumberish
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "pairRouter",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "stableRouter",
    values?: undefined
  ): string;

  decodeFunctionResult(
    functionFragment: "multiSwapETHForExactTokens",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "multiSwapExactETHForTokens",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "multiSwapExactTokensForETH",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "multiSwapExactTokensForTokens",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "multiSwapStructTest",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "multiSwapStructView",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "multiSwapTokensForExactETH",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "multiSwapTokensForExactTokens",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "multiSwapTokensForExactTokensTest",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "pairRouter", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "stableRouter",
    data: BytesLike
  ): Result;

  events: {};
}

export class RequiemAggregatorRECENT extends BaseContract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  listeners<EventArgsArray extends Array<any>, EventArgsObject>(
    eventFilter?: TypedEventFilter<EventArgsArray, EventArgsObject>
  ): Array<TypedListener<EventArgsArray, EventArgsObject>>;
  off<EventArgsArray extends Array<any>, EventArgsObject>(
    eventFilter: TypedEventFilter<EventArgsArray, EventArgsObject>,
    listener: TypedListener<EventArgsArray, EventArgsObject>
  ): this;
  on<EventArgsArray extends Array<any>, EventArgsObject>(
    eventFilter: TypedEventFilter<EventArgsArray, EventArgsObject>,
    listener: TypedListener<EventArgsArray, EventArgsObject>
  ): this;
  once<EventArgsArray extends Array<any>, EventArgsObject>(
    eventFilter: TypedEventFilter<EventArgsArray, EventArgsObject>,
    listener: TypedListener<EventArgsArray, EventArgsObject>
  ): this;
  removeListener<EventArgsArray extends Array<any>, EventArgsObject>(
    eventFilter: TypedEventFilter<EventArgsArray, EventArgsObject>,
    listener: TypedListener<EventArgsArray, EventArgsObject>
  ): this;
  removeAllListeners<EventArgsArray extends Array<any>, EventArgsObject>(
    eventFilter: TypedEventFilter<EventArgsArray, EventArgsObject>
  ): this;

  listeners(eventName?: string): Array<Listener>;
  off(eventName: string, listener: Listener): this;
  on(eventName: string, listener: Listener): this;
  once(eventName: string, listener: Listener): this;
  removeListener(eventName: string, listener: Listener): this;
  removeAllListeners(eventName?: string): this;

  queryFilter<EventArgsArray extends Array<any>, EventArgsObject>(
    event: TypedEventFilter<EventArgsArray, EventArgsObject>,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TypedEvent<EventArgsArray & EventArgsObject>>>;

  interface: RequiemAggregatorRECENTInterface;

  functions: {
    multiSwapETHForExactTokens(
      path: string[][],
      routerId: BigNumberish[],
      amountOut: BigNumberish,
      amountInMax: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    multiSwapExactETHForTokens(
      path: string[][],
      routerId: BigNumberish[],
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    multiSwapExactTokensForETH(
      path: string[][],
      routerId: BigNumberish[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    multiSwapExactTokensForTokens(
      path: string[][],
      routerId: BigNumberish[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    multiSwapStructTest(
      path: string[],
      routerId: BigNumberish[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    multiSwapStructView(
      path: string[][],
      routerId: BigNumberish[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: CallOverrides
    ): Promise<[string[]]>;

    multiSwapTokensForExactETH(
      path: string[][],
      routerId: BigNumberish[],
      amountOut: BigNumberish,
      amountInMax: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    multiSwapTokensForExactTokens(
      path: string[][],
      routerId: BigNumberish[],
      amountOut: BigNumberish,
      amountInMax: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    multiSwapTokensForExactTokensTest(
      path: string[][],
      routerId: BigNumberish[],
      amountOut: BigNumberish,
      amountInMax: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    pairRouter(overrides?: CallOverrides): Promise<[string]>;

    stableRouter(overrides?: CallOverrides): Promise<[string]>;
  };

  multiSwapETHForExactTokens(
    path: string[][],
    routerId: BigNumberish[],
    amountOut: BigNumberish,
    amountInMax: BigNumberish,
    deadline: BigNumberish,
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  multiSwapExactETHForTokens(
    path: string[][],
    routerId: BigNumberish[],
    amountOutMin: BigNumberish,
    deadline: BigNumberish,
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  multiSwapExactTokensForETH(
    path: string[][],
    routerId: BigNumberish[],
    amountIn: BigNumberish,
    amountOutMin: BigNumberish,
    deadline: BigNumberish,
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  multiSwapExactTokensForTokens(
    path: string[][],
    routerId: BigNumberish[],
    amountIn: BigNumberish,
    amountOutMin: BigNumberish,
    deadline: BigNumberish,
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  multiSwapStructTest(
    path: string[],
    routerId: BigNumberish[],
    amountIn: BigNumberish,
    amountOutMin: BigNumberish,
    deadline: BigNumberish,
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  multiSwapStructView(
    path: string[][],
    routerId: BigNumberish[],
    amountIn: BigNumberish,
    amountOutMin: BigNumberish,
    deadline: BigNumberish,
    overrides?: CallOverrides
  ): Promise<string[]>;

  multiSwapTokensForExactETH(
    path: string[][],
    routerId: BigNumberish[],
    amountOut: BigNumberish,
    amountInMax: BigNumberish,
    deadline: BigNumberish,
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  multiSwapTokensForExactTokens(
    path: string[][],
    routerId: BigNumberish[],
    amountOut: BigNumberish,
    amountInMax: BigNumberish,
    deadline: BigNumberish,
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  multiSwapTokensForExactTokensTest(
    path: string[][],
    routerId: BigNumberish[],
    amountOut: BigNumberish,
    amountInMax: BigNumberish,
    deadline: BigNumberish,
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  pairRouter(overrides?: CallOverrides): Promise<string>;

  stableRouter(overrides?: CallOverrides): Promise<string>;

  callStatic: {
    multiSwapETHForExactTokens(
      path: string[][],
      routerId: BigNumberish[],
      amountOut: BigNumberish,
      amountInMax: BigNumberish,
      deadline: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    multiSwapExactETHForTokens(
      path: string[][],
      routerId: BigNumberish[],
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    multiSwapExactTokensForETH(
      path: string[][],
      routerId: BigNumberish[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    multiSwapExactTokensForTokens(
      path: string[][],
      routerId: BigNumberish[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    multiSwapStructTest(
      path: string[],
      routerId: BigNumberish[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    multiSwapStructView(
      path: string[][],
      routerId: BigNumberish[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: CallOverrides
    ): Promise<string[]>;

    multiSwapTokensForExactETH(
      path: string[][],
      routerId: BigNumberish[],
      amountOut: BigNumberish,
      amountInMax: BigNumberish,
      deadline: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    multiSwapTokensForExactTokens(
      path: string[][],
      routerId: BigNumberish[],
      amountOut: BigNumberish,
      amountInMax: BigNumberish,
      deadline: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    multiSwapTokensForExactTokensTest(
      path: string[][],
      routerId: BigNumberish[],
      amountOut: BigNumberish,
      amountInMax: BigNumberish,
      deadline: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    pairRouter(overrides?: CallOverrides): Promise<string>;

    stableRouter(overrides?: CallOverrides): Promise<string>;
  };

  filters: {};

  estimateGas: {
    multiSwapETHForExactTokens(
      path: string[][],
      routerId: BigNumberish[],
      amountOut: BigNumberish,
      amountInMax: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    multiSwapExactETHForTokens(
      path: string[][],
      routerId: BigNumberish[],
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    multiSwapExactTokensForETH(
      path: string[][],
      routerId: BigNumberish[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    multiSwapExactTokensForTokens(
      path: string[][],
      routerId: BigNumberish[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    multiSwapStructTest(
      path: string[],
      routerId: BigNumberish[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    multiSwapStructView(
      path: string[][],
      routerId: BigNumberish[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    multiSwapTokensForExactETH(
      path: string[][],
      routerId: BigNumberish[],
      amountOut: BigNumberish,
      amountInMax: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    multiSwapTokensForExactTokens(
      path: string[][],
      routerId: BigNumberish[],
      amountOut: BigNumberish,
      amountInMax: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    multiSwapTokensForExactTokensTest(
      path: string[][],
      routerId: BigNumberish[],
      amountOut: BigNumberish,
      amountInMax: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    pairRouter(overrides?: CallOverrides): Promise<BigNumber>;

    stableRouter(overrides?: CallOverrides): Promise<BigNumber>;
  };

  populateTransaction: {
    multiSwapETHForExactTokens(
      path: string[][],
      routerId: BigNumberish[],
      amountOut: BigNumberish,
      amountInMax: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    multiSwapExactETHForTokens(
      path: string[][],
      routerId: BigNumberish[],
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    multiSwapExactTokensForETH(
      path: string[][],
      routerId: BigNumberish[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    multiSwapExactTokensForTokens(
      path: string[][],
      routerId: BigNumberish[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    multiSwapStructTest(
      path: string[],
      routerId: BigNumberish[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    multiSwapStructView(
      path: string[][],
      routerId: BigNumberish[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    multiSwapTokensForExactETH(
      path: string[][],
      routerId: BigNumberish[],
      amountOut: BigNumberish,
      amountInMax: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    multiSwapTokensForExactTokens(
      path: string[][],
      routerId: BigNumberish[],
      amountOut: BigNumberish,
      amountInMax: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    multiSwapTokensForExactTokensTest(
      path: string[][],
      routerId: BigNumberish[],
      amountOut: BigNumberish,
      amountInMax: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    pairRouter(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    stableRouter(overrides?: CallOverrides): Promise<PopulatedTransaction>;
  };
}