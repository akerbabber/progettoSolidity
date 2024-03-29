// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24; 

contract CPAMM {

    IERC20 public token0;
    IERC20 public token1;

    uint256 public reserve0;
    uint256 public reserve1;

    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    constructor (IERC20 _token0, IERC20 _token1) {
        token0 = _token0;
        token1 = _token1;
    }

    function _mint(address to, uint amount) internal {
        totalSupply += amount;
        balanceOf[to] += amount;
    }

    function _burn(address from, uint amount) internal {
        totalSupply -= amount;
        balanceOf[from] -= amount;
    }

    function _update(uint _reserve0, uint _reserve1) internal {
        reserve0 = _reserve0;
        reserve1 = _reserve1;
    }

    function swap(address _tokenIn, uint256 _amountIn)
        external
        returns (uint256 amountOut)
    {
        require(
            _tokenIn == address(token0) || _tokenIn == address(token1),
            "invalid token"
        );
        require(_amountIn > 0, "amount in = 0");

        bool isToken0 = _tokenIn == address(token0);

       (IERC20 tokenIn, IERC20 tokenOut, uint256 reserveIn, uint256 reserveOut)
       = isToken0
           ? (token0, token1, reserve0, reserve1)
           : (token1, token0, reserve1, reserve0);

       require(tokenIn.transferFrom(msg.sender, address(this), _amountIn), "transferFrom failed");
       uint256 amountInWithFee = (_amountIn * 997) / 1000;
       amountOut =
            (reserveOut * amountInWithFee) / (reserveIn + amountInWithFee);
        tokenOut.transfer(msg.sender, amountOut);

        _update(
            token0.balanceOf(address(this)), token1.balanceOf(address(this))
        );
}
function addLiquidity(uint256 _amount0, uint256 _amount1)
        external
        returns (uint256 shares)
    {
        token0.transferFrom(msg.sender, address(this), _amount0);
        token1.transferFrom(msg.sender, address(this), _amount1);

        if (reserve0 > 0 || reserve1 > 0) {
            require(
                reserve0 * _amount1 == reserve1 * _amount0, "x / y != dx / dy"
            );
        }

         if (totalSupply == 0) {
            shares = _sqrt(_amount0 * _amount1);
        } else {
            shares = _min(
                (_amount0 * totalSupply) / reserve0,
                (_amount1 * totalSupply) / reserve1
            );
        }

        require(shares > 0, "shares = 0");
        _mint(msg.sender, shares);

        _update(
            token0.balanceOf(address(this)), token1.balanceOf(address(this))
        );
    }

    function removeLiquidity(uint256 _shares)
        external
        returns (uint256 amount0, uint256 amount1)
    {
        uint256 bal0 = token0.balanceOf(address(this));
        uint256 bal1 = token1.balanceOf(address(this));

        amount0 = (_shares * bal0) / totalSupply;
        amount1 = (_shares * bal1) / totalSupply;

        require(amount0 > 0 && amount1 > 0, "amount0 or amount1 = 0");

        _burn(msg.sender, _shares);
        _update(bal0 - amount0, bal1 - amount1);

        token0.transfer(msg.sender, amount0);
        token1.transfer(msg.sender, amount1);

    }

     function _sqrt(uint256 y) private pure returns (uint256 z) {
        if (y > 3) {
            z = y;
            uint256 x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }

    function _min(uint256 x, uint256 y) private pure returns (uint256) {
        return x <= y ? x : y;
    }
}


interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount)
        external
        returns (bool);
}

interface IERC20Metadata is IERC20 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
}