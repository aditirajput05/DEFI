// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Trade_Bazzar {
    struct Listing {
        address seller;
        address asset;
        uint256 price;
        bool isSold;
        uint256 createdAt;
    }

    uint256 public listingCount;
    mapping(uint256 => Listing) public listings;
    mapping(address => uint256[]) public sellerListings;

    event NewListing(uint256 indexed listingId, address indexed seller, address asset, uint256 price);
    event TradeCompleted(uint256 indexed listingId, address indexed buyer);
    event ListingRemoved(uint256 indexed listingId, address indexed seller);

    function createListing(address _asset, uint256 _price) external {
        require(_price > 0, "Price must be greater than 0");
        listingCount += 1;
        listings[listingCount] = Listing(msg.sender, _asset, _price, false, block.timestamp);
        sellerListings[msg.sender].push(listingCount);
        emit NewListing(listingCount, msg.sender, _asset, _price);
    }

    function buy(uint256 _listingId) external payable {
        Listing storage listing = listings[_listingId];
        require(!listing.isSold, "Listing already sold");
        require(msg.value >= listing.price, "Insufficient payment");

        listing.isSold = true;
        payable(listing.seller).transfer(listing.price);

        if (msg.value > listing.price) {
            // Refund the excess amount
            payable(msg.sender).transfer(msg.value - listing.price);
        }

        emit TradeCompleted(_listingId, msg.sender);
    }

    function getListing(uint256 _listingId) external view returns (Listing memory) {
        return listings[_listingId];
    }

    function removeListing(uint256 _listingId) external {
        Listing storage listing = listings[_listingId];
        require(listing.seller == msg.sender, "Only the seller can remove the listing");
        require(!listing.isSold, "Listing already sold");

        delete listings[_listingId];
        for (uint256 i = 0; i < sellerListings[msg.sender].length; i++) {
            if (sellerListings[msg.sender][i] == _listingId) {
                sellerListings[msg.sender][i] = sellerListings[msg.sender][sellerListings[msg.sender].length - 1];
                sellerListings[msg.sender].pop();
                break;
            }
        }

        emit ListingRemoved(_listingId, msg.sender);
    }

    function getSellerListings(address _seller) external view returns (uint256[] memory) {
        return sellerListings[_seller];
    }

    function getRecentListings(uint256 _count) external view returns (Listing[] memory) {
        Listing[] memory recentListings = new Listing[](_count);
        uint256 count = 0;
        for (uint256 i = listingCount; i > 0 && count < _count; i--) {
            if (!listings[i].isSold) {
                recentListings[count] = listings[i];
                count++;
            }
        }
        return recentListings;
    }
}
