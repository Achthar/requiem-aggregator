/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import type {
  RequiemAggregator,
  RequiemAggregatorInterface,
} from "../RequiemAggregator";

const _abi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "_pairRouter",
        type: "address",
      },
      {
        internalType: "address",
        name: "_stableRouter",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [
      {
        internalType: "address[]",
        name: "path",
        type: "address[]",
      },
      {
        internalType: "uint256",
        name: "amountIn",
        type: "uint256",
      },
      {
        internalType: "uint256",
        name: "amountOutMin",
        type: "uint256",
      },
      {
        internalType: "uint256",
        name: "deadline",
        type: "uint256",
      },
    ],
    name: "multiSwap",
    outputs: [],
    stateMutability: "payable",
    type: "function",
  },
  {
    inputs: [],
    name: "pairRouter",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "stableRouter",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address[]",
        name: "path",
        type: "address[]",
      },
      {
        internalType: "uint256",
        name: "amountIn",
        type: "uint256",
      },
      {
        internalType: "uint256",
        name: "amountOutMin",
        type: "uint256",
      },
      {
        internalType: "address",
        name: "to",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "deadline",
        type: "uint256",
      },
      {
        internalType: "uint8[]",
        name: "stableIndxesInPath",
        type: "uint8[]",
      },
    ],
    name: "swapExactTokensForTokens",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
];

const _bytecode =
  "0x60c060405234801561001057600080fd5b50604051610dcc380380610dcc83398101604081905261002f91610069565b6001600160601b0319606092831b8116608052911b1660a05261009b565b80516001600160a01b038116811461006457600080fd5b919050565b6000806040838503121561007b578182fd5b6100848361004d565b91506100926020840161004d565b90509250929050565b60805160601c60a05160601c610cde6100ee60003960008181605601528181610107015281816101de0152818161041201526106b101526000818160bb015281816105ad015261075e0152610cde6000f3fe60806040526004361061003f5760003560e01c80634c3677c81461004457806356089a7c14610094578063866cb90d146100a95780639a38818c146100dd575b600080fd5b34801561005057600080fd5b506100787f000000000000000000000000000000000000000000000000000000000000000081565b6040516001600160a01b03909116815260200160405180910390f35b6100a76100a23660046109b7565b6100fd565b005b3480156100b557600080fd5b506100787f000000000000000000000000000000000000000000000000000000000000000081565b3480156100e957600080fd5b506100a76100f83660046108c6565b6103d5565b60006001905060007f00000000000000000000000000000000000000000000000000000000000000006001600160a01b03166366c0bd248760008151811061015557634e487b7160e01b600052603260045260246000fd5b60200260200101516040518263ffffffff1660e01b815260040161018891906001600160a01b0391909116815260200190565b60206040518083038186803b1580156101a057600080fd5b505afa1580156101b4573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906101d89190610ab4565b905060007f00000000000000000000000000000000000000000000000000000000000000006001600160a01b03166366c0bd248860018151811061022c57634e487b7160e01b600052603260045260246000fd5b60200260200101516040518263ffffffff1660e01b815260040161025f91906001600160a01b0391909116815260200190565b60206040518083038186803b15801561027757600080fd5b505afa15801561028b573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906102af9190610ab4565b905060006102c08383898789610677565b60408051600280825260608201835292935060009290916020830190803683370190505090508860018151811061030757634e487b7160e01b600052603260045260246000fd5b60200260200101518160008151811061033057634e487b7160e01b600052603260045260246000fd5b60200260200101906001600160a01b031690816001600160a01b0316815250508860028151811061037157634e487b7160e01b600052603260045260246000fd5b60200260200101518160018151811061039a57634e487b7160e01b600052603260045260246000fd5b60200260200101906001600160a01b031690816001600160a01b03168152505060006103c8838b8a8a610740565b5050505050505050505050565b60405160006024820181905260448201819052606482018790526084820181905260a4820184905290819087908290819081906001600160a01b037f0000000000000000000000000000000000000000000000000000000000000000169060c40160408051601f198184030181529181526020820180516001600160e01b031663383aef7760e21b1790525161046b9190610b1a565b600060405180830381855af49150503d80600081146104a6576040519150601f19603f3d011682016040523d82523d6000602084013e6104ab565b606091505b50604080516002808252606082018352939550919350600092906020830190803683370190505090508c6001815181106104f557634e487b7160e01b600052603260045260246000fd5b60200260200101518160008151811061051e57634e487b7160e01b600052603260045260246000fd5b60200260200101906001600160a01b031690816001600160a01b0316815250508c60028151811061055f57634e487b7160e01b600052603260045260246000fd5b60200260200101518160018151811061058857634e487b7160e01b600052603260045260246000fd5b60200260200101906001600160a01b031690816001600160a01b0316815250506000807f00000000000000000000000000000000000000000000000000000000000000006001600160a01b0316848e858f8f6040516024016105ee959493929190610b36565b60408051601f198184030181529181526020820180516001600160e01b031663556585b560e11b179052516106239190610b1a565b600060405180830381855af49150503d806000811461065e576040519150601f19603f3d011682016040523d82523d6000602084013e610663565b606091505b505050505050505050505050505050505050565b6040516348b4aac360e11b815260ff80871660048301528516602482015260448101849052606481018390526084810182905260009030907f00000000000000000000000000000000000000000000000000000000000000006001600160a01b03169063916955869060a401602060405180830381600087803b1580156106fd57600080fd5b505af1158015610711573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906107359190610a9c565b979650505050505050565b6040516338ed173960e01b8152600090309082906001600160a01b037f000000000000000000000000000000000000000000000000000000000000000016906338ed17399061079b908a9089908b9088908b90600401610b9c565b600060405180830381600087803b1580156107b557600080fd5b505af11580156107c9573d6000803e3d6000fd5b505050506040513d6000823e601f3d908101601f191682016040526107f19190810190610a09565b905080600182516108029190610c2d565b8151811061082057634e487b7160e01b600052603260045260246000fd5b602002602001015192505050949350505050565b80356001600160a01b038116811461084b57600080fd5b919050565b600082601f830112610860578081fd5b8135602061087561087083610c09565b610bd8565b80838252828201915082860187848660051b8901011115610894578586fd5b855b858110156108b9576108a782610834565b84529284019290840190600101610896565b5090979650505050505050565b60008060008060008060c087890312156108de578182fd5b863567ffffffffffffffff808211156108f5578384fd5b6109018a838b01610850565b9750602091508189013596506040890135955061092060608a01610834565b94506080890135935060a08901358181111561093a578384fd5b89019050601f81018a1361094c578283fd5b803561095a61087082610c09565b8082825284820191508484018d868560051b8701011115610979578687fd5b8694505b838510156109a457803561099081610c96565b83526001949094019391850191850161097d565b5080955050505050509295509295509295565b600080600080608085870312156109cc578384fd5b843567ffffffffffffffff8111156109e2578485fd5b6109ee87828801610850565b97602087013597506040870135966060013595509350505050565b60006020808385031215610a1b578182fd5b825167ffffffffffffffff811115610a31578283fd5b8301601f81018513610a41578283fd5b8051610a4f61087082610c09565b80828252848201915084840188868560051b8701011115610a6e578687fd5b8694505b83851015610a90578051835260019490940193918501918501610a72565b50979650505050505050565b600060208284031215610aad578081fd5b5051919050565b600060208284031215610ac5578081fd5b8151610ad081610c96565b9392505050565b6000815180845260208085019450808401835b83811015610b0f5781516001600160a01b031687529582019590820190600101610aea565b509495945050505050565b60008251610b2c818460208701610c50565b9190910192915050565b60a08152600086518060a0840152610b558160c0850160208b01610c50565b60208301879052601f01601f1916820182810360c09081016040850152610b7e90820187610ad7565b6001600160a01b039590951660608401525050608001529392505050565b85815284602082015260a060408201526000610bbb60a0830186610ad7565b6001600160a01b0394909416606083015250608001529392505050565b604051601f8201601f1916810167ffffffffffffffff81118282101715610c0157610c01610c80565b604052919050565b600067ffffffffffffffff821115610c2357610c23610c80565b5060051b60200190565b600082821015610c4b57634e487b7160e01b81526011600452602481fd5b500390565b60005b83811015610c6b578181015183820152602001610c53565b83811115610c7a576000848401525b50505050565b634e487b7160e01b600052604160045260246000fd5b60ff81168114610ca557600080fd5b5056fea26469706673582212203b2ad4432e31c849afc9dcdc1750885f0e512d752cc2228c89251fcd988f97f664736f6c63430008040033";

export class RequiemAggregator__factory extends ContractFactory {
  constructor(signer?: Signer) {
    super(_abi, _bytecode, signer);
  }

  deploy(
    _pairRouter: string,
    _stableRouter: string,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<RequiemAggregator> {
    return super.deploy(
      _pairRouter,
      _stableRouter,
      overrides || {}
    ) as Promise<RequiemAggregator>;
  }
  getDeployTransaction(
    _pairRouter: string,
    _stableRouter: string,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(
      _pairRouter,
      _stableRouter,
      overrides || {}
    );
  }
  attach(address: string): RequiemAggregator {
    return super.attach(address) as RequiemAggregator;
  }
  connect(signer: Signer): RequiemAggregator__factory {
    return super.connect(signer) as RequiemAggregator__factory;
  }
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): RequiemAggregatorInterface {
    return new utils.Interface(_abi) as RequiemAggregatorInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): RequiemAggregator {
    return new Contract(address, _abi, signerOrProvider) as RequiemAggregator;
  }
}