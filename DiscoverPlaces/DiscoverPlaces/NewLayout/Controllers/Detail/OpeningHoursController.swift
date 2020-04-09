//
//  OpeningHoursController.swift
//  DiscoverPlaces
//
//  Created by user on 23/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class OpeningHoursController: UITableViewController {
    
    var openingHours: OpeningHours? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Opening Times"
        view.isUserInteractionEnabled = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
        let dayOpeningHours = openingHours?.weekdayText?[indexPath.row]
        cell.textLabel?.text = dayOpeningHours
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return openingHours?.weekdayText?.count ?? 0
    }
    
}
