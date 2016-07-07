//
//  ThingsToDoViewController.swift
//  TripIn
//
//  Created by Will Fuger on 6/25/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit

class YapQViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var places: JSONArray = []
    
    var api = APIManager()
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    @IBAction func search(sender: AnyObject) {
        spinner.startAnimating()
        spinner.alpha = 1
        if (cityTextField.text?.isEmpty != false) {
            let alert = UIAlertController(title: "Ooops!", message: "Please enter a city", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Cancel) { action -> Void in }
            alert.addAction(okAction)
            spinner.stopAnimating()
            spinner.alpha = 0
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            let city = cityTextField.text?.stringByReplacingOccurrencesOfString(" ", withString: "%20")
            api.yapQCitySearch("points-of-interest/yapq-search-text?city_name=", city: city!, completion: didLoadPlaces)
        }
        
    }
    
    func didLoadPlaces(places: JSONArray) {
        spinner.stopAnimating()
        spinner.alpha = 0
        if places.count == 0 {
            let alert = UIAlertController(title: "Sorry!", message: "No info for that city", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in }
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            self.places = places
            tableView.alpha = 1
            tableView.rowHeight = UITableViewAutomaticDimension;
            tableView.estimatedRowHeight = 90.0;
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.alpha = 0
        spinner.alpha = 0
        cityTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        self.cityTextField.delegate = self
        if let indexPaths = self.tableView.indexPathsForSelectedRows {
            for indexPath in indexPaths {
                self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("place", forIndexPath: indexPath) as! YapQTableViewCell
        cell.place = places[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        search(self)
        textField.resignFirstResponder()
        return true
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "placeDetail" {
            if let indexpath = tableView.indexPathForSelectedRow {
                let thing = places[indexpath.row]
                let controller = segue.destinationViewController as! YapQDetailViewController
                controller.thing = thing 
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
