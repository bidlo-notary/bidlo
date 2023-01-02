// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/**
    Bidlo States
    0. Uninitialized / Incorrect Initialization
    1. Ready for Bids
    2. Deal Confirmed
    3. Closed
 */

struct Bid {
    address bidMaker;
    uint256 bidAmount;
    bool active;
}

struct StorageRequest {
    address owner;
    bool isOwnerStaked;
    uint256 initialBid;
    uint256 ownerStakeAmount;
    uint256 state;
    uint256 size;
    uint256 bounty;
    address selectedBidder;
    string cid;
    mapping(address => Bid) bids;
}

contract Bidlo {
    address _bidloOwner;
    mapping(uint256 => StorageRequest) requests;
    uint256 requestCount;

    event BidCreated();
    event StorageRequestCreated();

    constructor(address owner) {
        _bidloOwner = owner;
    }

    function createStorageRequest(uint256 size, uint256 amount) public payable {
        require(msg.value == amount / 2, "Initial Bid amount should be paid upfront");
        StorageRequest storage request = requests[requestCount++];
        request.owner = msg.sender;
        request.isOwnerStaked = true;
        request.ownerStakeAmount = amount;
        request.initialBid = amount;
        request.size = size;
    }

    function bid(uint256 requestIndex) public payable {
        require(
            msg.value <= requests[requestIndex].initialBid,
            "The bid should be lower than or equal to than the opening bid"
        );
        Bid memory bid = requests[requestIndex].bids[msg.sender];
        bid.bidMaker = msg.sender;
        bid.bidAmount = msg.value;
        bid.active = true;
        emit BidCreated();
    }

    function selectBid(
        uint256 requestIndex,
        address bidder,
        string memory cid
    ) public {
        Bid memory bid = requests[requestIndex].bids[bidder];
        require(bid.active, "Inactive Bid called");
        requests[requestIndex].selectedBidder = msg.sender;
        requests[requestIndex].state = 2;
        requests[requestIndex].cid = cid;
    }

    function confirmStorageProvisionAndVerifyDeal() public {}

    function completeDeal() public {}
}
