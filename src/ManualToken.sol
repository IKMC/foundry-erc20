// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ManualToken {
    mapping(address => uint256) private balances;

    function name() public pure returns (string memory) {
        return "Manual Token";
    }

    function symbol() public pure returns (string memory) {
        return "MNT";
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function totalSupply() public pure returns (uint256) {
        return 100 ether;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        uint256 previousBalance = balanceOf(msg.sender) + balanceOf(_to);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        assert(balanceOf(msg.sender) + balanceOf(_to) == previousBalance);
        return true;
    }
}
