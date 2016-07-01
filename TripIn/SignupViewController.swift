//
//  signupViewController.swift
//  TripIn
//
//  Created by Will Fuger on 6/22/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import Foundation
import UIKit


class SignupViewController: UIViewController {

    override func shouldAutorotate() -> Bool {
        return true
    }
    let api = APIManager()
    var airports = JSONArray()
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
    

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.keyboardAppearance = UIKeyboardAppearance.Dark
        password.keyboardAppearance = UIKeyboardAppearance.Dark
        
    }
    
}