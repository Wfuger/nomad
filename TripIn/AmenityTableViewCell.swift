//
//  AmenityTableViewCell.swift
//  TripIn
//
//  Created by Will Fuger on 7/3/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit

class AmenityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var amenityLabel: UILabel!
    var amenity:AnyObject? {
        didSet {
            updateCell()
        }
    }
    func updateCell() {
        if let ameni = amenity!["description"] as? String {
            amenityLabel.text = ameni
        }
//        print(amenity)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
