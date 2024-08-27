// 1. Get funds from users
// 2. Set a precise number that users only can only fund by in DKK (1 DKK). 
// We don’t want users to pay less or higher in 1 DKK that would make it more complicated to tally votes. 

// SPDX-License-Identifier: MIT
// solidity version is 0.8.19 or higher
pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "lib/chainlink-brownie-contracts/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    // Type declaration
    using PriceConverter for uint256;

    // state variables
    // It maps and tracks how much ether adress has funded which is why made it "private". 
    // It prevents external contracts or users to modify the data structure 
    mapping(address => uint256) private addressToAmountFunded;
    address[] private funders;

    //  immutable is not stored in storage and can't be 
    address public immutable i_owner;
    // Minimum 1 dollor has to be send
    uint256 public constant MINIMUM_USD = 1 * 10 ** 18;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        // checks that the specific number you send is correct
        require(msg.value.getConversionRate() >= MINIMUM_USD, "You need to spend more Ether");
        // updates a mapping that tracks how much Ether each address has contributed to the contract
        addressToAmountFunded[msg.sender] += msg.value;
        // Records the sender into funders array
        funders.push(msg.sender);
    }       

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    modifier onlyOwner() {
        // require(msg.sender == owner);
        if (msg.sender != i_owner) revert NotOwner();
        _;
    }

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }
}