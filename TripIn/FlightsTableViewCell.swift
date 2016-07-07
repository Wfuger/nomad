//
//  FlightsTableViewCell.swift
//  TripIn
//
//  Created by Will Fuger on 6/30/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit
import SwiftyJSON

class FlightsTableViewCell: UITableViewCell {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var transfersLabel: UILabel!
    @IBOutlet weak var flightTimeLabel: UILabel!
    
    var flight: AnyObject? {
        didSet {
            updateCell()
        }
    }

    
    
    func updateCell() {
        if let price = flight!["fare"] as? JSONDictionary,
            let Price = price["total_price"] as? String {
            priceLabel.text = "Price: $" + Price
        } else {
            priceLabel.text = ""
        }
        if let transfers = flight!["itineraries"]!![0]["outbound"]!!["flights"]!!.count {
            transfersLabel.text = "Number of Transfers: " + String(transfers - 1)
        } else {
            transfersLabel.text = ""
        }
        if let timeStart = flight!["itineraries"]!![0]["outbound"]!!["flights"]!![0]["departs_at"] as? String {
            print(timeStart)
        }
        if let numFlights = flight!["itineraries"]!![0]["outbound"]!!["flights"]!!.count {
            if let timeEnd = flight!["itineraries"]!![0]["outbound"]!!["flights"]!![numFlights - 1]["arrives_at"] as? String {
                print(timeEnd)
            }
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
