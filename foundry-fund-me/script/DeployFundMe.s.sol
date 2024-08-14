// SPDX-License-Indentifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";

contract DeployFundME is Script{
    function run() external{
        vm.startBroadcast();
        new FundMe();
        vm.stopBroadcast();
    }
}