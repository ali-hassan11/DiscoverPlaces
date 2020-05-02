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
    
    private static let googlePlacesApiKey = "AIzaSyAgIjIKhiEllBtS2f_OSGTxZyHSJI-lXpg"
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkConnection()
    }
    
    private func checkConnection() {
        guard Reachability.isConnectedToNetwork() else {
            showNoConnectionAlert()
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
        if locationServicesEnabled {
            determineUserLocationCompletionHandler?()
            self.navigationController?.popViewController(animated: true)
        } else {
            showLocationDisabledAlert()
        }
    }
    
    private func setupSearchBar() {
        GMSPlacesClient.provideAPIKey(LocationSearchController.googlePlacesApiKey)
        
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
        self.selectedLocationCompletionHandler?(location, place.name)
        self.navigationController?.popViewController(animated: true)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
//        resultsCompletionHandler?(nil, nil, error)
        print("🚨🚨🚨 FAILED TO AUTOCOMPLETE 🚨🚨🚨")
    }
    
}
