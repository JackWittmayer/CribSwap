//
//  NewListingVC.swift
//  CribSwap
//
//  Created by Jack Wittmayer on 8/21/20.
//  Copyright © 2020 Jack Wittmayer. All rights reserved.
//

import UIKit
import Firebase

class NewListingVC: UIViewController, UITextFieldDelegate {
    let db = Firestore.firestore()

    @IBAction func uploadPictureButton(_ sender: Any) {
    }
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var bedroomField: UITextField!
    @IBOutlet weak var bathroomField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var detailsSection: UIStackView!
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
    @IBAction func showDetails(_ sender: Any) {
        detailsSection.isHidden = !detailsSection.isHidden
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        priceField.delegate = self
        bedroomField.delegate = self
        bathroomField.delegate = self
        self.title = "New Listing"
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
      textField.resignFirstResponder()
      return true
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
