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
    
    
    @IBAction func search(_ sender: AnyObject) {
        spinner.startAnimating()
        spinner.alpha = 1
        if (cityTextField.text?.isEmpty != false) {
            let alert = UIAlertController(title: "Ooops!", message: "Please enter a city", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in }
            alert.addAction(okAction)
            spinner.stopAnimating()
            spinner.alpha = 0
            self.present(alert, animated: true, completion: nil)
        } else {
            let city = cityTextField.text?.replacingOccurrences(of: " ", with: "%20")
            api.yapQCitySearch("points-of-interest/yapq-search-text?city_name=", city: city!, completion: didLoadPlaces)
        }
        
    }
    
    func didLoadPlaces(_ places: JSONArray) {
        spinner.stopAnimating()
        spinner.alpha = 0
        if places.count == 0 {
            let alert = UIAlertController(title: "Sorry!", message: "No info for that city", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { action -> Void in }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            self.places = places
            tableView.alpha = 1
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 90.0
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.alpha = 0
        spinner.alpha = 0
        cityTextField.keyboardAppearance = UIKeyboardAppearance.dark
        self.cityTextField.delegate = self
        if let indexPaths = self.tableView.indexPathsForSelectedRows {
            for indexPath in indexPaths {
                self.tableView.deselectRow(at: indexPath, animated: true)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "place", for: indexPath) as! YapQTableViewCell
        cell.place = places[(indexPath as NSIndexPath).row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search(self)
        textField.resignFirstResponder()
        return true
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "placeDetail" {
            if let indexpath = tableView.indexPathForSelectedRow {
                let thing = places[(indexpath as NSIndexPath).row]
                let controller = segue.destination as! YapQDetailViewController
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
