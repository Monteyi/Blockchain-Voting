// SPDX-License-Identifier: MIT
// How to script is copied from https://book.getfoundry.sh/tutorials/solidity-scripting
pragma solidity ^0.8.18;

// imports the forge library which provides the utility to run the blockchain
import {Script} from "forge-std/Script.sol";
// imports the contract that we want to deploy
import {FundMe} from "../src/FundMe.sol";

contract DeployFundMe is Script {
    function run() external {
        // starts the transaction
        vm.startBroadcast();
        // deploys the new instance FundMe contract
        new FundMe();
        // stop the transaction after this call. Ensuring that only the intended transactions are included
        vm.stopBroadcast();
    }
}
