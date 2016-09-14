//
//  MainDashTVC.swift
//  TripIn
//
//  Created by Will Fuger on 6/25/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit

class MainDashTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.alwaysBounceVertical = false
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 110.0;
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

}
