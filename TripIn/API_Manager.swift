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
    
    func airportAutoCall(_ route: String, term: String, completion: @escaping (JSONArray) -> Void) {
        Alamofire.request("\(baseURL)\(route)\(API_KEY)\(term)/get").responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? JSONArray {
                    let priority = DispatchQueue.GlobalQueuePriority.high
                    DispatchQueue.global( priority: priority).async {
                        DispatchQueue.main.async {
                            completion( json )
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func flightLowFareSearch(_ route:String, origin:String, destination:String, date:String, completion: @escaping (JSONArray) -> Void) {
        Alamofire.request("\(baseURL)\(route)origin=\(origin)&destination=\(destination)&departure_date=\(date)&\(API_KEY)").responseJSON { response in
            print(response.result.value)
            switch response.result {
            case .success:
                let result = response.result
                let value = result.value as? JSONDictionary
                if let json = value?["results"] as? JSONArray {
                    let priority = DispatchQoS.userInitiated.qosClass
                    DispatchQoS.init(qosClass: priority, relativePriority: 1)
                    
//                    DispatchQueue.global( priority: priority).async {
//                        DispatchQueue.main.async {
//                            completion( json )
//                        }
//                    }
                }
                if let errah = response.result.value!["message"] as! String? {
                    let errahArr: [AnyObject] = ["errah", errah]
                    let priority = DispatchQueue.GlobalQueuePriority.high
                    DispatchQueue.global( priority: priority).async {
                        DispatchQueue.main.async {
                            completion( errahArr )
                        }
                    }

                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func hotelByAirport(_ url: String, completion: @escaping (JSONArray) -> Void) {
        Alamofire.request(.GET, baseURL + url).responseJSON { response in
            switch response.result {
            case .success:
                if let errah = response.result.value!["message"] as! String? {
                    let errahArr: [AnyObject] = ["errah", errah]
                    let priority = DispatchQueue.GlobalQueuePriority.high
                    DispatchQueue.global( priority: priority).async {
                        DispatchQueue.main.async {
                            completion( errahArr )
                        }
                    }
                }
                if let json = response.result.value!["results"] as? JSONArray {
                    let priority = DispatchQueue.GlobalQueuePriority.high
                    DispatchQueue.global( priority: priority).async {
                        DispatchQueue.main.async {
                            completion( json )
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func yapQCitySearch(_ url: String, city: String, completion: @escaping (JSONArray) -> Void) {
        Alamofire.request(.GET, baseURL + url + city + "&image_size=MEDIUM&" + API_KEY).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value!["points_of_interest"] as? JSONArray {
                    let priority = DispatchQueue.GlobalQueuePriority.high
                    DispatchQueue.global( priority: priority).async {
                        DispatchQueue.main.async {
                            completion( json )
                        }
                    }
                }
                if let errah = response.result.value!["message"] as! String? {
                    let errahArr: [AnyObject] = ["errah", errah]
                    let priority = DispatchQueue.GlobalQueuePriority.high
                    DispatchQueue.global( priority: priority).async {
                        DispatchQueue.main.async {
                            completion( errahArr )
                        }
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
