//
//  HotelsViewController.swift
//  TripIn
//
//  Created by Will Fuger on 6/25/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit

class HotelsViewController: UIViewController, UITextFieldDelegate {
    var api = APIManager()
    var hotels: JSONArray = []

    @IBOutlet weak var airportTextField: UITextField!
    @IBOutlet weak var outDatePicker: UIDatePicker!
    @IBOutlet weak var inDatePicker: UIDatePicker!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func searchButton(sender: AnyObject) {
        
        spinner.alpha = 1
        spinner.startAnimating()
        if (airportTextField.text?.isEmpty != false) {
            let alert = UIAlertController(title: "Ooops!", message: "Airport can't be empty", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Cancel) { action -> Void in }
            alert.addAction(okAction)
            spinner.stopAnimating()
            spinner.alpha = 0
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            let inDateStr = dateFormatter.stringFromDate(inDatePicker.date)
            var inDateArr = inDateStr.characters.split(" ").map(String.init)
            inDateArr.insert(inDateArr[2], atIndex: 0)
            inDateArr.removeLast()
            let outDateStr = dateFormatter.stringFromDate(outDatePicker.date)
            var outDateArr = outDateStr.characters.split(" ").map(String.init)
            outDateArr.insert(outDateArr[2], atIndex: 0)
            outDateArr.removeLast()
            for (index, item) in inDateArr.enumerate() {
                if index == 1 {
                    switch item {
                    case "Jan":
                        inDateArr[index] = "01"
                    case "Feb":
                        inDateArr[index] = "02"
                    case "Mar":
                        inDateArr[index] = "03"
                    case "Apr":
                        inDateArr[index] = "04"
                    case "May":
                        inDateArr[index] = "05"
                    case "Jun":
                        inDateArr[index] = "06"
                    case "Jul":
                        inDateArr[index] = "07"
                    case "Aug":
                        inDateArr[index] = "08"
                    case "Sep":
                        inDateArr[index] = "09"
                    case "Oct":
                        inDateArr[index] = "10"
                    case "Nov":
                        inDateArr[index] = "11"
                    case "Dec":
                        inDateArr[index] = "12"
                    default:
                        return
                    }
                    
                }
                if index == 2 {
                    var formattedDay:String
                    let chars = item.characters.count
                    if chars <= 2 {
                        formattedDay = "0" + item
                        inDateArr[index] = formattedDay.stringByReplacingOccurrencesOfString(",", withString: "")
                    } else {
                        inDateArr[index] = item.stringByReplacingOccurrencesOfString(",", withString: "")
                    }
                }
            }
            for (index, item) in outDateArr.enumerate() {
                if index == 1 {
                    switch item {
                    case "Jan":
                        outDateArr[index] = "01"
                    case "Feb":
                        outDateArr[index] = "02"
                    case "Mar":
                        outDateArr[index] = "03"
                    case "Apr":
                        outDateArr[index] = "04"
                    case "May":
                        outDateArr[index] = "05"
                    case "Jun":
                        outDateArr[index] = "06"
                    case "Jul":
                        outDateArr[index] = "07"
                    case "Aug":
                        outDateArr[index] = "08"
                    case "Sep":
                        outDateArr[index] = "09"
                    case "Oct":
                        outDateArr[index] = "10"
                    case "Nov":
                        outDateArr[index] = "11"
                    case "Dec":
                        outDateArr[index] = "12"
                    default:
                        return
                    }
                    
                }
                if index == 2 {
                    var formattedDay:String
                    let chars = item.characters.count
                    if chars <= 2 {
                        formattedDay = "0" + item
                        outDateArr[index] = formattedDay.stringByReplacingOccurrencesOfString(",", withString: "")
                    } else {
                        outDateArr[index] = item.stringByReplacingOccurrencesOfString(",", withString: "")
                    }
                }
            }
            let inFormattedDateStr = inDateArr.joinWithSeparator("-")
            let outFormattedDateStr = outDateArr.joinWithSeparator("-")
            let url = "hotels/search-airport?\(API_KEY)&location=\(airportTextField.text!)&check_in=\(inFormattedDateStr)&check_out=\(outFormattedDateStr)"
            api.hotelByAirport(url, completion: didLoadHotels)
        }
        
        
    }
    
    func didLoadHotels(hotels: JSONArray) {
        self.hotels = hotels
        spinner.stopAnimating()
        spinner.alpha = 0
        print(hotels)
        if hotels.count == 0 {
            let alert = UIAlertController(title: "Ooops!", message: "No results found try again.", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Cancel) { action -> Void in }
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        } else if hotels[0] as? String == "errah" {
            let alert = UIAlertController(title: "Ooops!", message: hotels[1] as? String, preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Cancel) { action -> Void in }
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            self.performSegueWithIdentifier("hotelsSegue", sender: self)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.alpha = 0
        spinner.stopAnimating()
        self.airportTextField.delegate = self
        airportTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        inDatePicker.setValue(UIColor.whiteColor(), forKey: "textColor")
        inDatePicker.datePickerMode = .CountDownTimer
        inDatePicker.datePickerMode = .Date
        
        outDatePicker.setValue(UIColor.whiteColor(), forKey: "textColor")
        outDatePicker.datePickerMode = .CountDownTimer
        outDatePicker.datePickerMode = .Date

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "hotelsSegue" {
            let controller = segue.destinationViewController as! HotelsTVC
            controller.hotels = self.hotels
        }
    }
 

}
