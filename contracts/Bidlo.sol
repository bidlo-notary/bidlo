// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

struct StorageRequest {
    address owner;
    bool isOwnerStaked;
    uint256 ownerStakeAmount;
}

contract Bidlo {
    address _bidloOwner;
    StorageRequest[] storageRequests;

    constructor(address owner) {
        _bidloOwner = owner;
    }

    function createStorageRequest(uint256 size, uint256 calldata amount) public payable {
        storageRequests.push(
            StorageRequest({owner: msg.sender, isOwnerStaked: false, ownerStakeAmount: 10})
        );
    }

    function stakeAsOwner() public {}

    function bid() public {}

    function selectBid() public {}

    function confirmStorageProvisionAndVerifyDeal() public {}

    function completeDeal() public {}
}
