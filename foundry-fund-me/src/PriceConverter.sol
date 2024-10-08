// SPDX-License-Identifier: MIT
// Got help with programming from: https://docs.chain.link/data-feeds/getting-started
pragma solidity ^0.8.19;

import {AggregatorV3Interface} from
    "lib/chainlink-brownie-contracts/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// We used library because it is executed inline within calling contracts
library PriceConverter {
    // We could make this public, but then we'd have to deploy it
    function getPrice() internal view returns (uint256) {
        // Sepolia ETH / USD Address
        // https://docs.chain.link/data-feeds/price-feeds/addresses
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        // It can return different kinds of variables, but we are only interested in price
        (, int256 price,,,) = priceFeed.latestRoundData();
        // Had to typecast to uint256 
        // ETH/USD rate in 18 digit 
        return uint256(price * 10000000000);
    }

    // 1000000000
    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        // the actual ETH/USD conversion rate, after adjusting the extra 0s.
        return ethAmountInUsd;
    }
}
