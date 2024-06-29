// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SolidityToken is ERC20, ERC20Burnable, Ownable {
    //FREEZE OR UNFREEZE ANY ACCOUNT (ONLY ACCESSIBLE BY OWNER)
    event AccountFrozen(address indexed account);
    event AccountUnfrozen(address indexed account);
    event TokensMinted(address to, uint amount);
    event TokensBurned(address  from, uint amount);
    event TokensTransferred(address  from, address to, uint amount);
    
    mapping(address => bool) private _frozenAccounts;

    constructor(uint initialSupply) ERC20("RichardBranson", "RDBN")
    Ownable(msg.sender)
     {
        _mint(msg.sender, initialSupply);
    }

    function mint(address to, uint amount) public onlyOwner {
        _mint(to, amount);
        emit TokensMinted(to, amount);
    }

    function burnToken(uint256 amount) public {
        _burn(msg.sender, amount);
        emit TokensBurned(msg.sender, amount);
    }

    function transferToken(address to, uint256 amount) public returns (bool) {
        require(!_frozenAccounts[msg.sender], "Your account is frozen");
        _transfer(msg.sender, to, amount);
        emit TokensTransferred(msg.sender, to, amount);
        return true;
    }
    function freezeAccount(address account) external onlyOwner {
        _frozenAccounts[account] = true;
        emit AccountFrozen(account);

    }
    function unfreezeAccount(address account) public onlyOwner {
        _frozenAccounts[account] = false;
        emit AccountUnfrozen(account);
    }
    function isAccountFrozen(address account) public view returns (bool) {
        return _frozenAccounts[account];
    }
}
