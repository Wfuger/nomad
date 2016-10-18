//
//  HotelTableViewCell.swift
//  TripIn
//
//  Created by Will Fuger on 7/3/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit

class HotelTableViewCell: UITableViewCell {
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var phoneNum: UILabel!
    @IBOutlet weak var minRate: UILabel!
    
    
    var hotel: AnyObject? {
        didSet {
            updateCell()
        }
    }
    
    func updateCell() {
        if let name = hotel!["property_name"] as? String {
            hotelName.text = name
        }

        if let contacts = hotel?["contacts"] as? JSONArray,
            let details = contacts[0] as? JSONDictionary,
            let phone = details["detail"] as? String {
            phoneNum.text = phone
        }
        
        if let rate = hotel?["min_daily_rate"] as? JSONDictionary,
            let _rate = rate["amount"] as? String {
            minRate.text = "As Low As: $\(_rate)"
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
