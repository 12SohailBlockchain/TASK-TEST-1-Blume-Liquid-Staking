/*

██████  ██      ███████ ████████  ██████  ██   ██ ███████ ███    ██ 
██   ██ ██      ██         ██    ██    ██ ██  ██  ██      ████   ██ 
██████  ██      ███████    ██    ██    ██ █████   █████   ██ ██  ██ 
██   ██ ██           ██    ██    ██    ██ ██  ██  ██      ██  ██ ██ 
██████  ███████ ███████    ██     ██████  ██   ██ ███████ ██   ████ 
                                                                    
                                                                    
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract BLSToken is ERC20 {
    using SafeMath for uint256;

    constructor(uint256 initialSupply) ERC20("Blume Liquid Staking", "BLS") {
        _mint(msg.sender, initialSupply);
    }
}

contract stBLSToken is ERC20 {
    using SafeMath for uint256;

    constructor() ERC20("Staked Blume Liquid Staking", "stBLS") {}

    function mint(address account, uint256 amount) public {
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) public {
        _burn(account, amount);
    }
}

contract BlumeLiquidStaking {
    using SafeMath for uint256;

    BLSToken public blsToken;
    stBLSToken public stBlsToken;

    constructor(BLSToken _blsToken, stBLSToken _stBlsToken) {
        blsToken = _blsToken;
        stBlsToken = _stBlsToken;
    }

    function stake(uint256 amount) public {
        // Transfer BLS tokens to this contract for staking
        blsToken.transferFrom(msg.sender, address(this), amount);

        // Mint the same amount of stBLS tokens to the sender
        stBlsToken.mint(msg.sender, amount);
    }

    function unstake(uint256 amount) public {
        // Burn stBLS tokens from the sender
        stBlsToken.burn(msg.sender, amount);

        // Transfer the same amount of BLS tokens back to the sender
        blsToken.transfer(msg.sender, amount);
    }
}
