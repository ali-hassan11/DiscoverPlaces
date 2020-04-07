//
//  AboutController.swift
//  DiscoverPlaces
//
//  Created by user on 05/04/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class AboutController: UIViewController {
    
    @IBOutlet weak var getInTouchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInTouchButton.roundCorners()
    }
    
    @IBAction func unnamedButtonPressed(_ sender: Any) {
        print("Find out more?...")
    }
    
}
