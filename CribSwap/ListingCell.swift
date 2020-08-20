//
//  ListingCell.swift
//  CribSwap
//
//  Created by Jack Wittmayer on 8/18/20.
//  Copyright © 2020 Jack Wittmayer. All rights reserved.
//

import Foundation
import UIKit

class ListingCell: UITableViewCell
{
    @IBOutlet weak var cellTitle: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var bedroomBath: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var subtitle: UILabel!
}
