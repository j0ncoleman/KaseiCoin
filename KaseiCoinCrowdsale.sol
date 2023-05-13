pragma solidity ^0.5.0;

import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";


// Have the KaseiCoinCrowdsale contract inherit the following OpenZeppelin:
// * Crowdsale
// * MintedCrowdsale
contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale { // UPDATE THE CONTRACT SIGNATURE TO ADD INHERITANCE
    
    // Provide parameters for all of the features of your crowdsale, such as the `rate`, `wallet` for fundraising, and `token`.
    constructor(
        uint256 rate, // rate in TKNbits
        address payable wallet, // wallet to receive funds
        KaseiCoin token // the token
    ) public
        Crowdsale(rate, wallet, token)
        MintedCrowdsale() 
    {
        // constructor can stay empty
    }
}


contract KaseiCoinCrowdsaleDeployer {
    address public kasei_token_address;
    address public kasei_crowdsale_address;

    constructor(
        string memory name,
        string memory symbol,
        address payable wallet
    ) public {
        KaseiCoin token = new KaseiCoin(name, symbol, 1);
        
        kasei_token_address = address(token);

        KaseiCoinCrowdsale crowdsale = new KaseiCoinCrowdsale(1, wallet, token);
            
        kasei_crowdsale_address = address(crowdsale);

        token.addMinter(kasei_crowdsale_address);
        
        token.renounceMinter();
    }
}