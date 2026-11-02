// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {OurToken} from "../src/OurToken.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";

interface MintableToken {
    function mint(address, uint256) external;
}

contract OurTokenTest is Test {
    OurToken public ourToken;
    DeployOurToken public deployer;

    // setting up test users
    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        // Transfer some tokens to Bob for testing purposes
        vm.prank(msg.sender);
        ourToken.transfer(alice, STARTING_BALANCE);
    }

    function testInitialSupply() public view {
        assertEq(ourToken.totalSupply(), deployer.INITIAL_SUPPLY());
    }

    function testUsersCantMint() public {
        vm.expectRevert();
        MintableToken(address(ourToken)).mint(address(this), 1);
    }

    function testAliceBalance() public view {
        assertEq(STARTING_BALANCE, ourToken.balanceOf(alice));
    }

    // ==========================================
    // ALLOWANCE & TRANSFER FROM TESTS
    // ==========================================

    function testAllowanceAndTransferFrom() public {
        uint256 allowanceAmount = 20 ether;
        uint256 spendAmount = 10 ether;

        // Alice approves Bob to spend her tokens
        vm.prank(alice);
        ourToken.approve(bob, allowanceAmount);

        assertEq(ourToken.allowance(alice, bob), allowanceAmount);

        // Bob executes the transfer from Alice to himself
        vm.prank(bob);
        ourToken.transferFrom(alice, bob, spendAmount);

        assertEq(ourToken.balanceOf(alice), STARTING_BALANCE - spendAmount);
        assertEq(ourToken.balanceOf(bob), spendAmount);
        assertEq(ourToken.allowance(alice, bob), allowanceAmount - spendAmount);
    }

    function testTransferFromFailsIfOverAllowance() public {
        uint256 allowanceAmount = 5 ether;
        uint256 spendAmount = 10 ether;

        vm.prank(alice);
        ourToken.approve(bob, allowanceAmount);

        vm.prank(bob);
        vm.expectRevert();
        ourToken.transferFrom(alice, bob, spendAmount);
    }

    function testAllowanceWorks() public {
        uint256 initialAllowance = 1000;

        vm.prank(alice);
        ourToken.approve(bob, initialAllowance);

        uint256 transferAmount = 500;

        vm.prank(bob);
        ourToken.transferFrom(alice, bob, transferAmount);

        assertEq(ourToken.balanceOf(bob), transferAmount);
        assertEq(ourToken.balanceOf(alice), STARTING_BALANCE - transferAmount);
    }

    // ==========================================
    // TRANSFER TESTS
    // ==========================================

    function testTransfer() public {
        uint256 transferAmount = 10 ether;

        vm.prank(alice);
        ourToken.transfer(bob, transferAmount);

        assertEq(ourToken.balanceOf(alice), STARTING_BALANCE - transferAmount);
        assertEq(ourToken.balanceOf(bob), transferAmount);
    }

    function testTransferFailsInsolvent() public {
        uint256 bankruptAmount = STARTING_BALANCE + 1;

        vm.prank(alice);
        vm.expectRevert(); // Standard ERC20 panic/revert on insufficient balance
        ourToken.transfer(bob, bankruptAmount);
    }

    // ==========================================
    // ADDITIONAL CRITICAL TESTS (Edge cases & Metadata)
    // ==========================================

    function testTokenMetadata() public view {
        assertEq(ourToken.name(), "Our Token");
        assertEq(ourToken.symbol(), "OTK");
        assertEq(ourToken.decimals(), 18);
    }

    function testZeroAmountTransfer() public {
        vm.prank(alice);
        bool success = ourToken.transfer(bob, 0);
        assertTrue(success);
        assertEq(ourToken.balanceOf(alice), STARTING_BALANCE);
        assertEq(ourToken.balanceOf(bob), 0);
    }
}
