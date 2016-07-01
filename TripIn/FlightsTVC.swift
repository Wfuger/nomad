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
        
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return flights.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("flight", forIndexPath: indexPath) as! FlightsTableViewCell

        cell.flight = flights[indexPath.row]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "flightDetails" {
            if let indexpath = tableView.indexPathForSelectedRow {
                let flight = flights[indexpath.row]["itineraries"]!![0]["outbound"]!!["flights"]!!
                let controller = segue.destinationViewController as! FlightsDetailTVC
                controller.flights = flight as! [AnyObject]

            }
        }
    }

}
