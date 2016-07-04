//
//  FlightsViewController.swift
//  TripIn
//
//  Created by Will Fuger on 6/25/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit
import SwiftyJSON

class FlightsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var departingTextField: UITextField!
    @IBOutlet weak var flyingToTextField: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var api = APIManager()
    var flights: JSONArray = []

    @IBAction func searchButton(sender: AnyObject) {
        spinner.startAnimating()
        if (departingTextField.text?.isEmpty != false || flyingToTextField.text?.isEmpty != false) {
            let alert = UIAlertController(title: "Ooops!", message: "Need to fill out both airport fields", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Cancel) { action -> Void in }
            alert.addAction(okAction)
            spinner.stopAnimating()
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            let dateStr = dateFormatter.stringFromDate(datePicker.date)
            
            var dateArr = dateStr.characters.split(" ").map(String.init)
            dateArr.insert(dateArr[2], atIndex: 0)
            dateArr.removeLast()
            
            for (index, item) in dateArr.enumerate() {
                if index == 1 {
                    switch item {
                    case "Jan":
                        dateArr[index] = "01"
                    case "Feb":
                        dateArr[index] = "02"
                    case "Mar":
                        dateArr[index] = "03"
                    case "Apr":
                        dateArr[index] = "04"
                    case "May":
                        dateArr[index] = "05"
                    case "Jun":
                        dateArr[index] = "06"
                    case "Jul":
                        dateArr[index] = "07"
                    case "Aug":
                        dateArr[index] = "08"
                    case "Sep":
                        dateArr[index] = "09"
                    case "Oct":
                        dateArr[index] = "10"
                    case "Nov":
                        dateArr[index] = "11"
                    case "Dec":
                        dateArr[index] = "12"
                    default:
                        return
                    }
                    
                }
                if index == 2 {
                    var formattedDay:String
                    let chars = item.characters.count
                    if chars <= 2 {
                        formattedDay = "0" + item
                        dateArr[index] = formattedDay.stringByReplacingOccurrencesOfString(",", withString: "")
                    } else {
                        dateArr[index] = item.stringByReplacingOccurrencesOfString(",", withString: "")
                    }
                }
            }
            let formattedDateStr = dateArr.joinWithSeparator("-")
            
            //        print(formattedDateStr)
            api.flightLowFareSearch("flights/low-fare-search?", origin: departingTextField.text!, destination: flyingToTextField.text!, date: formattedDateStr, completion: didLoadFlights)
            
        }
    }

    func didLoadFlights(flights: JSONArray) {
        spinner.stopAnimating()
        spinner.alpha = 0
        if let flightsErrah = flights[1] as? String {
            let alert = UIAlertController(title: "Sorry!", message: flightsErrah, preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in }
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            self.flights = flights
            self.performSegueWithIdentifier("flightsTVCSegue", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "flightsTVCSegue" {
            let controller = segue.destinationViewController as! FlightsTVC
            controller.flights = self.flights
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.stopAnimating()
        
        datePicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        datePicker.datePickerMode = .CountDownTimer
        datePicker.datePickerMode = .Date
        
        self.departingTextField.delegate = self
        self.flyingToTextField.delegate = self
        flyingToTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        departingTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == flyingToTextField {
            searchButton(self)
        }
        textField.resignFirstResponder()
        
        return true
        
    }

    

}
