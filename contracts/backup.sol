// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./interfaces/IRequiemRouter02.sol";
import "./interfaces/IRequiemStableSwap.sol";
import "./interfaces/IERC20.sol";

contract RequiemAggregatorRECENT {
    address public immutable pairRouter;
    address public immutable stableRouter;

    constructor(address _pairRouter, address _stableRouter) {
        pairRouter = _pairRouter;
        stableRouter = _stableRouter;
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
        for (uint i = 0; i < routerId.length; i++) {
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
        for (uint i = routerId.length - 1; i >= 0; i--) {
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
                    .getAmountsIn(outAmount, path[i]);
                connectingAmounts[i - routerId.length + 1] = amountsOut[
                    amountsOut.length - 1
                ];
            }
        }
        require(connectingAmounts[0] <= amountInMax, "INSUFFICIENT_INPUT");
        // then forward swap
        IERC20(path[0][0]).transferFrom(
            msg.sender,
            address(this),
            connectingAmounts[0]
        );
        for (uint i = routerId.length - 1; i >= 0; i--) {
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

    // classic swap tokens for exact tokens function
    // - first calculating the input amounts
    // - then forward swapping
    function multiSwapTokensForExactTokensTest(
        address[][] calldata path,
        uint[] memory routerId,
        uint256 amountOut,
        uint256 amountInMax,
        uint256 deadline
    ) external payable returns (uint256) {
        // uint256[] memory connectingAmounts = new uint256[](path.length);
        // calculate amounts
        uint256 outAmount = amountOut;
        // for (uint256 i = 0; i <1; i--) {
            // if (routerId[i] == 0) {
        //         uint8 inIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
        //             path[i][1]
        //         );
        //         uint8 outIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
        //             path[i][0]
        //         );
        //         outAmount = IRequiemStableSwap(stableRouter).calculateSwap(
        //             inIndex,
        //             outIndex,
        //             outAmount
        //         );
        //         // connectingAmounts[i - routerId.length + 1] = outAmount;
            // } else {
                uint256[] memory amountsOut = IRequiemRouter02(pairRouter)
                    .getAmountsIn(outAmount, path[0]);
                // connectingAmounts[i - routerId.length + 1] = amountsOut[
                //     amountsOut.length - 1
                // ];
            // }
        // }
        // require(connectingAmounts[0] <= amountInMax, "INSUFFICIENT_INPUT");
        // then forward swap
        // IERC20(path[0][0]).transferFrom(
        //     msg.sender,
        //     address(this),
        //     connectingAmounts[0]
        // );
        // for (uint256 i = routerId.length - 1; i > 0; i++) {
        //     if (routerId[i] == 0) {
        //         IERC20(path[i][0]).approve(stableRouter, connectingAmounts[0]);
        //         uint8 inIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
        //             path[i][0]
        //         );
        //         uint8 outIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
        //             path[i][1]
        //         );
        //         IRequiemStableSwap(stableRouter).swap(
        //             inIndex,
        //             outIndex,
        //             connectingAmounts[i],
        //             0,
        //             deadline
        //         );
        //     } else {
        //         IERC20(path[i][0]).approve(pairRouter, connectingAmounts[i]);
        //         IRequiemRouter02(pairRouter).swapExactTokensForTokens(
        //             connectingAmounts[i],
        //             0,
        //             path[i],
        //             address(this),
        //             deadline
        //         );
        //     }
        // }

        // IERC20(path[path.length - 1][path[path.length - 1].length - 1])
        //     .transfer(msg.sender, amountOut);
        return outAmount;
    }


    // Standard forward swap function using the Network CCY as input
    // Here the first swap is just ExactETHForTokens function
    // - in each step the previous output amount is used for the input
    function multiSwapExactETHForTokens(
        address[][] calldata path,
        uint256[] memory routerId,
        uint256 amountOutMin,
        uint256 deadline
    ) external payable returns (uint256) {
        (bool sent, ) = pairRouter.call{value: msg.value}("");
        require(sent, "FAILED_TO_SEND_ETH");
        IRequiemRouter02(pairRouter).swapExactETHForTokens(
            0,
            path[0],
            address(this),
            deadline
        );
        uint256[] memory amounts = IRequiemRouter02(pairRouter)
            .swapExactETHForTokens(0, path[0], address(this), deadline);
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
    // - then forward swapping strating with the ExactETHForTokensFunction
    function multiSwapETHForExactTokens(
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
        require(connectingAmounts[0] <= amountInMax, "INSUFFICIENT_INPUT");
        // then forward swap, starting with ETH
        (bool sent, ) = pairRouter.call{value: msg.value}("");
        require(sent, "FAILED_TO_SEND_ETH");
        IRequiemRouter02(pairRouter).swapExactETHForTokens(
            0,
            path[0],
            address(this),
            deadline
        );
        for (uint256 i = routerId.length - 1; i > 0; i++) {
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

    // standard forward swap function
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
        for (uint8 i = 0; i < routerId.length; i++) {
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
        require(connectingAmounts[0] <= amountInMax, "INSUFFICIENT_INPUT");
        // then forward swap
        IERC20(path[0][0]).transferFrom(
            msg.sender,
            address(this),
            connectingAmounts[0]
        );
        for (uint256 i = routerId.length - 1; i > 0; i++) {
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

    function multiSwapStructTest(
        address[] calldata path,
        uint256[] memory routerId,
        uint256 amountIn,
        uint256 amountOutMin,
        uint256 deadline
    ) external payable returns (uint256 amount) {
        IERC20(path[0]).transferFrom(msg.sender, address(this), amountIn);
        uint256 outAmount = amountIn;
        uint256 i = 0;
        // for (uint8 i = 0; i < routerId.length; i++) {
        //     if (routerId[i] == 0) {
        //         IERC20(path[i][0]).approve(stableRouter, outAmount);
        //         uint8 inIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
        //             path[i][0]
        //         );
        //         uint8 outIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
        //             path[i][1]
        //         );
        //         outAmount = _tradeRequiemStables(
        //             inIndex,
        //             outIndex,
        //             outAmount,
        //             i < routerId.length - 1 ? 0 : amountOutMin,
        //             deadline
        //         );
        //     } else {
        IERC20(path[0]).approve(pairRouter, outAmount);
        uint256[] memory amounts = IRequiemRouter02(pairRouter)
            .swapExactTokensForTokens(
                amountIn,
                amountOutMin,
                path,
                address(this),
                deadline
            );
        //     // }
        // // }

        // IERC20(path[path.length - 1])
        //     .transfer(msg.sender, outAmount);
        return outAmount;
    }

    function multiSwapStructView(
        address[][] calldata path,
        uint256[] memory routerId,
        uint256 amountIn,
        uint256 amountOutMin,
        uint256 deadline
    ) external view returns (address[] memory) {
        // IERC20(path[0][0]).transferFrom(msg.sender, address(this), amountIn);
        uint256 outAmount = amountIn;
        uint256 outLow;
        for (uint8 i = 0; i < routerId.length; i++) {
            if (routerId[i] == 0) {
                // IERC20(path[i][0]).approve(stableRouter, outAmount);
                // uint8 inIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                //     path[i][0]
                // );
                // uint8 outIndex = IRequiemStableSwap(stableRouter).getTokenIndex(
                //     path[i][1]
                // );
                // outAmount = _tradeRequiemStables(
                //     inIndex,
                //     outIndex,
                //     outAmount,
                //     i < routerId.length - 1 ? 0 : amountOutMin,
                //     deadline
                // );
            } else {
                // IERC20(path[i][0]).approve(pairRouter, outAmount);
                outLow = i < routerId.length - 1 ? 0 : amountOutMin;
                // uint256[] memory amounts = IRequiemRouter02(pairRouter)
                //     .swapExactTokensForTokens(
                //         outAmount,
                //         i < routerId.length - 1 ? 0 : amountOutMin,
                //         path[i],
                //         address(this),
                //         deadline
                //     );
                // outAmount = amounts[amounts.length - 1];
            }
        }

        // IERC20(path[path.length - 1][path[path.length - 1].length - 1])
        //     .transfer(msg.sender, outAmount);
        return (path[0]);
    }
}
