//
//  YapQTableViewCell.swift
//  TripIn
//
//  Created by Will Fuger on 7/1/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit

class YapQTableViewCell: UITableViewCell {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var place: AnyObject? {
        didSet {
            updateCell()
        }
    }

    func updateCell() {
        if let title = place!["title"] as? String {
            titleLabel.text = title
        } else {
            titleLabel.text = ""
        }
        if let descrip = place!["details"]!!["short_description"] as? String {
            descriptionLabel.text = descrip
        } else {
            descriptionLabel.text = ""
        }
        if let rating = place!["grades"]!!["yapq_grades"] as? String {
            ratingLabel.text = rating + "/5 stars"
        } else {
            ratingLabel.text = ""
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    

}
