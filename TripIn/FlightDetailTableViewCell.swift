//
//  FlightDetailTableViewCell.swift
//  TripIn
//
//  Created by Will Fuger on 6/30/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit
import SwiftyJSON

class FlightDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var depAirportLabel: UILabel!
    @IBOutlet weak var arrAirportLabel: UILabel!
    @IBOutlet weak var depTimeLabel: UILabel!
    @IBOutlet weak var arrTimeLabel: UILabel!
    @IBOutlet weak var seatsRemLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    
    
    var flight: AnyObject? {
        didSet {
            updateCell()
        }
    }
    
    func updateCell() {
        print(flight!)
        if let depAirport = flight!["origin"]!!["airport"] as? String {
            depAirportLabel.text = depAirport
        } else {
            depAirportLabel.text = ""
        }
        if let travelClass = flight!["booking_info"]!!["travel_class"] as? String {
            classLabel.text = travelClass
        } else {
            classLabel.text = ""
        }
        if let arrAirport = flight!["destination"]!!["airport"] as? String {
            arrAirportLabel.text = arrAirport
        } else {
            arrAirportLabel.text = ""
        }
        if let seats = flight!["booking_info"]!!["seats_remaining"] as? String {
            seatsRemLabel.text = "Seats Left: " + seats
        } else {
            seatsRemLabel.text = ""
        }
        if let depTime = flight!["departs_at"] as? String {
            depTimeLabel.text = depTime
        } else {
            depTimeLabel.text = ""
        }
        if let arrTime = flight!["arrives_at"] as? String {
            arrTimeLabel.text = arrTime
        } else {
            arrTimeLabel.text = ""
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