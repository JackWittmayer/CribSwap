//
//  NewListingVC.swift
//  CribSwap
//
//  Created by Jack Wittmayer on 8/21/20.
//  Copyright © 2020 Jack Wittmayer. All rights reserved.
//

import UIKit
import Firebase

class NewListingVC: UIViewController, UITextFieldDelegate, LocationSelectVCDelegate {
    let db = Firestore.firestore()

    func LocationSelectVCResponse(location: Location) {
        locationName.setTitle(location.name, for: .normal)
        locationPicture.image = location.picture
        address = location.address
    }
    // MARK: Outlets
    @IBOutlet weak var locationName: UIButton!
    var address: String?
    @IBAction func uploadPictureButton(_ sender: Any) {
    }
    @IBOutlet weak var locationPicture: UIImageView!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var bedroomField: UITextField!
    @IBOutlet weak var bathroomField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var detailsSection: UIStackView!
    
    // MARK: Actions
    // Create listing and add it to firebase:
    @IBAction func createListing(_ sender: Any) {
        if locationName.titleLabel?.text != "" && priceField.text != "" && bedroomField.text != "" && bathroomField.text != "" && descriptionField.text != "" && address != nil
        {
            var ref: DocumentReference? = nil
            ref = db.collection("sellListings").addDocument(data: ["ownerName": "Jack Wittmayer", "price": Float(priceField.text!), "bedroomCount": Int(bedroomField.text!), "bathroomCount": Int(bathroomField.text!), "description": descriptionField.text!, "type": 1, "location": locationName.titleLabel!.text!, "address": address])
            {
                err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        }
        else
        {
            print("Missing listing information")
        }
    }
    // Reveal the details section:
    @IBAction func showDetails(_ sender: Any) {
        detailsSection.isHidden = !detailsSection.isHidden
    }
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        priceField.delegate = self
        bedroomField.delegate = self
        bathroomField.delegate = self
        self.title = "New Listing"
        // Do any additional setup after loading the view.
    }
    
    // Make keyboard go away when done typing in any text field:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
      textField.resignFirstResponder()
      return true
    }
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? LocationSelectVC
        {
            vc.delegate = self
        }
    }
}
