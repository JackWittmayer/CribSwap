//
//  ListingInfoViewController.swift
//  CribSwap
//
//  Created by Jack Wittmayer on 8/18/20.
//  Copyright © 2020 Jack Wittmayer. All rights reserved.
//

import UIKit

class ListingInfoViewController: UIViewController {
    
    var listing: Listing?
// MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var roomtype: UILabel!
    @IBOutlet weak var horizontalScroll: UIScrollView!
    @IBOutlet weak var pictureScroll: UIView!
    @IBOutlet weak var detailsSection: UIStackView!
    
    //MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let passedListing = listing else
        {
            print("Error passing listing")
            return
        }
        titleLabel.text = passedListing.location
        subtitle.text = passedListing.ownerName
        distance.text = "1 mile from campus"
        price.text = "$\(passedListing.price)/month"
        roomtype.text = passedListing.bedroomBath
        if let pictures = passedListing.pictures
        {
            addPictures(pictures: pictures)
        }
        else
        {
            pictureScroll.isHidden = true
            horizontalScroll.isHidden = true
        }
        if let details = passedListing.details
        {
            addDetailsSection(details: details)
        }
        else
        {
            detailsSection.isHidden = true
        }

        // Do any additional setup after loading the view.
    }
    // MARK: Private Methods
    
    // Adds pictures to the horizontal scroll bar based on the passed in listing:
    func addPictures(pictures: [UIImage]?)
    {
        let height = pictureScroll.frame.height
        var lastPictureEndX: CGFloat = -30
        for picture in pictures!
        {
            // Scale the image so it fits correctly in the scroll view:
            let scale = pictureScroll.frame.height/picture.size.height
            let pictureView = UIImageView(image: picture)
            pictureView.frame = CGRect(x: lastPictureEndX + 30, y: 0, width: picture.size.width*scale, height: height)
            pictureScroll.addSubview(pictureView)
            lastPictureEndX = lastPictureEndX + 30 + picture.size.width*scale
        }
    }
    
    // Iterates through all the data in the listing's detail section and adds it to the page:
    func addDetailsSection(details: Details)
    {
        let mirror = Mirror(reflecting: details)
        for detail in mirror.children
        {
            let value = detail.value as! String
            print("key: \(detail.label!), value: \(value)")
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 10))
            label.text = "\(detail.label!): \(value)"
            detailsSection.addArrangedSubview(label)
        }
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
