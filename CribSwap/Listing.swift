//
//  Listing.swift
//  CribSwap
//
//  Created by Jack Wittmayer on 8/17/20.
//  Copyright © 2020 Jack Wittmayer. All rights reserved.
//

import Foundation
import UIKit

struct Details
{
    let furnished: String?
    let genderPreference: String?
}

class Listing
{
    let ownerName: String
    let price: Float
    let pictures: [UIImage]?
    let location: String?
    let address: String?
    let type: listingType
    let bedroomBath: String
    let details: Details?
    
    // Create listing without details:
    init(ownerName: String, price: Float, pictures: [UIImage]?, location: String?, address: String?, type: listingType, bedroomBath: String)
    {
        self.ownerName = ownerName
        self.price = price
        self.pictures = pictures
        self.location = location
        self.address = address
        self.type = type
        self.bedroomBath = bedroomBath
        self.details = nil
    }
    // Create listing with details:
    init(ownerName: String, price: Float, pictures: [UIImage]?, location: String?, address: String?, type: listingType, bedroomBath: String, details: Details)
    {
        self.ownerName = ownerName
        self.price = price
        self.pictures = pictures
        self.location = location
        self.address = address
        self.type = type
        self.bedroomBath = bedroomBath
        self.details = details
    }
}

enum listingType {
    case buy
    case sell
}

