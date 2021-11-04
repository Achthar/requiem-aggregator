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
  Overrides,
  PayableOverrides,
  CallOverrides,
} from "ethers";
import { BytesLike } from "@ethersproject/bytes";
import { Listener, Provider } from "@ethersproject/providers";
import { FunctionFragment, EventFragment, Result } from "@ethersproject/abi";
import type { TypedEventFilter, TypedEvent, TypedListener } from "./common";

interface RequiemAggregatorInterface extends ethers.utils.Interface {
  functions: {
    "multiSwap(address[],uint256,uint256,uint256)": FunctionFragment;
    "pairRouter()": FunctionFragment;
    "stableRouter()": FunctionFragment;
    "swapExactTokensForTokens(address[],uint256,uint256,address,uint256,uint8[])": FunctionFragment;
  };

  encodeFunctionData(
    functionFragment: "multiSwap",
    values: [string[], BigNumberish, BigNumberish, BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "pairRouter",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "stableRouter",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "swapExactTokensForTokens",
    values: [
      string[],
      BigNumberish,
      BigNumberish,
      string,
      BigNumberish,
      BigNumberish[]
    ]
  ): string;

  decodeFunctionResult(functionFragment: "multiSwap", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "pairRouter", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "stableRouter",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "swapExactTokensForTokens",
    data: BytesLike
  ): Result;

  events: {};
}

export class RequiemAggregator extends BaseContract {
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

  interface: RequiemAggregatorInterface;

  functions: {
    multiSwap(
      path: string[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    pairRouter(overrides?: CallOverrides): Promise<[string]>;

    stableRouter(overrides?: CallOverrides): Promise<[string]>;

    swapExactTokensForTokens(
      path: string[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      to: string,
      deadline: BigNumberish,
      stableIndxesInPath: BigNumberish[],
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;
  };

  multiSwap(
    path: string[],
    amountIn: BigNumberish,
    amountOutMin: BigNumberish,
    deadline: BigNumberish,
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  pairRouter(overrides?: CallOverrides): Promise<string>;

  stableRouter(overrides?: CallOverrides): Promise<string>;

  swapExactTokensForTokens(
    path: string[],
    amountIn: BigNumberish,
    amountOutMin: BigNumberish,
    to: string,
    deadline: BigNumberish,
    stableIndxesInPath: BigNumberish[],
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  callStatic: {
    multiSwap(
      path: string[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: CallOverrides
    ): Promise<void>;

    pairRouter(overrides?: CallOverrides): Promise<string>;

    stableRouter(overrides?: CallOverrides): Promise<string>;

    swapExactTokensForTokens(
      path: string[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      to: string,
      deadline: BigNumberish,
      stableIndxesInPath: BigNumberish[],
      overrides?: CallOverrides
    ): Promise<void>;
  };

  filters: {};

  estimateGas: {
    multiSwap(
      path: string[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    pairRouter(overrides?: CallOverrides): Promise<BigNumber>;

    stableRouter(overrides?: CallOverrides): Promise<BigNumber>;

    swapExactTokensForTokens(
      path: string[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      to: string,
      deadline: BigNumberish,
      stableIndxesInPath: BigNumberish[],
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;
  };

  populateTransaction: {
    multiSwap(
      path: string[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      deadline: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    pairRouter(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    stableRouter(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    swapExactTokensForTokens(
      path: string[],
      amountIn: BigNumberish,
      amountOutMin: BigNumberish,
      to: string,
      deadline: BigNumberish,
      stableIndxesInPath: BigNumberish[],
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;
  };
}
