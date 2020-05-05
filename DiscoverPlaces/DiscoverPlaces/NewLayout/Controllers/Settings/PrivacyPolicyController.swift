//
//  AboutController.swift
//  DiscoverPlaces
//
//  Created by user on 05/04/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

final class PrivacyPolicyController: UIViewController {
    
    @IBOutlet weak var privacyPolicyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        privacyPolicyButton.roundCorners()
    }
    
    @IBAction func privacyPolicyButtonPressed(_ sender: Any) {
        if let url = URL(string: "https://policies.google.com/privacy") {
            UIApplication.shared.open(url)
        }
    }
    
    
}
