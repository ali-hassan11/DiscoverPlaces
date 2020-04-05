//
//  Extensions.swift
//  DiscoverPlaces
//
//  Created by user on 05/04/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showToastAlert(title: String, message: String? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        present(alertVC, animated: true) {
            _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                alertVC.dismiss(animated: true, completion: nil)
            }
        }
    }
}

