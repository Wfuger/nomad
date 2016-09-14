//
//  YapQDetailViewController.swift
//  TripIn
//
//  Created by Will Fuger on 7/1/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit
import MapKit

class YapQDetailViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var thing: AnyObject!
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        scroller.contentInset = UIEdgeInsetsMake(0, 0, 1500, 0)
//        let scroll = self.subView
//        let lastItem = scroll.subviews.last!
//        let lastOriginY = lastItem.frame.origin.y
//        let lastHeight = lastItem.frame.height
//        let finalHeight = lastOriginY + lastHeight
//        self.scroller.contentSize = CGSizeMake(lastItem.frame.size.width, finalHeight)
        
  
        
        
        if let titel = thing["title"] as? String {
            titleLabel.text = titel
        } else {
            titleLabel.text = ""
        }
        if let imageUrl = thing["main_image"] as? String {
            DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
                let data = try? Data(contentsOf: URL(string: imageUrl)!)
                var image: UIImage?
                if data != nil {
                    image = UIImage(data: data!)
                }
                DispatchQueue.main.async {
                    self.placeImage.image = image
                }
            }
        }
        
        var latitude:CLLocationDegrees
        var longitude:CLLocationDegrees
        let latDelta:CLLocationDegrees = 0.09
        let longDelta:CLLocationDegrees = 0.09
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)

        if let lat = thing["location"] as? JSONDictionary,
            let _lat = lat["latitude"] as? CLLocationDegrees {
            latitude = _lat
            if let long = thing["location"] as? JSONDictionary,
                let _long = long["longitude"] as? CLLocationDegrees {
                longitude = _long
                let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
                map.setRegion(region, animated: false)
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                map.addAnnotation(annotation)
            }
        }
        if let desc = thing["details"] as? JSONDictionary,
            let _description = desc["description"] as? String {
            descriptionLabel.text = _description
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        
//        self.scroller.frame = self.view.bounds
//        self.scroller.contentSize.height = 400
//        self.scroller.contentSize.width = 0
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
