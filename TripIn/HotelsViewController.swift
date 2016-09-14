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
    
    @IBAction func searchButton(_ sender: AnyObject) {
        
        spinner.alpha = 1
        spinner.startAnimating()
        if (airportTextField.text?.isEmpty != false) {
            let alert = UIAlertController(title: "Ooops!", message: "Airport can't be empty", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in }
            alert.addAction(okAction)
            spinner.stopAnimating()
            spinner.alpha = 0
            self.present(alert, animated: true, completion: nil)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.medium
            let inDateStr = dateFormatter.string(from: inDatePicker.date)
            var inDateArr = inDateStr.characters.split(separator: " ").map(String.init)
            inDateArr.insert(inDateArr[2], at: 0)
            inDateArr.removeLast()
            let outDateStr = dateFormatter.string(from: outDatePicker.date)
            var outDateArr = outDateStr.characters.split(separator: " ").map(String.init)
            outDateArr.insert(outDateArr[2], at: 0)
            outDateArr.removeLast()
            for (index, item) in inDateArr.enumerated() {
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
                        inDateArr[index] = formattedDay.replacingOccurrences(of: ",", with: "")
                    } else {
                        inDateArr[index] = item.replacingOccurrences(of: ",", with: "")
                    }
                }
            }
            for (index, item) in outDateArr.enumerated() {
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
                        outDateArr[index] = formattedDay.replacingOccurrences(of: ",", with: "")
                    } else {
                        outDateArr[index] = item.replacingOccurrences(of: ",", with: "")
                    }
                }
            }
            let inFormattedDateStr = inDateArr.joined(separator: "-")
            let outFormattedDateStr = outDateArr.joined(separator: "-")
            let url = "hotels/search-airport?\(API_KEY)&location=\(airportTextField.text!)&check_in=\(inFormattedDateStr)&check_out=\(outFormattedDateStr)"
            api.hotelByAirport(url, completion: didLoadHotels)
        }
        
        
    }
    
    func didLoadHotels(_ hotels: JSONArray) {
        self.hotels = hotels
        spinner.stopAnimating()
        spinner.alpha = 0
        print(hotels)
        if hotels.count == 0 {
            let alert = UIAlertController(title: "Ooops!", message: "No results found try again.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else if hotels[0] as? String == "errah" {
            let alert = UIAlertController(title: "Ooops!", message: hotels[1] as? String, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            self.performSegue(withIdentifier: "hotelsSegue", sender: self)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.alpha = 0
        spinner.stopAnimating()
        self.airportTextField.delegate = self
        airportTextField.keyboardAppearance = UIKeyboardAppearance.dark
        inDatePicker.setValue(UIColor.white, forKey: "textColor")
        inDatePicker.datePickerMode = .countDownTimer
        inDatePicker.datePickerMode = .date
        
        outDatePicker.setValue(UIColor.white, forKey: "textColor")
        outDatePicker.datePickerMode = .countDownTimer
        outDatePicker.datePickerMode = .date

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "hotelsSegue" {
            let controller = segue.destination as! HotelsTVC
            controller.hotels = self.hotels
        }
    }
 

}
