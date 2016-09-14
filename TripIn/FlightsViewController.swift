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

    @IBAction func searchButton(_ sender: AnyObject) {
        spinner.startAnimating()
        if (departingTextField.text?.isEmpty != false || flyingToTextField.text?.isEmpty != false) {
            let alert = UIAlertController(title: "Ooops!", message: "Need to fill out both airport fields", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in }
            alert.addAction(okAction)
            spinner.stopAnimating()
            self.present(alert, animated: true, completion: nil)
        } else {
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.medium
            let dateStr = dateFormatter.string(from: datePicker.date)
            
            var dateArr = dateStr.characters.split(separator: " ").map(String.init)
            dateArr.insert(dateArr[2], at: 0)
            dateArr.removeLast()
            
            for (index, item) in dateArr.enumerated() {
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
                        dateArr[index] = formattedDay.replacingOccurrences(of: ",", with: "")
                    } else {
                        dateArr[index] = item.replacingOccurrences(of: ",", with: "")
                    }
                }
            }
            let formattedDateStr = dateArr.joined(separator: "-")
            
            //        print(formattedDateStr)
            api.flightLowFareSearch("flights/low-fare-search?", origin: departingTextField.text!, destination: flyingToTextField.text!, date: formattedDateStr, completion: didLoadFlights)
            
        }
    }

    func didLoadFlights(_ flights: JSONArray) {
        spinner.stopAnimating()
        spinner.alpha = 0
        if let flightsErrah = flights[1] as? String {
            let alert = UIAlertController(title: "Sorry!", message: flightsErrah, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { action -> Void in }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            self.flights = flights
            self.performSegue(withIdentifier: "flightsTVCSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "flightsTVCSegue" {
            let controller = segue.destination as! FlightsTVC
            controller.flights = self.flights
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.stopAnimating()
        
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.datePickerMode = .countDownTimer
        datePicker.datePickerMode = .date
        
        departingTextField.autocorrectionType = .no
        flyingToTextField.autocorrectionType = .no
        self.departingTextField.delegate = self
        self.flyingToTextField.delegate = self
        flyingToTextField.keyboardAppearance = UIKeyboardAppearance.dark
        departingTextField.keyboardAppearance = UIKeyboardAppearance.dark
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }

}
