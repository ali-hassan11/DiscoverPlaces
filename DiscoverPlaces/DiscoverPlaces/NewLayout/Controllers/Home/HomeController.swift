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
    
    private let searchResponseFilter = SearchResponseFilter()
    
    private var locationManager:CLLocationManager!
    private var isLocationSettingEnabled = false
    
    private var userLocation: Location?
    
    private var placeResults = [PlaceResult]()
    
    //Make custom object
    private let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .medium)
        aiv.color = .secondaryLabel
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    private let fadeView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingView()
        navigationItem.largeTitleDisplayMode = .always
        setupBarButtons()
        setupCollectionView()
        determineMyCurrentLocation()
    }
    
    private func setupBarButtons() {
        let locationBarButton = UIBarButtonItem(image: UIImage(systemName: "mappin.and.ellipse"), style: .plain, target: self, action: #selector(addTapped))
        locationBarButton.tintColor = .systemPink
        navigationItem.rightBarButtonItem = locationBarButton
        locationBarButton.tintColor = .label
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CategoriesHolder.self, forCellWithReuseIdentifier: CategoriesHolder.id)
        collectionView.register(HomeLargeCellHolder.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeLargeCellHolder.id)
    }
    
    private func setupLoadingView() {
        view.addSubview(fadeView)
        fadeView.alpha = 1
        fadeView.fillSuperview()
        
        fadeView.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    fileprivate func fetchPlacesData(location: Location) {
        
        Service.shared.fetchNearbyPlaces(location: location) { (response, error) in
            
            if let error = error {
                print("Failed to fetch places: ", error)
                return
            }
            
            //success
            guard let response = response else {
                print("No results?")
                return
            }
            
            //If results < 5, load other places
            let placeResults = self.searchResponseFilter.results(from: response)
            self.handleFetchSuccess(with: placeResults)
        }
    }
    
    private func handleFetchSuccess(with placeResults: [PlaceResult]) {
        self.placeResults = placeResults
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.activityIndicatorView.stopAnimating()
                self.fadeView.alpha = 0
                self.collectionView.reloadData()
            }) { _ in
                self.fadeView.removeFromSuperview()
            }
        }
    }
    
    @objc func addTapped() {
        let locationSearchVC = UIViewController()
        locationSearchVC.view.backgroundColor = .blue
        show(locationSearchVC, sender: self)
    }
}

extension HomeController {
    //MARK: Home Large Cell
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeLargeCellHolder.id, for: indexPath) as! HomeLargeCellHolder
        cell.horizontalController.userLocation = self.userLocation
        cell.horizontalController.results = placeResults
        cell.horizontalController.didSelectHandler = { [weak self] result in //Only need placeId
            guard let placeId = result.place_id, let location = self?.userLocation else { return }
            let detailsController = PlaceDetailsController(placeId: placeId, location: location)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesHolder.id, for: indexPath) as! CategoriesHolder
        cell.horizontalController.didSelectCategory = { [weak self] category in
            guard let location = self?.userLocation else { return }
            let multipleCategoriesController = MultipleCategoriesController(category: category, location: location)
            multipleCategoriesController.title = category.rawValue
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
            fetchForLastSavedLocation()
            
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            isLocationSettingEnabled = true
            
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            
        default:
            fetchForLastSavedLocation()
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation = locations[0] as CLLocation
        
        let currentLocation = Location(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
        
        if isLocationSettingEnabled {
            updateLastSavedLocation(with: currentLocation)
            self.userLocation = currentLocation
        }
        
        fetchPlacesData(location: currentLocation)
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error, when trying to get location: \(error)")
        fetchForLastSavedLocation()
    }
    
    func updateLastSavedLocation(with location: Location) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(location)
            UserDefaults.standard.set(data, forKey: "Location")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    func fetchForLastSavedLocation() {
        if let data = UserDefaults.standard.data(forKey: "Location") {
            do {
                let decoder = JSONDecoder()
                let lastSavedLocation = try decoder.decode(Location.self, from: data)
                self.userLocation = lastSavedLocation
                fetchPlacesData(location: lastSavedLocation)
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        } else {
            fetchPlacesData(location: Location(lat: 25.1412, lng: 55.1852)) //Decide on a Default location (Currently Dubai)
        }
    }
}
