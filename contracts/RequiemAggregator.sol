// SPDX-License-Identifier: MIT
pragma solidity >=0.7.6;

import "./interfaces/IRequiemRouter02.sol";
import "./interfaces/IRequiemStableSwap.sol";
import "./interfaces/IERC20.sol";
import "./interfaces/IWETH.sol";

contract RequiemAggregator {
    address public immutable pairRouter;
    address public immutable stableRouter;
    address public immutable WETH;

    constructor(
        address _pairRouter,
        address _stableRouter,
        address _WETH
    ) {
        pairRouter = _pairRouter;
        stableRouter = _stableRouter;
        WETH = _WETH;
    }

    // standard forward swap function
    // - in each step the previous output amount is used for the input
    function multiSwapExactTokensForTokens(
        address[][] calldata path,
        uint256[] memory routerId,
        uint256 amountIn,
        uint256 amountOutMin,
        uint256 deadline
    ) external payable returns (uint256) {
        IERC20(path[0][0]).transferFrom(msg.sender, address(this), amountIn);
        uint256 outAmount = amountIn;
        for (uint256 i = 0; i < routerId.length; i++) {
            if (routerId[i] == 0) {
                IERC20(path[i][0]).approve(stableRouter, outAmount);
                uint8 inIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                    path[i][0]
                );
                uint8 outIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                    path[i][1]
                );
                outAmount = IRequiemStableSwap(stableRouter).swap(
                    inIndex,
                    outIndex,
                    outAmount,
                    i < routerId.length - 1 ? 0 : amountOutMin,
                    deadline
                );
            } else {
                IERC20(path[i][0]).approve(pairRouter, outAmount);
                uint256[] memory amounts = IRequiemRouter02(pairRouter)
                    .swapExactTokensForTokens(
                        outAmount,
                        i < routerId.length - 1 ? 0 : amountOutMin,
                        path[i],
                        address(this),
                        deadline
                    );
                outAmount = amounts[amounts.length - 1];
            }
        }

        IERC20(path[path.length - 1][path[path.length - 1].length - 1])
            .transfer(msg.sender, outAmount);
        return outAmount;
    }

    // classic swap tokens for exact tokens function
    // - first calculating the input amounts
    // - then forward swapping
    function multiSwapTokensForExactTokens(
        address[][] calldata path,
        uint256[] memory routerId,
        uint256 amountOut,
        uint256 amountInMax,
        uint256 deadline
    ) external payable returns (uint256) {
        uint256[] memory connectingAmounts = new uint256[](path.length);
        // calculate amounts
        uint256 outAmount = amountOut;
        for (uint256 i = routerId.length; i > 0; i--) {
            if (routerId[i - 1] == 0) {
                uint8 inIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                    path[i - 1][1]
                );
                uint8 outIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                    path[i - 1][0]
                );
                outAmount = IRequiemStableSwap(stableRouter).calculateSwap(
                    inIndex,
                    outIndex,
                    outAmount
                );
                connectingAmounts[i - 1] = outAmount;
            } else {
                uint256[] memory amountsIn = IRequiemRouter02(pairRouter)
                    .getAmountsIn(outAmount, path[i - 1]);
                connectingAmounts[i - 1] = amountsIn[0];
            }
        }
        require(connectingAmounts[0] <= amountInMax, "INSUFFICIENT_INPUT");
        // then forward swap
        IERC20(path[0][0]).transferFrom(
            msg.sender,
            address(this),
            connectingAmounts[0]
        );
        for (uint256 i = 0; i < routerId.length; i++) {
            if (routerId[i] == 0) {
                IERC20(path[i][0]).approve(stableRouter, connectingAmounts[0]);
                uint8 inIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                    path[i][0]
                );
                uint8 outIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                    path[i][1]
                );
                IRequiemStableSwap(stableRouter).swap(
                    inIndex,
                    outIndex,
                    connectingAmounts[i],
                    0,
                    deadline
                );
            } else {
                IERC20(path[i][0]).approve(pairRouter, connectingAmounts[i]);
                IRequiemRouter02(pairRouter).swapExactTokensForTokens(
                    connectingAmounts[i],
                    0,
                    path[i],
                    address(this),
                    deadline
                );
            }
        }

        IERC20(path[path.length - 1][path[path.length - 1].length - 1])
            .transfer(msg.sender, amountOut);
        return connectingAmounts[0];
    }

    // Standard forward swap function using the Network CCY as input
    // Here the first action is a WETH deposit
    // - in each step the previous output amount is used for the input
    function multiSwapExactETHForTokens(
        address[][] calldata path,
        uint256[] memory routerId,
        uint256 amountOutMin,
        uint256 deadline
    ) external payable returns (uint256) {
        uint256[] memory amounts = IRequiemRouter02(pairRouter).getAmountsOut(
            msg.value,
            path[0]
        );
        IWETH(WETH).deposit{value: amounts[0]}();
        IERC20(WETH).approve(pairRouter, amounts[0]);
        amounts = IRequiemRouter02(pairRouter).swapExactTokensForTokens(
            amounts[0],
            0,
            path[0],
            address(this),
            deadline
        );

        uint256 outAmount = amounts[amounts.length - 1];
        for (uint8 i = 1; i < routerId.length; i++) {
            if (routerId[i] == 0) {
                IERC20(path[i][0]).approve(stableRouter, outAmount);
                uint8 inIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                    path[i][0]
                );
                uint8 outIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                    path[i][1]
                );
                outAmount = IRequiemStableSwap(stableRouter).swap(
                    inIndex,
                    outIndex,
                    outAmount,
                    i < routerId.length - 1 ? 0 : amountOutMin,
                    deadline
                );
            } else {
                IERC20(path[i][0]).approve(pairRouter, outAmount);
                amounts = IRequiemRouter02(pairRouter).swapExactTokensForTokens(
                        outAmount,
                        i < routerId.length - 1 ? 0 : amountOutMin,
                        path[i],
                        address(this),
                        deadline
                    );
                outAmount = amounts[amounts.length - 1];
            }
        }

        IERC20(path[path.length - 1][path[path.length - 1].length - 1])
            .transfer(msg.sender, outAmount);
        return outAmount;
    }

    // classic swap tokens for exact tokens function
    // - first calculating the input amounts
    // - then depositing ETH / receiving WETH
    // - then forward swapping
    function multiSwapETHForExactTokens(
        address[][] calldata path,
        uint256[] memory routerId,
        uint256 amountOut,
        uint256 deadline
    ) external payable returns (uint256) {
        uint256[] memory connectingAmounts = new uint256[](path.length);
        // calculate amounts
        uint256 outAmount = amountOut;
        for (uint256 i = routerId.length; i > 0; i--) {
            if (routerId[i - 1] == 0) {
                uint8 inIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                    path[i - 1][1]
                );
                uint8 outIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                    path[i - 1][0]
                );
                outAmount = IRequiemStableSwap(stableRouter).calculateSwap(
                    inIndex,
                    outIndex,
                    outAmount
                );
                connectingAmounts[i - 1] = outAmount;
            } else {
                uint256[] memory amountsIn = IRequiemRouter02(pairRouter)
                    .getAmountsIn(outAmount, path[i - 1]);
                connectingAmounts[i - 1] = amountsIn[0];
            }
        }
        require(msg.value >= connectingAmounts[0], "INSUFFICIENT_INPUT");
        // // refund dust eth, if any
        if (msg.value > connectingAmounts[0])
            payable(msg.sender).transfer(msg.value - connectingAmounts[0]);

        // then forward swap
        IWETH(WETH).deposit{value: connectingAmounts[0]}();
        IERC20(WETH).approve(pairRouter, connectingAmounts[0]);
        IRequiemRouter02(pairRouter).swapExactTokensForTokens(
            connectingAmounts[0],
            0,
            path[0],
            address(this),
            deadline
        );
        for (uint256 i = 1; i < routerId.length; i++) {
            if (routerId[i] == 0) {
                IERC20(path[i][0]).approve(stableRouter, connectingAmounts[0]);
                uint8 inIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                    path[i][0]
                );
                uint8 outIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                    path[i][1]
                );
                IRequiemStableSwap(stableRouter).swap(
                    inIndex,
                    outIndex,
                    connectingAmounts[i],
                    0,
                    deadline
                );
            } else {
                IERC20(path[i][0]).approve(pairRouter, connectingAmounts[i]);
                IRequiemRouter02(pairRouter).swapExactTokensForTokens(
                    connectingAmounts[i],
                    0,
                    path[i],
                    address(this),
                    deadline
                );
            }
        }

        IERC20(path[path.length - 1][path[path.length - 1].length - 1])
            .transfer(msg.sender, amountOut);
        return connectingAmounts[0];
    }

    // standard forward swap function that returns ETH
    // - in each step the previous output amount is used for the input
    function multiSwapExactTokensForETH(
        address[][] calldata path,
        uint256[] memory routerId,
        uint256 amountIn,
        uint256 amountOutMin,
        uint256 deadline
    ) external payable returns (uint256) {
        IERC20(path[0][0]).transferFrom(msg.sender, address(this), amountIn);
        uint256 outAmount = amountIn;
        uint256[] memory amounts;
        for (uint8 i = 0; i < routerId.length - 1; i++) {
            if (routerId[i] == 0) {
                IERC20(path[i][0]).approve(stableRouter, outAmount);
                uint8 inIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                    path[i][0]
                );
                uint8 outIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                    path[i][1]
                );
                outAmount = IRequiemStableSwap(stableRouter).swap(
                    inIndex,
                    outIndex,
                    outAmount,
                    i < routerId.length - 1 ? 0 : amountOutMin,
                    deadline
                );
            } else {
                IERC20(path[i][0]).approve(pairRouter, outAmount);
                amounts = IRequiemRouter02(pairRouter).swapExactTokensForTokens(
                        outAmount,
                        i < routerId.length - 1 ? 0 : amountOutMin,
                        path[i],
                        address(this),
                        deadline
                    );
                outAmount = amounts[amounts.length - 1];
            }
        }

        IERC20(path[path.length - 1][0]).approve(pairRouter, outAmount);
        amounts = IRequiemRouter02(pairRouter).swapExactTokensForETH(
            outAmount,
            0,
            path[path.length - 1],
            msg.sender,
            deadline
        );

        outAmount = amounts[amounts.length - 1];
        // payable(msg.sender).transfer(outAmount);
        return outAmount;
    }

    // classic swap tokens for exact tokens function
    // - first calculating the input amounts
    // - then forward swapping
    function multiSwapTokensForExactETH(
        address[][] calldata path,
        uint256[] memory routerId,
        uint256 amountOut,
        uint256 amountInMax,
        uint256 deadline
    ) external payable returns (uint256) {
        uint256[] memory connectingAmounts = new uint256[](path.length);
        // calculate amounts
        uint256 outAmount = amountOut;
        for (uint256 i = routerId.length - 1; i > 0; i++) {
            if (routerId[i] == 0) {
                uint8 inIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                    path[i][1]
                );
                uint8 outIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                    path[i][0]
                );
                outAmount = IRequiemStableSwap(stableRouter).calculateSwap(
                    inIndex,
                    outIndex,
                    outAmount
                );
                connectingAmounts[i - routerId.length + 1] = outAmount;
            } else {
                uint256[] memory amountsOut = IRequiemRouter02(pairRouter)
                    .getAmountsIn(amountOut, path[i]);
                connectingAmounts[i - routerId.length + 1] = amountsOut[
                    amountsOut.length - 1
                ];
            }
        }
        require(connectingAmounts[0] > amountInMax, "EXCESSIVE_INPUT");
        // then forward swap
        IERC20(path[0][0]).transferFrom(
            msg.sender,
            address(this),
            connectingAmounts[0]
        );
        for (uint256 i = 0; i < path.length - 1; i++) {
            if (routerId[i] == 0) {
                IERC20(path[i][0]).approve(stableRouter, connectingAmounts[0]);
                uint8 inIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                    path[i][0]
                );
                uint8 outIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                    path[i][1]
                );
                IRequiemStableSwap(stableRouter).swap(
                    inIndex,
                    outIndex,
                    connectingAmounts[i],
                    0,
                    deadline
                );
            } else {
                IERC20(path[i][0]).approve(pairRouter, connectingAmounts[i]);
                IRequiemRouter02(pairRouter).swapExactTokensForTokens(
                    connectingAmounts[i],
                    0,
                    path[i],
                    address(this),
                    deadline
                );
            }
        }

        IERC20(path[path.length - 1][0]).approve(
            pairRouter,
            connectingAmounts[path.length - 1]
        );
        IRequiemRouter02(pairRouter).swapExactTokensForETH(
            connectingAmounts[path.length - 1],
            0,
            path[path.length - 1],
            msg.sender,
            deadline
        );
        // payable(msg.sender).transfer(outAmount);
        return connectingAmounts[0];
    }
}
