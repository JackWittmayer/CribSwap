//
//  ViewController.swift
//  CribSwap
//
//  Created by Jack Wittmayer on 8/13/20.
//  Copyright © 2020 Jack Wittmayer. All rights reserved.
//

import UIKit

// MARK: Sample Data
let buyListings = [Listing(ownerName: "Sophie Goodwin", price: 800, pictures: nil, location: nil, address: nil, type: listingType.buy, bedroomBath: "4x4")]
let sellListings = [
    Listing(ownerName: "Jack Wittmayer", price: 450, pictures: [UIImage(named: "Apartment")!], location: "2nd Avenue Center", address: nil, type: listingType.sell, bedroomBath: "4x4"),
    Listing(ownerName: "Joe Schmoe", price: 600, pictures: [UIImage(named: "Apartment")!, UIImage(named: "Apartment")!], location: "The Standard", address: nil, type: listingType.sell, bedroomBath: "4x4", details: Details(furnished: "Yes", genderPreference: "Female preferred")),
    Listing(ownerName: "John Smith", price: 400, pictures: [UIImage(named: "Apartment")!], location: "Gainesville Place", address: nil, type: listingType.sell, bedroomBath: "4x4")]


class ListingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Initialization
    let listingMode = listingType.sell
    var selectedRowIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Listings"
    }
    
    // MARK: TableView Methods
    
    // Returns the number of rows in the table based on the capacity of the sell and buy listing arrays
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
    
    // Creates the table cells:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Attempt to reuse a table cell to save resources:
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell", for: indexPath) as! ListingCell
        let listing: Listing
        
        // Find the appropriate listing to use for the table cell:
        if listingMode == listingType.sell
        {
            listing = sellListings[indexPath.row]
        }
        else
        {
            listing = buyListings[indexPath.row]
        }
        
        // If the listing doesn't have a location, make the cell title the name of the person who created the listing:
        if listing.location != nil
        {
            cell.cellTitle.text = listing.location
            cell.subtitle.text = listing.ownerName
        }
        else
        {
            cell.cellTitle.text = listing.ownerName
            cell.subtitle.text = nil
        }
        
        // Initialize other cell information from the selected listing:
        cell.distance.text = "1 mile from campus"
        cell.price.text = "$\(listing.price)/month"
        cell.bedroomBath.text = listing.bedroomBath
        
        // Initialize the cell's picture with the first picture in the listing:
        if let pictures = listing.pictures
        {
            cell.picture.image = pictures[0]
        }
        return cell
    }
    
    // Updates the index of the selected row in order to segue to it:
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedRowIndex = indexPath.row
        return indexPath
    }
    
    // MARK: Navigation
    // Updates the listing variable in the ListingInfoViewController before navigating to it:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ListingInfoViewController
        {
            vc.listing = sellListings[selectedRowIndex]
        }
    }
}

