// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

// The is Test part indicates that FundMeTest is inheriting from the Test contract.
// In Solidity, inheritance allows a contract to inherit all the functions, variables, and modifiers from another contract.
// This means that FundMeTest can use all the functionalities provided by the Test contract without needing to redefine them.
// These could include functions for setting up test environments, manipulating state, asserting conditions, and more.
contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() external {
        fundMe = new FundMe();
    }
    // we use public "view" because it Ensure that testMinimumDollarIsFive() only reads the contract’s state and does not modify it.
    // it gives better clarity and better gas efficiency.
    function testMinimumDolloarIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 1e18);
    }
    // Checks if the owner is equal with the sender of ETH

    function testOwnerIsMsgSender() public view {
        console.log(fundMe.i_owner());
        console.log(msg.sender);
        console.log(address(this));
        assertEq(fundMe.i_owner(), address(this));
    }

    // Checks if sender sends enough ETH
    // can't use "view" because it test modifies the state
    function testFundfailsNotEnoughETH() public {
        vm.expectRevert();
        fundMe.fund{value: 0}(); // send 0 value, which is less than the MINIMUM_USD
    }

    // Checks if we did send enough
    //function testDidSendEnoughETH() public{
    //    fundMe.fund{value: 12}();
    //    uint256 amountFunded = fundMe.addressToAmountFunded(address(this));
    //    assertEq(amountFunded, 12);
    //}
}
