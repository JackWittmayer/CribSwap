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
    }
    // MARK: Outlets
    @IBOutlet weak var locationName: UIButton!
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
        var ref: DocumentReference? = nil
        ref = db.collection("sellListings").addDocument(data: ["ownerName": "Jack Wittmayer", "price": priceField.text!, "bedroomCount": bedroomField.text!, "bathroomCount": bathroomField.text!, "description": descriptionField.text!])
        {
            err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
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
