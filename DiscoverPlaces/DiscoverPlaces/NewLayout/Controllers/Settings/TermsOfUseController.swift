//
//  AboutController.swift
//  DiscoverPlaces
//
//  Created by user on 05/04/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class TermsOfUseController: UIViewController {
    
    @IBOutlet weak var termsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        termsButton.roundCorners()
    }
    
    @IBAction func termsButtonPressed(_ sender: Any) {        
        if let url = URL(string: "https://policies.google.com/privacy") {
            UIApplication.shared.open(url)
        }
    }
    
    
}
