// contracts/Dispatcher.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Fidelity is ERC20, Ownable {

    using SafeMath for uint256;

    address[] public fidels;
    mapping(address => uint256) public fidelSubscriptionTimestamps;
    mapping(address => bool) public fidelsActive;

    /**
     * @dev Constructor that gives msg.sender all of existing tokens.
     */
    constructor() ERC20("Fidelity", "FID") {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        if (fidelSubscriptionTimestamps[account] == 0 || fidelSubscriptionTimestamps[account] > block.timestamp) {
          return 0;
        } else {
          // 1 day = 1 token
          return block.timestamp.sub(fidelSubscriptionTimestamps[account]).div(864);
        }
    }

    function decimals() public view virtual override returns (uint8) {
        return 2;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual override returns (uint256) {
        uint256 totalSupply = 0;
        for (uint256 i = 0; i < fidels.length; i++) {
            address fidel = fidels[i];
            totalSupply += balanceOf(fidel);
        }
        return totalSupply;
    }

    /**
     * @dev See {IERC20-transfer}.
     */
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        return false;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        return false;
    }

    function addFidel(address account, uint256 subscriptionTimestamp) public virtual onlyOwner {
        if (!fidelsActive[account]) {
            fidels.push(account);
            fidelsActive[account] = true;
        }
        fidelSubscriptionTimestamps[account] = subscriptionTimestamp;
    }

    function removeFidel(address account) public virtual onlyOwner {
        fidelSubscriptionTimestamps[account] = 0;
    }
}
