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
        if let descrip = place!["details"] as? JSONDictionary,
            let desc = descrip["short_description"] as? String {
                descriptionLabel.text = desc
        } else {
            descriptionLabel.text = ""
        }
        
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
