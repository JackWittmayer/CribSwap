//
//  ViewController.swift
//  CribSwap
//
//  Created by Jack Wittmayer on 8/13/20.
//  Copyright © 2020 Jack Wittmayer. All rights reserved.
//

import UIKit


let buyListings = [Listing(ownerName: "Sophie Goodwin", price: 800, pictures: nil, location: nil, address: nil, type: listingType.buy, bedroomBath: "4x4")]
let sellListings = [
    Listing(ownerName: "Jack Wittmayer", price: 450, pictures: [UIImage(named: "Apartment")!], location: "2nd Avenue Center", address: nil, type: listingType.sell, bedroomBath: "4x4"),
    Listing(ownerName: "Joe Schmoe", price: 600, pictures: [UIImage(named: "Apartment")!, UIImage(named: "Apartment")!], location: "The Standard", address: nil, type: listingType.sell, bedroomBath: "4x4", details: Details(furnished: "Yes", genderPreference: "Female preferred")),
    Listing(ownerName: "John Smith", price: 400, pictures: [UIImage(named: "Apartment")!], location: "Gainesville Place", address: nil, type: listingType.sell, bedroomBath: "4x4")]


class ListingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let listingMode = listingType.sell
    var selectedRowIndex = 0
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listingMode == listingType.sell
        {
            return sellListings.capacity
        }
        else
        {
            return buyListings.capacity
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell", for: indexPath) as! ListingCell
        let arrayCell: Listing
        if listingMode == listingType.sell
        {
            arrayCell = sellListings[indexPath.row]
        }
        else
        {
            arrayCell = buyListings[indexPath.row]
        }
        
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
        if let pictures = arrayCell.pictures
        {
            cell.picture.image = pictures[0]
        }
        //cell.picture.image = UIImage(named: "Apartment")
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedRowIndex = indexPath.row
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ListingInfoViewController
        {
            vc.listing = sellListings[selectedRowIndex]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Listings"
    }


}

