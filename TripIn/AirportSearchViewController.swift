//
//  AirportSearchViewController.swift
//  TripIn
//
//  Created by Will Fuger on 6/30/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit
import SwiftyJSON

class AirportSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate  {
    
    @IBOutlet weak var airportTextField: UITextField!
    
    var airports: JSONArray = []
    
    var api = APIManager()
    
    func didLoadAirports( airports: JSONArray) {
        self.airports = airports
//        print("airports\(airports)")
        tableView.alpha = 1
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 90.0;
        tableView.reloadData()
    }

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.alpha = 0
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.airportTextField.delegate = self
        airportTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func search(sender: AnyObject) {
        api.airportAutoCall("airports/autocomplete?", term: "&term=" + airportTextField.text!, completion: didLoadAirports)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airports.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell { 
        let cell = tableView.dequeueReusableCellWithIdentifier("airport", forIndexPath: indexPath) as! AirportTableViewCell
        cell.airport = airports[indexPath.row]
        return cell
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        search(self)
        textField.resignFirstResponder()
        
        return true
        
    }
    

}


