//
//  ViewController.swift
//  CribSwap
//
//  Created by Jack Wittmayer on 8/13/20.
//  Copyright © 2020 Jack Wittmayer. All rights reserved.
//

import UIKit


let sellListings = [Listing(ownerName: "Jack Wittmayer", price: 450, pictures: nil, location: "2nd Avenue Center", address: nil, type: 0, bedroomBath: "4x4")]

let listingMode = 1

class SellListingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sellListings.capacity
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell", for: indexPath) as! ListingCell
        let arrayCell: Listing
        arrayCell = sellListings[indexPath.row]
        
        if arrayCell.location != nil
        {
            cell.cellTitle.text = arrayCell.location
            cell.subtitle.text = arrayCell.ownerName
        }
        else
        {
            cell.cellTitle.text = arrayCell.ownerName
            cell.subtitle.text = nil
        }
        cell.distance.text = "1 mile from campus"
        cell.price.text = "$\(arrayCell.price)/month"
        cell.bedroomBath.text = arrayCell.bedroomBath
        cell.picture.image = UIImage(named: "Apartment")
        return cell
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sell Listings"
    }


}

