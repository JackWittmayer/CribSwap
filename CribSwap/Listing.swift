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
    let type: Int
    let bedroomCount: Int
    let bathroomCount: Int
    let details: Details?
    let description: String?
    
    // Create listing without details:
    init(ownerName: String, price: Float, pictures: [UIImage]?, location: String?, address: String?, type: Int, bedroomCount: Int, bathroomCount: Int, description: String?)
    {
        self.ownerName = ownerName
        self.price = price
        self.pictures = pictures
        self.location = location
        self.address = address
        self.type = type
        self.bedroomCount = bedroomCount
        self.bathroomCount = bathroomCount
        self.details = nil
        self.description = description
    }
    // Create listing with details:
    init(ownerName: String, price: Float, pictures: [UIImage]?, location: String?, address: String?, type: Int, bedroomCount: Int, bathroomCount: Int, description: String?, details: Details?)
    {
        self.ownerName = ownerName
        self.price = price
        self.pictures = pictures
        self.location = location
        self.address = address
        self.type = type
        self.bedroomCount = bedroomCount
        self.bathroomCount = bathroomCount
        self.description = description
        self.details = details
    }
}


