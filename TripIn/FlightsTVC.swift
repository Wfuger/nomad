//
//  FlightsTVC.swift
//  TripIn
//
//  Created by Will Fuger on 6/27/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit
import SwiftyJSON

class FlightsTVC: UITableViewController {
    
    var flights = JSONArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = true
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return flights.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flight", for: indexPath) as! FlightsTableViewCell

        cell.flight = flights[(indexPath as NSIndexPath).row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "flightDetails" {
            if let indexpath = tableView.indexPathForSelectedRow {
                
                if let itin = flights[(indexpath as NSIndexPath).row] as? JSONDictionary,
                    let Itiner = itin["itineraries"] as? JSONArray,
                    let outbound = Itiner[0] as? JSONDictionary,
                    let Outbound = outbound["outbound"] as? JSONDictionary,
                    let flight = Outbound["flights"] as? JSONArray {
                    
                        let controller = segue.destination as! FlightsDetailTVC
                        controller.flights = flight
                }
            }
        }
    }
}
