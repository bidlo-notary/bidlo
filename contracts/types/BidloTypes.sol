// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.4.25 <=0.8.17;

library BidloTypes {
    struct CreateStorageRequest {
        uint256 baseBid;
        uint256 storageSize;
        string location;
        uint256 categoryCode;
    }
}
