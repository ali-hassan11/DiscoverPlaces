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
    
    private var userLocation: LocationItem?
    
    private var placeResults = [PlaceResult]()
    
    //Make custom object
    private let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .medium)
        aiv.color = .secondaryLabel
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    //Make custom object
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
        
        fetchForLastSavedLocation()
//        determineMyCurrentLocation()
    }
    
    private func setupBarButtons() {
        let locationBarButton = UIBarButtonItem(image: UIImage(systemName: "mappin.and.ellipse"), style: .plain, target: self, action: #selector(showSetLocationController))
        locationBarButton.tintColor = .systemPink
        navigationItem.rightBarButtonItem = locationBarButton
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
        userLocation = UserLoation.lastSavedLocation()
        print("\n🗺 Home Controller Location: " + (userLocation?.name ?? "NO LOCATION NAME"))
        collectionView.reloadData()
    }
    
    fileprivate func fetchPlacesData(location: LocationItem) {
        
        Service.shared.fetchNearbyPlaces(location: location.selectedLocation) { (response, error) in
            
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
    
    @objc func showSetLocationController() {
        let locationSearchController = LocationSearchController()
        
        locationSearchController.resultsCompletionHandler = { [weak self] location, name in
            guard let location = location else { return }
            let locationStub = LocationItem(name: name, selectedLocation: location, actualUserLocation: self?.userLocation?.actualUserLocation)
            self?.userLocation = locationStub
            self?.updateLastSavedLocation(with: locationStub)
            self?.fetchForLastSavedLocation()
            print(UserLoation.lastSavedLocation())
        }
        
        locationSearchController.determineUserLocationTappedHandler = { [weak self] in
            self?.determineMyCurrentLocation()
        }
        
        navigationController?.pushViewController(locationSearchController, animated: true)
    }
}

extension HomeController {
    //MARK: Home Large Cell
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeLargeCellHolder.id, for: indexPath) as! HomeLargeCellHolder
        cell.horizontalController.userLocation = self.userLocation
        cell.horizontalController.results = placeResults
        cell.configureTitle(with: userLocation?.name)
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
    
//        guard isLocationSettingEnabled == false else { return }
        
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
        
        let locationCoords = Location(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
        let locationStub = LocationItem(name: nil, selectedLocation: locationCoords, actualUserLocation: locationCoords) //Use geocoding to get name of current location
        
        self.userLocation = locationStub
        self.updateLastSavedLocation(with: locationStub)
        self.fetchForLastSavedLocation()
        
//        if isLocationSettingEnabled {
//            updateLastSavedLocation(with: currentLocation)
//            self.userLocation = currentLocation
//        }
//
//        fetchPlacesData(location: currentLocation)
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error, when trying to get location: \(error)")
        fetchForLastSavedLocation()
    }
    

    func updateLastSavedLocation(with location: LocationItem) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(location)
            UserDefaults.standard.set(data, forKey: "LocationKey")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    func fetchForLastSavedLocation() {
        if let data = UserDefaults.standard.data(forKey: "LocationKey") {
            do {
                let decoder = JSONDecoder()
                let lastSavedLocation = try decoder.decode(LocationItem.self, from: data)
                self.userLocation = lastSavedLocation
                fetchPlacesData(location: lastSavedLocation)
            } catch {
                print("Unable to Decode Note (\(error))")
                fetchPlacesData(location: LocationItem(name: "Dubai", selectedLocation: Location(lat: 25.1412, lng: 55.1852), actualUserLocation: nil)) //Decide on a Default location (Currently Dubai)
            }
        } else {
            fetchPlacesData(location: LocationItem(name: "Dubai", selectedLocation: Location(lat: 25.1412, lng: 55.1852), actualUserLocation: nil)) //Decide on a Default location (Currently Dubai)
        }
    }
}

extension UserDefaults {
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    // Note: Store this value in AppDelegate if you have multiple places where you are checking for this flag
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}
