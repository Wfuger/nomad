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
    
    var airports = JSONArray()
    
    var api = APIManager()
    
    func didLoadAirports( _ airports: JSONArray) {
        self.airports = airports
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
        airportTextField.keyboardAppearance = UIKeyboardAppearance.dark
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func search(_ sender: AnyObject) {
        api.airportAutoCall("airports/autocomplete?", term: "&term=" + airportTextField.text!, completion: didLoadAirports)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airports.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { 
        let cell = tableView.dequeueReusableCell(withIdentifier: "airport", for: indexPath) as! AirportTableViewCell
        cell.airport = airports[(indexPath as NSIndexPath).row]
        return cell
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        search(self)
        textField.resignFirstResponder()
        
        return true
        
    }
    

}


