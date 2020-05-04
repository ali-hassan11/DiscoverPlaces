//
//  LocationSearchController.swift
//  DiscoverPlaces
//
//  Created by user on 09/04/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit
import GooglePlaces

class LocationSearchController: UITableViewController, CLLocationManagerDelegate {
    
    var selectedLocationCompletionHandler: ((Location?, String?) -> ())?
    var determineUserLocationCompletionHandler: (()->())?
    
    private var resultsViewController: GMSAutocompleteResultsViewController?
    private var searchController: UISearchController?
    
    private let locationManager = CLLocationManager()
    private var locationServicesEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Set Location"
        
        locationManager.delegate = self
        
        setupSearchBar()
        setupBarButtonItems()
        
        checkConnection()
    }
    
    private func checkConnection() {
        guard Reachability.isConnectedToNetwork() else {
            pushErrorController(title: Constants.noInternetConnectionTitle, message: Constants.genericNoConnectionMessage, popToRoot: true)
            return
        }
    }
    
    private func setupBarButtonItems() {
        let btn = UIButton(type: .system)
        btn.setTitle(" Locate Me", for: .normal)
        btn.setImage(UIImage(systemName: "mappin"), for: .normal)
        btn.addTarget(self, action: #selector(dismissAndLocateUser), for: .touchUpInside)
        btn.tintColor = .systemPink
        
        let locationBarButton = UIBarButtonItem(customView: btn)
        navigationItem.rightBarButtonItem = locationBarButton
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationServicesEnabled = true
        default:
            locationServicesEnabled = false
        }
    }
    
    @objc func dismissAndLocateUser() {
        if locationServicesEnabled && Reachability.isConnectedToNetwork() {
            determineUserLocationCompletionHandler?()
            navigationController?.popToRootViewController(animated: true)
        } else {
            pushErrorAlert()
        }
    }
    
    private func pushErrorAlert() {
        if Reachability.isConnectedToNetwork() == false {
            pushErrorController(title: Constants.noInternetConnectionTitle, message: Constants.noInternetForLocatingMessage, popToRoot: false)
        } else if locationServicesEnabled == false {
            pushErrorController(title: Constants.locationServicesDisabledTitle, message: Constants.locationServicesDisabledMessage, popToRoot: false)
        }
    }
    
    private func pushErrorController(title: String, message: String, popToRoot: Bool) {
        let errorController = ErrorController(message: message, buttonTitle: Constants.backtext) {
            ///DidTapActionButtonHandler
            if popToRoot {
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
        self.navigationController?.pushViewController(errorController, animated: true)
    }
    
    private func setupSearchBar() {
        GMSPlacesClient.provideAPIKey(Constants.googlePlacesAPIkey)
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        searchController?.searchBar.sizeToFit()
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
        
        searchController?.searchBar.placeholder = "Enter Location..."
        searchController?.hidesNavigationBarDuringPresentation = true
        
        resultsViewController?.tintColor = .systemPink
        resultsViewController?.primaryTextColor = .label
        resultsViewController?.secondaryTextColor = .secondaryLabel
        resultsViewController?.tableCellSeparatorColor = .separator
        resultsViewController?.tableCellBackgroundColor = .systemBackground
    }
    
}

extension LocationSearchController: GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        
        let location = Location(lat: place.coordinate.latitude, lng: place.coordinate.longitude)
        selectedLocationCompletionHandler?(location, place.name)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        //        resultsCompletionHandler?(nil, nil, error)
        print("🚨🚨🚨 FAILED TO AUTOCOMPLETE 🚨🚨🚨")
    }
    
}
