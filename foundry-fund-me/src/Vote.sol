// 1. Get funds from users
// 2. Set a precise number that users only can only fund by in DKK (1 DKK). 
// We don’t want users to pay less or higher in 1 DKK that would make it more complicated to tally votes. 

// SPDX-License-Identifier: MIT
// solidity version is 0.8.19 or higher
pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "lib/chainlink-brownie-contracts/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract Vote {
    // Type declaration to get the same type call
    using PriceConverter for uint256;

    // state variable
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

    function sendVote() public payable {
        // checks that the specific number you send is correct
        require(msg.value.getConversionRate() >= MINIMUM_USD, "You need to more or less in Ether, so it's exactly 1 doller");
        // updates a mapping that tracks how much Ether each address has contributed to the contract
        addressToAmountFunded[msg.sender] += msg.value;
        // Records the sender into funders array
        funders.push(msg.sender);
    }
    
    // I use version function to determine I use the correct contract
    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    // use modifer because it imbed the code in any function to modify its behaviour.
    // that way we don't have to check on each function is the owner correct.
    modifier onlyOwner() {
        // Restrict access to functions. If it isn't the owner, then it will revert back with an error
        if (msg.sender != i_owner) revert NotOwner();
        _;
    }

    fallback() external payable {
        sendVote();
    }

    receive() external payable {
        sendVote();
    }
}