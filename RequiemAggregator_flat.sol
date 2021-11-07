
// File: contracts/interfaces/IWETH.sol



pragma solidity >=0.5.0;

interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint value) external returns (bool);
    function withdraw(uint) external;
}

// File: contracts/interfaces/IERC20.sol



pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}
// File: contracts/interfaces/IRequiemStableSwap.sol



pragma solidity 0.8.4;


interface IRequiemStableSwap {
    /// EVENTS
    event AddLiquidity(
        address indexed provider,
        uint256[] tokenAmounts,
        uint256[] fees,
        uint256 invariant,
        uint256 tokenSupply
    );

    event TokenExchange(
        address indexed buyer,
        uint256 soldId,
        uint256 tokensSold,
        uint256 boughtId,
        uint256 tokensBought
    );

    event RemoveLiquidity(address indexed provider, uint256[] tokenAmounts, uint256[] fees, uint256 tokenSupply);

    event RemoveLiquidityOne(address indexed provider, uint256 tokenIndex, uint256 tokenAmount, uint256 coinAmount);

    event RemoveLiquidityImbalance(
        address indexed provider,
        uint256[] tokenAmounts,
        uint256[] fees,
        uint256 invariant,
        uint256 tokenSupply
    );

    event RampA(uint256 oldA, uint256 newA, uint256 initialTime, uint256 futureTime);

    event StopRampA(uint256 A, uint256 timestamp);

    event NewFee(uint256 fee, uint256 adminFee, uint256 withdrawFee);

    event CollectProtocolFee(address token, uint256 amount);

    event FeeControllerChanged(address newController);

    event FeeDistributorChanged(address newController);

    // pool data view functions
    function getLpToken() external view returns (IERC20 lpToken);

    function getA() external view returns (uint256);

    function getAPrecise() external view returns (uint256);

    function getToken(uint8 index) external view returns (IERC20);

    function getTokens() external view returns (IERC20[] memory);

    function getTokenIndex(address tokenAddress) external view returns (uint8);

    function getTokenBalance(uint8 index) external view returns (uint256);

    function getTokenBalances() external view returns (uint256[] memory);

    function getNumberOfTokens() external view returns (uint256);

    function getVirtualPrice() external view returns (uint256);

    function calculateTokenAmount(uint256[] calldata amounts, bool deposit) external view returns (uint256);

    function calculateSwap(
        uint8 tokenIndexFrom,
        uint8 tokenIndexTo,
        uint256 dx
    ) external view returns (uint256);

    function calculateRemoveLiquidity(address account, uint256 amount) external view returns (uint256[] memory);

    function calculateRemoveLiquidityOneToken(
        address account,
        uint256 tokenAmount,
        uint8 tokenIndex
    ) external view returns (uint256 availableTokenAmount);

    function getAdminBalances() external view returns (uint256[] memory adminBalances);

    function getAdminBalance(uint8 index) external view returns (uint256);

    function calculateCurrentWithdrawFee(address account) external view returns (uint256);

    // state modifying functions
    function swap(
        uint8 tokenIndexFrom,
        uint8 tokenIndexTo,
        uint256 dx,
        uint256 minDy,
        uint256 deadline
    ) external returns (uint256);

    function addLiquidity(
        uint256[] calldata amounts,
        uint256 minToMint,
        uint256 deadline
    ) external returns (uint256);

    function removeLiquidity(
        uint256 amount,
        uint256[] calldata minAmounts,
        uint256 deadline
    ) external returns (uint256[] memory);

    function removeLiquidityOneToken(
        uint256 tokenAmount,
        uint8 tokenIndex,
        uint256 minAmount,
        uint256 deadline
    ) external returns (uint256);

    function removeLiquidityImbalance(
        uint256[] calldata amounts,
        uint256 maxBurnAmount,
        uint256 deadline
    ) external returns (uint256);

    function updateUserWithdrawFee(address recipient, uint256 transferAmount) external;
}

// File: contracts/interfaces/IRequiemRouter01.sol



pragma solidity >=0.6.2;

interface IRequiemRouter01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

// File: contracts/interfaces/IRequiemRouter02.sol



pragma solidity >=0.6.2;


interface IRequiemRouter02 is IRequiemRouter01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

// File: contracts/RequiemAggregator.sol


pragma solidity >=0.7.6;





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
