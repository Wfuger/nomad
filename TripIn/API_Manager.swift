//
//  API_Manager.swift
//  TripIn
//
//  Created by Will Fuger on 6/22/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    let baseURL = "http://api.sandbox.amadeus.com/v1.2/"
    
    func airportAutoCall(route: String, term: String, completion: JSONArray -> Void) {
        Alamofire.request(.GET, (baseURL + route + API_KEY + term)).responseJSON { response in
            switch response.result {
            case .Success:
                if let json = response.result.value as? JSONArray {
                    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                    dispatch_async( dispatch_get_global_queue( priority, 0 ) ) {
                        dispatch_async( dispatch_get_main_queue() ) {
                            completion( json )
                        }
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func flightLowFareSearch(route:String, origin:String, destination:String, date:String, completion: JSONArray -> Void) {
        Alamofire.request(.GET, (baseURL + route + "origin=" + origin + "&destination=" + destination + "&departure_date=" + date + "&" + API_KEY)).responseJSON { response in
            print(response.result.value)
            switch response.result {
            case .Success:
                if let json = response.result.value!["results"] as? JSONArray {
                    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                    dispatch_async( dispatch_get_global_queue( priority, 0 ) ) {
                        dispatch_async( dispatch_get_main_queue() ) {
                            completion( json )
                        }
                    }
                }
                if let errah = response.result.value!["message"] as! String? {
                    let errahArr: [AnyObject] = ["errah", errah]
                    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                    dispatch_async( dispatch_get_global_queue( priority, 0 ) ) {
                        dispatch_async( dispatch_get_main_queue() ) {
                            completion( errahArr )
                        }
                    }

                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func flightExtSearch(url:String, completion: JSONArray -> Void) {
        Alamofire.request(.GET, url).responseJSON { response in
            switch response.result {
            case .Success:
                if let json = response.result.value!["results"] as? JSONArray {
                    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                    dispatch_async( dispatch_get_global_queue( priority, 0 ) ) {
                        dispatch_async( dispatch_get_main_queue() ) {
                            completion( json )
                        }
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func hotelByAirport(url: String, completion: JSONArray -> Void) {
        Alamofire.request(.GET, url).responseJSON { response in
            switch response.result {
            case .Success:
                if let json = response.result.value!["results"] as? JSONArray {
                    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                    dispatch_async( dispatch_get_global_queue( priority, 0 ) ) {
                        dispatch_async( dispatch_get_main_queue() ) {
                            completion( json )
                        }
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func hotelByGeo(url: String, completion: JSONArray -> Void) {
        Alamofire.request(.GET, url).responseJSON { response in
            switch response.result {
            case .Success:
                if let json = response.result.value!["results"] as? JSONArray {
                    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                    dispatch_async( dispatch_get_global_queue( priority, 0 ) ) {
                        dispatch_async( dispatch_get_main_queue() ) {
                            completion( json )
                        }
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func hotelPropertyCode(url: String, completion: JSONDictionary -> Void) {
        Alamofire.request(.GET, url).responseJSON { response in
            switch response.result {
            case .Success:
                if let json = response.result.value! as? JSONDictionary {
                    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                    dispatch_async( dispatch_get_global_queue( priority, 0 ) ) {
                        dispatch_async( dispatch_get_main_queue() ) {
                            completion( json )
                        }
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func carRentalByAirport(url: String, completion: JSONArray -> Void) {
        Alamofire.request(.GET, url).responseJSON { response in
            switch response.result {
            case .Success:
                if let json = response.result.value!["results"] as? JSONArray {
                    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                    dispatch_async( dispatch_get_global_queue( priority, 0 ) ) {
                        dispatch_async( dispatch_get_main_queue() ) {
                            completion( json )
                        }
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func carRentalByGeo(url: String, completion: JSONArray -> Void) {
        Alamofire.request(.GET, url).responseJSON { response in
            switch response.result {
            case .Success:
                if let json = response.result.value!["results"] as? JSONArray {
                    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                    dispatch_async( dispatch_get_global_queue( priority, 0 ) ) {
                        dispatch_async( dispatch_get_main_queue() ) {
                            completion( json )
                        }
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func trainSchedSearch(url: String, completion: JSONArray -> Void) {
        Alamofire.request(.GET, url).responseJSON { response in
            switch response.result {
            case .Success:
                if let json = response.result.value!["results"] as? JSONArray {
                    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                    dispatch_async( dispatch_get_global_queue( priority, 0 ) ) {
                        dispatch_async( dispatch_get_main_queue() ) {
                            completion( json )
                        }
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func trainStationInfo(url: String, completion: JSONDictionary -> Void) {
        Alamofire.request(.GET, url).responseJSON { response in
            switch response.result {
            case .Success:
                if let json = response.result.value! as? JSONDictionary {
                    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                    dispatch_async( dispatch_get_global_queue( priority, 0 ) ) {
                        dispatch_async( dispatch_get_main_queue() ) {
                            completion( json )
                        }
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func trainExtSearch(url: String, completion: JSONArray -> Void) {
        Alamofire.request(.GET, url).responseJSON { response in
            switch response.result {
            case .Success:
                if let json = response.result.value!["results"] as? JSONArray {
                    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                    dispatch_async( dispatch_get_global_queue( priority, 0 ) ) {
                        dispatch_async( dispatch_get_main_queue() ) {
                            completion( json )
                        }
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func trainAutocomplete(url: String, completion: JSONDictionary -> Void) {
        Alamofire.request(.GET, url).responseJSON { response in
            switch response.result {
            case .Success:
                if let json = response.result.value! as? JSONDictionary {
                    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                    dispatch_async( dispatch_get_global_queue( priority, 0 ) ) {
                        dispatch_async( dispatch_get_main_queue() ) {
                            completion( json )
                        }
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func yapQCitySearch(url: String, completion: JSONArray -> Void) {
        Alamofire.request(.GET, url).responseJSON { response in
            switch response.result {
            case .Success:
                if let json = response.result.value!["points_of_interest"] as? JSONArray {
                    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                    dispatch_async( dispatch_get_global_queue( priority, 0 ) ) {
                        dispatch_async( dispatch_get_main_queue() ) {
                            completion( json )
                        }
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func yapQGeoSearch(url: String, completion: JSONArray -> Void) {
        Alamofire.request(.GET, url).responseJSON { response in
            switch response.result {
            case .Success:
                if let json = response.result.value!["points_of_interest"] as? JSONArray {
                    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                    dispatch_async( dispatch_get_global_queue( priority, 0 ) ) {
                        dispatch_async( dispatch_get_main_queue() ) {
                            completion( json )
                        }
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
}