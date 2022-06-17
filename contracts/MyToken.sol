// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {

    uint256 drip = 1 ether; // 1 * (10^18)
    mapping (address => uint256) public addressTime;

    constructor() ERC20("Hawkz", "HWK") {
        _mint(msg.sender, 200 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function faucet() external {
        require(addressTime[msg.sender] < block.timestamp, "ayoo chill");
        _mint(msg.sender, drip);
        addressTime[msg.sender] = block.timestamp + 30 seconds; //30 seconds is our cooldown time
    }

    function airdrop (address[] memory _airdrops) public onlyOwner {
        for(uint i = 0; i < _airdrops.length; i++) {
            _mint(_airdrops[i], drip);
        }
    }

    function buy (uint _amount) external payable {
        require(msg.value > 0, "send money");
        _mint(msg.sender, _amount);
    }
}