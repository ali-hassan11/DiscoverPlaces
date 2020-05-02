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
    
    func showLocationDisabledAlert() {
           let alertController = UIAlertController(title: "We were unable to locate you", message: "Please make sure that location services are turned on in your device settings", preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
           
           alertController.addAction(action)
           
           present(alertController, animated: true, completion: nil)
       }
    
    func showNoConnectionAlert() {
        let alertController = UIAlertController(title: "No Connection", message: "Please check that you are connected to the internet", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showNoConnectionAlertAndDismiss() {
        let alertController = UIAlertController(title: "No Connection", message: "Please check that you are connected to the internet", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showRetryConnectionAlert(retryHandler: ((UIAlertAction)->())?) {
        let alertController = UIAlertController(title: "No Connection", message: "Please check that you are connected to the internet", preferredStyle: .alert)
                
        let action = UIAlertAction(title: "Retry", style: .default, handler: retryHandler)

        alertController.addAction(action)

        present(alertController, animated: true, completion: nil)
    }

}

