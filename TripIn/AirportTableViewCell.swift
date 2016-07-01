//
//  AirportTableViewCell.swift
//  TripIn
//
//  Created by Will Fuger on 6/30/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit
import SwiftyJSON

class AirportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var airportLabel: UILabel!
    @IBOutlet weak var airportCodeLabel: UILabel!
    
    
    var airport: AnyObject? {
        didSet {
            updateCell()
        }
    }
    func updateCell() {
        if let label = airport!["label"] as? String {
            airportLabel.text = label
        }
    }

    
}
