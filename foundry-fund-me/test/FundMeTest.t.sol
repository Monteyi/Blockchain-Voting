// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";

// The is Test part indicates that FundMeTest is inheriting from the Test contract. 
// In Solidity, inheritance allows a contract to inherit all the functions, variables, and modifiers from another contract. 
// This means that FundMeTest can use all the functionalities provided by the Test contract without needing to redefine them.
// These could include functions for setting up test environments, manipulating state, asserting conditions, and more.
contract FundMeTest is Test {
    function setUp() external {}

    function testDemo() public {}


}