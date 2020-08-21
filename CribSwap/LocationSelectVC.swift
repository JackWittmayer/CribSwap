//
//  LocationSelectVC.swift
//  CribSwap
//
//  Created by Jack Wittmayer on 8/21/20.
//  Copyright © 2020 Jack Wittmayer. All rights reserved.
//

import UIKit


// Structure to make using location information easier:
struct Location
{
    let name: String
    let address: String
    let picture: UIImage
}

class LocationCell: UITableViewCell
{
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var picture: UIImageView!
}
// MARK: Sample Data
let locations = [Location(name: "Add New Location", address: "", picture: UIImage(systemName: "square.and.arrow.up")!), Location(name: "The Standard", address: "1360 W University Ave, Gainesville, FL 32603", picture: UIImage(named: "Apartment")!), Location(name: "2nd Avenue Centre", address: "address: 505 SW 2nd Ave, Gainesville, FL 32601", picture: UIImage(named: "Apartment")!), Location(name: "Gainesville Place", address: "2800 SW 35th Pl, Gainesville, FL 32608", picture: UIImage(named: "Apartment")!)]

var filteredLocations = locations


// Delegate protocol that allows transfering data when the navigation controller is popped:
protocol LocationSelectVCDelegate
{
    func LocationSelectVCResponse(location: Location)
}

class LocationSelectVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    var delegate: LocationSelectVCDelegate?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Search Bar Methods
    
    // Filter the table when the search bar text is changed:
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty
        {
            filteredLocations = locations
        }
        else
        {
            var filtered: [Location] = []
            for location in locations
            {
                if location.name.contains(searchText)
                {
                    filtered.append(location)
                }
            }
            filteredLocations = filtered
        }
        tableView.reloadData()
    }
    
    // Show cancel button when the search bar is being edited:
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            self.searchBar.showsCancelButton = true
    }
    
    // Close the search bar and refresh the table when the cancel button is clicked:
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filteredLocations = locations
        tableView.reloadData()
    }
    
    // MARK: TableView Methods
    
    // Initialize the number of table rows with the number of filtered locations:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLocations.capacity
    }
    
    // Create the tableView cells:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
        let location = filteredLocations[indexPath.row]
        cell.cellTitle.text = location.name
        cell.picture.image = location.picture
        return cell
    }
    
    // When a cell is selected, pop the navigation controller and send the location data to NewListingVC:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.LocationSelectVCResponse(location: filteredLocations[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
    



    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
