//
//  Flight.swift
//  TripIn
//
//  Created by Will Fuger on 6/30/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import Foundation
import SwiftyJSON

class Flight {
    
    var _price: String?
    var _flights: JSONArray?
    
    init(data: JSONDictionary) {
        
        if let price = data["fare"]!["total_price"]! as? String {
            self._price = price
        } else {
            self._price = ""
        }
        
        if let flights = data["itineraries"]![0]["outbound"]!!["flights"] as? JSONArray {
            self._flights = flights
        } else {
            self._flights = [AnyObject]()
        }
        
        
    }
    
    
}