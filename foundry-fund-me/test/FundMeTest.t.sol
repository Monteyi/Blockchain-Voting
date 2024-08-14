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

    function setUp()  external {
        fundMe = new FundMe();
        }
// we use public view because Ensure that testMinimumDollarIsFive() only reads the contract’s state and does not modify it. it gives better clarity and better gas efficiency.
    function testMinimumDolloarIsFive() public view{
        assertEq(fundMe.MINIMUM_USD(), 5e18);
        }

        function testOwnerIsMsgSender() public view{
            console.log(fundMe.i_owner());
            console.log(msg.sender);
            console.log(address(this));
            assertEq(fundMe.i_owner(), address(this));
        }
}