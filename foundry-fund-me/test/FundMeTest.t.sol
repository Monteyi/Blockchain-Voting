// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";

// The is Test part indicates that FundMeTest is inheriting from the Test contract. 
// In Solidity, inheritance allows a contract to inherit all the functions, variables, and modifiers from another contract. 
// This means that FundMeTest can use all the functionalities provided by the Test contract without needing to redefine them.
// These could include functions for setting up test environments, manipulating state, asserting conditions, and more.
contract FundMeTest is Test {
    uint256 number = 1;

    function setUp() external {
        number = 2;
    }

    function testDemo() public {
        console.log(number);
        console.log("hello");
        assertEq(number, 2);

    }


}