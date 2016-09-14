//
//  HotelVC.swift
//  TripIn
//
//  Created by Will Fuger on 7/3/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit
import MapKit

class HotelVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    var hotel:AnyObject?
    var amenities:[AnyObject] = []
    
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var map: MKMapView!


    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 40.0;
        tableView.reloadData()
        if let hotelname = hotel!["property_name"] as? String {
            hotelName.text = hotelname
        }
        if let amenitiesArr = hotel!["amenities"] as? JSONArray {
            amenities = amenitiesArr
        }
        var latitude:CLLocationDegrees
        var longitude:CLLocationDegrees
        let latDelta:CLLocationDegrees = 0.09
        let longDelta:CLLocationDegrees = 0.09
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        if let lat = hotel!["location"]!!["latitude"] as? CLLocationDegrees {
            latitude = lat
            if let long = hotel!["location"]!!["longitude"] as? CLLocationDegrees {
                longitude = long
                let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
                map.setRegion(region, animated: false)
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                map.addAnnotation(annotation)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amenities.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Amenity", for: indexPath) as! AmenityTableViewCell
        cell.amenity = amenities[(indexPath as NSIndexPath).row]
        return cell
    }

}
