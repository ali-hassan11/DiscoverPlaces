//
//  LocationSearchController.swift
//  DiscoverPlaces
//
//  Created by user on 09/04/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit
import GooglePlaces

final class LocationSearchController: UITableViewController, CLLocationManagerDelegate {
    //Change to LocationItem
    var selectedLocationCompletionHandler: ((Location, String?) -> Void)?
    var locateUserCompletionHandler: (() -> Void)?
    
    private var resultsViewController: GMSAutocompleteResultsViewController?
    private var searchController: UISearchController?
    
    private let locationManager = CLLocationManager()
    private var locationServicesEnabled = false
    
    init(selctedLocationHandler: ((Location, String?) -> ())?, locateUserHandler: (() -> Void)?) {
        self.selectedLocationCompletionHandler = selctedLocationHandler
        self.locateUserCompletionHandler = locateUserHandler
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Set Location"
        
        locationManager.delegate = self
        
        setupResultsController()
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
            locateUserCompletionHandler?()
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
    
    private func setupResultsController() {
        GMSPlacesClient.provideAPIKey(Constants.googlePlacesAPIkey)
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        let filter = GMSAutocompleteFilter()
        filter.type = .region
        
        resultsViewController?.autocompleteFilter = filter
        
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
