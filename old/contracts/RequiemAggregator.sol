// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./interfaces/IRequiemRouter02.sol";
import "./interfaces/IRequiemStableSwap.sol";
import "./interfaces/IERC20.sol";

contract RequiemAggregator {
    address public immutable pairRouter;
    address public immutable stableRouter;

    constructor(address _pairRouter, address _stableRouter) {
        pairRouter = _pairRouter;
        stableRouter = _stableRouter;
    }

    // function swapExactTokensForTokens(
    //     address[] memory path,
    //     uint256 amountIn,
    //     uint256 amountOutMin,
    //     address to,
    //     uint256 deadline,
    //     uint8[] memory stableIndxesInPath
    // ) public {
    //     uint8 inIndex;
    //     uint8 outIndex;
    //     uint256 currentInAmount = amountIn;
    //     uint8 currenStableIndex = 0;

    //     for (uint8 i = 0; i < path.length - 1; i++) {
    //         if (i == stableIndxesInPath[currenStableIndex]) {
    //             // 1) transaction through pairs
    //             if (i != 0) {
    //                 address[] memory localPath = new address[](
    //                     i - currenStableIndex + 1
    //                 );
    //                 // create local path for execution
    //                 for (
    //                     uint8 j = currenStableIndex > 0
    //                         ? stableIndxesInPath[currenStableIndex - 1] + 1
    //                         : 0;
    //                     j <= i;
    //                     j++
    //                 ) {
    //                     localPath[j] = path[j];
    //                 }

    //                 //uint256[] memory currentAmounts = new uint256[](i - currenStableIndex + 1);

    //                 uint256[] memory currentAmounts = IRequiemRouter02(
    //                     pairRouter
    //                 ).swapTokensForExactTokens(
    //                         currentInAmount,
    //                         i == path.length - 2 ? amountOutMin : 0,
    //                         localPath,
    //                         to,
    //                         deadline
    //                     );

    //                 currentInAmount = currentAmounts[currentAmounts.length - 1];
    //             } else {
    //                 // if first trade is stableswap

    //                 inIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
    //                     path[0]
    //                 );
    //                 outIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
    //                     path[1]
    //                 );

    //                 // uint256 minOut = IRequiemStableSwap(stableRouter).calculateSwap(inIndex, outIndex, dx);

    //                 currentInAmount = IRequiemStableSwap(stableRouter).swap(
    //                     inIndex,
    //                     outIndex,
    //                     currentInAmount,
    //                     0,
    //                     deadline
    //                 );
    //             }

    //             // execute the stableSwap transaction

    //             inIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
    //                 path[i]
    //             );
    //             outIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
    //                 path[i + 1]
    //             );

    //             currentInAmount = IRequiemStableSwap(stableRouter).swap(
    //                 inIndex,
    //                 outIndex,
    //                 currentInAmount,
    //                 i == path.length - 2 ? amountOutMin : 0,
    //                 deadline
    //             );

    //             currenStableIndex += 1;
    //         }
    //     }
    // }

    function swapExactTokensForTokens(
        address[] memory path,
        uint256 amountIn,
        uint256 amountOutMin,
        address to,
        uint256 deadline,
        uint8[] memory stableIndxesInPath
    ) public {
        uint8 inIndex;
        uint8 outIndex;
        uint256 currentInAmount = amountIn;
        uint8 currenStableIndex = 0;

        (bool a, bytes memory outAmount) = stableRouter.delegatecall(
            abi.encodeWithSignature("swap(uint8,uint8,uint256,uint256,uint256",  
            inIndex,
            outIndex,
            currentInAmount,
            0,
            deadline));

        address[] memory localPath = new address[](2);
        localPath[0] = path[1];
        localPath[1] = path[2];

        (bool b, bytes memory outAmountFinal) = pairRouter.delegatecall(
            abi.encodeWithSignature("swapTokensForExactTokens(uint,uint,address[],address,uint", 
            outAmount,
            amountOutMin,
            localPath,
            to,
            deadline));

        // // if first trade is stableswap
        // IERC20(path[0]).transferFrom(msg.sender, address(this), amountIn);
        // IERC20(path[0]).approve(address(this), amountIn);

        // IERC20(path[0]).approve(stableRouter, amountIn);

        // inIndex = IRequiemStableSwap(stableRouter).getTokenIndex(path[0]);
        // outIndex = IRequiemStableSwap(stableRouter).getTokenIndex(path[1]);
        // currentInAmount = IRequiemStableSwap(stableRouter).swap(
        //     inIndex,
        //     outIndex,
        //     currentInAmount,
        //     0,
        //     deadline
        // );
   
        // // net trade is regular
        // IRequiemRouter02(pairRouter).swapTokensForExactTokens(
        //     currentInAmount,
        //     amountOutMin,
        //     localPath,
        //     to,
        //     deadline
        // );
    }


function _tradeOnRequiem(uint256 amountIn, address[] memory path, uint256 amountOutMin, uint256 deadline) private returns(uint amount){
    address recipient = address(this);
      
    uint256[] memory amounts =  IRequiemRouter02(pairRouter).swapExactTokensForTokens(
        amountIn,
        amountOutMin,
        path,
        recipient,
        deadline
    );

    return amounts[amounts.length-1];
}

// function _getPathForSushiSwap() private pure returns (address[] memory) {
//     address[] memory path = new address[](2);
//     path[0] = 0xffb3ed4960cac85372e6838fbc9ce47bcf2d073e;
//     path[1] = 0xca9ec7085ed564154a9233e1e7d8fef460438eea;
    
//     return path;
// }

function _tradeRequiemStables(
    uint8 fromIndex,
        uint8 toIndex,
        uint256 inAmount,
        uint256 minOutAmount,
        uint256 deadline) private returns (uint256 amount){
            
    address recipient = address(this);
      
    return IRequiemStableSwap(stableRouter).swap(
        fromIndex,
        toIndex,
        inAmount,
        minOutAmount,
        deadline
    );
}

    function multiSwap(address[] memory path, uint256 amountIn, uint256 amountOutMin,uint256 deadline) external payable {

    uint256 amountOutMinBridge = 1;
    uint8 inIndex = IRequiemStableSwap(stableRouter).getTokenIndex(path[0]);
    uint8  outIndex = IRequiemStableSwap(stableRouter).getTokenIndex(path[1]);
    uint256 outStable = _tradeRequiemStables(inIndex, outIndex,amountIn, amountOutMinBridge, deadline);
    address[] memory pathEnd = new address[](2);
    pathEnd[0] = path[1];
    pathEnd[1] = path[2];
    (uint256  amounts) =_tradeOnRequiem(outStable, path, amountOutMin, deadline);
   
}

}
