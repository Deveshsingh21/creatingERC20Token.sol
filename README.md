# ERC 20 TOKEN
This Smart Contract written in Solidity Language defines the creation of an ERC20 TOKEN. This contract allows us to carry out different functions on these Tokens.
Video Explanation  https://www.loom.com/share/4145a2ddff3f4d1e9be9a262a64d4bac
## Description 
This smart contract inherits some readymade smart contracts from OpenZeppelin which are ERC20, ERC20Burnable, Ownable.
Other than these it includes some built in functions for freezing account ,unfreezing account, minting new tokens, burning tokens, and transferring tokens.

## Getting Started
 ### Executing Program
 To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.
 1. ### Creating New File And Pasting Code
    
  Click on the "+" icon in the left-hand sidebar.Save the file with a .sol extension (e.g., SolidityToken.sol).
   ```
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
    
    
}
```
2. ### Compile the Code
   Click on the "Solidity Compiler" tab in the left-hand sidebar. Ensure the "Compiler" option is set to "0.8.25" (or another compatible version). Click on the "Compile SolidityToken.sol" button.
3. ### Deploy the Contract
   Click on the "Deploy & Run Transactions" tab in the left-hand sidebar. Enter the initial supply in the deployment input box. Click on the "Deploy" button.After deployment, we can interact with the contract using the provided functions that are freezeAccount,unfreezeAccount, mint, burnToken, transferToken.
    ## Authors
   Metacrafter DeveshSingh21 deveshsingh5603@gmail.com
   ## License
   This project is licensed under the MIT License.
   
   
