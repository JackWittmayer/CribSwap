//
//  ViewController.swift
//  CribSwap
//
//  Created by Jack Wittmayer on 8/13/20.
//  Copyright © 2020 Jack Wittmayer. All rights reserved.
//

import UIKit
import Firebase

// MARK: Sample Data
let sampleBuyListings = [Listing(ownerName: "Sophie Goodwin", price: 800, pictures: nil, location: nil, address: nil, type: 0, bedroomCount: 4, bathroomCount: 4, description: nil)]
let sampleSellListings = [
    Listing(ownerName: "Jack Wittmayer", price: 450, pictures: [UIImage(named: "Apartment")!], location: "2nd Avenue Center", address: nil, type: 1, bedroomCount: 4, bathroomCount: 4, description: nil),
    Listing(ownerName: "Joe Schmoe", price: 600, pictures: [UIImage(named: "Apartment")!, UIImage(named: "Apartment")!], location: "The Standard", address: nil, type: 1, bedroomCount: 4, bathroomCount: 4, description: nil, details: Details(furnished: "Yes", genderPreference: "Female preferred")),
    Listing(ownerName: "John Smith", price: 400, pictures: [UIImage(named: "Apartment")!], location: "Gainesville Place", address: nil, type: 1, bedroomCount: 4, bathroomCount: 4, description: nil)]


class ListingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Initialization
    let listingMode = 1
    var selectedRowIndex = 0
    var buyListings = [Listing]()
    var sellListings = [Listing]()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Listings"
        let db = Firestore.firestore()
        db.collection("sellListings").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                if self.listingMode == 1
                {
                    self.sellListings = sampleSellListings
                }
                else
                {
                    self.buyListings = sampleBuyListings
                }
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    if let ownerName = document["ownerName"], let type = document["type"], let price = document["price"], let bedroomCount = document["bedroomCount"], let bathroomCount = document["bathroomCount"]
                    {
                        let listing = Listing(ownerName: ownerName as! String, price: price as! Float, pictures: document["pictures"] as? [UIImage], location: document["location"] as? String, address: document["address"] as? String, type: type as! Int, bedroomCount: bedroomCount as! Int, bathroomCount: bathroomCount as! Int, description: document["desription"] as? String, details: document["details"] as? Details)
                        print(document["ownerName"])
                        if self.listingMode == 1
                        {
                            self.sellListings.append(listing)
                        }
                        else
                        {
                            self.buyListings.append(listing)
                        }
                    }
                    else
                    {
                        print("Missing essential listing information")
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: TableView Methods
    
    // Returns the number of rows in the table based on the capacity of the sell and buy listing arrays
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listingMode == 1
        {
            print(sellListings.count)
            return sellListings.count
        }
        else
        {
            return buyListings.count
        }
    }
    
    // Creates the table cells:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Attempt to reuse a table cell to save resources:
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell", for: indexPath) as! ListingCell
        let listing: Listing
        
        // Find the appropriate listing to use for the table cell:
        if listingMode == 1
        {
            print(indexPath.row)
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
        cell.bedroomBath.text = "\(listing.bedroomCount)x\(listing.bathroomCount)"
        
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

