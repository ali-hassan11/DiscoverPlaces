//
//  HomeController.swift
//  DiscoverPlaces
//
//  Created by user on 05/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//
import UIKit
import CoreLocation

class HomeController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let largeCellHolderId = "largeCellHeaderId"
    fileprivate let categoriesHolderId = "categoriesHolderId"

    private var locationManager:CLLocationManager!
    private var isLocationSettingEnabled = false
    
    private var userLocation: Location?
    
    var results = [PlaceResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let locationBarButton = UIBarButtonItem(image: UIImage(systemName: "mappin.and.ellipse"), style: .plain, target: self, action: #selector(addTapped))
        locationBarButton.tintColor = .systemPink
        navigationItem.rightBarButtonItem = locationBarButton
        
        
        locationBarButton.tintColor = .label
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        collectionView.backgroundColor = .systemBackground
        collectionView.register(CategoriesHolder.self, forCellWithReuseIdentifier: categoriesHolderId)
        //Header 1
        collectionView.register(HomeLargeCellHolder.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: largeCellHolderId)
    
        determineMyCurrentLocation()
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    fileprivate func fetchPlacesData(location: Location) {
        
        Service.shared.fetchNearbyPlaces(location: location, radius: 5000) { (results, error) in
            
            if let error = error {
                print("Failed to fetch places: ", error)
                return
            }
            
            //success
            guard let results = results else {
                print("No results?")
                return
            }
            
            var filteredResults = [PlaceResult]()
            
            results.results.forEach({ (result) in
                if result.containsPhotos()
                    && !(result.types?.contains("locality") ?? true)
                {
                    filteredResults.append(result)
                }
            })
            
            //If results < 5, load other places
            
            self.results = filteredResults
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    @objc func addTapped() {
        let locationSearchVC = UIViewController()
        locationSearchVC.view.backgroundColor = .blue
        show(locationSearchVC, sender: self)
    }
    
    //MARK: Home Large Cell
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: largeCellHolderId, for: indexPath) as! HomeLargeCellHolder
        cell.horizontalController.userLocation = self.userLocation
        cell.horizontalController.results = results
        cell.horizontalController.didSelectHandler = { [weak self] result in
            let detailsController = PlaceDetailsController()
            detailsController.placeId = result.place_id
            
            self?.navigationController?.pushViewController(detailsController, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.width - 32)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    //MARK: Categories Controller
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoriesHolderId, for: indexPath) as! CategoriesHolder
        cell.horizontalController.didSelectCategory = { [weak self] category in
            let multipleCategoriesController = MultipleCategoriesController()
            multipleCategoriesController.location = self?.userLocation
            multipleCategoriesController.category = category
            self?.navigationController?.pushViewController(multipleCategoriesController, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 380)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension HomeController: CLLocationManagerDelegate {
              
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    
        guard isLocationSettingEnabled == false else { return }
        
        switch status {
        case .restricted, .denied:
            fetchDefaultLocation()
            
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            isLocationSettingEnabled = true
            
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            
        default:
            fetchDefaultLocation()
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation = locations[0] as CLLocation
        
        let currentLocation = Location(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
        
        if isLocationSettingEnabled {
            self.userLocation = currentLocation
        }
        
        fetchPlacesData(location: currentLocation)
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error, when trying to get location: \(error)")
        fetchDefaultLocation()
    }
    
    func fetchDefaultLocation() {
        fetchPlacesData(location: Location(lat: 24.4539, lng: 54.3773))
        //Have an array of default locations, Or Save last location and load places from that 🤔🤔🤔
    }
}
