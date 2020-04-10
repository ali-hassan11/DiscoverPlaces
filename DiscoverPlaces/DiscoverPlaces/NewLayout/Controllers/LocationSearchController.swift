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
    
    var resultsCompletionHandler: ((Location?, String?) -> ())?
    var determineUserLocationTappedHandler: (()->())?
    
    private var resultsViewController: GMSAutocompleteResultsViewController?
    private var searchController: UISearchController?
    
    private let locationManager = CLLocationManager()
    private var locationServicesEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Set Location"
        
        locationManager.delegate = self
        
        setupSearchBar()
        setupLocateMeButton()
    }
    
    private func setupLocateMeButton() {
        let locationBarButton = UIBarButtonItem(image: UIImage(systemName: "mappin.and.ellipse"), style: .plain, target: self, action: #selector(dismissAndLocateUser))
        locationBarButton.tintColor = .systemPink
        navigationItem.rightBarButtonItem = locationBarButton
        locationBarButton.tintColor = .label
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
            determineUserLocationTappedHandler?()
            self.navigationController?.popViewController(animated: true)
        } else {
            showToastAlert(title: "Please enable location services, or select location manually")
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
        
        searchController?.hidesNavigationBarDuringPresentation = false
        
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
        self.resultsCompletionHandler?(location, place.name)
        self.navigationController?.popViewController(animated: true)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
//        resultsCompletionHandler?(nil, nil, error)
        print("🚨🚨🚨 FAILED TO AUTOCOMPLETE 🚨🚨🚨")
    }
    
}
