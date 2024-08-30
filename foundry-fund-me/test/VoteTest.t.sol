// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {Vote} from "../src/Vote.sol";

// The "VoteTest is Test" part indicates that VoteTest is inheriting from the Test contract that foundry has.
contract VoteTest is Test {
    Vote vote;

    function setUp() external {
        vote = new Vote();
    }
    // we use public "view" because it Ensure that testMinimumDollarIsFive() only reads the contract’s state and does not modify it.
    // it gives better clarity and better gas efficiency.
    function testMinimumDolloarIsFive() public view {
        assertEq(vote.MINIMUM_USD(), 1e18);
    }

    // Checks if the owner is equal with the sender of ETH
    function testOwnerIsMsgSender() public view {
        console.log(vote.i_owner());
        console.log(msg.sender);
        console.log(address(this));
        assertEq(vote.i_owner(), address(this));
    }

    // Checks if sender sends enough ETH
    // can't use "view" because it test modifies the state
    function testFundfailsNotEnoughETH() public {
        vm.expectRevert();
        vote.sendVote{value: 0}(); // send 0 value, which is less than the MINIMUM_USD
    }
}
